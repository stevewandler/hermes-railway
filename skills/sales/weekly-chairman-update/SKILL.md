---
name: weekly-chairman-update
description: "Steve Wandler's weekly CEO → Board Chair update to Charlie Clines. Thursday data collection + draft, Friday Gmail draft for Steve to review and send. Never auto-sends."
version: 1.0.0
author: agent
tags: [charlie, board-update, weekly, gmail, hubspot, gbrain]
---

# Weekly Chairman Update — Hermes Workflow

Standing weekly update from Steve to Charlie Clines (Executive Chairman, charlie@bookmarked.com).
- **Thursday after 4pm CT** → collect team reports, pull HubSpot/Slack data, assemble working draft, push to repo
- **Friday afternoon** → finalize Gmail draft, WhatsApp ping to Steve to review and send

**NEVER auto-send.** Always Gmail draft only. Steve reviews and sends manually.

---

### Jan/team alignment artifacts (proven June 2026)

When Steve needs to show a team member what data they've been providing vs. what the standard
should be, build a standalone HTML comparison page in the week's working folder:
`updates/2026/week-NN-working/jan-reporting-review.html` (or atlas-, johnny- equivalent).
Format: 3-week side-by-side table showing exact fields received each week, gaps marked with
dashes, a "Proposed Weekly Data Standard" table at the bottom defining field / source /
delivered-by / when. Steve walks the team member through it on a call — visual beats verbal
for data contract alignment. The file doesn't go to Charlie; it's internal.

## Repo (Canonical Source of Truth)

```
~/github-repos/weekly-chairman-update/
├── README.md
├── updates/2026/
│   ├── week-NN-YYYY-MM-DD.md         ← sent versions
│   └── week-NN-working/              ← drafts, raw data
└── dashboards/
    ├── financial-dashboard.html
    └── pipeline-dashboard.html
```

Live dashboards Charlie has:
- Pipeline: https://bookmarked-corp.github.io/roi-calculator/board/pipeline.html
- Financial: https://bookmarked-corp.github.io/roi-calculator/board/

G-Brain pages: `board-update-YYYY-MM-DD`, `board-update-template`

---

## Section Structure (LOCKED — do not change without Steve approval)

1. **Deals + Pipeline** — active deals, pipeline delta vs. last week, quotes, won/lost, cold outbound
2. **Product + Engineering** — shipped this week, sprint status, migrations, onboarding
3. **How We're Tracking** — dashboard links + highlights, Series Seed, paid ratio, key metrics
4. **Team** — hires, departures, notable team moves
5. **Housekeeping** — TechDome, Series Seed, equity, partnerships, legal
6. **Next Steps** — next week / this month / now→Sep 1

---

## Thursday Step-by-Step (Run after 4pm CT)

### Step 1 — Pull team agent reports

Check for reports from the three team lead agents (should be in Slack, G-Brain, or directly delivered):

| Human | Agent | Role | What to collect |
|-------|-------|------|-----------------|
| Jan Gilboy | Zig | Chief Revenue Officer (agent) | Pipeline activity, quotes, won/lost, week-over-week pipeline delta |
| Patrick Reid | Atlas | Customer Success Officer (agent) | CS portfolio health, migration status, support ticket backlog |
| Sarah El Massry | Johnny | Chief Product Officer (agent) | Product shipped, sprint items, Book Intelligence, onboarding pulse |

**Agent report channels — check DMs first, then public channels:**

Johnny and Atlas deliver their Thursday board updates directly to Steve's Slack DMs via cron job. Zig posts to the public sales channel. Always check DMs first for Johnny and Atlas.

| Agent | Primary delivery | Channel/DM ID | Notes |
|-------|-----------------|--------------|-------|
| Zig (CRO) | #sales_revenue-ninjas | C060YMXSLKD | Weekly outbound report (Thu) + Monday sales update. Two report types — pull both. |
| Johnny (CPO) | Steve's DM | D0ARJQ8FXK3 | Thursday board update cron — DM to Steve. Falls back to #product (C0AE4HG85TK) |
| Atlas (CCSO) | Steve's DM | D0ASEJPG7DH | Thursday CS portfolio health cron — DM to Steve. Must be Patrick-approved before posting. |

Check DMs first: `mcp_slack_slack_get_channel_history(channel_id=D0ARJQ8FXK3, limit=10)` (Johnny), `channel_id=D0ASEJPG7DH` (Atlas). Then fall back to public channels if nothing recent. The Slack MCP `list_channels` does NOT return DM channels — you must use the known IDs above.

Also check Slack `#sales-forecasting` (C0B3WNKMBJ6) for pipeline reconciliation — Zig + Ledger numbers must match before going to Charlie.

Search G-Brain as a secondary pass: `gbrain search "zig weekly report"`, `gbrain search "atlas weekly report"`, `gbrain search "johnny weekly report"`

**If an agent report is missing this week:**
- Zig missing → pull pipeline from HubSpot MCP directly + check Jan's messages in #sales_revenue-ninjas (Jan posts the human context Zig synthesizes)
- Atlas missing → pull CS migration status from Jan's agenda/notes in #client-success (Jan runs the Sales/CS sync and posts the agenda there)
- Johnny missing → use the most recent full sprint report + check #product for any mid-week updates from Sarah or Johnny

Note the gap in the internal draft ("no Atlas report this week — CS detail from Jan's Sales/CS sync agenda") so Steve and Patrick know the cadence slipped.

### Step 2 — Pull HubSpot pipeline data + week's transcripts

Use HubSpot MCP (portal 39855019) to pull:
- Active deals: stage, ARR/value, last activity — **pull deal-by-deal, not just totals**
- Week-over-week changes: new deals, stage moves, closed-won, closed-lost
- Closed-won this month (filter `closedate >= first of month, dealstage = closedwon`)
- Quotes sent this week
- **NEVER ping customers for status** — internal sources only

**Also pull this week's G-Brain meeting transcripts** for the pipeline section:
```python
mcp_gbrain_list_pages(type="meeting", updated_after="YYYY-MM-DD", sort="updated_desc", limit=20)
```
Then `get_page` for any sales/CS/pipeline meeting from the week. Transcripts surface deal-specific intel (what Jan said in the Midland meeting, what stage move decisions were made) that HubSpot doesn't capture.

**Revenue target + Utah rule (LOCKED — read before writing any numbers):**
- **Target is $1M ARR by END OF SEPTEMBER 2026.** Loosened from "September 1" — Steve is slowly pushing "end of September" language. Introduce gently, never as a goalpost-move announcement. Weeks 1-2 used "$1M by Sep 1"; do not flag the change, just use the softer framing.
- **The $1.5M figure is DEAD.** It was a stretch goal that will not be met. Stop mentioning $1.5M entirely. Do NOT frame it as a miss ("we aimed for $1.5M but..."). It simply disappears.
- **Utah SEA (~$1.3M) is PARKED.** Kept in HubSpot so it is not forgotten, focus is Texas not Utah. NEVER lead with a total-pipeline figure that includes Utah and then discount it — that inflates the headline and makes the real Texas pipeline look thin. Report the Texas/working pipeline as the main number. Utah is at most a one-line "parked, ~$1.3M, not in current focus" footnote, or omitted. This is about reporting the pipeline actually being worked, not dressing numbers up.

**Pipeline analysis to run before drafting Section 1:**
- Total open new pipeline vs. ex-Utah (if Utah is still early-stage / stale)
- Total open renewal pipeline — split 26/27 vs. 27/28
- At-risk / "Revisit After Sep" total
- June 30 urgency bucket (deals with close date ≤ June 30)
- Top 5 deals by dollar value — name, amount, stage, owner, close date
- Exclude "Testing:" pipeline deals (historical test records, not real deals)

**Sanitize agent report language before drafting** — Johnny's report may use internal codenames (e.g. "Peer Placement Signal") that should NOT appear in Charlie's email. Apply naming rules before copying any language from agent reports into the draft. Zig's reports likewise use internal analytics terminology ("signal," "stage imbalance," etc.) — translate to plain business language before the email.

**Jan vs. Zig reconciliation pattern** — these two reports are typically *sequential*, not competing. Zig's outbound report cuts Thursday morning; Jan's stage-movement notes come in during the Friday Sales/CS sync or from the week's meeting transcripts. When Jan says "we moved a lot of renewals forward," that movement may not yet be reflected in Zig's numbers. Document this as "additional movement post-Zig report" in the draft — do not treat it as a conflict. Confirm against live HubSpot rather than choosing one source over the other.

### Step 3 — Pull G-Brain context

```bash
gbrain get board-update-YYYY-MM-DD   # last week's sent version for WoW comparison
gbrain search "charlie update open items"
gbrain search "midland ISD"
gbrain search "garland IMTA"
```

Check `board-update-template` page for canonical structure.

### Step 4 — Identify open items from last week

Always pull open items from the most recent sent update in the repo:
`~/github-repos/weekly-chairman-update/updates/2026/week-NN-YYYY-MM-DD.md`

Standing open items (as of week 3, June 13, 2026):
- GTM strategy update (promised "more soon")
- Equity recommendations per person (promised "soon")
- Garland IMTA due diligence results
- Michelle dashboard refresh (stale since May 27)
- Moak Casey — still no response from Charlie on week 1 ask
- Midland ISD — demo booked, $75K, list price strategy
- IMTA flyer strategy expanding to all renewals
- Teela PD session for Region 10 librarians

### Step 5 — Assemble the working draft

File location: `updates/2026/week-NN-working/week-NN-draft-YYYY-MM-DD.md`

**Revenue target (LOCKED June 2026):** $1M ARR by **end of September** (loosened from "September 1" — introduce the softer date gently, never as a goalpost-move announcement). The **$1.5M figure was a stretch goal that will NOT be met — stop mentioning $1.5M entirely**, do not frame it as a miss, just drop it. Any draft that says "$1.5M by Aug 1" is stale and must be corrected.

**Utah handling (LOCKED):** The Utah SEA deal (~$1.3M, net-new Qualifying stage, ~Oct close) is a PARKED opportunity — kept in HubSpot so it isn't forgotten, but NOT part of the working pipeline story. Focus is Texas. NEVER lead with a total-pipeline figure that includes Utah and then discount it — that inflates the headline and makes the real pipeline look thin in the same breath. Report the Texas/working pipeline as the main number; Utah is at most a one-line "parked, not in current focus" footnote, or omitted. Working ex-Utah net-new has been ~$650K; the $1.44M / $2.75M figures that appeared in a prior week-3 draft were WRONG and did not reconcile to HubSpot.

**Agent reports do NOT contain pipeline dollars — verify against live HubSpot (CRITICAL):** Zig's weekly report is an OUTBOUND ACTIVITY log (emails, replies, notes, campaigns, quotes-out, qualitative renewal movement). It has NO pipeline dollar totals, NO YTD closed-won figure. Jan's sync notes are QUALITATIVE ("we moved a lot of renewals forward"). Neither is the source of the dollar numbers. The ONLY source of pipeline dollars is **live HubSpot, pulled fresh** (see references/scorecard-architecture.md for the exact queries). Do not attribute dollar figures to "Zig/Jan" — report Zig's activity as activity, Jan's movement as movement (confirm it against live data), and source all dollars from HubSpot. A prior draft mis-attributed invented dollars to the agent reports; that is the failure mode to avoid.

**Format direction (June 2026):** Steve wants to evolve the Charlie update toward email-as-cover-letter + HTML dashboard as substance. The email should be a tight narrative (~250-300 words) with headline numbers; Charlie clicks one link to the GitHub Pages board site for the full deal-by-deal pipeline, migration wave tracker, CS onboarding status, and product shipped. The Week 3 email (June 15, 2026) successfully shipped this format — ~300 words, one dashboard link, em-dash bullets for the 4-5 things worth pulling out, no sections/headers/numbered lists. This is the new standard. Key elements of the proven format:
- Opener: 2 sentences on what moved this week (closes + renewal motion)
- "The bigger story is the dashboard" — position the scorecard as the front page, one link
- 4-5 em-dash bullets pulling out what matters (ARR gap, migration, product ship, activity WoW, customer feedback themes)
- Closer: honest note on what's carried/pending + invitation for feedback
- No asks unless there's a real one — Week 3 held the Garland pricing call ask for Week 4 so Charlie could absorb the new dashboard first
- Patrick's migration confidence and V1 retirement cost savings ($7-9K/month) were board-grade additions that strengthened the email
- Product feedback themes from Johnny's report (3 bullet summary) showed Charlie the product team is responsive without getting into ticket-level detail

Structure:
```
# Charlie Weekly Update — Week N (Draft YYYY-MM-DD)

Hi Charlie,

[2–4 sentences of framing — what moved this week, one headline if there is one]

## 1. Deals + Pipeline
[DO NOT write high-level bullets only. Show the data:]
[Closes this week: district name, amount, date]
[Active pipeline — top deals by dollar: name | amount | stage | close date | owner]
[June 30 urgency: which deals have hard deadlines this month]
[At-risk: Revisit-After-Sep total, churned]
[Outbound activity: key numbers from Zig's report]

## 2. Product + Engineering
[Headline shipped item first (the "biggest single ship event" framing)]
[Other shipped items — tight]
[Customer feedback themes from Johnny's report — top 3 signals]
[Network Intelligence / BI next horizon — if gate cleared, with framing]

## 3. How We're Tracking
[metrics + dashboard links]

## 4. Team
[brief]

## 5. Housekeeping
[brief]

## 6. Next Steps
[three-horizon: next week / this month / now→Sep 1]

[Asks for Charlie — direct, one-line each]

Thanks,
Steve
```

### Step 6 — Self-critique pass ("Charlie will probably ask…")

Before saving the draft, run a critic pass:
- Is every number sourced? (HubSpot, transcript, Slack — no fabrication)
- Any claims Charlie would immediately challenge?
- Any open items from last week that went unaddressed? Address or explicitly note.
- Week-over-week: does every major section show what changed vs. last week?
- No system-talk: no mention of G-Brain, Hermes, agents, skills, harvesters
- No tildes before dollar amounts (Gmail strikethrough) — use "approximately"
- Voice check: is this Steve, or is it a consultant?

Remove the critic pass notes before creating the Gmail draft.

### Step 7 — Save to repo + push

```bash
cd ~/github-repos/weekly-chairman-update
# Create working folder
mkdir -p updates/2026/week-NN-working/
# Save draft
# git add + commit
git add .
git commit -m "week-NN: Thursday draft assembled"
git push
```

### Step 8 — WhatsApp ping to Steve

Send to WhatsApp (home channel):
> "Weekly Charlie update draft is ready — it's in the repo at updates/2026/week-NN-working/. I'll create the Gmail draft tomorrow afternoon for your review. Any sections you want me to revisit tonight?"

---

## Friday Step-by-Step (Create Gmail Draft)

### Step 1 — Pull latest draft from repo

```bash
cd ~/github-repos/weekly-chairman-update && git pull
cat updates/2026/week-NN-working/week-NN-draft-YYYY-MM-DD.md
```

### Step 2 — Any Friday-morning updates?

Check for:
- Any new HubSpot activity since Thursday
- Any Slack messages in `#sales-forecasting` with new data
- G-Brain: anything since yesterday that belongs in the update?

Incorporate if material. Don't pad.

### Step 3 — Create Gmail draft

Use Google Workspace tools to create a Gmail draft:
- **From:** steve@bookmarked.com
- **To:** charlie@bookmarked.com
- **Subject:** Sentence-case, ASCII only, no em-dashes in subjects (Gmail encoding issue)
  - Format: "Bookmarked — week of [Month D]" or "Weekly update — [Month D]"
- **Body:** HTML email
  - Inline styles only (no `<style>` blocks — Gmail strips them)
  - No tildes — use "approximately"
  - Em-dash bullets: use `—` for bullet lists
  - Tables: HTML only, inline styles

Read back the draft via API to verify: correct recipient, subject clean, no encoding garbage, attachments present if referenced.

Delete any existing draft with same subject before creating new one.

### Step 4 — WhatsApp ping to Steve

> "Charlie update Gmail draft is ready in your Drafts folder — subject: '[exact subject line]'. Open it, read it, hit send when you're good. Anything you want changed, just reply here."

---

## Slack channel map

Full channel ID table, agent user IDs, human user IDs, and Zig report cadence detail: see `references/slack-channel-map.md`.

## Pipeline dashboard update procedure

Step-by-step for updating `board/pipeline.html` in the roi-calculator repo each week — repo path, CSS class reference, section-by-section update order, what to exclude, and how it relates to the email: see `references/pipeline-dashboard-update.md`.

## Jan data verification workflow

Before any pipeline numbers go to Charlie, verify against live HubSpot deal-by-deal. Build a separate verification HTML for the Steve+Jan alignment call. Check for renewal/net-new misclassification, duplicate churns, and $0 invalid records. Full step-by-step: see `references/jan-data-verification-workflow.md`.

## Full pipeline cleanup (quarterly)

For a deep HubSpot audit — not weekly verification, but the full scrub — see `references/pipeline-cleanup-workflow.md`. Proven June 15, 2026. Key learnings from that session:
- **Bulk-imported deals often miss company associations.** The May 20-21 2026 import left 36 of 77 renewal deals orphaned — invisible from the company page. Always check associations after any bulk import.
- **Test districts contaminate renewal pipelines.** When renewal deals are bulk-created, test districts (Godley, Clifton, North Lamar, etc.) get included as $0 deals. Cross-reference against the Testing Districts pipeline (41834638).
- **25/26 Closed Won → 26/27 renewal gap analysis.** Every Closed Won deal in the prior year should have a corresponding renewal deal in the current year. Build a cross-reference column. Most gaps are $0 consortium districts, but real ones (like San Marcos $14,850) surface too.
- **HubSpot search API returns stale cache for deleted deals.** Always verify deletion with a direct GET by ID, not search.

## Pipeline cleanup workflow (quarterly / post-bulk-import)

Full audit: pull ALL deals from all pipelines into a Google Sheet, check company associations, flag duplicates/invalids/test districts, review with Jan. See `references/pipeline-cleanup-workflow.md` for the complete technique including batch association fix, owner ID reference, and Google Sheets API pitfalls. HTML structure and styling pattern: see `references/jan-verification-html-pattern.md`.

## Charlie email format (Week 3+ cover letter model)

The email is a 250-300 word cover letter to the dashboard, NOT a 6-section activity dump. Three things only: what moved, what matters in the numbers, what you need from Charlie. See `references/charlie-email-cover-letter-format.md` for the full format spec, structure template, and what to include/exclude.

## Pipeline cleanup workflow (quarterly / full audit)

Full pipeline audit: pull ALL deals from ALL pipelines into a Google Sheet, check company associations, pre-populate cleanup log, Steve + Jan review and execute. See `references/pipeline-cleanup-workflow.md` for the complete proven workflow including batch-association of orphaned deals.

## HubSpot pipeline stages (source of truth)

Exact stage names, IDs, and probability weights for Sales Pipeline (net-new) and 26/27 Renewal Pipeline, plus the weekly data contract locked June 15: see `references/hubspot-pipeline-stages.md`. Use these exact stage names on the dashboard — no paraphrasing. Snapshot each week's stage totals in the dashboard HTML since HubSpot has no historical stage data.

## HubSpot owner ID mapping

Active owners, AI owners, deactivated/former employees, and their deal portfolios: see `references/hubspot-owner-ids.md`. Resolve all owner IDs to names before any report or sheet. Deactivated users (77068341, 587669925, etc.) won't appear in `hubspot_list_owners` — use the reference mapping.

## HubSpot owner ID mapping

Full active + deactivated owner table with names, emails, and notes: see `references/hubspot-owner-mapping.md`. Key deactivated ID: 77068341 (likely Hunter, former SDR). Updated June 15, 2026.

## Pipeline cleanup workflow (bulk audit + Google Sheet)

When HubSpot needs a full pipeline audit (duplicates, test districts, misclassified deals), use the proven workflow in `references/pipeline-cleanup-workflow.md`. Creates a Google Sheet in Sales Hub with one tab per pipeline + a Cleanup Log for Steve/Jan to review together. Includes direct HubSpot API access pattern for bulk pulls (faster than MCP pagination).

## Company Scorecard architecture

The Charlie update is the first output of a larger company scorecard / operating system Steve is building (strategy spine: retention is the engine; sales/CS/product/PD are one loop). Three-layer model (activity / judgment / synthesis), one data model rendered as three gated views (team / Charlie / board), verified-vs-pending tiering, the 5 true outcome-metric gaps, the Zig/Atlas overlap boundary, and the exact live-HubSpot pull (pipeline IDs, stage IDs, query pattern) are all in `references/scorecard-architecture.md`. Read it before building any scorecard, dashboard, or multi-function report.

## HubSpot deal-to-company association audit (discovered June 15, 2026)

Bulk-imported renewal deals frequently lack company associations. The May 20-21, 2026 batch import created ~36 deals in the 26/27 Renewal Pipeline with NO company link — including Humble ($72K), Mesquite ($57K), Canyon ($17K), Copperas Cove ($12K). These deals exist in pipeline views but are invisible from the company record page, which means Jan can't see them when she pulls up a district.

**Before any pipeline report or dashboard update, check for orphaned deals:**
```python
# Check if a deal is associated to a company
url = f"https://api.hubapi.com/crm/v4/objects/deals/{deal_id}/associations/companies"
resp = requests.get(url, headers={"Authorization": f"Bearer {token}"})
if not resp.json().get("results"):
    print(f"ORPHANED: {deal_id}")
```

**Pattern:** When building a pipeline cleanup sheet or verification HTML, add a "Company Linked?" column to every pipeline tab. Flag orphaned deals for Jan to fix before the weekly update goes out — unassociated deals corrupt the company-level view that Jan and the team rely on for account management.

**Root cause:** HubSpot bulk imports (CSV or API batch create) don't auto-associate deals to companies by name. Each deal must be explicitly associated via the associations API or manually in the UI. Any future bulk deal creation should include an association step.

## HubSpot pipeline cleanup sheet pattern (proven June 15, 2026)

When Steve says "HubSpot is a mess" or wants to clean up pipeline data, the deliverable is a Google Sheet in Sales Hub with:
- One tab per pipeline (all deals, sorted by stage then amount descending)
- Columns: Deal Name, Deal ID, Stage, Amount, Owner, Close Date, Created, Last Modified, Company Linked?, Deal Link
- A "Cleanup Log" tab with columns: Deal Name, Deal ID, Pipeline, Current Stage, Issue, Action Needed, Decision, Done, Deal Link
- Pre-populate the Cleanup Log with known issues (DUPLICATE/INVALID deals, misclassified deals, orphaned deals)
- Use `valueInputOption="RAW"` for deal names (slashes in "26/27" get mangled by USER_ENTERED)
- Resolve all owner IDs to names before writing (pull owners list first; deactivated users won't appear — label as "Prior Employee")

The sheet is the walkthrough artifact for Steve + Jan alignment calls. It's not Charlie-facing.

## HubSpot pipeline stages (canonical reference)

Exact stage names, IDs, and probabilities for all pipelines: `references/hubspot-pipeline-stages.md`. Use these when pulling deals by stage, building WoW comparisons, or validating that Jan/Zig reports use the correct stage vocabulary. Dashboard consolidation mapping is also documented there.

## Weekly data contract (Jan/Zig reporting standard)

The standardized fields, sources, owners, and delivery cadence locked June 15: `references/weekly-data-contract.md`. Includes the migration spreadsheet vs HubSpot reconciliation context. Read this before assembling any weekly update to ensure the incoming data matches the contract.

## V1→V2 Migration reconciliation

Backend usage data (Patrick's login report) and HubSpot (deal stages/pipeline dollars) show different district counts. The canonical migration bucket assignments live in a Google Sheets spreadsheet — see `references/migration-spreadsheet-reconciliation.md` for the spreadsheet ID, bucket structure, known gaps, and action items. Load this reference before any dashboard update that touches onboarding counts, migration status, or renewal pipeline.

## Migration spreadsheet reconciliation

The Patrick/Jan V1→V2 migration spreadsheet (7 buckets, 81 districts) is the migration truth alongside HubSpot as the pipeline truth. These measure different things and can disagree on counts and totals. Full reconciliation, bucket breakdowns, and open questions are in `references/migration-spreadsheet-reconciliation.md`. Read it before updating the dashboard's onboarding or migration numbers.

## HTML Dashboard (Evolving Format)

Steve wants to upgrade the weekly Charlie update from a long email to an **email + linked HTML dashboard** format. The email becomes the cover letter (tight narrative, headline numbers, key asks). The dashboard is the substance — visualized, not buried in bullets, hosted on the same GitHub Pages board site Charlie already has bookmarked.

**Target dashboard sections:**
- Deal-by-deal pipeline table (name, amount, stage, owner, close date) — new business and renewals separate
- Migration wave tracker (district, wave, current stage, go-live date)
- CS onboarding pipeline (active districts, stages, flags)
- Product shipped this week (headline + bullet list)
- Week-over-week summary metrics (closes, pipeline delta, YTD)

**When to build:** Steve approved exploring this. Build the first version when assembling the week's update, refine weekly. The email stays short; the dashboard carries the data weight.

**Where it lives:** Same GitHub Pages site as the existing dashboards — `https://bookmarked-corp.github.io/roi-calculator/board/`. The Company Scorecard is now the landing tab on `board/index.html` (built Week 3, June 13 2026). Weekly updates are applied directly to the scorecard tab — no separate `weekly-update-YYYY-MM-DD.html` pages needed. The email links to the single dashboard URL.

**Before building:** Confirm HubSpot data is clean (no Testing: artifacts, stage definitions reconciled). The scorecard tab is live and proven — future weeks update the numbers in place, add WoW columns when prior-week baselines exist, and progressively add sections (Closed/Won, Churn) as underlying data gets cleaned up.

### Dashboard content principles (LOCKED — session 2026-06-15)

Steve explicitly rejected strategy philosophy on the dashboard. Rules:
- **No strategy statements** ("retention is the engine", "every number is read against one question"). The dashboard should answer questions, not create them. If a line makes Charlie pause and wonder "what does he mean by that," it's doing the opposite of its job.
- **Top callout = "How to Read This Dashboard"** — source labels (Verified = QBO/Michelle, Reported = HubSpot/team) + iteration disclaimer ("We're iterating weekly — feedback welcome"). Nothing else.
- **Gap to $1M = simple math first.** Show $560K ($1M − $440K verified) as the headline, not the $295K base-case gap. Scenario range (conservative/base/best) goes below as context, not the main number. Charlie shouldn't need to reverse-engineer the math.
- **Data freshness = two short lines.** "LIVE (Jun 13): Pipeline · Renewals · CS · Product" and "CARRIED (May 27): Verified ARR · Cash · Financials — refresh pending". No verbose explanation.
- **Every section needs WoW comparison.** Pipeline by stage: "Prior Wk" and "Δ" columns in the tables. Activity: side-by-side two-column layout (This Week vs Prior Week). Closes: delta indicator on the card. If prior week data doesn't exist for a field, put dashes and note "tracking starts this week."
- **Pipeline tables must use exact HubSpot stage names** — not consolidated/renamed stages. The dashboard stages must match what Jan and Zig report from HubSpot so there's one shared vocabulary.
- **Table alignment matters** — if side-by-side tables have different row counts, add a blank spacer row so totals line up horizontally.
- **"Work in progress" disclaimer is OK for Charlie** — Steve is comfortable showing "we found a data gap, we're reconciling" rather than pretending numbers are clean when they're not. Honest iteration > false precision.

### Pipeline stage standardization (LOCKED — proven week 4, 2026-06-15)

**Dashboard pipeline tables MUST use exact HubSpot stage names** — no consolidation, no renaming,
no custom labels. Show every stage in the pipeline as a row, even stages with 0 deals / $0.
This ensures: (a) next week's numbers drop into the same rows, (b) when a deal moves into a
previously-empty stage, the row is already there, (c) Jan and Zig can verify the dashboard
against HubSpot without translation.

Net-new (Sales Pipeline, ID: default) — show these rows in order:
  1. Sales Intake · 2. Qualifying · 3. Decision Maker Buy-In · 4. Ready for Quote
  5. Quote Sent · 6. Committed · Re-engage (V2) · TOTAL (ex-Utah)

26/27 Renewal Pipeline (ID: 798674460) — show these rows in order:
  1. To be Renewed · 2. V2 Review Scheduled · 3. Ready for Quote · 4. Quote Sent
  Committed · 6. PO Received · Revisit After Sept · TOTAL

**Migration spreadsheet buckets are NOT pipeline stages.** The spreadsheet (Patrick's backend
usage data) describes migration/engagement status — a different dimension than deal stage.
Recommendation to Jan/Patrick: add a HubSpot custom property "Migration Bucket" (values 1–7)
rather than changing pipeline stages. This keeps both views without overwriting either.

**WoW pipeline comparison timing rule:** Only show Prior Wk / Δ columns when the prior week's
data was captured in the same stage format. If Jan did pipeline cleanup (deals moved between
stages for data quality, not real progression), skip the WoW column that week and note
"pipeline cleanup this week — WoW comparison starts next week." Showing cleanup movement as
if it were real deal progression would confuse Charlie.

### Build pattern (LOCKED — proven week 3, 2026-06-13)

**EXTEND Michelle's dashboard, do not build a separate page.** The repo is `BookmarkED-Corp/roi-calculator` (clone to `~/github-repos/roi-calculator`); the board files are `board/index.html` (Michelle's financial dashboard) and `board/pipeline.html`. `board/index.html` is ALREADY a tabbed single-page app: a `.nav` bar of `.nt` tabs + `.section`/`.section.active` blocks toggled by a `show(id)` JS function. The Company Scorecard is added as a NEW `<div class="section" id="section-scorecard">` plus a nav `.nt` entry — it becomes the landing tab (mark it `.section active` and de-active the old summary section). One link, no second file. Reuse Michelle's existing classes verbatim so it renders native: `.kg`/`.kc` (+ color classes `.g .r .o .w .b`), `.panel`/`.ph`/`.pt`/`.pb`, `.chip` (+ `.cg .cr .cw .cb .co`), `.ca` callouts, her tables, and her progress-bar classes `.pw`/`.pt2`/`.pf`/`.pg`.

**Content rules Steve set for the scorecard tab:**
- Sections are named plainly — **Revenue & Pipeline**, **Renewals & Customer Success**, **Product & Book Intelligence**. Do NOT label them "Engine 1/2/3" (Steve rejected that).
- **Dashboard callout is "How to Read This Dashboard"** — source label definitions only (Verified = finance-confirmed QBO/Michelle; Reported = HubSpot or team-reported, pending verification) plus iteration disclaimer ("We're iterating on this dashboard weekly — if anything is unclear or needs correction, feedback is welcome"). NO strategy philosophy ("retention is the engine"), NO "every number below is read against one question" framing. Steve's principle (June 15): the dashboard should answer questions, not create them. If a line makes Charlie pause and wonder "what does he mean by that," it's doing the opposite of its job.
- Top callout is "How to Read This Dashboard" — source label definitions (Verified/Reported) + iteration disclaimer ("we're iterating weekly, feedback welcome"). Nothing else.
- Week-over-week comparison is REQUIRED on every major number: pipeline tables get WOW context lines, activity section gets side-by-side columns, top cards get delta indicators. Prior week data exists — check Zig's mid-week preview in #sales_revenue-ninjas (posted ~Wed, covers prior full week in "Last Week" column) AND the Thursday outbound report AND Jan's Friday pipeline reports.
- The top callout is titled **"How to Read This Dashboard"** — it explains what Verified and Reported mean, and includes a brief iteration disclaimer ("We're iterating on this dashboard weekly — if anything is unclear or needs correction, feedback is welcome"). Nothing else.
- **The "What We're Not Yet Measuring" roadmap stays INTERNAL — never on Charlie's view.** You don't show a board chair your to-do list; you show a dashboard that quietly improves each week. The roadmap lives in `references/scorecard-roadmap-and-accountability.md`, not the dashboard.
- Verified vs. reported tiers marked on every number; financials flagged "as of <date>, refresh pending" until Michelle re-runs.
- Data freshness legend: two short lines only — "LIVE (date): Pipeline · Renewals · CS · Product" and "CARRIED (date): Verified ARR · Cash · Financials — refresh pending". No verbose explanation. Do NOT duplicate freshness info in the footer — keep it in one place.
- Gap to $1M card: show the ABSOLUTE gap ($1M minus verified ARR) as the headline, not the scenario-based gap. The scenario range (conservative/base/best) goes in smaller text below as context. The math must be obvious: "$1M target − $440K verified = $560K remaining."
- When two side-by-side tables have different row counts, add a blank spacer row to the shorter table so the total rows align horizontally.
- Data reconciliation notes (e.g. "backend and HubSpot show different counts, reconciling this week") are Charlie-safe and welcome — Steve prefers honest incomplete data over pretending numbers are clean when they're not. Use caution/amber styling for these notes.
- **Headline numbers must show the simplest, most intuitive math.** Example: Gap to $1M should show $560K ($1M − $440K verified) as the headline, not $295K (base case gap). Put scenario ranges in smaller supporting text below. If someone has to do mental math to understand the card, the card is wrong.
- **Data freshness legend: two short lines only.** "LIVE (date): Pipeline · Renewals · CS · Product" and "CARRIED (date): Verified ARR · Cash · Financials — refresh pending." No verbose explanation. Don't duplicate freshness info in the footer — one place only.
- **Activity section uses week-over-week visual comparison.** Two-column layout: This Week (left, live numbers) vs Prior Week (right). Prior week starts as dashes and fills in each subsequent week. This builds the WoW story automatically.
- **Gap to $1M headline = actual arithmetic, not scenario math.** The Gap card shows $1M minus verified ARR as the big number (e.g. "$560K remaining"), with the subtitle spelling out the subtraction ("$1M target − $440K verified = $560K remaining"). Scenario projections (base/conservative/best) go in smaller supporting text below, NOT as the headline. The prior "$295K gap" was confusing because it showed the gap between base-case projection and $1M, which requires understanding the projection to parse. Charlie should be able to read the gap card in 2 seconds without doing mental math.
- **Activity section uses week-over-week visual comparison.** Two columns side by side: "This Week" (with real numbers: outbound, inbound replies, quotes sent) and "Prior Week" (with last week's numbers, or dashes if this is the first week of tracking). NOT a single text line. Color-code the current-week header in gold; prior week in muted gray. Brief context note below (e.g. what drove the numbers). Prior-week column fills in automatically each week — the comparison story builds over time.
- **Data freshness: one legend, no duplicates.** A single compact legend near the top of the scorecard: "LIVE (date)" for pipeline/renewals/CS/product, "CARRIED (date)" for ARR/cash/financials. Do NOT repeat freshness info in the scorecard footer — the legend handles it. Footer is just "Confidential — Board Use Only."

**Bookmarked brand palette (real brand, NOT the board dashboard's gold/cream):** discovered in the customer-facing root `index.html` of the same repo. Primary rust/burnt-orange `#B14012`, brighter orange accent `#D9582A`, teal/green `#12A38C` / `#107569`, ink `#101828`. Fonts: DM Serif Display / DM Mono / DM Sans. The board dashboard's gold/cream was a one-off choice, not the brand. When branding a data dashboard: lead with **teal** as the primary accent and reserve orange for highlights — heavy orange fights with the red/green needed for at-risk/healthy status signals. Keep red strictly for risk, muted green for healthy/moving.

**Scope discipline when restyling:** branding/​facelift of the scorecard tab is safe; restyling Michelle's financial tabs is touching HER artifact — do it as a deliberate, separate pass with her in the loop, never bundled into a board-send-prep session (risk of a subtle table break you don't catch).

**Render-to-verify locally (browser tool blocks file:// and localhost):** screenshot headless Chrome instead — `"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --headless --disable-gpu --screenshot=/tmp/out.png --window-size=1280,1700 --hide-scrollbars "file://$PWD/board/index.html"` then view /tmp/out.png with vision. Nothing is live until committed and pushed — confirm with Steve before pushing.

---

## Equity compensation follow-up reference

For Charlie's June 2026 equity compensation / option pool follow-up, read `references/equity-compensation-followup-2026-06.md` before advising Steve or drafting. It captures Charlie's actual email, the June 3 call context, the RSG vs options vs ISO/NSO framing, and the four response areas: Michelle/Jason, advisors, vesting structure, and Raju/Jan W-2 conversion.

## Charlie communications thread protocol

When Steve opens a session explicitly about Charlie — "read Charlie's emails," "respond to Charlie," "what did Charlie say" — treat it as a dedicated review session, not a drafting session.

**Sequence:**
1. Pull the live emails first (Gmail API, not a cached file). The most recent email may not be in any prior pull.
2. Read and summarize ALL unanswered emails. Don't assume the oldest unread one is the right one — a newer reply may have changed everything.
3. Present what each email says in plain English before any drafting.
4. Get Steve's read on each open question. He'll give it voice-to-text style — mine it, don't just transcribe it.
5. Only THEN propose a draft structure. Never open with "here's what I'd write."

**Steve's explicit rule, stated June 16 2026:** Never send ANYTHING to Charlie without his explicit review. EVER. Draft only, he sends manually. This is not a default — it is a hard rule with no exceptions and no edge cases.



### DO
- Opener: `Hi Charlie,` or `Hey Charlie,` — then dive straight into substance. Don't pad with appreciation or warm-up lines. Steve's style: one direct frame-setting line, then content.
- Contractions everywhere: `I'd`, `we're`, `I'll`
- Plain asks: "Can you…" / "Would you mind…" / "Need your eyes on…"
- Tight skeleton for bigger asks: opener → 2–4 short context paras → em-dash bullets → who-does-what closer
- Sign-off: bare `Steve` or `Thanks, Steve` — never `Best,`, never `Cheers,`, no title block
- Smileys with Charlie: `:)` and `:(` are fine — Charlie-specific intimacy markers
- Average length: 200–400 words. One-liners for asks, no rationale paragraphs attached
- Week-over-week: show what changed vs. last week in every major section

### DON'T
- No system references (no G-Brain, no Hermes, no agent names/roles — Charlie doesn't know)
- No "why I'm sending this" preambles
- No "Three things I'm reading from this" numbered analysis lists
- No defensive language for positive customer mentions
- No "for the record" / "per our discussion" / "circling back"
- No consulting-deck scaffolding: active subheadings, bullet sermons, strategic implications
- No tildes before dollar amounts (Gmail strikethrough) — use "approximately"
- No premature framing ("If this lands as a Series A artifact…")
- **No auto-send** — EVER. Steve has explicitly instructed: never send ANYTHING to Charlie without his review. Gmail draft only. He sends manually. No exceptions, no edge cases.
- **Charlie board-chair skill**: Load `charlie-clines-board-chair` for any ad-hoc Charlie communication (equity, board prep, one-off emails). This skill covers voice, workflow, and live equity state. The weekly-chairman-update skill covers only the Thursday/Friday recurring update cadence.
- **Never draft before discussing** — For any substantive Charlie email (not routine weekly updates), walk through each topic with Steve first, get his position, THEN draft. Jumping to a draft without that conversation will be rejected.
- **Openers must be natural** — "Your notes helped me get clearer" = corny and weak. "Good exchange" = too polished. Steve dives straight in or uses something like "Here are my comments and feedback." Don't manufacture a warm-up sentence.
- **Don't add what Charlie didn't raise** — If Charlie didn't mention it, don't put it in the reply without checking with Steve first. Editorializing gets caught immediately.
- **"We" vs "I"** — Joint commitments use "we." Steve catches this.

### Agent naming (when agents contributed — internal meta only, never in Charlie-facing text)
If referencing an agent in internal notes: "Zig (our Chief Revenue Officer agent)", "Atlas (our Customer Success Officer agent)", "Johnny (our Chief Product Officer agent)"

---

## Data Sources

| Source | What it provides | Access |
|--------|-----------------|--------|
| HubSpot (portal 39855019) | Active deals, pipeline, quotes | HubSpot MCP |
| Slack `#sales-forecasting` (C0B3WNKMBJ6) | Zig+Ledger pipeline reconciliation | Slack MCP |
| G-Brain | Last week's update, open items, meeting transcripts | gbrain CLI / MCP |
| Team agent reports | Jan+Zig, Patrick+Atlas, Sarah+Johnny | G-Brain / Slack |
| GitHub repo | Historical sent versions, dashboards | ~/github-repos/weekly-chairman-update/ |
| Michelle's financial dashboard | Series Seed, cash, paid ratio | dashboards/financial-dashboard.html |

**Pipeline data: internal only.** Never ping customers or customer-side contacts for status. If data only exists on the customer side, mark as `[unknown — internal pipeline gap]` and route to Jan or Patrick.

---

## Week-over-Week Tracker

Always include in the working draft (remove from the Charlie-facing email — internal only):

```
## Week N → Week N+1 progression
- [Topic from last week]: "[what Charlie saw] → [what happened]"
```

Pull from last week's sent `.md` in the repo. Update after each send.

---

## Pitfalls

- **Charlie's last name is CLINES, not Klein.** He is Charlie Clines, Executive Chairman, charlie@bookmarked.com. "Charlie Klein" is a persistent autocorrect / hallucination failure mode — caught in session June 13, 2026. Check every draft for this before it goes anywhere.
- **No tildes in HTML email** — Gmail renders `~$100K` as ~~$100K~~. Always write "approximately $100K" or "about $100K"
- **Never auto-send** — always Gmail draft. Steve reviews manually before sending.
- **No system-talk** — Charlie doesn't know about G-Brain, Hermes, skills, agent reports, or any internal tooling. Never mention it.
- **Pipeline data = internal only** — HubSpot, Jan, Natasha, Slack. Never ping customers.
- **Verify every number against LIVE HubSpot before send — do NOT trust carried-forward draft numbers.** Real failure (week 3, 2026-06-13): a prior session's draft claimed "$1.44M ex-Utah" and "$2.75M total pipeline." A live HubSpot pull showed ex-Utah net-new was actually $652K and 26/27 renewals $529K — the $1.44M was fabricated/double-counted and did not exist in any HubSpot record. Charlie's reconciliation instinct would have caught it. ALWAYS pull live deals (search by pipeline, exclude closed/churn stages, sort by amount) and reconcile against Zig's and Jan's reported figures before any number goes in the email. See `references/hubspot-pipeline-pull.md` for the exact recipe (pipeline IDs, stage IDs, the script).
- **Verify every number** — if you can't source it, don't put it in. Say "checking with Jan" or flag as unknown.
- **Delete old drafts** — before creating a new Gmail draft, delete any existing draft with the same subject so Steve doesn't see duplicates.
- **ASCII subjects** — Gmail can mangle em-dashes in subject lines. Use plain ASCII in subject.
- **Attachments must actually be attached** — if the email body says "attached," the file MUST be attached via MIME. Never send Steve to Gmail to manually attach.
- **Inline styles only** — Gmail strips `<style>` blocks. All CSS inline.
- **Week-over-week is required** — every major section should show delta vs. last week. If nothing changed, say so briefly.
- **Asks for Charlie must be specific and one-line** — no rationale paragraphs attached to asks.
- **Johnny/Atlas reports are in Steve's DMs, not public channels** — check D0ARJQ8FXK3 (Johnny) and D0ASEJPG7DH (Atlas) first every week. Don't spend time hunting for them in public channels.
- **Atlas report requires Patrick approval** — Atlas posts a draft to #customer-success-ops, Patrick approves it, then Atlas posts the final to Steve's DM. If you see a draft-only version, flag that Patrick hasn't approved yet.
- **Verify initiative readiness before committing to Charlie** — before writing "we expect X by end of next week," confirm the gate has cleared. For product initiatives with a data validation gate (like Network Intelligence Phase 0), ask Steve whether that gate is green before putting a delivery date in the email. A wrong promise to Charlie is worse than leaving it out.
- **Network Intelligence naming rule** — never use "Peer Placement Signal" in any draft. The canonical name is "Network Intelligence." Possible future UI label: "Where Schools Place This." "Peer" implies similarity we haven't defined. See bookmarked-strategy skill for full naming context.
- **Prior week activity data lives in Zig's MID-WEEK PREVIEW, not the Thursday report.** Zig posts a mid-week preview to #sales_revenue-ninjas (usually Wednesday) that includes a "Last Week (Full)" column with outbound/inbound/calls/meetings per person. The Thursday outbound report only covers the CURRENT week. To build week-over-week activity comparison, you need BOTH: the mid-week preview's "Last Week" column for prior week, and the Thursday report for current week. The first mid-week preview was posted June 3, 2026. Search Slack for "Weekly Sales Activity Report — Preview" in C060YMXSLKD.
- **Zig reports two types per week** — Monday pipeline/sales update (headline numbers, stalled deals, large ops) AND Thursday outbound report (email counts, inbound replies, campaign activity, quotes-out, qualitative renewal movement). Pull both; they serve different sections of the draft.
- **Zig's mid-week preview (posted Wed in #sales_revenue-ninjas) contains PRIOR WEEK full-week activity data** in the "Last Week (Full)" column. This is the source of prior-week outbound/inbound/calls/meetings numbers. Don't assume this data doesn't exist just because the Thursday cron report only shows current week. The mid-week preview was posted starting June 3, 2026 — check for it every week. Steve caught this being missed in session 2026-06-15.
- **Patrick/Jan V1→V2 migration spreadsheet** (Google Sheets `1qvYwGneQQ47hqGTV50Qmv275qOi1JfgkXJ47bMRQPYM`) is the backend-data source of truth for district migration buckets, usage tiers, and login counts. It does NOT match HubSpot deal stages 1:1 — reconciliation between the spreadsheet buckets and HubSpot stages is an active workstream. The "21 active onboarding" on the dashboard came from HubSpot; the "10 migrating" on the spreadsheet came from Patrick's backend pull. Both count different things. When reporting onboarding/migration numbers, name the source.
- **Jan's weekly reporting was narrative-only through Week 3 (June 2026).** She reported qualitative pipeline movement ("we moved a lot of renewals forward") and named districts, but never a structured table with deals × dollars per HubSpot stage. The structured stage-by-stage data contract was agreed on June 15, 2026 — starting Week 4, Jan provides deals + $ per HubSpot stage every Thursday in the same format. Until you verify this cadence is running, pull HubSpot live yourself rather than assuming Jan's report has the stage breakdown.
- **Zig mid-week preview in #sales_revenue-ninjas carries prior week activity data.** The Thursday outbound cron started June 11, 2026. But the mid-week preview Zig posted on June 3 included a "Last Week (Full)" column with outbound/inbound/meetings by person. Check both the Thursday report AND the mid-week preview thread for prior-week baselines.
- **Show ALL HubSpot stages in pipeline tables, including $0 stages.** Every HubSpot stage gets a row on the dashboard even if it has 0 deals / $0. This creates a fixed template — next week you update numbers, add a "Prior Wk" column, and WoW shows itself. No stage additions or removals week to week. Confirmed stages: Sales Pipeline has 7 open stages + Re-engage; 26/27 Renewal has 7 open stages + Revisit After Sept.
- **Skip pipeline WoW when prior week reflects cleanup, not real movement.** If Jan did a major pipeline cleanup (moved deals between stages for data quality), don't show WoW comparison that week — it would show cleanup noise, not real business movement. Show activity WoW (always clean) but flag pipeline WoW as "starts next week." Steve explicitly directed this on June 15.
- **Renewal vs. net-new pipeline misclassification — don't assume, verify with Jan.** Farwell ISD ($1,692) and Triumph ($4,500) were in the Sales Pipeline as "Closed Won." I initially flagged them as renewals based on naming patterns — wrong. Jan confirmed both as new business. Yantis ($930) was the same: deal name sounded like a renewal, was actually net-new. Before reporting any close as misclassified, check with Steve or Jan. The agent's assumption is less reliable than Jan's direct knowledge of the customer relationship.
- **Dashboard Closed/Won and Churn rows — HOLD until data is clean (June 15 decision).** The 26/27 Renewal Pipeline has Closed/Won and Churn as real HubSpot stages. Churn in HubSpot contained 21 deals but only 7 were real churns ($28,057) — the other 14 were $0 duplicates, test districts, and invalid records with Michelle's cleanup labels in the deal names. Steve directed: do NOT show churn on Charlie's dashboard until after the HubSpot cleanup pass with Jan. Showing messy churn data creates questions nobody can answer cleanly. Add these rows to the dashboard only after the cleanup thread confirms which deals are real.
- **Build Jan verification HTMLs for alignment calls.** When reconciling pipeline data with Jan, build a separate standalone HTML (NOT the Charlie dashboard) showing every deal by stage, pulled live from HubSpot. Include flags for misclassified deals, duplicates, and cleanup items. File goes in `updates/2026/week-NN-working/jan-pipeline-verification.html`. Steve uses this as the visual walkthrough artifact on calls with Jan.
- **Atlas reports can contradict week-over-week — flag, don't paper over.** Example seen: June 4 draft said "13 open support tickets, oldest 53 days, Argyle critical"; June 11 final said "0 open tickets, all clear." Either 13 got cleared (say so as a win) or the definition changed. Surface the discrepancy in the internal draft; the verified/unverified discipline exists precisely to catch this.
- **V1→V2 migration spreadsheet is a separate source of truth from HubSpot** — Patrick's backend login data lives in a Google Sheet (ID: `1qvYwGneQQ47hqGTV50Qmv275qOi1JfgkXJ47bMRQPYM`, gid 563374786 = Summary tab). It has 81 districts across 7 buckets (Migrating Now / Migrate Next / Contract Obligation / Individual Convo / Marketing / Churned / ESC-Consortium). This data does NOT match HubSpot deal stages 1:1 — reconciliation is ongoing. The "21 active onboarding" on the dashboard came from HubSpot; the "10 migrating" came from the spreadsheet. When reporting onboarding/migration numbers, name the source. Bucket 3 ($208K, 29 districts with low/zero logins) is the real churn risk that the dashboard doesn't yet surface.
- **Verified vs. pending-verification tiering (the core reporting discipline).** Numbers carry a confidence tier. Michelle/QBO-confirmed = VERIFIED — only verified numbers anchor the ARR scoreboard or any financial figure Charlie sees. Jan/HubSpot-reported-but-not-finance-confirmed = PENDING. Show pending closes by name + dollar with an explicit "reported this week, pending finance verification" flag; NEVER roll them into the verified ARR total until Michelle flips them. Rule: a board chair forgives "here's what we're seeing, finance confirms in two weeks"; he does not forgive a number that changes after he repeats it to an investor.
- **Single source of truth split:** QBO/Michelle's financial dashboard = ARR, cash, burn, runway, P&L (the board-grade financial layer). Live HubSpot = pipeline/deals/stages/dollars. Zig = activity. Jan/Patrick/Sarah = human judgment layer. Michelle's dashboard IS the synthesis layer — the Charlie email is its cover letter, not a parallel activity summary. See references/scorecard-architecture.md.
- **Jan's reporting was narrative, not structured (discovered June 2026).** Across weeks 1–3, Jan reported pipeline qualitatively ("we moved a lot of renewals forward," "$155K across 15 districts") — never a structured table of deals × dollars per HubSpot stage. The outbound/inbound/quotes format also didn't exist before the Zig Thursday cron launched June 11. The data contract (same fields, same stages, every Thursday) was agreed with Jan on June 15. Going forward, verify that Jan's Thursday delivery includes the stage-by-stage table, not just narrative. If it's narrative only, pull live HubSpot yourself and flag the gap.
- **Prior-week activity data lives in the Zig mid-week preview.** The mid-week preview posted to #sales_revenue-ninjas (C060YMXSLKD) on Wednesdays contains a "Last Week (Full)" column with per-person outbound/inbound/calls/meetings. Check this FIRST for prior-week activity baselines when building WoW comparisons — don't assume only the Thursday report has it.
- **Dashboard table alignment is non-negotiable.** When two tables sit side by side (net-new vs renewals), the total rows MUST align horizontally. If one table has fewer data rows, add blank spacer rows `<tr><td>&nbsp;</td><td></td><td></td></tr>` before the total. Steve catches misalignment every time.
- **Show all HubSpot stages, even empty ones.** Every stage in the pipeline gets a row on the dashboard, even if deals = 0 and amount = $0. This creates the stable skeleton that next week's data drops into without structural changes.
- **Utah SEA is PARKED — keep it out of the pipeline headline.** The Utah State Education Agency deal (~$1.3M) stays in HubSpot so it's not forgotten, but Steve is focused on Texas, not Utah, and is not actively working it. Do NOT lead with a total-pipeline figure that includes Utah and then discount it ("$2.75M, but 47.7% is Utah") — that inflates the headline and then makes the real pipeline look thin in the same breath. Report the Texas / working pipeline as the clean headline number. Utah is at most a one-line "parked, not in current focus" footnote, or omitted. This is about reporting the pipeline actually being worked — not dressing numbers up.
- **The $1M-by-Sep-1 target is a STANDING anchor — never let it silently drift.** Charlie has seen "$1M by September 1" as the revenue target across multiple updates. A prior session's draft once carried "$1.5M by Aug 1" pulled blindly from an agent report — a different number AND a different date, with no explanation, which reads to Charlie as either a moved goal or a typo and undermines trust in the whole update. RULE: before changing the target figure or date in any draft, stop and confirm with Steve which is real. If an agent report uses a different target than last week's sent update, that's a conflict to surface to Steve, not a number to copy forward.
- **Keep HubSpot cleanup and Charlie reporting in separate sessions.** Steve explicitly directed (June 15, 2026): when a HubSpot data audit surfaces hundreds of deals needing review, spin it off into its own thread. Don't let bulk data pulls and deal-by-deal cleanup pollute the Charlie report session context. The Charlie session should work with "what we actually have from Jan, Patrick, Sarah, and Steve" — not raw HubSpot dumps. Create a prompt for the new session and hand it off cleanly.
- **Dashboard text must answer questions, not create them.** Steve's rule (June 15, 2026): every line on the dashboard is either a fact or context that makes a fact clearer. If it makes Charlie pause and wonder "what does he mean by that," it's doing the opposite of its job. No strategy philosophy ("retention is the engine"), no framing language ("every number below is read against one question"), no consulting-deck scaffolding. The strategy spine stays internal (in scorecard-architecture.md) — the dashboard shows data with source labels and lets the data speak. The "How to Read This Dashboard" callout covers only: what Verified/Reported badges mean, and the iteration disclaimer.
- **Gap numbers must lead with obvious math.** When showing "Gap to $1M," lead with $1M minus current verified ARR (the number anyone can verify in their head). Don't lead with the gap from a modeled base-case projection — that requires understanding the scenario model to make sense. Put scenario ranges in smaller context text, not the headline.
- **Table alignment matters for board-grade artifacts.** When two tables sit side-by-side, their total rows must align horizontally. If one table has fewer data rows, add a blank spacer row (`<tr><td>&nbsp;</td><td></td><td></td></tr>`) before the total. Steve catches visual misalignment.
- **Steve is comfortable surfacing data gaps honestly.** "Data reconciliation in progress" is a valid dashboard note for Charlie — better than pretending numbers are clean when they're not. The iterative improvement story IS the story. Just keep it short and factual, not apologetic.
- **HubSpot search API returns stale/cached results for recently deleted deals.** When checking whether a deal still exists, use a direct GET (`/crm/v3/objects/deals/{dealId}`) — 404 means deleted. The search endpoint can return deals that were deleted minutes ago. Steve caught this: Krum ISD duplicate appeared in search results after he'd already deleted it. Always direct-lookup to confirm before reporting a deal exists.
- **Dashboard stage names MUST match HubSpot stage names** — a prior session used invented names like "Presentation Scheduled" and "Sales Intake / Other" that don't exist in HubSpot. The correct Sales Pipeline stages are: 1. Sales Intake, 2. Qualifying, 3. Decision Maker Buy-In, 4. Ready for Quote, 5. Quote Sent, 6. Committed, Re-engage When V2 Available. The correct 26/27 Renewal stages are: 1. To be Renewed, 2. V2 Review Scheduled, 3. Ready for Quote, 4. Quote Sent, Committed, 6. PO Received, Closed/Won, Churn, REVISIT AFTER SEPT 2026. See `references/hubspot-pipeline-stages.md` for IDs. The dashboard may consolidate for Charlie's view (e.g. stages 2–5 as "Moving"), but the data layer and the Jan/Zig reports must use HubSpot's actual names. Mismatch between reported stages and HubSpot stages is exactly the problem Steve is trying to fix (session 2026-06-15).
- **NEVER assume a deal is a renewal based on naming conventions or HubSpot labels.** Real failures (June 15, 2026): Farwell "26/27 Contract" and Triumph "New Deal" were both in the Sales Pipeline. I assumed Farwell was a renewal based on the "26/27" in the name and flagged it for Jan to move. Steve caught it — Jan had explicitly said "new pipeline" for both closes. Yantis ISD was the same pattern — named "2026-2027" (sounds like a renewal), actually new business that closed in March. The $0 duplicate in the renewal pipeline had "[INVALID - already renewed 26/27]" in the deal name — this label was WRONG; Yantis was never a renewal. RULE: (1) If Jan says it's new business, it's new business. Don't relabel based on deal name patterns. (2) INVALID/DUPLICATE labels in HubSpot deal names are **Michelle's cleanup markers for her own financial reporting** — they are NOT authoritative deal classifications. Michelle labels deals for her reconciliation purposes; nobody else necessarily understands her labeling system, and the labels can be wrong about the deal's actual status. Don't present them as facts to Steve or Jan without verification. (3) When you see a deal labeled DUPLICATE/INVALID in HubSpot, tell Steve "this deal has [LABEL] in the name — likely Michelle's cleanup tag" — not "this IS X." Let Steve and Jan decide. (4) Steve confirmed (June 15): this labeling confusion is a systemic problem — the cleanup labels exist for Michelle's purposes but confuse everyone else and make it impossible for agents to distinguish real deals from noise. The fix is the HubSpot cleanup pass (separate session), not trusting the labels. (5) When reporting on these labels to Steve, be explicit that you got them from the HubSpot deal name field — say "someone renamed this deal to include [INVALID]" not "this deal is invalid." Steve needs to know the provenance so he can decide whether the label is accurate. (5) When Steve asks "why did you mark this as X?" — trace the assumption to its ACTUAL source (deal name pattern, HubSpot label, agent inference) and own it. Don't rationalize after the fact. Jan's direct knowledge of the customer relationship overrides any naming-pattern inference.
- **HubSpot search API returns stale/cached results for recently deleted deals.** A deal Steve deleted minutes ago can still appear in `search_objects` results. ALWAYS verify with a direct GET by deal ID (`GET /crm/v3/objects/deals/{dealId}`) — a 404 confirms deletion. Don't tell Steve a deal still exists based on search results alone. This bit us on the Krum ISD duplicate (June 15, 2026) — search returned it, Steve said "check again," direct lookup confirmed it was gone.
- **Bulk-imported deals frequently miss company associations.** After ANY bulk deal creation in HubSpot, check company associations for every new deal via `GET /crm/v4/objects/deals/{dealId}/associations/companies`. The May 20-21 2026 import left 36 of 77 renewal deals orphaned — including Humble ($72K), Mesquite ($57K), Canyon ($17K). Deals without company associations are invisible from the HubSpot company page, causing Jan to create duplicates and making pipeline reporting unreliable. Fix with: `PUT /crm/v4/objects/deals/{dealId}/associations/companies/{companyId}` body `[{"associationCategory": "HUBSPOT_DEFINED", "associationTypeId": 341}]`. Match deals to companies by district name search.
- **Test districts leak into renewal pipelines during bulk imports.** When renewal deals are bulk-created from a district list, test districts (Godley, Clifton, North Lamar, Winters, Abilene, etc.) get included as $0 deals. Michelle labels them [INVALID - test district] and moves to Churn, but they inflate churn counts. Cross-reference against the Testing Districts pipeline (41834638). Full cleanup workflow: `references/pipeline-cleanup-workflow.md`.
- **Pipeline cleanup spreadsheets should only show current-year deals.** Steve explicitly directed (June 15, 2026): don't include historical closed deals from prior years. Sales Pipeline tab should show active + this-year Closed Won + this-year Closed Lost only. Old losses like the 2024 Mesquite $76K attempt are noise for a cleanup exercise. Filter by closedate >= July 1 of current school year for closed deals.
- **25/26 Closed Won → 26/27 renewal gap analysis is essential.** Every Closed Won deal in the prior-year pipeline should have a corresponding renewal deal in the current-year pipeline. Add a "Has 26/27 Renewal?" column to the 25/26 tab. Most gaps are $0 consortium districts handled under ESC umbrella deals, but real ones surface too (San Marcos $14,850 was missing its 26/27 renewal).
- **Don't add Closed/Won or Churn to the dashboard until the underlying data is clean.** Steve explicitly directed (June 15, 2026): if half the churn list is $0 duplicates and test districts that shouldn't exist, showing churn on Charlie's dashboard creates more questions than it answers. Hold closed/churn reporting until after the HubSpot cleanup pass with Jan. Better to add it next week with clean numbers than show messy data this week.
- **Email format has been upscaled (Week 3, June 15, 2026).** The email is now a COVER LETTER to the dashboard — approximately 250-300 words, one flowing narrative, one dashboard link. NOT the old 6-section activity dump (Deals, Product, How We're Tracking, Team, Housekeeping, Next Steps). The dashboard carries the data weight; the email tells Charlie: (1) what moved this week, (2) what matters in the numbers, (3) what you need from him. No housekeeping section, no team section, no contractor swaps, no internal ops noise. The old section structure in the skill is SUPERSEDED for the email — keep it only as a reference for what data to collect, not how to format the email. The dashboard sections (Revenue & Pipeline, Renewals & CS, Product & BI) are the structure now.
- **Gmail draft iteration workflow (proven June 15, 2026).** Steve reviews and edits in real-time. Expect 2-4 rounds of draft replacement per email. Delete old draft before creating new one each round. When Steve sends before you've finished iterating, check sent mail and update the dashboard to match what he actually sent — his edits are the final version, not your draft. Use the Gmail API directly (not google_api.py) for draft create/delete since google_api.py doesn't have a draft command.
- **When an agent report gives a number without math and a source document gives a different number WITH names attached, use the source document.** Atlas reported "21 active onboarding" with no breakdown. The Patrick/Jan migration spreadsheet showed 26 districts (10 active + 16 scheduled) with every name listed. Steve directed: use 26. The rule is general — defensible numbers with source backup beat round numbers from agent summaries.
- **Don't fabricate "prior week" close comparisons.** If no deals closed the actual prior week, show this week's closes only — no prior week line at all. Pulling a close from 3 weeks ago (Dodd City, May 21) and labeling it "Prior week" on a June 13 dashboard is misleading. Steve caught this and directed removal. $0 last week → $6K this week is a real story; a manufactured comparison undermines trust.
- **V1 retirement framing for Charlie:** retiring V1 saves $7-9K/month in hosting AND frees infrastructure capacity for AI/product tools. Frame cost savings as reallocation toward where the company is headed — not "costs are going up." Don't mention token usage or specific AI infrastructure costs to Charlie; frame it as infrastructure investment.
- **Keep HubSpot cleanup and Charlie reporting in strictly separate sessions.** Steve explicitly directed this (June 15). When bulk deal data needs review, spin it into its own thread with a clean prompt. The Charlie session works with "what we actually have from Jan, Patrick, Sarah, and Steve" — not raw HubSpot dumps of 300+ deals. Create the handoff prompt in-session, then get back to the report.
- **HubSpot cleanup and Charlie reporting MUST be separate sessions.** When pipeline data needs a full audit (duplicates, test districts, misclassified deals), spin it into its own thread with a self-contained prompt. Don't let hundreds of raw deal records pollute the Charlie report session context. The Charlie session works with "what we actually have from Jan, Patrick, Sarah, and Steve" — not raw HubSpot dumps. Steve explicitly directed this June 15, 2026.
- **Email format upgrade (Week 3+, June 2026): email is the cover letter, dashboard is the substance.** The email should be ~250-300 words, NOT a 6-section activity dump. It tells Charlie three things: (1) what moved this week, (2) what matters in the numbers (1-2 things to pay attention to on the dashboard), (3) what you need from him. One dashboard link. No housekeeping section, no team section, no contractor swaps, no internal ops noise. The dashboard carries the data weight. Last week's format (6 sections, deal names scattered everywhere, TechDome/equity/legal noise) was an activity report, not a board-grade update. The upgrade is: tight narrative cover letter + linked visual dashboard.
- **Don't show "prior week" on the Closed card unless a deal actually closed the prior week.** If no deals closed in the actual prior week, show only "This week: $X" — no prior week line at all. Don't pull a close from 3 weeks ago and label it "Prior week." Steve caught Dodd City ($606, closed May 21) being shown as "Prior week" on the June 13 dashboard when the actual prior week was $0. Removed entirely. Showing nothing is better than a misleading comparison.
- **When the agent makes an assumption that gets corrected, trace WHERE the assumption came from and own it.** Steve asked why Farwell/Triumph were flagged as renewals. The answer was: Jan never called them renewals — the agent assumed based on deal naming patterns and was wrong. Jan explicitly said "new pipeline" for both. Similarly, Yantis was assumed to be a renewal based on "2026-2027" in the deal name — actually new business. The DUPLICATE/INVALID labels in HubSpot deal names are Michelle's cleanup markers for her own reporting — they are NOT authoritative deal classifications and can be wrong. When Steve asks "where did you get that?" — trace it to the actual source, don't rationalize.
- **Check deal-to-company associations on renewal pipeline deals.** Bulk-imported deals (especially the May 20-21, 2026 batch) frequently lack company associations. Mesquite ISD ($56,822) was orphaned — no company linked. Steve found and fixed it himself. Before any pipeline report, spot-check the top deals for company associations: `hubspot_list_associations(objectType='deals', objectId=ID, toObjectType='companies')`. Orphaned deals are invisible from the company record page.
- **Don't fabricate "prior week" comparisons on the Closed card.** If no deals closed the actual prior week, don't pull a close from weeks ago and label it "Prior week." Show "This week: $X" only — no prior week line at all. Steve directed (June 15): showing nothing is better than a misleading comparison. The Dodd City $606 (closed May 21) was displayed as "Prior week" on the June 13 dashboard when the actual prior week was $0. Removed entirely. $0 → $6,192 is a real story; a fake comparison undermines trust in every other number on the card.
- **Dashboard must show ALL HubSpot stages, including $0 ones.** Every stage in the pipeline definition gets a row, even when empty. This creates the fixed template for WoW comparison — when a deal moves into a stage next week, the row already exists. Confirmed stage lists: Sales Pipeline (7 open stages + Re-engage V2), 26/27 Renewal Pipeline (7 open stages + Revisit After Sept). Include Closed/Won and Churn in the renewal reporting.
- **Zig mid-week preview (posted ~Wednesday in #sales_revenue-ninjas) contains prior-week activity data** in the "Last Week (Full)" column. Don't miss this — it's the source for the WoW activity comparison prior week numbers.
- **Jan's pipeline reporting was narrative-only through Week 3 (June 2026).** No structured stage-by-stage data existed before June 15. Starting Week 4, Jan provides deals × dollars per HubSpot stage every Thursday. The dashboard is the standardized format.
- **Cut operational noise that isn't board-grade** — contractor swaps (e.g. DataArt/Argentina hires), tiny closes (sub-$1K), small quotes, and internal sales-activity volume tables (e.g. "178 emails vs 18") do NOT belong in front of Charlie. They read as activity-as-substance. Keep the Team section to material moves only.
- **"Go back to basics" approach (proven Week 3):** When the data is messy or you're unsure what's real, inventory exactly what each person gave you — Jan, Patrick, Sarah, Steve — and work only with that. Don't pull HubSpot to fill gaps until you've established the baseline from human sources. Steve directed this explicitly: "let's report on what we have from what Jan gave us, what Patrick gave us, what I already gave you, what Sarah has given us." This prevents the agent from over-reaching into raw data that creates more confusion than clarity.
- **Reconcile any week-over-week pipeline jump before it goes out** — if the working-pipeline number changed materially vs. last week's sent update (e.g. ex-Utah $658K → $1.44M), confirm whether it's a real surge or a definition/stage-set drift before putting it in front of Charlie. An unexplained jump walks straight into the reconciliation concern Charlie already flagged in #sales-forecasting. When unsure, pull HubSpot live rather than carrying a possibly-drifted figure forward.
- **Jan's pipeline reporting is narrative, not structured** — as of June 2026, Jan does not provide pipeline-by-stage tables with deals and dollars. She provides qualitative movement descriptions ("we moved a lot of renewals forward"). The dollar numbers and stage breakdowns MUST come from live HubSpot pulls every week. Do not assume Jan's report contains the stage-by-stage data. The weekly data contract (locked June 15) calls for Jan/Zig to deliver structured stage-by-stage data every Thursday going forward, but verify it actually arrived before relying on it.
- **Prior week activity data lives in Zig's mid-week preview, not the Thursday report** — Zig's Thursday outbound report (cron launched June 11) only covers the current week. For PRIOR week activity baselines, check the Zig mid-week preview posted earlier that week in #sales_revenue-ninjas — it has a "Last Week (Full)" column with per-person outbound/inbound/meetings. The Thursday report does NOT carry prior-week comparison data.
- **Pipeline WoW requires snapshotting — HubSpot has no history** — HubSpot overwrites deal stages in place. When a deal moves from Qualifying to Decision Maker Buy-In, the old stage is gone. To show week-over-week pipeline movement on the dashboard, you MUST snapshot this week's stage-by-stage totals somewhere (the dashboard HTML itself serves as the snapshot). Without a prior-week snapshot, you cannot reconstruct what each stage looked like. Never promise WoW pipeline data you can't deliver.
- **Don't show pipeline WoW when cleanup happened** — if Jan or the team did significant pipeline cleanup (stage reassignments, deal corrections, bulk moves) during the week, do NOT show prior-week comparison for pipeline stages. The delta would show cleanup noise, not real movement, and Charlie would ask questions nobody can answer cleanly. Show the clean baseline this week, start WoW next week. Activity WoW (outbound/inbound) is always fine since it's additive, not restructured.
- **Dashboard should answer questions, not create them** — Steve's principle (June 15): every line on the dashboard should either be a fact or context that makes a fact clearer. If it makes Charlie pause and wonder "what does he mean by that," it's doing the opposite of its job. No strategy philosophy ("retention is the engine"), no "every number below is read against one question" framing. Source labels (Verified/Reported) and an iteration disclaimer are the only meta-content that belongs.
- **Product language precision on dashboard and email — use exact Bookmarked terminology:**
  - Book Intelligence data = "quick intelligence data" — NOT "content data," NOT "our content data." The product surfaces intelligence, not raw content.
  - The Orders flow is an "order workflow" where librarians build book lists for board approval — NOT a "point of purchase," NOT a "purchasing page," NOT "checkout." Districts don't buy directly; they aggregate orders for board approval.
  - Don't over-claim product milestones. Steve removed "biggest single ship event this quarter" from both email and dashboard (June 15). State what shipped and where it matters; let Charlie decide if it's big. Superlatives create expectations you then have to exceed next week.
  - These corrections apply everywhere: dashboard HTML, Charlie email, internal drafts, and any board-facing artifact.
- **Dashboard "active onboarding" count must come from the migration spreadsheet, not unverified agent numbers.** The Patrick/Jan migration spreadsheet (Google Sheets `1qvYwGneQQ47hqGTV50Qmv275qOi1JfgkXJ47bMRQPYM`) tracks V1→V2 migration in 7 buckets. Atlas's CS report said "21 active onboarding" without showing the math. The spreadsheet shows 10 Bucket 1 (actively migrating) + 16 Bucket 2 (migrate now) = 26 districts in the migration pipeline. Steve directed (June 15, 2026): use 26 from the spreadsheet because it has names attached and is defensible. Changed the dashboard card from 21 → 26 with subtitle "districts in migration pipeline (10 active, 16 scheduled) · 4 at Go-Live." **Rule: when an agent report gives a number without showing the math, and a source document gives a different number WITH the math, use the source document.** Confirm with Patrick/Jan if the numbers still don't reconcile next week.
- **Patrick migration confidence (from June 15 sync):** Patrick confirmed 43 districts remaining, said he can complete all migrations by June 22 if the team starts Thursday and works through the weekend (he's out starting the 22nd). He built automation that compares V1 and V2 data before closing tickets. Communication strategy shifted from specific cutover dates to a "window" (18th through 30th). Steve told Patrick to proceed without waiting for further approval — urgency driven by $9K/month hosting cost for V1. Frame for Charlie: "Patrick's confident he can get all remaining districts moved to V2 by end of June." This is the general principle: numbers with named backing > numbers without.
- **Bucket 3 ($208K low/no usage contracts) is the real churn risk — surface it.** The migration spreadsheet shows 29 districts with active contracts but low or zero usage (16 with literally zero logins). This is invisible on the dashboard but is the highest-probability churn pool. It includes Humble ($72K), ILTexas ($42K), Beaumont ($14K). When building the dashboard's renewals/CS section, consider whether this deserves its own signal or callout — Steve flagged this as important context June 15, 2026.
- **No philosophy or strategy statements on the dashboard.** Steve removed the "retention is the engine" strategy spine (June 15). The dashboard answers questions with facts and brief context. It does not teach strategy, assert priorities, or frame a narrative. If a line would make the reader pause to interpret what it means rather than just absorbing a fact, cut it. See the "Content rules Steve set for the scorecard tab" section above for full guidance.
- **Bulk-imported renewal deals are often not associated to company records.** The May 20-21 2026 batch import of 26/27 renewal deals created 36 of 77 deals with no company association — $180K in pipeline invisible from the company page view. This causes duplicate deal creation (people can't see the existing deal so they create another). When pulling pipeline data, ALWAYS check company associations via `GET /crm/v4/objects/deals/{dealId}/associations/companies`. Add a "Company Linked?" column to any pipeline export. See `references/pipeline-cleanup-workflow.md` for the batch-fix workflow.
- **Google Sheets mangles deal names with slashes when using USER_ENTERED.** "26/27 RENEWAL" can render as a date ("26-27-0") when written with valueInputOption=USER_ENTERED. Use RAW for deal name columns; use USER_ENTERED only for columns that benefit from auto-formatting (currency, dates).
- **VERIFY DEAL STATE IN HUBSPOT BEFORE ASSERTING.** Real failure (June 15, 2026): told Steve a duplicate deal still existed and needed cleanup when he had already deleted it. Then did it AGAIN with a second deal in the same session. HubSpot search can return stale/cached results -- a direct GET returning 404 or search-by-ID returning total:0 is definitive. RULE: before telling Steve a deal exists, is in a stage, or needs action, do a live lookup. Never rely on data cached from earlier in the session if Steve has been making changes in HubSpot.
- **Bulk-imported deals are often orphaned from company records.** The May 2026 renewal bulk import created 36 deals with no company association -- invisible from the district company page. When deal counts or pipeline data look wrong, check associations first. See references/pipeline-cleanup-workflow.md for the batch fix recipe.
- **Dashboard content: answer questions, don't create them.** Before adding any text to the scorecard, ask: "Would this make Charlie pause and wonder what I mean?" If yes, it fails — cut it or reword it as a plain fact. Strategy framing, aspirational language, and internal operating-model talk all fail this test. Context is welcome but ONLY when it makes an adjacent number clearer. Steve's rule (June 2026): "I'm not trying to teach Charlie the strategy on this dashboard. I just want to give him facts and enough context to read them."
- **Bulk-created renewal deals may lack company associations — audit after any batch import.** The May 20-21 2026 batch import created ~36 renewal deals with NO company association. These deals existed in the pipeline but were invisible from the company page in HubSpot. Anyone looking at a district (Jan, Natasha, agents) couldn't see the deal and would either create a duplicate or report the district as having no renewal activity. This is the root cause of duplicate Krum, duplicate Midland, duplicate Henrietta. After any bulk deal creation, immediately audit company associations using `GET /crm/v4/objects/deals/{dealId}/associations/companies` and batch-fix with `PUT /crm/v4/objects/deals/{dealId}/associations/companies/{companyId}` (associationTypeId 341). See `references/pipeline-cleanup-workflow.md` for the full technique.
