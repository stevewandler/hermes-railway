---
name: founder-cockpit
description: "Architecture, data pipeline, design tokens, and operating rules for Steve's Northy-powered founder cockpit — the single centralized dashboard for his entire operating system."
version: 1.0.0
author: agent
tags: [cockpit, northy, dashboard, founder-os, triage, design-system]
related_skills: [strategy-agent]
---

# Founder Cockpit

The cockpit is the single page Steve opens to fly his entire operating system. One URL. Everything he needs. Built as a static HTML page that reads from a JSON data file, deployed via GitHub Pages.

## Architecture

```
Northy cron scan → writes northy-cockpit.json + triage page → git commit → GitHub Pages deploy
                                      ↓
                              cockpit-8f2a7k.html reads JSON on page load
                                      ↓
                              Steve sees live triage, commitments, metrics, health
```

### Data Pipeline

1. **Northy runs** (cron: nightly 9pm deep scan, every 3 hours light scan)
2. **Northy writes two artifacts:**
   - `ops/northy-triage` in G-Brain (markdown — for chat reference)
   - `board/northy-cockpit.json` in `~/github-repos/roi-calculator/` (JSON — for the dashboard)
3. **Northy commits and pushes** the JSON to GitHub
4. **GitHub Pages auto-deploys** — cockpit reloads fresh data

### JSON Schema (northy-cockpit.json)

```json
{
  "meta": {
    "last_updated": "ISO timestamp",
    "scan_type": "Nightly Deep Scan | Business Hours Scan | On-Demand",
    "northy_message": "Northy's closing message for the cycle"
  },
  "act_now": [{ "id", "title", "category", "detail", "action", "status" }],
  "think_about": [{ "id", "title", "category", "urgency" }],
  "health": { "frame": {"status","note"}, "floor": {"status","note"}, "focus": {"status","note"}, "why": {"status","note"} },
  "cliff": [{ "metric", "value", "target", "gap", "status": "urgent|watch" }],
  "commitments": {
    "steve_owes": [{ "what", "to", "date", "status": "urgent|open|watch" }],
    "team_owes": [{ "who", "what", "date", "status" }]
  },
  "quick_access": [{ "label", "url" }],
  "intel": [{ "id", "source", "title", "pattern", "applies_to", "priority" }],
  "resolved": [{ "id", "outcome", "when" }]
}
```

## Design System

### Typography
- DM Sans — body, labels, data
- DM Serif Display — headlines, key numbers
- DM Mono — IDs, categories, status badges, timestamps

### Color Palette (Bookmarked system)
- `--ink: #101828` — primary text
- `--paper: #f9f7f2` — page background
- `--gold: #12A38C` — accents, active states, Northy brand
- `--danger: #c0392b` — urgent items, Act Now dots
- `--success: #107569` — green status, approved items
- `--caution: #d97706` — yellow status, drifting items

### ADHD-Friendly Rules
- One decision per card. No choice overload.
- Expandable bodies. Steve chooses what to read deeper.
- Left column = action required. Right column = context.
- Short titles. Fragments OK. No walls of text.
- High contrast text on white/paper backgrounds.
- Status dots (color-coded) > status text.
- Tap targets minimum 44px on mobile.

## Cockpit Tab Structure (8 tabs, locked June 22)

| # | Tab | What's In It | Data Sources |
|---|---|---|---|
| 🧭 | **Home** | Northy triage (Act Now + Think About This), September Cliff, Strategic Health, commitments, Quick Access, Resolved | northy-cockpit.json, Northy cron scans |
| 💰 | **Finance** | Cash, runway, burn, V1 savings, deferred comp, repayment schedule. Links to full financial dashboard. | index.html (financial dashboard), Charlie prep docs |
| 📊 | **Sales** | Active pipeline $, deals closing, stalled deals, IMTA districts. Links to Confluence Sales Hub + HubSpot. | Jan's reports, pipeline.html, HubSpot, Confluence SH |
| 🤝 | **CS** | Migration status (R/Y/G), wave progress, PD sessions, V2 spot checks. Links to Confluence CS Hub + Migration Matrix. | Patrick's reports, Confluence CS/SD spaces |
| 🏗️ | **Product** | Epics shipped, blockers, sprint status. Links to product dashboard + Product Hub + Reporting. | Sarah's reports, product.html, Jira, Confluence PROD |
| 🎯 | **Strategy** | D-001–D-011, O-001–O-005, three-play framework, competitive frame, WHY alignment. | G-Brain bookmarked-strategy source, Northy drift detection |
| 🔵 | **Intel** | Weekly patterns from founder watch list (Garry Tan, Anthropic, Shopify, Wade Foster). | Northy intelligence feed, northy-cockpit.json |
| 🤖 | **Tokens** | AI spend by model. Anthropic + OpenRouter. Daily/monthly trends. | OpenRouter API (GET /api/v1/key), Anthropic Console billing |
- Northy icon + title
- Scan type + timestamp
- Must clearly show how fresh the data is

### Northy Bar
- One-line daily message from Northy
- "What am I missing?" button (triggers live scan)
- This is the emotional anchor of the page

### Left Column (Primary — what needs Steve's attention)
- **🔴 Needs Your Decision** — expandable triage cards with approve/kill buttons. Max 3 items.
- **🟡 Think About This** — lower-priority items. Tight summary only.

### Right Column (Context — numbers and quick access)
- **⏳ September Cliff** — cash, pipeline gap, days remaining
- **⚪ Strategic Health** — Frame/Floor/Focus/WHY with status dots
- **📋 What You Owe** — Steve's commitments, urgent-first
- **👥 What Team Owes You** — key team commitments
- **🔵 Founder Intelligence** — (expandable section) new patterns from watch list
- **🔗 Quick Access** — dynamic links to relevant dashboards

## URL Pattern

The cockpit uses a random 6+ character alphanumeric slug in the filename for privacy: `cockpit-{random}.html`. No login required. Not easily guessable. Best-effort privacy.

## Feedback Loop

### Phase 1 (current — built June 22, 2026)
Steve resolves items on the cockpit page:
1. **Tap Done/Not Now** on an Act Now card → item disappears from the view and appears in the ✅ Resolved panel
2. **localStorage persistence** → resolved items survive page reloads on that device
3. **"Send to Northy" button** appears in the Resolved panel header
4. **Tapping the button copies a command** to clipboard: "Northy, I resolved these items:\n- N-001: done\n- N-002: killed"
5. **Steve pastes into Hermes chat** → Northy (in chat) processes the resolutions → updates G-Brain triage page and knowledge base → writes `northy-resolved.json` to the repo
6. **Northy's next cron scan** reads `northy-resolved.json`, marks items as resolved in the triage board, clears the file

### Phase 2 (future)
Approve/kill calls a serverless function (Vercel) that writes directly to G-Brain or the repo. Removes the manual clipboard step. Requires a private backend endpoint.

## Deployment

- GitHub Pages via BookmarkED-Corp/roi-calculator repo
- `board/cockpit-{random}.html` + `board/northy-cockpit.json`
- Auto-deploys on every push to main

## Northy Integration

### Nightly deep scan must:
1. Run all five jobs
2. Write `ops/northy-triage` to G-Brain (markdown)
3. Write `board/northy-cockpit.json` to the repo (JSON)
4. Read `board/northy-resolved.json` if exists for resolved items
5. Commit and push: `git add board/northy-cockpit.json board/northy-resolved.json && git commit -m "Northy scan $(date +%Y-%m-%dT%H:%M)" && git push`
6. Delete resolved items from resolved.json after processing

### Business hours scan must:
1. Check for urgent items only
2. If urgent: update the JSON + triage page + commit
3. If nothing urgent: do nothing

## Current State (June 22, 2026)

- Cockpit HTML: built and deployed with four tabs (Home, Strategy, Intel, Tokens)
- JSON pipeline: schema defined; Northy cron jobs write + push JSON after each scan
- Feedback loop: localStorage + clipboard export (Phase 1)
- Strategy tab: D-001–D-011, O-001–O-005, three-play framework, competitive frame, WHY alignment
- Intel tab: patterns from watch list (Garry Tan, Anthropic, Shopify)
- Tokens tab: structure built, API endpoints identified (OpenRouter GET /api/v1/key), awaiting cron
- Domain reporting (Sales, CS, Product, Finance): URLs needed from Jan, Patrick, Sarah
- Full feature plan: `ops/founder-cockpit-feature-plan` in G-Brain
- Mobile: functional but unpolished

## Pitfalls

1. **Outdated JSON.** If Northy doesn't push after a scan, Steve is looking at stale data. Timestamp visibility is critical.
2. **JSON schema drift.** If the HTML expects fields the cron job doesn't write, the page breaks silently. Schema is the contract.
3. **Git conflicts on the JSON.** If two scans overlap, the second push fails. Mitigation: pull before push, or use unique timestamps.
4. **Over-engineered Phase 1.** Don't add real-time WebSocket, database backends, or auth before Steve has used the basic version for a week.
5. **Mobile neglect.** Steve will open this on his phone. Test every change on both desktop and mobile.
6. **Link rot.** Quick access links that go to external dashboards will break when those dashboards move. Audit monthly.
