---
name: district-account-pickup
description: "Use when Steve needs to revive, understand, or re-engage a specific district/contact/account. Triangulate G-Brain + district dossier/repo + HubSpot + Google/Drive before recommending next action."
version: 1.0.0
author: agent
tags: [sales, districts, hubspot, gbrain, re-engagement, bookmarked]
---

# District Account Pickup

## Native Hermes Routing

Use when Steve says any variant of: "pick up [district/contact]", "I need to re-engage [customer]", "here's the context on [deal]", or hands over a block of reference IDs (HubSpot contact/company/deal IDs + G-Brain slugs + GitHub file path).

Source-of-truth order:
1. User-provided district/contact clue and any dossier path/IDs.
2. G-Brain for person, district, prior meetings, transcripts, and relationship context.
3. District dossier/repo paths if present; verify file existence before trusting.
4. HubSpot for live CRM/contact/company/deal state.
5. Google Drive/Gmail/Plaud for transcripts or recent correspondence when needed.
6. OpenMessage for text message / SMS / RCS history with contacts (MCP server at `http://127.0.0.1:7007/mcp/sse`; tools: `search_messages`, `get_person_messages`, `get_person_messages_range`). Steve uses Android/Google Messages — NOT iMessage. Check OpenMessage before concluding you can't see texts.

Output mode: brief Steve on current state, leverage point, risks, open questions, and the next best action. If drafting outreach, load `bookmarked-outreach-email` and `send-as-steve-email` before send mechanics.

**Do NOT use this skill for Bookmarked's company-level GTM / product / viral-adoption strategy work.** That's a separate ongoing initiative — load `bookmarked-strategy` instead.

---

## Trigger Signals

- "Pick up the [District] / [Contact Name] re-engagement project"
- "A deep research session was completed and the full dossier is saved at [path]"
- "Lisa's last email is unanswered" / "[Contact] hasn't heard from us since [date]"
- Block of HubSpot IDs + G-Brain slugs + GitHub dossier path handed over in one message
- Dossier lives in a GitHub branch (e.g. `stevewandler/gbrain-mcp` on branch `School-Districts`)

---

## Step-by-Step Workflow

### 0. Read the dossier from its GitHub location

District deep-dive dossiers for Steve live in the `stevewandler/gbrain-mcp` repo, under `districts/<district-slug>/deep-dive.md`, on the `School-Districts` branch. Use `gh api` — not curl with GITHUB_TOKEN, not browser:

```bash
gh api repos/stevewandler/gbrain-mcp/contents/districts/<slug>/deep-dive.md?ref=School-Districts \
  --jq '.content' | base64 -d
```

This repo is private. `gh api` uses the keyring credential and always works when `gh auth status` shows logged in.

**If the dossier has Open Questions at the bottom** — work through them before building a re-engagement plan. They are the blockers. Surface which ones you can answer from G-Brain/HubSpot and which ones only Steve can answer. Don't skip this step.

---

### 1. Verify the dossier exists before trusting it

When a GitHub file path is given (e.g. `bookmarked-strategy/districts/canyon-isd-xyz.md`), **check that the file actually exists before treating it as ground truth**. Research sessions sometimes document a planned file that hasn't been committed yet.

```bash
ls ~/github-repos/bookmarked-strategy/districts/ 2>/dev/null || echo "NO districts/ dir"
cat ~/github-repos/bookmarked-strategy/districts/<filename>.md 2>/dev/null || echo "FILE NOT FOUND"
```

If the file doesn't exist, proceed with G-Brain directly — it is the primary source of truth.

### Finding Plaud Transcripts for Non-District Contacts (VC/Investor/Partner)

Plaud transcripts for external calls (investors, partners, advisors) are NOT named after the contact — they get auto-named `untitled-meeting` unless Plaud identifies the context. The unlock is to **search Google Drive by company name or contact name**, not by date.

```bash
$GAPI drive search "Alexey" --max 10
$GAPI drive search "DFG" --max 10
$GAPI drive search "[company name]" --max 10
```

The transcript filename will follow the pattern: `YYYY-MM-DD_HHMM_<context-name>.md`
Plaud files have `type: plaud` in the frontmatter `sources` array.

When you find it, download and read — the transcript has full speaker dialogue even when G-Brain hasn't ingested it yet. The speaker labels may be wrong (Plaud sometimes misidentifies Steve as "Dawn Jordan" or other names) — this is a known Plaud transcription artifact, not a problem with the content.

**Timeline reconstruction:** If Steve says "I had a call with them a couple of weeks ago," triangulate from the email thread. The reply email that said "looking forward to our chat next week" + date sent = approximate call window. Search Drive for meetings in that 5-day window.

---

### Step 2: Pull G-Brain pages in parallel (via HTTP MCP)

Use `execute_code` with the runtime token pattern. Get all named pages simultaneously:

```python
import re, json, subprocess

with open('/Users/stevewandler/.hermes/config.yaml') as f:
    c = f.read()
m = re.search(r'Bearer (gbrain_[^\n"]+)', c)
token = m.group(1)

def gbrain_get(slug):
    payload = json.dumps({"jsonrpc": "2.0", "id": 1, "method": "tools/call",
                          "params": {"name": "get_page", "arguments": {"slug": slug}}})
    cmd = ['curl', '-s', '-X', 'POST', 'http://localhost:7432/mcp',
           '-H', 'Content-Type: application/json',
           '-H', 'Accept: application/json, text/event-stream',
           '-H', 'Authorization: Bearer ' + token,
           '-d', payload]
    result = subprocess.run(cmd, capture_output=True, text=True, timeout=30)
    for line in result.stdout.split('\n'):
        if line.startswith('data: '):
            try:
                return json.loads(line[6:]).get('result', {}).get('content', [{}])[0].get('text', '')
            except:
                pass
    return ''
```

Key pages to pull for any district account:
- Person page (e.g. `lisa-hill`)
- Org contact page if separate (e.g. `amanda-izzard` for champions)
- The most critical meeting slug (usually the most recent with decisions/commitments)
- Any earlier meeting slugs that created open commitments

### 2b. Finding Plaud transcripts when they're not in G-Brain

Plaud recordings of investor/partner calls often aren't ingested into G-Brain yet (they live in Drive but haven't been synced). The naive search for "plaud [name]" returns nothing. The correct pattern:

**Search Drive by company name or person name — not "plaud":**

```bash
$GAPI drive search "Alexey" --max 10
$GAPI drive search "[Company Name]" --max 10
```

Plaud transcripts have a specific filename pattern: `YYYY-MM-DD_HHMM_<title-slug>.md` and their frontmatter contains `type: plaud` and a `plaud_file_id`. The title slug is usually the best-guess meeting title Plaud assigned — which DOES include recognizable names/companies if Plaud identified them.

**If Drive search by name finds it:** download and read it. The meeting date in the filename tells you which call it is.

**If Drive search returns nothing useful:** search by date range instead — reconstruct the likely call date from the email thread (e.g. "Steve booked after May 12, Alexey said 'couple weeks ago' on June 1 → call was ~May 19-22") then search Drive for untitled meetings in that window:

```bash
$GAPI drive search "untitled meeting 2026-05" --max 20
```

Download and skim each one's frontmatter — Plaud files have `type: plaud` in sources; Google Meet files have `type: meet`. Check duration to narrow candidates (investor call = 30-60 min, not 3 min).

**Confirmed working (Jun 2026):** Found `2026-05-20_1100_investment-discussion-bookmarked-pitch-to-dgf-elements.md` via `drive search "Alexey"` after G-Brain search for "Alexey Korablev DFG" returned nothing useful. The filename included "dgf-elements" which matched the company name in the search.

---

### 3. Find the most recent email

Search G-Brain for the contact + timeframe:

```python
def gbrain_search(query, limit=8):
    payload = json.dumps({"jsonrpc": "2.0", "id": 1, "method": "tools/call",
                          "params": {"name": "search", "arguments": {"query": query, "limit": limit}}})
    # ... same curl pattern ...
```

Search: `"[Contact Name] [month/year] email"` and `"[District] renewal [year]"`.

Pull the actual email page via `gbrain_get(slug)` — the compiled_truth contains the full thread text.

### 4. Identify the re-engagement window

**First: establish data freshness.** Before reconstructing the timeline, check when the Gmail ingest last ran (look at the `date` frontmatter on the most recent `gmail/bm/` page for this contact). Compare against HubSpot's `notes_last_contacted` on the contact record. If HubSpot shows more recent activity than the latest Gmail page, tell Steve: "HubSpot shows contact on [date] but my email data only goes through [ingest date] — what did you send?" Also state upfront: "I can't see text messages — when did you last text them?"

Five things to extract:
1. **Last outbound action** — when was it, from whom, what did it ask? Check ALL channels: G-Brain email pages, HubSpot activity timestamps, AND OpenMessage text history. (Flag if this is based on incomplete data.)
2. **Last inbound response** — what did the contact say, what did they ask for?
3. **Days since unanswered** — is this still warm or going cold?
4. **Open commitments from Steve** — from meeting transcripts, what did Steve say he'd do?
5. **Communication channels used** — email, text (via OpenMessage), in-person? Note which channels you checked and which you couldn't access (e.g. OpenMessage not configured).

The window is open as long as: the contact's last message showed intent + no reply has been sent + the stated timeline hasn't passed.

### 5. Deliver the briefing

Structure:

```
## The Situation
[One-paragraph narrative. What is actually happening with this account right now.]

## What [Contact] Actually Needs
[What they're trying to accomplish. What they need from Steve to move forward. Distinguish between stated ask and real need.]

## Open Commitments (Steve owes)
[Bulleted list from meeting transcripts — date committed, what was promised, overdue flag if applicable]

## What Needs to Happen Right Now
[Numbered, specific. Not options — one path. Include: who sends the email, what it says, what dates/numbers go in it.]

## The Bigger Picture
[Why this account matters beyond the deal size. Strategic context. Pattern implications for other districts.]
```

### 5b. Check Confluence BEFORE doing web research on Bookmarked domain topics

Jan Gilboy maintains canonical Bookmarked sales reference pages in Confluence (Sales Hub space, `bookmarked-team.atlassian.net`). These pages have **better numbers and more accurate context** than general web research because they're authored with Bookmarked-specific knowledge:

- **IMTA Funding** (page 147488769) — correct formula ($174.69/student biennial, not $120/year), ESC 16 fiscal agent = no RFP required, eligible categories with TEA's own language, talk tracks, spend patterns
- **Market Intelligence — Texas Districts** (page 109412811) — live IMTA Intelligence Dashboard, Board Intelligence tiers, cross-signal analysis
- **Weekly Sales Updates** — current pipeline state

**Search Confluence first for any topic involving:** IMTA funding, district budget, compliance angles, ESC partnerships, product positioning, pricing.

```python
# Atlassian token is in jira CLI config at ~/.config/.jira/.config.yml
# OR in ~/.hermes/config.yaml under mcp_servers.atlassian.env.ATLASSIAN_API_TOKEN
import yaml, requests, re

# Primary: Hermes config
with open('/Users/stevewandler/.hermes/config.yaml') as f:
    c = f.read()
m = re.search(r'ATLASSIAN_API_TOKEN:\s*([^\n]+)', c)
if not m:
    # Fallback: jira CLI config
    with open('/Users/stevewandler/.config/.jira/.config.yml') as f:
        jira_cfg = yaml.safe_load(f.read())
    token = jira_cfg['api_token']
else:
    token = m.group(1).strip()

auth = ('steve@bookmarked.com', token)
r = requests.get(
    'https://bookmarked-team.atlassian.net/wiki/rest/api/content/search',
    auth=auth, headers={'Accept': 'application/json'},
    params={'cql': 'text ~ "IMTA" AND space = "SH"', 'limit': 10}
)
```

---

### 6. Check IMTA eligibility as a funding angle

IMTA (Instructional Materials and Technology Allotment) is a biennial per-student state funding allotment from TEA that Texas districts can spend on instructional materials, technology, and eligible software. Bookmarked/OnShelf qualifies under two TEA categories: (1) software that manages/inventories instructional materials, and (2) software that analyzes suitability of instructional materials.

**Key numbers (2026–27 biennium):** $174.69/student base rate. Many districts carry 18–22% unspent carryover. A $10K renewal is typically <1% of a mid-size district's annual IMTA allotment.

**The talk track:** When a district says "budget constraints," lead with IMTA before talking price. *"IMTA is available for most TX districts right now — and Bookmarked is eligible under two TEA categories. The funding usually isn't the blocker; it's the SB 13 compliance friction."*

**How to look up a specific district's IMTA allotment:**

```python
# Download the TEA 2026-27 IMTA allotment PDF and search it
import subprocess, re

r = subprocess.run(
    ['curl', '-sL',
     'https://tea.texas.gov/academics/instructional-materials/procure-instructional-materials-in-emat/2026-2027-imta-funds.pdf',
     '-o', '/tmp/imta-2627.pdf'],
    capture_output=True
)

# Extract text with pdftotext (macOS: available via `brew install poppler`)
result = subprocess.run(['pdftotext', '/tmp/imta-2627.pdf', '-'], capture_output=True, text=True)
lines = result.stdout.split('\n')

# Search for district (case-insensitive)
district = 'CANYON ISD'
for i, line in enumerate(lines):
    if district.lower() in line.lower():
        # Print ~8 surrounding lines — PDF columns appear as sequential lines
        for l in lines[max(0,i-2):i+8]:
            if l.strip():
                print(l)
        print('---')
```

**PDF column order:** CDN | District Name | District Enrollment | EB Enrollment | Student Allotment | EB Add-on | **Total Biennial Allotment**
Divide total by 2 for approximate annual budget.

**Confluence IMTA page (Sales Hub):** The canonical Jan-authored reference is at `https://bookmarked-team.atlassian.net/wiki/spaces/SH/pages/147488769/IMTA+Funding` — includes talk tracks, eligible categories, spend patterns, and the District Intelligence Portal pointer. Last updated June 8, 2026.

To query Confluence via REST (Python, using the token from config.yaml):
```python
import requests, re
with open('/Users/stevewandler/.hermes/config.yaml') as f: c = f.read()
token = re.search(r'ATLASSIAN_API_TOKEN:\s*([^\n]+)', c).group(1).strip()
auth = ('steve@bookmarked.com', token)
r = requests.get('https://bookmarked-team.atlassian.net/wiki/rest/api/content/search',
    auth=auth, headers={'Accept': 'application/json'},
    params={'cql': 'text ~ "IMTA" ORDER BY lastModified DESC', 'limit': 20})
```
**Note:** The Atlassian token in config must have Confluence scope. If you get 403 FORBIDDEN "Request rejected because caller cannot access Confluence," the token is Jira-only — Steve needs to generate a new token at `https://id.atlassian.com/manage-profile/security/api-tokens` and update `mcp_servers.atlassian.env.ATLASSIAN_API_TOKEN` in `~/.hermes/config.yaml`. Jira itself will still work with the old token.

**Canyon ISD IMTA (2026–27):** Total biennial allotment = **$2,027,584.87** (~$1M/year). At $10,598 renewal, that's ~1% of annual eligible spend. Not a budget problem — a paperwork problem. See `references/canyon-isd-lisa-hill-state.md` for full detail.

---

### 7. Research the contact's public profile before the meeting

When Steve asks for background on a contact, or you're building a re-engagement email and want to reference their specific credentials accurately — do this research proactively. It frequently surfaces more than the dossier has.

**Multi-step pattern that works for Texas education contacts:**

```bash
# Step 1: DuckDuckGo HTML search (POST, not GET — avoids bot detection)
curl -sL --data "q=Melissa+Leigh+Humble+ISD+Texas+librarian+award" \
  "https://html.duckduckgo.com/html/" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36" \
  > /tmp/ddg_results.html

# Step 2: Extract snippets
python3 -c "import re; body=open('/tmp/ddg_results.html').read(); \
snippets=re.findall(r'class=.result__snippet.[^>]*>(.*?)</a>',body,re.DOTALL); \
[print(re.sub(r'<[^>]+>','',s).strip()) for s in snippets[:15]]"

# Step 3: Resolve any bit.ly or short links to find the original press release
curl -sIL "https://bit.ly/XXXXXX" --max-time 10 | grep -i "location:"

# Step 4: Fetch the press release / award page
curl -sL "https://www.humbleisd.net/article/XXXXXXX" > /tmp/article.html
```

**What to check for Texas school library contacts specifically:**
- TASL (Texas Association of School Librarians) award page: `txla.org/awards-scholarships-stipends/unit-awards-scholarships/distinguished-service-school-administrators-award/` — has a full past-winners table
- TLA Librarian of the Year: `txla.org/awards-scholarships-stipends/tla-awards-scholarships/librarian-of-the-year/` — separate, higher-profile award
- District press releases at `[district].net/article/XXXXXXX` — usually the richest source
- TxASL Instagram `txasltla` — announces award winners in March/April each year

**Key distinction:** TASL Distinguished Library Service Award for School Administrators ≠ TLA Librarian of the Year.
- TASL award = recognizes administrators (non-librarians) who champion library services. Given by the school librarians' association.
- TLA Librarian of the Year = recognizes practicing librarians. Given by Texas Library Association. More prominent in general press.
- Steve internally described Melissa as "Librarian of the Year" — the substance is right (she is one of the most recognized school library administrators in Texas) but the precise award name is TASL Distinguished Library Service Award for School Administrators.

### 8. Draft the reply email — calibrate pricing to what the contact actually asked

**Two situations, two approaches:**

**A. Contact explicitly asked for a cost estimate:** Lead with the number. Give the real rate, signal flexibility without committing, plant the IMTA seed in the same email. Burying the number when they asked for it reads as evasive.

Pattern (Canyon ISD / Lisa Hill, Jun 2026): Acknowledge delay in one clause → confirm meeting, put date entirely on them → state rate directly ("Our standard rate for 26/27 is $3 per student, which puts Canyon at $31,794") → signal flexibility ("we're going to figure something out — Canyon has been one of our best partners") → plant IMTA seed in one conversational paragraph → close short, sign "Steve".

**B. Contact has NOT asked for pricing:** Don't front-load. The email's job is locking the meeting. Say you want to come prepared with the right numbers and would rather do it in person.

**On social offers (dinner, staying over):** Honor the personal layer — it's what makes it a relationship and not just a CS renewal. But frame as an open offer, not a commitment. "Maybe we grab dinner" not "I'm holding you to dinner." They may have family, a long drive home, schedule constraints. Light open offer lets them say yes without pressure, decline without awkwardness.

When the contact is a trusted advisor / personal relationship (co-presenter, multi-year champion, someone who has dinner with Steve), the email has one job: **lock the meeting**. Not close the renewal.

Pattern confirmed from Canyon ISD / Lisa Hill (Jun 2026) — when they DID ask for pricing:
- Acknowledge the delay in one clause that acknowledges it's been busy for both of them, not just Steve. "It's been a busy stretch on both our ends" — don't make the apology one-sided.
- Confirm the meeting warmly and leave the date entirely to them: "Name the date and time and I'll drive out."
- Since she asked for a cost estimate, give her the number directly. State the rate, then the district total: "Our standard rate for 26/27 is $3 per student, which puts Canyon at $31,794 for the year."
- Signal flexibility without making a commitment you'll regret. The formula: acknowledge budget pressure plainly, then say you'll figure it out together. E.g.: "I know the district is facing some real budget pressure right now — let's figure out together what works." NOT vague metaphors like "I know what the district is carrying" — that doesn't mean anything to the reader.
- Plant the IMTA seed in the same email once you have the number and the flexibility signal in place. Cite TEA as the source — it makes it credible, not a sales claim: "According to TEA, it looks like Canyon ISD still has IMTA funding available for 26/27, and Bookmarked qualifies as an eligible spend under two TEA categories."
- If there's a personal layer (dinner after, staying the night, "hit the town"), honor it — but as an open offer. "If schedules allow, maybe we grab dinner" — not "I'm holding you to dinner after."

On budget pressure language: be plain and specific. "The district is facing some real budget pressure" or "I know Canyon is dealing with real budget constraints" — not abstract phrases like "I know what your district is carrying." Loaded metaphors that don't have clear referents make Steve sound like he's reaching.

Always offer to draft the reply before Steve asks. Format: short, warm, Steve's register (see `steve-email-voice`), ends with "Steve" alone.

---

## Finding and Reading the Actual Proposal (Gmail + Drive)

When you need the full proposal context — not just the email thread — pull and read the PDF:

```bash
GAPI="~/.hermes/hermes-agent/venv/bin/python3 ~/.hermes/skills/productivity/google-workspace/scripts/google_api.py"

# 1. Search Gmail for the thread
$GAPI gmail search "to:contact@district.net OR from:contact@district.net" --max 20

# 2. Search Drive for the proposal doc
$GAPI drive search "district name proposal" --max 10

# 3. Download the PDF
$GAPI drive download DRIVE_FILE_ID --output /tmp/district-proposal.pdf

# 4. Extract text (pdftotext is available on macOS via Homebrew poppler)
pdftotext /tmp/district-proposal.pdf -
```

**Why this matters:** The proposal PDF contains the exact pricing tiers offered, the branding/product name used, the deadline framing, and the ROI math — details that may differ from what Steve remembers or what's in G-Brain. Always cross-check before drafting a follow-up.

**Branding note for Bookmarked:** Product has been referred to as both "Bookmarked" and "OnShelf" across different proposals. Check the actual PDF — don't assume the current brand name matches what was sent to this district.

**Expired deadlines:** Check whether a discount deadline was in the proposal and whether it has passed. This is often an elephant-in-the-room that needs addressing before re-engagement.

---

## HubSpot Reference Pattern

When HubSpot IDs are provided:
- Contact ID → look up in G-Brain via `gbrain_search("[Contact Name] HubSpot email")`
- Deal ID → search for renewal deal in G-Brain `"[District] renewal deal [year]"`
- The G-Brain person page usually has relationship status + open threads already synthesized

Don't make direct HubSpot API calls unless G-Brain doesn't have what you need — G-Brain is already synced and searchable.

---

## Finding Meeting Transcripts (Plaud + Google Meet)

Meeting transcripts for a contact may live in one of three places:

1. **G-Brain** — if the Plaud/Meet file was ingested via the Google Drive API sweep. Search: `gbrain search "[Contact Name] meeting"` or `gbrain search "[Company/topic] call"`. This is the first check but NOT guaranteed to have everything.

2. **Google Drive (date-range search)** — Plaud recordings sync to Drive as markdown files named `YYYY-MM-DD_HHMM_untitled-meeting.md` or `YYYY-MM-DD_HHMM_[title].md`. If G-Brain search comes up empty, pull Drive directly:
   ```bash
   $GAPI drive search "untitled meeting YYYY-MM" --max 20
   ```
   Then download the candidates by date and scan for speaker names or topic keywords in the frontmatter/summary section. Google Meet transcripts use the same naming pattern.

3. **Not yet ingested** — Plaud recordings are synced to Drive but not always ingested into G-Brain in the same sweep. If the Drive search finds a candidate file that isn't in G-Brain, download it directly and read it.

**Timing heuristic:** Work backward from the email thread. If an investor says "great speaking with you a couple of weeks ago" in a June 1 email, the call was ~May 15-22. Narrow the Drive search to that 2-week window.

**Plaud + Google Meet both create "untitled-meeting" files.** If the call was on Zoom with Plaud recording, the file will have `type: plaud` in the frontmatter sources. Google Meet calls have `type: meet`. Both follow the same filename pattern.

**If you can't find the transcript:** Don't block on it. The email thread itself usually contains enough context (what the contact is asking for, what was committed to on the call). A missing transcript is not a blocker — proceed with what the email gives you and flag to Steve that the specific call details weren't available.

---

## Pitfalls

- **Stalled accounts have 6 standard diagnostic questions — answer them before building a plan.** For any account where the dossier flags open questions, work through: (1) Was the MSA/contract ever signed? (2) What specific event caused comms to go dark? (3) Is Steve still personally warm with the champion? (4) Was the product actually deployed, or just agreed to? (5) Who should own re-engagement — Steve (champion relationship) or Jan/Teela (ops)? (6) Is there a partner angle (Moak Casey, ESC)? These are not optional background — they determine the entire re-engagement strategy.

- **Steve should always open the door when the relationship is personal.** If the champion co-presented a webinar, took a call with Steve, or has a personal equity narrative — the first re-engagement message must come from Steve, not the CS team. Sending Jan or Teela first reads as a demotion. Steve restarts, then hands off deliberately.

- **Use `gh api` to read dossier files — not `git clone --sparse`.** Both work, but `git clone --sparse` takes 3–4 terminal calls (init, set sparse-checkout, checkout, read) and leaves a temp directory to clean up. `gh api repos/owner/repo/contents/path?ref=branch --jq '.content' | base64 -d` is one call, no disk footprint, same result. Always prefer it.

- **Private GitHub repos return 404 — identical to missing.** Steve's district strategy repos (e.g. `stevewandler/gbrain-mcp`) are private. `curl`, browser tools, and web-fetching subagents all get HTTP 404 — which looks identical to "repo doesn't exist." **Subagents given a private raw URL will hallucinate plausible-looking file content instead of failing cleanly — they do NOT error out, they return invented markdown that looks real.** This has happened multiple times. Do NOT use `delegate_task` or browser to fetch private repo files.

  **Two correct paths (prefer gh api, fall back to git clone):**

  ```bash
  # Option A — gh api (fastest, no disk footprint)
  gh api repos/stevewandler/gbrain-mcp/contents/districts/garland-isd/README.md?ref=School-Districts \
    --jq '.content' | base64 -d

  # Option B — git clone (use when reading multiple files from same branch)
  git clone --branch School-Districts --depth 1 \
    https://github.com/stevewandler/gbrain-mcp.git /tmp/gbrain-mcp
  # Then: read_file /tmp/gbrain-mcp/districts/garland-isd/README.md
  ```

  If Steve says "it should be in GitHub" but a fetch returns 404 or empty content — stop immediately and ask Steve to verify credentials or paste the content directly. Do NOT retry with curl, web_extract, or delegate_task.

- **Referenced dossier files may not exist.** Steve sometimes describes a planned file as if it's complete. Verify with `ls`/`cat` before assuming it's there. If missing, proceed with G-Brain — it IS the source of truth.

- **The districts/ folder may not exist yet.** `bookmarked-strategy/districts/` is a planned directory structure. File the observation and proceed without it.

- **Don't confuse relationship status labels.** G-Brain person pages sometimes say "active prospect / in trial" while HubSpot shows the deal as "customer." Trust the HubSpot deal stage for commercial status; trust G-Brain meeting transcripts for actual relationship dynamics.

- **Check OpenMessage for text messages BEFORE saying you can't see texts.** Steve uses OpenMessage (MCP server at `http://127.0.0.1:7007/mcp/sse`) to expose his Android/Google Messages SMS/RCS history. The server has tools: `search_messages`, `get_person_messages`, `get_person_messages_range`, `list_conversations`. Steve does NOT use iMessage — never assume iMessage. If the OpenMessage MCP server isn't in `mcp_servers:` in `~/.hermes/config.yaml`, it needs to be added:
    ```yaml
    mcp_servers:
      openmessage:
        url: "http://127.0.0.1:7007/mcp/sse"
        enabled: true
    ```
    The app must be running (check `pgrep -fl openmessage`). If the server IS configured but tools aren't available, the app may need to be launched from `/Applications/OpenMessage.app` or `/Volumes/OpenMessage/OpenMessage.app`.

- **Gmail data in G-Brain is NOT real-time — check the ingest date.** G-Brain email pages are batch-ingested; as of June 2026 the last ingest was June 6. If you're reconstructing a communication timeline, the most recent emails may be missing. Always check HubSpot's `notes_last_contacted` timestamp on the contact record — it often shows activity days or weeks newer than the latest Gmail page in G-Brain. When there's a gap, say so explicitly: "G-Brain email data goes through [date]; HubSpot shows you last contacted them on [date], but I don't have the content of that message." Don't present a stale email as the "last outreach" — Steve will correct you.

- **Search G-Brain more aggressively for recent emails.** When reconstructing a timeline, don't stop at the first query. Search by participant email address (e.g. `mjruiz@garlandisd.net`), by thread subject fragments, and by date-filtered queries (`since: 2026-06-01`). The first semantic search may miss emails that a keyword search for the email address catches. Run at least two queries: one semantic and one keyword. If HubSpot shows more recent activity than your best G-Brain hit, acknowledge the gap immediately — don't make Steve ask.

- **Check OpenMessage for text messages BEFORE saying you can't see texts.** Steve uses OpenMessage (MCP server at `http://127.0.0.1:7007/mcp/sse`) to expose his Android/Google Messages SMS/RCS history. The server has tools: `search_messages`, `get_person_messages`, `get_person_messages_range`, `list_conversations`. Steve does NOT use iMessage — never assume iMessage. If the OpenMessage MCP server isn't in `mcp_servers:` in `~/.hermes/config.yaml`, it needs to be added:
    ```yaml
    mcp_servers:
      openmessage:
        url: "http://127.0.0.1:7007/mcp/sse"
        enabled: true
    ```
    The app must be running (check `pgrep -fl openmessage`). If the server IS configured but tools aren't available, the app may need to be launched from `/Applications/OpenMessage.app` or `/Volumes/OpenMessage/OpenMessage.app`.

- **Gmail data in G-Brain is NOT real-time — check the ingest date.** G-Brain email pages are batch-ingested; as of June 2026 the last ingest was June 6. If you're reconstructing a communication timeline, the most recent emails may be missing. Always check HubSpot's `notes_last_contacted` timestamp on the contact record — it often shows activity days or weeks newer than the latest Gmail page in G-Brain. When there's a gap, say so explicitly: "G-Brain email data goes through [date]; HubSpot shows you last contacted them on [date], but I don't have the content of that message." Don't present a stale email as the "last outreach" — Steve will correct you.

- **Search G-Brain more aggressively for recent emails.** When reconstructing a timeline, don't stop at the first query. Search by participant email address (e.g. `mjruiz@garlandisd.net`), by thread subject fragments, and by date-filtered queries (`since: 2026-06-01`). The first semantic search may miss emails that a keyword search for the email address catches. Run at least two queries: one semantic and one keyword. If HubSpot shows more recent activity than your best G-Brain hit, acknowledge the gap immediately — don't make Steve ask.

- **The visit and the renewal are often linked.** If Steve committed to an in-person visit in a meeting, the contact may be waiting on that before signaling renewal intent. Surface this explicitly.

- **Email should come from Steve, not CS.** When the contact replied personally to Steve, the next message must come from Steve. Don't suggest Jan or CS re-engage — it reads as a demotion.

---

## References

- `references/canyon-isd-lisa-hill-state.md` — Canyon ISD / Lisa Hill account state as of June 2026 (first use of this skill)
- `references/mesquite-isd-state-jun2026.md` — Mesquite ISD account state + open questions + IMTA status as of June 2026 (Angel Rivera / Cara Jackson)
- `references/humble-isd-melissa-leigh-state.md` — Humble ISD / Dr. Melissa Leigh full account state as of June 2026: award detail (2025 TASL Distinguished Library Service Award, first-ever for Humble ISD), relationship arc, V2 use case hook, HubSpot cleanup tasks, re-engagement agenda
- `references/garland-isd-michael-ruiz-state.md` — Garland ISD / Michael Ruiz full account state as of June 2026: $140K deal at contract-sent stage, relationship arc (7+ meetings), three cost-saving paths, gating risks (Asst. Supt. C&I, board), Taylor DePasquale as scheduling gatekeeper, three separate tracks (deal / AI coaching / TALAS)
- `references/dfg-elements-alexey-korablev-state.md` — DFG Elements VC / Alexey Korablev account state as of June 2026: firm overview, timeline, call transcript location, data room commitment, next actions
