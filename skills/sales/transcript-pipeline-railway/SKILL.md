---
name: transcript-pipeline-railway
description: "Hermes-native meeting transcript pipeline: pull Google Meet Gemini Notes, extract structured meeting data via LLM, and write G-Brain meeting pages. Runs as a cron job. Designed for Railway deployment — no Conductor, no Python scripts, no gws CLI."
triggers:
  - transcript pipeline
  - meeting ingestion
  - process transcripts
  - pull meet notes
  - extract meetings
version: 1.0.0
category: sales
---

# Transcript Pipeline — Hermes-Native (Railway Edition)

Replaces the Conductor-based pipeline (meet_sync.py → merger.py → extract_signal.py) with a single Hermes skill that runs as a cron job.

## Architecture

```
Google Calendar → Gemini Notes (auto-created on Meet calls)
                         │
                         ▼
                Drive folder: Meet source
                         │
                         ▼
              [this skill reads each doc]
                         │
                         ▼
              LLM extraction (structured meeting data)
                         │
                         ▼
              G-Brain meeting page (idempotent — skip if exists)
```

Plaud recordings are merged when available in Drive (uploaded by `plaud-drive-sync` on the laptop), but the pipeline does not block on Plaud availability.

## Drive Folder Map

| Folder | ID | Purpose |
|---|---|---|
| Meet source (Gemini Notes) | `1Y8y4BdUZUzU4Hyd2CdbJz36sDaAYbXDR` | Google Meet auto-creates Gemini Notes docs here |
| Plaud raw | `1CLTCzGz4CUBZ3BLHi7LzF-Fy5gG8hnRO` | plaud-drive-sync uploads here |
| Canonical | `1NaJU9iSVLNqBkh7snILsF33nlATybbF3` | Merged/processed transcripts |

## Cron Job Configuration

Register as a Hermes cron job:

```
Name: meet-sync-hourly
Schedule: every 60m
Skills: transcript-pipeline-railway, google-workspace, gbrain
Prompt: "Run the transcript pipeline for meetings in the last 2 hours. Load transcript-pipeline-railway skill and follow its execution protocol."
Deliver: local (no user output — pipeline writes to G-Brain)
```

## Execution Protocol

### Step 1: Find recent Gemini Notes

Search the Meet source folder for Gemini Notes docs modified in the last N hours (default: 2 hours for hourly runs, 24 hours for daily catch-up):

```bash
GAPI="python ${HERMES_HOME:-$HOME/.hermes}/skills/productivity/google-workspace/scripts/google_api.py"
$GAPI drive search "mimeType='application/vnd.google-apps.document' and '<MEET_SOURCE_FOLDER_ID>' in parents" --raw-query --max 50
```

Or use the `$GAPI drive search` with the folder constraint.

**When files are found:** Parse the results to get file IDs and names. Gemini Notes file names look like: `"Meeting Title - 2026 06 22 09:30 CDT - Notes by Gemini"`

### Step 2: Check for existing G-Brain pages (idempotency)

For each doc, derive the expected G-Brain meeting slug:
- Format: `meeting-YYYY-MM-DD-<slugified-title>`
- Check if page exists in G-Brain via MCP search

Skip if the meeting page already exists. This makes the pipeline safe to re-run.

### Step 3: Read the doc content

```bash
$GAPI docs get <DOC_ID>
```

Gemini Notes docs contain two sections:
- `📝 Notes` — Gemini's AI-generated summary (decisions, commitments, notes)
- `📖 Transcript` — Full meeting transcript (computer-generated, editable)

The skill reads BOTH sections. The transcript is the primary signal; the notes are cross-reference.

### Step 4: Handle edge cases

**Empty meetings:** If the transcript section is under 200 meaningful characters (after stripping boilerplate like "Transcription ended after...", "A summary wasn't produced..."), mark the meeting as `empty_meeting: true` but still create a page with whatever content exists. The Gemini summary may still have value even if the transcript is thin.

**Gemini format changes:** Gemini occasionally changes its export format (bold headers, emoji variations). The doc content is read directly from the API — no regex parsing required. The LLM extraction step handles format variability.

**Plaud availability:** If a Plaud recording exists in the Plaud folder for the same date ± time window, include its transcript as secondary source. Plaud is optional — pipeline does not wait for it.

### Step 5: Extract structured meeting data via LLM

Prompt the LLM (the skill runs as an agent, so the LLM IS the extractor) to produce:

```markdown
---
type: meeting
date: 2026-06-22
start_time: "09:30"
timezone: CDT
duration: "32m"
participants:
  - Steve Wandler
  - Jan Gilboy
scope: work
meet_drive_id: <DOC_ID>
canonical_drive_id: <CANONICAL_FILE_ID if saved>
---

**2026-06-22 · 09:30 CDT · 32m · Jan Gilboy & Steve Wandler**

[Meeting summary — 2-3 sentences]

## Decisions

- Decision 1
- Decision 2

## Commitments

### Person owes

- Commitment description

## Blockers

- Blocker description

## Risks

- Risk description

## Asks

- Person → Person: Ask description

## Operational notes

- Key operational detail

## Sources

- Canonical: My Drive/Transcripts/Canonical/<filename>.md
- Meet: Drive <DOC_ID>

## Linked

- People with pages: [[person-1]] · [[person-2]]
```

### Step 6: Create G-Brain meeting page

Use `mcp_gbrain_put_page` to create the page with slug `meeting-YYYY-MM-DD-<slugified-title>`.

**Meeting slug convention:**
- Named participants: `meeting-2026-06-22-jan-steve`
- Recurring meetings: `meeting-2026-06-22-dev-stand`
- Descriptive for ad-hoc: `meeting-2026-06-22-discussion-v2-migration`

### Step 7: Save canonical file to Drive (optional)

If the Canonical folder is accessible, write the structured markdown as a `.md` file:
```
My Drive/Transcripts/Canonical/YYYY-MM-DD_HHMM_<slug>.md
```

This preserves the canonical transcript for future re-processing.

## Google Auth on Railway

The skill uses the `google-workspace` skill's OAuth token. On Railway, the token file (`~/.hermes/google_token.json`) must be present on the persistent volume. If absent or expired, the skill logs the error and the cron failure alert fires.

**Token setup for Railway:**
1. Run the OAuth setup on the local Mac to generate `google_token.json`
2. Copy `google_token.json` and `google_client_secret_work.json` to the Railway volume at `/opt/data/`
3. The token auto-refreshes — no manual re-auth needed unless the refresh token expires (>6 months idle)

## Pitfalls

**Gemini doc format drift:** Gemini periodically changes the export format. Unlike the Conductor pipeline (which used brittle regex), this skill reads the full doc content and lets the LLM parse it. Format changes are handled by the LLM's natural language understanding.

**Rate limits:** Google Docs API has per-user quotas. Processing 50+ docs in a single run may hit limits. The hourly cron naturally spreads load — each run handles ~1-5 new meetings.

**Meeting page duplicates:** The idempotency check (Step 2) prevents duplicates. If a meeting was already ingested by a previous run, it's skipped.

**Plaud latency:** Plaud recordings sync to Drive only when the laptop runs `plaud-drive-sync` (every 15 min when laptop is on). If the laptop is off, Plaud recordings won't be available for merging. The pipeline still produces meeting pages from Gemini Notes alone.

**Token expiration:** Google OAuth refresh tokens expire after 6 months of inactivity. The pipeline runs hourly, so the token stays fresh. But if the Railway service is paused for months, the token will need re-auth.
