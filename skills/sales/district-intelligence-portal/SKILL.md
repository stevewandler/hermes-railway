---
name: district-intelligence-portal
description: "Build, operate, and improve Bookmarked's District Intelligence Portal — sales intelligence dashboards for Texas ISDs backed by board minutes, IMTA funding, superintendent movement, media, and HubSpot pipelines."
version: 1.0.0
author: agent
tags: [bookmarked, district-portal, sales-intelligence, hubspot, board-minutes, imta, supt-movement, github-pages, pipeline]
---

# District Intelligence Portal — Operations Skill

**Load this skill any time Steve says:**
- "portal", "district intelligence portal", "district dashboard"
- "board minutes pipeline", "IMTA pipeline"
- "supt movement", "supt alerter", "superintendent dashboard"
- "bookmarked-exports", "publish to GitHub Pages"
- Anything about improving, rebuilding, or adding a tab to the portal

**Also load:** `bookmarked-strategy` for GTM context. `gbrain` if ingesting new data.

---

## Architecture in One Sentence

The portal is a set of Python generators that merge four data pipelines (board minutes, IMTA, superintendent movement, media) into static HTML dashboards, published to GitHub Pages, cross-referenced against HubSpot outreach state.

---

## Two-Repo Setup

| Repo | Remote | Local | Role |
|------|--------|-------|------|
| `bookmarked-os` | `git@github.com:BookmarkED-Corp/bookmarked-os.git` (private) | `~/github-repos/bookmarked-os/` | All code, generators, data |
| `bookmarked-exports` | `BookmarkED-Corp/bookmarked-exports` (PUBLIC) | **Not cloned locally** | GitHub Pages publish target |

**GitHub Pages URL:** `https://bookmarked-corp.github.io/bookmarked-exports/reports/`

There is no automated deploy. Publishing = generate locally → copy HTML to bookmarked-exports → `git push`.

---

## Credentials & Logins

| Credential | Location | Used By |
|------------|----------|---------|
| HubSpot Private App token | `~/github-repos/bookmarked-os/.mcp.json` → `mcpServers.hubspot.env.PRIVATE_APP_ACCESS_TOKEN` | `hubspot-discovery/01_pull_companies.py`, direct REST calls |
| HubSpot Portal ID | `39855019` (hardcoded) | Deep links in `03_review_report.py`, `04_build_outreach_stub.py` |
| Slack bot token | `~/github-repos/bookmarked-os/.mcp.json` → `mcpServers.slack.SLACK_BOT_TOKEN` | Board pipeline Slack channel `C060YMXSLKD` (Slack alerts deferred in supt alerter v1) |
| Google Workspace (gws CLI) | `~/.config/gws/` | `supt_alerter.py` sends Gmail via `gws gmail users messages send` — account `steve@bookmarked.com` |
| GAS Webapp (assignments) | `https://script.google.com/macros/s/AKfycbz...exec` | Live district ownership layer in portal browser |
| Google Sheet (assignments) | `https://docs.google.com/spreadsheets/d/1YhHfA7fYCUFtgrtk32Q9JD2eJSJgPUnNE0msWMnEWJI/edit` | Ownership store behind GAS |
| GitHub SSH | `git@github.com` | Push to both repos |

---

## Portal Structure

```
bookmarked-os/claude-output/
├── board-minutes-pipeline/          ← upstream: board scoring (Red/Yellow/Green)
│   ├── config/districts.csv         ← 1,019 ISDs
│   ├── config/keywords.yaml         ← 4-tier weighted scoring config
│   ├── data/cache.sqlite            ← document cache
│   ├── data/results/current_snapshot.json   ← board data consumed by joiner
│   ├── data/results/supt-events.jsonl       ← supt change events
│   └── run.py                       ← `python3 run.py --mode incremental`
│
├── imta-pipeline/                   ← upstream: IMTA allotments
│   ├── data/raw-pdfs/2026-2027-imta-funds.pdf
│   ├── data/results/current_snapshot.json   ← IMTA data consumed by joiner
│   └── src/pipeline.py
│
├── district-intelligence-portal/    ← THE PORTAL
│   ├── src/
│   │   ├── joiner.py                ← CORE: merges board + IMTA + supt-events → unified-districts.json
│   │   ├── trend_tracker.py         ← delta vs. previous run → trend-deltas.json
│   │   ├── profile_page.py          ← district-profile.html (1,210 districts, JS-routed by ?d=slug)
│   │   ├── supt_movement_dashboard.py ← supt-movement-dashboard.html
│   │   ├── supt_extractor.py        ← regex NLP: hire/resign/retire/interim detection
│   │   ├── supt_alerter.py          ← email alerts via gws (daily owner + Monday digest)
│   │   ├── media_enrich.py          ← media-tracker.json → media-items.json
│   │   ├── media_dashboard.py       ← media-intelligence-dashboard.html
│   │   ├── pdf_generator.py         ← Playwright: profile → PDF brief
│   │   └── tea_directory_snapshot.py ← BLOCKED: TEA URL unresolved
│   ├── hubspot-discovery/
│   │   ├── 01_pull_companies.py     ← REST pull: 1,625 TX companies
│   │   ├── 02_fuzzy_match.py        ← multi-signal matcher (95.8% high-confidence)
│   │   ├── 03_review_report.py      ← hubspot-match-review.html
│   │   └── 04_build_outreach_stub.py ← hubspot-outreach-stub.json (approved: false)
│   ├── output/                      ← GITIGNORED — regenerated on each run
│   │   ├── unified-districts.json   ← 1,210 district records
│   │   ├── supt-movement.json       ← 90-day supt movement
│   │   ├── trend-deltas.json        ← trend pills data
│   │   ├── hubspot-outreach-stub.json ← HubSpot match data (approved=false — pending review)
│   │   ├── assignments-config.js    ← GAS webapp config (committed, not in output gitignore)
│   │   ├── pdfs/                    ← 11 pre-generated district briefs
│   │   └── supt-alerter-previews/   ← email preview HTMLs
│   ├── data/supt-alerter-state.json ← deduplication state for alerter
│   └── BACKLOG.md                   ← living build log: shipped/pending/data quality
│
└── research/media-tracker.json      ← media coverage source (updated by /media-monitor skill)
```

---

## Run Commands

```bash
# Working directory for ALL commands:
cd ~/github-repos/bookmarked-os

# ── UPSTREAM PIPELINES ──────────────────────────────────────────────────

# Board minutes (incremental — daily ops)
python3 claude-output/board-minutes-pipeline/run.py --mode incremental

# Board minutes (full — 1,019 ISDs — takes hours — use sparingly)
python3 claude-output/board-minutes-pipeline/run.py --mode full

# Board minutes test run (first N districts)
python3 claude-output/board-minutes-pipeline/run.py --mode full --max 10

# IMTA pipeline (only when TEA publishes new PDF)
# Live PDF URL (confirmed 2026-06-09):
# https://tea.texas.gov/academics/instructional-materials/procure-instructional-materials-in-emat/2026-2027-imta-funds.pdf
# PDF column order: CDN | District Name | District Enrollment | EB Enrollment | Student Allotment | EB Add-on | Total Biennial Allotment
# To look up a single district quickly without running the pipeline, see district-account-pickup skill step 6.
python3 claude-output/imta-pipeline/src/pipeline.py

# ── PORTAL REGEN ────────────────────────────────────────────────────────

# 1. Merge pipelines (always run first)
python3 claude-output/district-intelligence-portal/src/joiner.py

# 2. Trend tracker (after joiner)
python3 claude-output/district-intelligence-portal/src/trend_tracker.py

# 3. Generate HTML
python3 claude-output/district-intelligence-portal/src/supt_movement_dashboard.py
python3 claude-output/district-intelligence-portal/src/profile_page.py
python3 claude-output/district-intelligence-portal/src/media_enrich.py  # requires media-tracker.json current
python3 claude-output/district-intelligence-portal/src/media_dashboard.py

# 4. PDF briefs (Playwright required — top targets + Red districts)
python3 claude-output/district-intelligence-portal/src/pdf_generator.py
python3 claude-output/district-intelligence-portal/src/pdf_generator.py <slug>  # single district

# ── HUBSPOT REFRESH (manual, not daily) ─────────────────────────────────
python3 claude-output/district-intelligence-portal/hubspot-discovery/01_pull_companies.py
python3 claude-output/district-intelligence-portal/hubspot-discovery/02_fuzzy_match.py
python3 claude-output/district-intelligence-portal/hubspot-discovery/03_review_report.py
python3 claude-output/district-intelligence-portal/hubspot-discovery/04_build_outreach_stub.py
# Then: open output/hubspot-match-review.html, verify top 11, set approved=true, regenerate profile page

# ── SUPT ALERTER (also runs via crontab) ────────────────────────────────
SUPT_ALERTER_LIVE=1 python3 claude-output/district-intelligence-portal/src/supt_alerter.py          # daily
SUPT_ALERTER_LIVE=1 python3 claude-output/district-intelligence-portal/src/supt_alerter.py --weekly # digest
```

---

## Scheduling (Steve's Mac)

**crontab** (run `crontab -l` to verify):
```
# 4:00 AM CT daily — regen portal pages (after 3:23 AM board pipeline)
0 4 * * *   cd ~/github-repos/bookmarked-os && python3 .../joiner.py && .../supt_movement_dashboard.py && .../profile_page.py

# 6:30 AM CT daily — owner alert emails
30 6 * * *  SUPT_ALERTER_LIVE=1 python3 .../supt_alerter.py

# Monday 7:30 AM CT — weekly digest to jan@, teela@, steve@, charlie@
30 7 * * 1  SUPT_ALERTER_LIVE=1 python3 .../supt_alerter.py --weekly
```

**⚠️ SCHEDULING GAP:** Board minutes pipeline (3:23 AM every 2 days) and IMTA pipeline (1st/15th 4:23 AM) are documented in BACKLOG.md but have NO actual cron or launchd entry. They are run manually or triggered manually. This needs to be fixed.

---

## Known Gaps & Active Backlog

| Gap | Status | What to do |
|-----|--------|-----------|
| HubSpot matches `approved: false` | Since 2026-04-14 | Open `hubspot-match-review.html`, verify top 11, flip `approved: true`, regenerate profile page (~30 min) |
| TEA directory snapshot | BLOCKED | Manually test candidate URLs in browser — `tealprod.tea.state.tx.us/Tea.AskTED.Web/Forms/AdvancedSearch.aspx` |
| supt_alerter.py GitHub Pages URL | BUG | `stevewandler.github.io` → fix to `bookmarked-corp.github.io/bookmarked-exports/reports/` |
| Board/IMTA pipeline scheduling | NOT SCHEDULED | Add crontab entries: `23 3 */2 * *` for board, `23 4 1,15 * *` for IMTA |
| No automated publish to GitHub Pages | Manual | Could add a `git push` step to the regen cron |
| bookmarked-os working tree dirty | 7 modified files | Review `git diff --stat`, commit when ready |
| 10 numeric-slug districts | Data quality | Patch `joiner.py` to skip nameless IMTA records |
| 5 top-target districts unowned | Sales gap | Arlington, Cypress-Fairbanks, Wimberley, Progreso, West Oso — assign in HubSpot |
| Texas ISD Book Intelligence tab | Wave 3 pending | PEN America Airtable → Playwright scrape → CSV → fuzzy join |
| Combined Signal tab | Deferred until Book Intel ships | Unified ranking by signal_layers count |

---

## Portal Tabs & Generators

| Tab | HTML File | Generator | Data Source |
|-----|-----------|-----------|-------------|
| Board Intelligence | `board-minutes-pipeline/output/board-minutes-dashboard.html` | `src/dashboard.py` (in board pipeline) | `data/results/current_snapshot.json` |
| IMTA Intelligence | `imta-pipeline/output/imta-intelligence-dashboard.html` | `src/dashboard.py` (in IMTA pipeline) | `data/results/current_snapshot.json` |
| Media Intelligence | `district-intelligence-portal/output/media-intelligence-dashboard.html` | `src/media_dashboard.py` | `output/media-items.json` |
| Supt Movement | `district-intelligence-portal/output/supt-movement-dashboard.html` | `src/supt_movement_dashboard.py` | `output/supt-movement.json` |
| District Profile | `district-intelligence-portal/output/district-profile.html` | `src/profile_page.py` | `output/unified-districts.json` (all 1,210) |
| HubSpot Match Review | `district-intelligence-portal/output/hubspot-match-review.html` | `hubspot-discovery/03_review_report.py` | Internal review artifact |

---

## Design System

All dashboards share:
- Font: Urbanist (Google Fonts, 400–800)
- Eigengrau: `#101828` (text)
- Deep Green: `#107569` (active tabs, primary CTA)
- Teal: `#12A38C` (accents)
- Pumpkin: `#FF692E` (alerts, urgency, "New" pills)
- Amber: `#F59E0B` (interim, pending)
- Cool bg: `#F8FAFC`
- Radius: sm=6px, md=10px, lg=14px
- Portal nav: sticky, pill-style tabs, consistent across ALL tabs

**Brand authority:** `knowledge/brand/brand-design-system.md` in bookmarked-os. Portal uses a compliant variant (Sea Green → Teal/Deep Green as portal primary).

---

## Supt Alerter — Current State (2026-06-08)

- Shadow mode: **OFF in crontab** (`SUPT_ALERTER_LIVE=1` env var overrides the file default)
- State: `data/supt-alerter-state.json` — 0 alerted events, last_run 06:30, last_weekly 07:30
- Weekly digest recipients: jan@, teela@, steve@, charlie@ (added 2026-05-27)
- Email sent from: `steve@bookmarked.com` via gws CLI
- Email previews in: `output/supt-alerter-previews/`

---

## HubSpot Owner Map

| Owner ID | Name | Email |
|----------|------|-------|
| 81631149 | Patrick Reid | patrick@bookmarked.com |
| 83343072 | Jan Gilboy | jan@bookmarked.com |
| 436425345 | Teela Watson | teela@bookmarked.com |
| 479487253 | Steve Wandler | steve@bookmarked.com |
| 676475396 | Sarah El Massry | sarah@bookmarked.com |
| 681243224 | Michelle Rogers | michelle@bookmarked.com |
| 83027884 | Natasha Flanders | natasha@bookmarked.com |
| 83162430 | Raju Datla | raju@bookmarked.com |
| 84751596 | Charlie Clines | charlie@bookmarked.com |

---

## G-Brain Pages (search these for detail)

- `district-intelligence-portal` — canonical architecture (all files, data model, pipeline flow)
- `district-intelligence-portal-infra` — full infrastructure, credentials, scheduling, run commands
- `superintendent-intelligence-workflow` — workflow spec, alert routing, current live data
- `bookmarked-os-repo-map` — broader repo context, design assets, exports directory

---

## IMTA Numbers — Check Confluence First

The portal's IMTA pipeline pulls from the TEA biennial PDF, which gives allotment amounts (what districts are *allocated*). Jan Gilboy's Confluence page (Sales Hub, page ID **147488769**, "IMTA Funding") has additional critical facts that the pipeline doesn't capture:

- **Formula:** $174.69/student **biennial** (not $120/year — 2-year allotment, not annual)
- **ESC 16 is the fiscal agent** → no RFP required for procurement. Huge deal for sales.
- **Districts can use IMTA for the platform AND the books** that flow through it
- **Unspent IMTA carryover** (e.g. Garland's $2.17M) is separate from the biennial allotment — Jan's EMAT-sourced figures are the actionable sales number
- **IMTA + SB13 one-pager** already built at `claude-output/exports/imta-sb13-one-pager-2026-04-15.html`

Always cross-check portal IMTA numbers against the Confluence page before using them in district conversations.

---

## Pitfalls

- **`output/` is gitignored in the portal** — all generated HTML/JSON is local-only until manually copied to bookmarked-exports and pushed. Don't assume GitHub Pages is current.
- **Two GitHub Pages URLs in play:** `supt_alerter.py` hardcodes `stevewandler.github.io` (WRONG). `pdf_generator.py` uses `bookmarked-corp.github.io` (correct). Every email alert has broken links. Fix `supt_alerter.py` before the next live alert run.
- **`SUPT_ALERTER_LIVE=1` is SET in crontab** — the Python file defaults to shadow mode but the env var in crontab overrides it. Alerts are live, not shadow.
- **`hubspot-discovery/companies-tx.jsonl` and `owners.json` are gitignored** — they're regenerated by `01_pull_companies.py`. Don't try to read them from git history.
- **Portal HTML is also gitignored** — `output/` is in `.gitignore`. The committed source is the Python generators, not the HTML.
- **Working tree dirty as of 2026-06-08** — `joiner.py`, `profile_page.py`, `dashboard.py` (board), `dashboard.py` (IMTA), `pipeline.py` (board) all have uncommitted changes. Run `git diff --stat` before starting any new build work.
- **Board minutes full run takes hours** — 1,019 ISDs with time budgets of 15–40 min each + politeness delays. Use `--mode incremental` for daily ops.
- **TEA directory snapshot is not runnable** — `tea_directory_snapshot.py` has `TEA_DIRECTORY_URL = None` and empty selectors. Don't try to run it.

## References

- `references/infra-state-2026-06-08.md` — full infrastructure audit: scheduling reality, credential locations, git status, known gaps
