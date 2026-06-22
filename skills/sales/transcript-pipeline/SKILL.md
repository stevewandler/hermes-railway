---
name: transcript-pipeline
description: "Diagnose, audit, and maintain Steve's Plaud + Google Meet → Canonical → G-Brain transcript ingestion pipeline. CONDUCTOR-BASED — stopped 2026-06-22. For current pipeline, see transcript-pipeline-railway skill."
triggers:
  - transcript pipeline
  - plaud sync
  - meet sync
  - transcripts missing
  - pipeline broken
  - meetings not in G-Brain
  - transcript ingestion
  - google meet transcript
  - plaud transcript
  - canonical folder
  - merger script
  - transcript extract
  - ingest meetings
---

# Transcript Pipeline — Conductor-Based (DEPRECATED 2026-06-22)

> **STATUS:** The Conductor LaunchAgents running this pipeline were stopped on 2026-06-22. The pipeline is being replaced by the Hermes-native `transcript-pipeline-railway` skill, which runs as a cron job on Railway. This document is retained for diagnostic reference when investigating historical pipeline data or Drive artifacts.

## Replacement
- **New skill:** `transcript-pipeline-railway` — Hermes-native, no Conductor, no Python scripts, no gws CLI
- **Migration date:** 2026-06-22
- **Stopped agents:** `com.bookmarked.meet-sync`, `com.bookmarked.meet-intraday`, `com.bookmarked.transcript-extract`, `com.bookmarked.transcript-merger` (all 13 Bookmarked LaunchAgents)

## Context: Why Two Sources

Steve records meetings two ways deliberately:

1. **Google Meet + Gemini** — Gemini auto-generates Notes docs attached to calendar invites for any Meet call
2. **Plaud** — runs in the background on the desktop (or via hardware Plaud device). Used when:
   - The Google Meet participant doesn't want to be recorded (Plaud is private, only for Steve)
   - In-person meetings or conversations that have no Google Meet component

Steve's preference: **full transcript, not Gemini summary.** Gemini Notes are included in canonical files as a cross-reference signal only, wrapped in HTML comment fences. The G-Brain extraction pass uses the full transcript body.

---

## Pipeline Architecture (Five Stages)

```
Plaud hardware ──► Plaud Desktop ──► web.plaud.ai ──┐
                                                    ├──► Drive: Transcripts/{Plaud,Meet}/ ──► Canonical/ ──► extraction-ledger ──► G-Brain pages
Google Meet ──► Gemini Notes (Doc on cal invite) ───┘
        (1) Capture           (2) Drive sync            (3) Merge       (4) Extract+Write     (5) Verify
```

### Stage 1 — Capture
- **Google Meet:** Gemini Notes auto-attaches to calendar invite as a Google Doc. No action needed.
- **Plaud desktop:** Plaud Desktop must be running + signed in. Recordings push to web.plaud.ai before the sync script sees them.
- **Plaud hardware device:** Syncs to Plaud Desktop → web.plaud.ai same path.

### Stage 2 — Drive Sync (launchd jobs)
- `plaud-drive-sync` → pulls from web.plaud.ai API → uploads .md files to `Drive/Transcripts/Plaud/`
- `meet-sync` → lists Meet Gemini Notes docs modified in last N days → downloads full transcript → saves .md to `Drive/Transcripts/Meet/`
- Both run via launchd plists at `~/Library/LaunchAgents/com.bookmarked.{plaud-drive-sync,meet-sync}.plist`

**CRITICAL SCHEDULING NOTE — Plaud vs Meet frequency:**
- **Meet** has TWO sync paths: daily (`meet-sync` at 5:45 PM) AND intraday (`meet-intraday` every 30 min via `run_intraday.sh`). Meet transcripts appear in G-Brain within ~30 minutes.
- **Plaud** has only the daily sync (`plaud-drive-sync` at 5:30 PM, `--days 2`). Plaud recordings do NOT appear until after 6 PM when the daily merger+extract chain completes.
- `run_intraday.sh` (every 30 min) runs: `meet_sync.py --hours 2` → `merger.py --hours 2` → `extract_signal.py --hours 2` → `intraday_brief.py`. It does NOT include Plaud sync.
- **This means any Plaud-only recording (personal calls, in-person meetings, Teresa conversations) is invisible to Hermes agents until end of day.** If Steve or another agent asks about a same-day Plaud call and can't find it, this is why.
- **Planned fix (identified 2026-06-19, not yet applied):** Add Plaud sync line to `run_intraday.sh` before the meet_sync call. Plaud sync is idempotent (skips already-uploaded files), so running it every 30 min costs only a quick API check. This would give Plaud recordings the same ~30-minute availability as Meet transcripts.

### Stage 3 — Merger
- `merger.py` matches Plaud and Meet files by **date + start time (±5 min tolerance)** on the same day
- When both sources exist for the same meeting:
  - **Meet = primary** (better speaker labels, real names from invited list)
  - **Plaud = secondary** (referenced in frontmatter, body dropped — no duplicate ingestion)
- Plaud-only (no matching Meet doc) → Plaud is primary
- Meet-only (no Plaud recording) → Meet is primary
- Output: `Drive/Transcripts/Canonical/` in format `YYYY-MM-DD_HHMM_<slug>.md`

### Stage 4 — Extract Signal
- `extract_signal.py` reads Canonical files, runs LLM extraction pass → writes G-Brain meeting pages
- Uses OpenAI API (OPENAI_API_KEY must be set)
- Keyed by `meeting_id` (= filename minus .md). Idempotent.

### Stage 5 — G-Brain Pages
- Meeting pages land at `meetings/YYYY-MM-DD_HHMM_<slug>` in G-Brain

---

## Key Paths

| Component | Path |
|-----------|------|
| Scripts | `~/conductor/workspaces/gbrain-mcp/doha/scripts/` |
| Ledgers | `~/conductor/workspaces/gbrain-mcp/doha/.context/*-ledger.json` |
| Logs | `~/Library/Logs/{plaud-drive-sync,meet-sync,meet-intraday,transcript-merger,transcript-extract}.{log,err}` |
| LaunchD plists | `~/Library/LaunchAgents/com.bookmarked.{plaud-drive-sync,meet-sync,transcript-merger,transcript-extract}.plist` |
| Transcript format spec | `~/conductor/workspaces/gbrain-mcp/doha/.context/TRANSCRIPT-FORMAT.md` |
| Pipeline kill switch / cost config | `~/conductor/workspaces/gbrain-mcp/doha/.context/pipeline.toml` |

**Drive Folder IDs:**
- Plaud raw: `1CLTCzGz4CUBZ3BLHi7LzF-Fy5gG8hnRO`
- Meet raw: `1tb0QwVSulOdsmRYT9L86kCGZbn2BRB26` (also the meet-sync OUTPUT)
- Canonical: `1NaJU9iSVLNqBkh7snILsF33nlATybbF3`
- Meet source (Gemini Notes): `1Y8y4BdUZUzU4Hyd2CdbJz36sDaAYbXDR`

---

## Diagnostic Steps (do in order)

### 1. Is the canonical folder getting new files?

**PATH note (confirmed 2026-06-10):** `gws` lives at `/Users/stevewandler/.npm-global/bin/gws` — NOT on Hermes terminal PATH by default. Always prepend `export PATH="/Users/stevewandler/.npm-global/bin:$PATH"` or you get `gws: command not found`.

**Shell quoting note:** Use double-quotes around the folder ID inside the JSON string (not single-quote escape sequences). The `'\''` escaping pattern reliably fails in Hermes `terminal()` calls with a JSON parse error on the gws output. The working form is `"q": "\"<folder-id>\" in parents..."`.

**gws drive files get syntax:** To download a canonical file by Drive ID, use `--params` not `--file-id`:
```bash
gws drive files get --params '{"fileId": "<id>", "alt": "media"}' -o /tmp/output.md
```
### 0. Fast-path: check canonical folder first (do this before anything else)

When Steve asks "do you have my X meeting?" or "look at my call with Y this morning" —
check the canonical folder FIRST. It's one API call and returns a sorted list of today's
meetings in seconds. If the file is there, download and read it directly. Only fall
through to Plaud API or pipeline diagnostics if the file is missing.

```bash
export PATH="/Users/stevewandler/.npm-global/bin:$PATH"
GOOGLE_WORKSPACE_CLI_KEYRING_BACKEND=file gws drive files list \
  --params '{"q": "\"1NaJU9iSVLNqBkh7snILsF33nlATybbF3\" in parents and trashed = false", \
             "fields": "files(id,name,modifiedTime,id)", "pageSize": 20, "orderBy": "modifiedTime desc"}' \
  2>&1 | head -60
```

The filename slug is `YYYY-MM-DD_HHMM_<meeting-topic>.md` — today's meetings are at
the top sorted by `modifiedTime desc`. Download the file directly:
```bash
GOOGLE_WORKSPACE_CLI_KEYRING_BACKEND=file gws drive files get \
  --params '{"fileId": "<ID>", "alt": "media"}' -o /tmp/meeting.md 2>&1
```

**Note on gws quoting:** the `--params` JSON must use `"` double-quotes around the
folder ID (not `\'` single-quote escapes) or gws rejects it with a syntax error.

### 1. Is the canonical folder getting new files?
```bash
GOOGLE_WORKSPACE_CLI_KEYRING_BACKEND=file gws drive files list \
  --params '{"q": "\"1NaJU9iSVLNqBkh7snILsF33nlATybbF3\" in parents and trashed = false", \
             "fields": "files(id,name,modifiedTime)", "pageSize": 10, "orderBy": "modifiedTime desc"}' \
  2>/dev/null | python3 -c "import sys,json; d=json.load(sys.stdin); [print(f['modifiedTime'][:10], '|', f['name'][:80]) for f in d.get('files',[])]"
```
If today's meetings are there → Stage 4/5 might be the issue.

### 2. Check launchd job logs for errors
```bash
tail -30 ~/Library/Logs/plaud-drive-sync.log
tail -20 ~/Library/Logs/plaud-drive-sync.err
tail -30 ~/Library/Logs/meet-sync.log
tail -20 ~/Library/Logs/meet-sync.err
tail -20 ~/Library/Logs/transcript-merger.err
tail -20 ~/Library/Logs/transcript-extract.err
```

### 3. Test gws auth manually
```bash
gws auth status
# Token must show: token_valid: true, has_refresh_token: true
```

### 4. Test Drive folder access with file backend (how launchd calls it)
```bash
GOOGLE_WORKSPACE_CLI_KEYRING_BACKEND=file gws drive files list \
  --params '{"q": "'\''1Y8y4BdUZUzU4Hyd2CdbJz36sDaAYbXDR'\'' in parents and trashed = false", \
             "fields": "files(id,name)", "pageSize": 3}' 2>&1 | head -20
```
If this fails but `gws auth status` passes → keyring backend mismatch (see pitfalls).

### 5. Check what's in the ledgers for skipped items
```bash
python3 -c "
import json
for f in ['extraction-ledger.json','merger-ledger.json','meet-sync-ledger.json']:
    path = f'/Users/stevewandler/conductor/workspaces/gbrain-mcp/doha/.context/{f}'
    try:
        d = json.load(open(path))
        print(f'{f}: {len(d)} entries')
    except: print(f'{f}: missing/unreadable')
"
```

---

## Plaud Drive Sync — Known Break (as of 2026-06-10)

The `com.bookmarked.plaud-drive-sync` launchd agent stopped syncing after May 20, 2026. Transcripts from May 21 onward are NOT in Google Drive. They are accessible only via the Plaud API directly.

**To access Plaud transcripts from any date via the API:**

```python
import sys, asyncio
from datetime import datetime
sys.path.insert(0, "/Users/stevewandler/.local/share/uv/tools/plaud-mcp/lib/python3.12/site-packages")
from plaud_mcp.plaud_client import PlaudClient

async def main():
    client = PlaudClient()
    # Get all files (1,985 total as of June 2026)
    files = await client.get_all_files(sort_by="start_time", is_desc=True, page_size=100)

    # CRITICAL: timestamps are in MILLISECONDS
    # May 29, 2026 = 1748491200000ms, June 1 = 1748750400000ms
    for f in files:
        st = f.get("start_time", 0)
        dt = datetime.fromtimestamp(st / 1000)  # divide by 1000!
        dur_min = f.get("duration", 0) // 60000

    # Get transcript for a specific file
    transcript = await client.get_transcript(file_id)
    # Returns list of segments: {"spk": "Steve Wandler", "content": "text..."}
    # Segments have NO timestamps — just speaker + content

asyncio.run(main())
```

**Key pitfalls:**
- Timestamps are milliseconds, not seconds — `datetime.fromtimestamp(ts)` overflows to year 58408. Always divide by 1000.
- Files often have no filename (field is `filename`, value is None) — identify by date + duration
- Run with `~/.local/share/uv/tools/plaud-mcp/bin/python` (Python 3.12), NOT the Hermes venv python
- The sync break needs fixing separately — create a cron job or manual trigger to resume uploads

**To check what's in the Drive sync backlog:**
```bash
tail -30 ~/Library/Logs/plaud-drive-sync.log
tail -20 ~/Library/Logs/plaud-drive-sync.err
```

## Known Bugs

**`has_gemini_notes = not empty` false-positive bug (meet_sync.py line 363, confirmed 2026-06-18):**
The `is_empty_meeting()` function checks if the transcript section (after stripping boilerplate) is under 200 characters. If true, it sets `empty = True`. Then line 363 sets `has_gemini_notes = not empty`. This means a meeting where Gemini actually wrote notes but the transcript section is short gets incorrectly marked as BOTH `empty_meeting: true` AND `gemini_notes_available: false`. These are independent conditions — Gemini notes can exist even when the transcript is short/empty. The fix: `has_gemini_notes` should be determined by whether the notes section has real content, independently of the transcript length check.

**Impact:** In a 30-day audit (2026-06-18), 8 of 39 empty_meeting files were false positives — Gemini notes existed but were not ingested. Affected meetings: recurring syncs (Patrick/Steve, Sarah/Steve, Raju/Steve 1:1s) where Gemini wrote notes but the exported transcript section was short.

**Audit methodology for detecting false positives:**
1. `grep -rl "empty_meeting: true"` across `Transcripts/Canonical/`
2. List all `.gdoc` files in `Transcripts/Google-Meet (1)/` — parse dates from filenames (format: `Title - 2026 06 18 09:59 CDT - Notes by Gemini.gdoc`)
3. Cross-reference by date AND meeting name keywords (≥2 word overlap)
4. Every `.gdoc` file is 175 bytes — it's a JSON pointer: `{"doc_id": "...", "email": "..."}`. The actual content lives in Google Docs, accessed via `gws drive files export`.
5. The "true empties" are predominantly dev-stands (no Gemini notes generated for those).

## Pitfalls

**gws keyring backend mismatch (intermittent meet-sync failures):**
The launchd plists set `GOOGLE_WORKSPACE_CLI_KEYRING_BACKEND=file`, but gws encrypted credentials live in the `keyring` backend by default. When running interactively, `gws` uses the system keyring (works). When launchd fires the script, it uses `file` backend → may fail on token refresh timing. If manual `gws drive files list` works but the launchd job logs show `gws failed: drive files list`, this is the cause. Fix: ensure `plain_credentials_exists: true` in `gws auth status` output, or re-auth with `GOOGLE_WORKSPACE_CLI_KEYRING_BACKEND=file gws auth login`.

**CONFIRMED ROOT CAUSE (Jun 2026, 3-week gap):** The plist pointed to `GoogleDrive-steve@bookmarked.com/My Drive/07 AI/Claude Code/bookmarked-os-private/.../sync.py` — a Google Drive filesystem path that no longer existed. The script had moved to the git repo. Launchd was silently failing with no error output because the script path didn't exist. The fix took 5 minutes once identified.

**CONFIRMED ROOT CAUSE (Jun 18 2026, empty_meeting false positives):** Gemini changed its export format to wrap headers in `**bold**` markdown (e.g. `# **📖 Transcript**` instead of `# 📖 Transcript`). The `TRANSCRIPT_HEADER_RE` and `NOTES_HEADER_RE` regexes in `meet_sync.py` didn't match the bold-wrapped headers, so `split_notes_and_transcript()` returned the entire doc as notes and an empty transcript. The `is_empty_meeting()` function then saw `len("") < 200` → marked empty. Additionally, `has_gemini_notes` was coupled to `not empty` instead of being evaluated independently. Fix: updated regexes to accept optional `**` wrapping, decoupled `has_gemini_notes` from `empty_meeting` (now checks notes content independently), and added a notes-content check to `is_empty_meeting()` so meetings with substantial Gemini notes are never marked empty even if the transcript section is short. Affected files: `meet_sync.py` lines 44-45 (regexes), 230-247 (is_empty_meeting), 368-378 (has_gemini_notes).

**AUDIT PROCEDURE for empty_meeting false positives:** Cross-reference `grep -rl "empty_meeting: true" ~/My Drive/Transcripts/Canonical/` against `.gdoc` files in `Google-Meet (1)/`. Match by date AND meeting name keywords (not just substring — use word overlap >= 2). Of 39 empties in 30 days, 2 were true false positives (had 30K+ chars of real content), 6 were correctly empty (Gemini doc existed but said "A summary wasn't produced"), and 31 were true empties (dev-stands, no .gdoc). The fix primarily matters for future meetings where Gemini uses the bold header format.

**Audit methodology for false positive detection:**
When auditing empty_meeting false positives, match by BOTH date AND meeting-name keywords (≥2 overlapping words). Don't match across dates — a .gdoc from 2025 is not evidence for a 2026 meeting. Of 8 initial "false positives" identified by loose matching, only 2 were real (June 16 and June 18 Sarah/Steve). The other 6 had Gemini docs that said "A summary wasn't produced" — correctly marked empty. Always dry-run (`--reprocess --dry-run`) a confirmed case before bulk reprocessing.

**Reprocessing after meet_sync fix — the merger creates duplicates:**
The meet_sync uploads corrected files as NEW files in Drive (doesn't update in place). The merger then sees both old and new copies. If the old copy is processed after the new one, it overwrites the corrected canonical with stale data. After reprocessing meet_sync files, you must either: (a) trash old stale copies from the Meet output folder before running merger, or (b) upload corrected canonical files directly to the Canonical folder bypassing the merger. The merger's `--reprocess` flag re-uploads everything including stale duplicates.

**Gemini format drift monitoring:** Gemini periodically changes its Google Docs export format (headers, bold wrapping, emoji usage). When meetings start showing up as empty_meeting: true unexpectedly, first check: export a known-good doc via `gws drive files export` and compare the actual header format against the regex patterns in `meet_sync.py`. The regex is the most fragile point in the pipeline.

**Plaud same-day visibility gap (most common reason an agent "can't find" a Plaud transcript):**
If Steve or another agent asks about a call from earlier today and it's not in G-Brain or the canonical Drive folder, check whether it's a Plaud-only recording. Plaud sync runs once daily at 5:30 PM — unlike Meet which syncs every 30 min. The recording exists in web.plaud.ai but hasn't been pulled yet. You can query Plaud directly via PlaudClient (see "When Plaud Drive sync is broken" section below) to confirm. If the `run_intraday.sh` fix has been applied (adding Plaud sync to the intraday loop), this gap no longer exists — check `run_intraday.sh` for a `sync.py` or Plaud line to verify.

**FIRST CHECK: Plaud plist script path drift (most common cause of Plaud sync stopping entirely):**
The `com.bookmarked.plaud-drive-sync.plist` `ProgramArguments` path has drifted before when the sync script was moved from Google Drive to the git repo. If Plaud produces zero new files for multiple days, check the plist path FIRST:
```bash
grep -A4 "ProgramArguments" ~/Library/LaunchAgents/com.bookmarked.plaud-drive-sync.plist
```
Correct path (as of 2026-06-10): `~/github-repos/bookmarked-os-private/claude-output/openclaw/plaud-drive-sync/sync.py`
If the path is wrong, fix it, then reload: `launchctl unload ... && launchctl load ...`
After fixing, run a manual backfill: `cd ~/github-repos/bookmarked-os-private/claude-output/openclaw/plaud-drive-sync && /Users/stevewandler/.local/share/uv/tools/plaud-mcp/bin/python sync.py --days 30`

**Plaud sync DNS failure (httpx.ConnectError: nodename nor servname provided):**
Plaud Desktop sync calls web.plaud.ai. If launchd fires during sleep/wake or before network is up, DNS resolution fails. The job silently no-ops. As of 2026-06-10, a network preflight check was added to sync.py — it calls `socket.getaddrinfo("api.plaud.ai", 443)` before hitting the API and exits with code 4 if DNS fails (clean exit, no crash, retries next run). If you see `ERROR: Cannot reach api.plaud.ai` in the log, it's a timing issue, not a credentials issue. Not a credentials issue — just timing. Check `plaud-drive-sync.err` for `ConnectError`. The job will catch up on the next run. If it never catches up, a backfill run is needed.

**gws transient failures in pipeline scripts (meet_sync, merger, extract_signal):**
These scripts all use a `run_gws()` helper that calls `gws drive files list` as a subprocess. As of 2026-06-10 the helper was patched to retry 3× with exponential backoff (1s, 2s). If you see `gws failed after 3 attempts` in the error log, the token is genuinely broken — re-run `GOOGLE_WORKSPACE_CLI_KEYRING_BACKEND=file gws auth status` and confirm `token_valid: true`. Single-shot failures that don't repeat are normal transient noise. The fix pattern if you need to apply it to a fresh copy:
```python
def run_gws(args, output_file=None, retries=3):
    import time
    cmd = [GWS] + args
    if output_file:
        cmd.extend(["--output", str(output_file)])
    last_err = ""
    for attempt in range(retries):
        res = subprocess.run(cmd, capture_output=True, text=True, check=False)
        if res.returncode == 0:
            return res.stdout
        last_err = res.stderr.strip() or "(no stderr)"
        if attempt < retries - 1:
            time.sleep(2 ** attempt)
    raise RuntimeError(f"gws failed after {retries} attempts: {' '.join(args[:3])}\nstderr: {last_err}")
```

**gws Tasks scope missing on steve@bookmarked.com:**
The `gws` CLI credential for `steve@bookmarked.com` does NOT have the Tasks API scope. `gws tasks tasklists list` returns 403. Use the Hermes google_token.json via the Google Tasks API Python client instead. CEO Daily task list ID: `VFg2a2NjWF8xN21IakEyUg`.


Drops undated meeting pages (the `meeting-YYYY-MM-DD-*` slug pattern). Run without date flags.

**Gemini export format changes (bold headers, Jun 2026):**
Gemini periodically changes its Google Docs export format. As of mid-June 2026, headers switched from `# 📖 Transcript` to `# **📖 Transcript**` (bold-wrapped). The `TRANSCRIPT_HEADER_RE` and `NOTES_HEADER_RE` regexes in `meet_sync.py` must handle both formats. If empty_meeting false positives appear, FIRST check whether the regex matches the current Gemini header format by exporting a known-good doc and inspecting the actual markdown headers. The regex fix (Jun 18 2026) uses `\**` to accept optional bold wrapping.

**`has_gemini_notes` must be independent of `empty_meeting`:**
A meeting can have Gemini notes (summary, decisions) but a short or empty transcript. The `has_gemini_notes` flag should evaluate the notes section content directly (> 200 chars after stripping boilerplate), NOT be set as `not empty`. Fixed Jun 18 2026 in `meet_sync.py`.

**Auditing empty_meeting false positives:**
To find false positives: `grep -rl "empty_meeting: true" ~/My Drive/Transcripts/Canonical/` then cross-reference against .gdoc files in Google-Meet (1)/ by date + meeting name keywords. Note: many "false positives" are actually correct — Gemini docs exist but contain "A summary wasn't produced" placeholder text. Download and inspect the actual export content before assuming a false positive.

**Reprocessing corrected files through the pipeline:**
1. Run `meet_sync.py --file-id <id> --reprocess` for each affected source doc
2. Run `merger.py --days N --reprocess` to regenerate canonical files
3. Meet output folder accumulates duplicates (old + new) — merger may pick the old one. Verify canonical output, not just meet_sync output.
4. Direct upload to Canonical folder may be needed if merger grabs stale duplicates.

**Scripts use `gws` not direct Google API:**
All scripts (meet_sync.py, merger.py, extract_signal.py) call `gws` as a subprocess. If `gws` isn't in the PATH that launchd uses, everything silently fails. The plists include `/Users/stevewandler/.npm-global/bin` in PATH — that's where `gws` lives. Confirm with `which gws`.

**Duplicate ingestion prevention:**
The merger already handles this. When Meet + Plaud exist for the same meeting (matched by date + start time ±5 min), Meet is primary and Plaud body is dropped. Only one canonical file is written. No separate dedup step needed.

**Gemini summary vs full transcript:**
Steve's preference is the full transcript, NOT the Gemini summary. The canonical format preserves Gemini Notes in HTML comment fences (`<!-- gemini-notes-start --> ... <!-- gemini-notes-end -->`) for reference only. The G-Brain extraction pass uses the full transcript body between `<!-- transcript-start -->` and `<!-- transcript-end -->`. Do not flip this.

**G-Brain content-sanity warnings on large transcript files (>50KB):**
When `gbrain sync` logs `content-sanity warn: <slug> (N bytes) — exceeds warn threshold, consider splitting`, those transcripts are being chunked poorly — long conversations are partially retrieved or missed entirely in search. Fix: split each oversized file at a natural timestamp break into two part files (~25KB each), preserving ALL content and YAML frontmatter (add `part: 1` / `part: 2` field). The split files must be committed to the git repo and then a `gbrain sync --source <source> --full` run to re-ingest.

Teresa transcripts in `~/github-repos/bookmarked-strategy/drive/teresa-schindelbeck/transcripts-teresa/` are the primary culprits — confirmed split 2026-06-10 (8 files → 16 part files at natural timestamp breaks). This materially improves retrieval quality for relationship-context queries. If transcript search quality seems poor for a specific person, check file sizes first.

**Delegate the split work to a subagent** — do not do it in the main session (too many files, tedious). Prompt:
> "Split oversized transcript markdown files into part-1 and part-2 at natural timestamp midpoints. Keep ALL content. Preserve YAML frontmatter in both parts, adding `part: 1` or `part: 2`. Delete the original. Commit and push when all files are done."
Subagent needs `terminal` and `file` toolsets. Provide the list of files and their directory. A Haiku subagent handles this well — 8 files took ~6 minutes. After the agent completes, run `gbrain sync --source <source> --full` to re-ingest the split files. The next Teresa query will retrieve from the correct half of each conversation.

**Finding oversized files before they cause problems — search the whole repo, not just transcripts:**
```bash
# All files over 50KB in a repo (covers transcripts, gdocs, everything)
find ~/github-repos/<repo> -name "*.md" -size +50k 2>/dev/null | grep -v teresa | sort
# Files over 50000 bytes need splitting
```
The `gdoc/` directory in bookmarked-strategy also accumulates oversized files — weekly Water Cooler all-hands meetings grow to 60KB+. Check gdoc/ as well as transcript directories. Confirmed split 2026-06-10: 6 Water Cooler files in `bookmarked-strategy/gdoc/all-hands-watercooler-*` → 12 part files.

**Plaud backlog:**\nAs of 2026-06-09, ~571 Plaud transcripts were unsynced historically (from before the pipeline was built). The plaud-drive-sync job only looks back `--days 2` by default. Backfill requires running with a wider window or using `backfill_plaud.py`.

**When Plaud Drive sync is broken — query Plaud directly via PlaudClient:**\nThe plaud-mcp package includes a `PlaudClient` that hits the Plaud REST API directly using the token from the Plaud Desktop app's LevelDB storage. Use this to find and read transcripts when the Drive sync pipeline is broken. Run with `~/.local/share/uv/tools/plaud-mcp/bin/python` (NOT system python).

```python
import asyncio, sys
from datetime import datetime
sys.path.insert(0, "/Users/stevewandler/.local/share/uv/tools/plaud-mcp/lib/python3.12/site-packages")
from plaud_mcp.plaud_client import PlaudClient

async def main():
    client = PlaudClient()
    # Get all files (1985+ in account as of Jun 2026)
    files = await client.get_all_files(sort_by="start_time", is_desc=True, page_size=100)
    
    # ⚠️ TIMESTAMPS ARE IN MILLISECONDS — divide by 1000 for datetime
    # (using seconds gives year 58408 — the tell-tale sign of a ms/s confusion)
    target_ms = 1748491200000  # May 29 2026 CDT
    
    for f in files:
        st = f.get("start_time", 0)
        if st > target_ms:
            dt = datetime.fromtimestamp(st / 1000).strftime("%Y-%m-%d %H:%M")
            dur_min = f.get("duration", 0) // 60000
            name = f.get("filename") or "(unnamed)"
            fid = f.get("id", "?")
            print(f"{dt} | {dur_min}m | {name} | {fid}")

asyncio.run(main())
```

To get transcript for a specific file:
```python
transcript = await client.get_transcript(file_id)  # returns list of segments
for seg in transcript:
    print(f"[{seg.get('spk','')}]: {seg.get('content','')}")
```

Available methods: `get_all_files()`, `get_file_detail(id)`, `get_transcript(id)`, `get_summary(id)`, `get_recent_files()`, `get_file_count()`.

---

## Full Recovery Backfill (after a gap > 2 days)

When Plaud sync has been broken for days/weeks, do these in order. Each step depends on the previous completing successfully.

**Step 1 — Fix the root cause first.** Don't backfill until the ongoing pipeline is repaired or you'll just re-accumulate debt.

**Step 2 — Plaud Drive backfill:**
```bash
cd ~/github-repos/bookmarked-os-private/claude-output/openclaw/plaud-drive-sync
# Dry run first to see count:
/Users/stevewandler/.local/share/uv/tools/plaud-mcp/bin/python sync.py --days 30 --dry-run 2>&1 | head -5
# Then for real:
/Users/stevewandler/.local/share/uv/tools/plaud-mcp/bin/python sync.py --days 30 2>&1
```
Note: only shows "new candidate(s)" — files already in Drive are skipped (idempotent). Expect the dry-run count to be higher than actual if some files were already there.

**Step 3 — Merger backfill:**
```bash
cd ~/conductor/workspaces/gbrain-mcp/doha/scripts
GOOGLE_WORKSPACE_CLI_KEYRING_BACKEND=file \
/Users/stevewandler/.local/share/uv/tools/plaud-mcp/bin/python merger.py --days 30 2>&1
```
Watch for the groups summary line: `groups: N total = meet+plaud:X meet-only:Y plaud-only:Z`
This confirms the merger matched files correctly.

**Step 4 — Extract + write to G-Brain:**
```bash
cd ~/conductor/workspaces/gbrain-mcp/doha/scripts
GOOGLE_WORKSPACE_CLI_KEYRING_BACKEND=file \
/Users/stevewandler/.local/share/uv/tools/plaud-mcp/bin/python extract_signal.py --days 30 2>&1
```
This is the slow step — LLM call per file. 34 files ≈ 8-10 minutes. Run in background:
```bash
# Background with output capture:
GOOGLE_WORKSPACE_CLI_KEYRING_BACKEND=file \
/Users/stevewandler/.local/share/uv/tools/plaud-mcp/bin/python extract_signal.py --days 30 > /tmp/extract-out.txt 2>&1 &
# Monitor:
tail -f /tmp/extract-out.txt
```

**Step 5 — Queue an embed pass** to vector-index the new pages:
```bash
# Via G-Brain MCP (preferred — uses the running jobs worker):
# submit_job name=embed
# OR via gbrain CLI:
gbrain embed
```

**Step 6 — Create a Google Task** in CEO Daily to record what was ingested (use Tasks API via google_token.json, not gws — gws Tasks scope not enabled for steve@bookmarked.com).

**Interpreter note:** ALL pipeline scripts use `#!/Users/stevewandler/.local/share/uv/tools/plaud-mcp/bin/python` as their shebang and require plaud_mcp to be importable. Do NOT run them with `~/.hermes/hermes-agent/venv/bin/python3` or system python — `import plaud_mcp` will fail.

---



## Accessing Transcript Content Referenced in Slack

When Steve says "Jan sent me a deck/link in Slack" — Slack DM content is NOT accessible via any pipeline tool (no Slack API configured, not indexed in G-Brain, not in the git repos). Options:
1. Ask Steve to paste the URL/link directly into the chat
2. The canonical transcript itself will contain whatever was *discussed* about the deck (read the transcript)
3. G-Brain may have context from prior sessions if the deck was shared earlier

Do not spend time searching Drive, Gmail, or repos for a link that was shared as a Slack DM — it won't be there.

---

To find gaps (meetings in canonical folder but not in G-Brain):
```bash
# List canonical files from last 14 days
export PATH="/Users/stevewandler/.npm-global/bin:$PATH"
GOOGLE_WORKSPACE_CLI_KEYRING_BACKEND=file gws drive files list \
  --params '{"q": "'\''1NaJU9iSVLNqBkh7snILsF33nlATybbF3'\'' in parents and trashed = false", \
             "fields": "files(id,name,modifiedTime)", "pageSize": 50, "orderBy": "modifiedTime desc"}' \
  2>/dev/null
# Then cross-reference against G-Brain: gbrain search "meeting-YYYY-MM-DD"
```

---

## Reference Files
- `references/pipeline-audit-2026-06-10.md` — full audit of pipeline health as of 2026-06-10
- `references/pipeline-audit-2026-06-18.md` — Gemini bold header format change
- `references/pipeline-v2-railway.md` — Railway-native replacement (v2) — Conductor pipeline stopped 2026-06-22
