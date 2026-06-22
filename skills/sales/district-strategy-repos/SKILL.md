---
name: district-strategy-repos
description: "Private GitHub repos as portable strategy context for districts, partners, and organizations — branch structure, file conventions, cross-session continuity."
version: 1.0.0
author: agent
tags: [bookmarked, strategy, github, districts, talas, context-management, cross-session]
---

# District & Partner Strategy Repos

Steve uses private GitHub repos to store portable strategy context that survives across sessions and can eventually be shared with partners. This is the pattern for how that works.

**Load this skill when:**
- Starting or continuing district strategy work (Garland ISD, Mesquite, etc.)
- Working on TALAS or other partner organization strategy
- Needing to pick up a strategy thread from a previous session
- Setting up a new district or partner context repository

---

## The Two-Repo Pattern

### `stevewandler/gbrain-mcp` — Org strategy and intelligence
Used for Bookmarked's broader strategy assets: district research, GTM briefs, IMTA research, TALAS organizational strategy.

**Branch conventions:**
- `School-Districts` — district-specific strategy (Garland ISD, Mesquite ISD, etc.)
- `IMTA-Research` — IMTA funding research and district data
- `TALAS-Strategy` — TALAS organizational strategy (Steve's POV, not shareable with Michael as-is)

**Folder structure:**
```
districts/<district-slug>/
  README.md          — thread index, current state, where context lives
  sales-strategy.md  — close strategy
  05-29-meeting-notes.md  — source meetings
strategy/
  gtm-product-model-input.md  — portable GTM brief
  imta/                       — IMTA research hub
organizations/
  talas/                      — TALAS org strategy
```

### `stevewandler/Ruiz-Wandler` — Personal collaboration
Used for Steve's personal working relationship with Michael Ruiz — shareable with Michael eventually. Contains what Steve is building FOR him, not strategy ABOUT him.

**Folder structure:**
```
README.md                    — relationship framing, current state
michael-ai-setup.md          — what's deployed, workflow loops, next steps
brain-context/               — TALAS mission, strategic priorities, Lopez vision placeholder
sessions/                    — notes from working sessions
ideas/                       — concepts in progress
talas-ntx-ai-proposal-v2.html  — the visual one-pager for the board
```

---

## The Key Boundary

| Belongs in `gbrain-mcp/organizations/talas/` | Belongs in `Ruiz-Wandler/` |
|----------------------------------------------|---------------------------|
| Steve's strategic POV on TALAS as an org | What Steve is building for Michael personally |
| Why TALAS matters for Bookmarked (network play) | Michael's AI setup and workflow loops |
| Chapter membership strategy | Session notes from their working sessions |
| The statewide research and ingestion | The one-pager Steve sends to Michael |
| Context Steve wouldn't hand to Michael unfiltered | Context Michael has equal claim to |

**Rule of thumb:** If it would be awkward for Michael to read it, it goes in `gbrain-mcp`. If it's something you'd hand him directly, it goes in `Ruiz-Wandler`.

---

## Cross-Session Pickup

When picking up a strategy thread from a previous session:

1. **Clone the repo to `/tmp/`** — repos are private so they need credentials:
   ```bash
   git clone https://github.com/stevewandler/gbrain-mcp.git /tmp/gbrain-mcp
   cd /tmp/gbrain-mcp && git checkout School-Districts
   ```
   If 404, the repo is private — Steve needs to have cloned it first in his terminal, then you can clone using the existing git credentials.

2. **Read in order:** README.md first (thread index), then the relevant strategy file, then meeting notes. The README always says what the current state is and what the next decision is.

3. **Commit work back to the same branch** — always push before ending a session. Future sessions should start from committed state.

4. **Don't hallucinate file contents.** If the clone fails or returns 404, say so and ask Steve to clone it manually rather than fabricating content. Previous sessions' subagents hallucinated plausible-looking content when the private repo wasn't accessible — this is dangerous.

---

## File Conventions

Every district or partner folder should have:

- `README.md` — index: current state, key people, files in folder, where the rest of context lives (G-Brain pages, Plaud recordings, related repos), two threads to pick up
- Strategy files should start with a "where we left off" or "current state" block
- Meeting notes should reference their Plaud recording hash if available
- Open questions should be clearly marked and owned

---

## IMTA Research (committed reference)

Full IMTA research lives in `gbrain-mcp/strategy/imta/`:
- `README.md` — key numbers, Garland $2.17M, statewide $1.4B unspent
- `imta-primer.md` — what IMTA is, statute, allowable uses, bank mechanics
- `imta-district-data.md` — finding balances, Fund Code 420, Appendix A dataset
- `imta-eligibility-and-approach.md` — Bookmarked's eligibility case, sales motion, procurement path

**Key numbers:**
- Garland ISD unspent IMTA: **$2.17M** (Jan Gilboy, TEA EMAT report 2026-06-08)
- Garland biennial allotment: **$9,209,796.16** (from TEA 2026-27 allotment PDF)
- Use the $2.17M in conversations — it's what's available NOW, not a forward projection
- Rate: $174.69/student biennial (not $120/year — the TEA PDF is biennial)
- ESC 16 = fiscal agent for IMTA procurement → no RFP required

---

## TALAS Research (committed reference)

Full TALAS research lives in `gbrain-mcp/organizations/talas/`:
- `talas-website-full-ingestion.md` — complete crawl of talasedu.org
- `talas-statewide-research.md` — leadership, chapters, events, membership
- `talas-ntx-chapter-research.md` — NTX chapter specifics, people, gaps
- `talas-overview.md` — mission, NTX stats, strategic priorities (Michael's words)

**Key facts:**
- NTX chapter is 1 year old, zero independent digital presence
- 47 members, 14 districts, 7-person board
- Bryan McCorkle (NovoDia) sponsored the chapter — already a paid partner
- Summer Leadership Summit: June 22-23, 2026, Austin (statewide — worth attending)
- Jennifer = board member who wants AI sessions; full name/contact TBD from Michael

---

## Plaud Transcript Access

Plaud transcripts are accessible via the `plaud-mcp` client installed at `/Users/stevewandler/.local/share/uv/tools/plaud-mcp/`:

```python
import sys, asyncio
sys.path.insert(0, "/Users/stevewandler/.local/share/uv/tools/plaud-mcp/lib/python3.12/site-packages")
from plaud_mcp.plaud_client import PlaudClient

async def main():
    client = PlaudClient()
    files = await client.get_all_files(sort_by="start_time", is_desc=True, page_size=100)
    # timestamps are in MILLISECONDS — divide by 1000 for epoch seconds
    # get_transcript(file_id) returns list of segments with 'spk' and 'content' fields
    transcript = await client.get_transcript(file_id)

asyncio.run(main())
```

**Pitfall:** Plaud timestamps are milliseconds not seconds. `datetime.fromtimestamp(ts/1000)` not `datetime.fromtimestamp(ts)`. Files have no names (field is `filename`, often None) — identify by date and duration.

**Plaud Drive sync** stopped at May 20, 2026 — transcripts after that date are only in the Plaud app, not in Drive. Fix the sync pipeline separately.

---

## Reference Files
- `references/talas-people-registry.md` — names, roles, contacts for NTX TALAS board and statewide leadership; who's known (Michael, Bryan, Jennifer first name only, Taylor), who's unknown (other 5 board members, Jason's last name), statewide roster with Dr. Stephanie Elizalde (Dallas ISD) flagged as key proximity

## Confluence Access (Bookmarked team wiki)

Bookmarked uses Atlassian at `bookmarked-team.atlassian.net`. Credentials in `~/.config/.jira/.config.yml` (API token works for both Jira and Confluence). Search Confluence via REST:

```python
import urllib.request, json, base64, re

TOKEN = "<from ~/.config/.jira/.config.yml>"
EMAIL = "steve@bookmarked.com"
BASE = "https://bookmarked-team.atlassian.net"

# Search
url = f"{BASE}/wiki/rest/api/content/search?cql=text+%7E+%22IMTA%22+AND+type+%3D+page&limit=20"
creds = base64.b64encode(f"{EMAIL}:{TOKEN}".encode()).decode()
req = urllib.request.Request(url, headers={"Authorization": f"Basic {creds}"})
with urllib.request.urlopen(req) as r:
    results = json.loads(r.read())

# Fetch page content (strip HTML)
def get_page(page_id):
    url = f"{BASE}/wiki/rest/api/content/{page_id}?expand=body.storage"
    req = urllib.request.Request(url, headers={"Authorization": f"Basic {creds}"})
    with urllib.request.urlopen(req) as r:
        d = json.loads(r.read())
    body = d.get("body", {}).get("storage", {}).get("value", "")
    text = re.sub(r"<[^>]+>", " ", body)
    return re.sub(r"\s+", " ", text).strip()
```

**Jan Gilboy's IMTA research** lives in Confluence (Sales Hub space) — search for "IMTA Funding" to find her reference guide. It has the Bookmarked IMTA eligibility case in TEA's own language.

---

## The Michael Ruiz Two-Track Rule

When working on anything Michael-related, always clarify which track:

| Track 1 — Personal/Operational | Track 2 — TALAS Org | Track 3 — Commercial |
|--------------------------------|--------------------|--------------------|
| His AI habit, G-Brain, coaching | Board doc, member strategy | Bookmarked deal, IMTA |
| Lives in `Ruiz-Wandler/` | Lives in `gbrain-mcp/organizations/talas/` | Lives in `gbrain-mcp/districts/garland-isd/` |
| Michael can see all of it | Michael owns/co-authors it | Separate email thread |

**Internal strategy doc** (Steve only, not for Michael): `Ruiz-Wandler/strategy/internal-strategy.md` — the real goals, open questions, and cadence plan.

**Steve drives the cadence** with Michael — Michael will not initiate. Weekly touchpoint (text), monthly working session (in person). Don't wait for Michael to ask.

---

## TALAS Deliverables Created (2026-06-10)

All committed to `stevewandler/Ruiz-Wandler` (main branch):

| File | What it is |
|------|-----------|
| `michael-onboarding-prompts.md` | 5 walk-and-talk prompts for Week 1 — context-building only, no pressure |
| `communications/text-michael-checkin.md` | Warm check-in text + follow-up cover note with prompts attached |
| `communications/email-michael-imta.md` | 6-sentence IMTA email — $2.17M, separate thread, no pricing pressure |
| `talas-board-doc-michaels-version.html` | Michael's board doc — his name, 4 options as menu, summer window framing |
| `talas-ntx-ai-proposal-v2.html` | Steve's version of the one-pager (TALAS branded, blue header with logo) |
| `strategy/internal-strategy.md` | Internal only — real goals, open questions, two-track framework, cadence |

The Google Doc version (`DRAFT — What if TALAS North Texas Led on AI?`) was created in `steve@bookmarked.com` Drive (doc ID: `1tde-4hcmxeB_ELDt6GlciT2xtjijMfaKUXjB_mPkWs8`) but still needs to be moved to the correct TALAS folder in the work Drive.

---

## Private Repo Access — Subagent Hallucination Risk

**Critical pitfall:** When a GitHub repo is private and unauthenticated, `curl` returns HTTP 404. Subagents delegated to fetch raw content from private repos do NOT fail gracefully — they return **plausible-looking hallucinated content** instead of an error. This is silent and dangerous.

**Detection:** If a subagent returns content for a private repo without being given credentials, assume it hallucinated. Verify by checking the HTTP status code directly:
```bash
curl -s -w '\nHTTP_STATUS:%{http_code}' 'https://raw.githubusercontent.com/user/private-repo/branch/file.md'
# If HTTP_STATUS:404 → file doesn't exist or repo is private
```

**Correct approach for private repos:**
1. Clone locally with credentials: `git clone https://github.com/user/repo.git`
2. Read files from disk with `read_file` — never delegate raw URL fetches to subagents for private repos
3. If the repo is already cloned locally, use `find` to confirm the path before reading

- `references/talas-ntx-context.md` — TALAS North Texas context: repos, key people, two-track framework, Drive location, IMTA details

## Pitfalls

- **Private repos return 404 to subagents** — subagents cannot access private GitHub repos via HTTPS without credentials. They will hallucinate plausible-looking content rather than erroring. Always clone repos yourself in your terminal before asking the agent to read them from `/tmp/`.
- **Don't mix the two tracks with Michael** — TALAS personal collaboration and the Bookmarked/IMTA deal are separate. Keep them in separate repos, separate emails, separate conversations.
- **Biennial vs. annual IMTA** — the TEA allotment PDF shows biennial totals (2-year). Divide by 2 for annual. The $2.17M carryover is what's actually sitting unspent — use that number, not the allotment.
- **TALAS NTX chapter URL has a wrong slug** — their chapter page is at `talasedu.org/chapters/costal-bend-2/` (an admin error in the CMS). Don't expect a clean URL like `/chapters/north-texas/`.
