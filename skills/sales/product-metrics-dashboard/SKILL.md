---
name: product-metrics-dashboard
description: "Bookmarked weekly product reporting: epic dashboard, customer feedback loops, product measurement framework, and Sarah coaching. Load when Steve asks about product metrics, what shipped, Sarah's reporting, or the product dashboard."
version: 1.0.0
author: agent
tags: [product, metrics, dashboard, epics, sarah, reporting]
triggers:
  - product metrics
  - product dashboard
  - what shipped in product
  - Sarah's reporting
  - epic status
  - customer feedback loop
  - product updates for Charlie
---

# Product Metrics Dashboard — Bookmarked

Weekly product reporting system for Steve, Charlie/board, and the team. Centered on the Epic View as the primary unit of measurement.

## Dashboard Location

- **Business dashboard (Charlie/team):** `/Users/stevewandler/github-repos/roi-calculator/board/product.html`
- **Detailed dashboard (Sarah/Johnny/Scout):** TBD — separate page with individual ticket numbers, BOOK-XXXX references, Jira hygiene notes
- **Repo:** `BookmarkED-Corp/roi-calculator` under `board/`
- **Live URL:** `https://bookmarked-corp.github.io/roi-calculator/board/product.html` (pushed June 15, 2026)

**TWO DASHBOARDS, TWO AUDIENCES:**
- Business dashboard: Charlie, board, team. No ticket numbers. No Jira jargon. Plain English epic names with 1-sentence descriptions. Scannable in 2 minutes.
- Detailed dashboard: Sarah, Johnny, Scout. Individual BOOK-XXXX numbers, Jira hygiene callouts, story-level detail grouped by product area.

## Branding — MUST USE BOOKMARKED BRAND

The dashboard uses Bookmarked's canonical brand design system (NOT the old financial dashboard dark theme from Michelle):
- **Font:** Urbanist (Google Fonts) — weights 400/500/600/700
- **Background:** White #FFFFFF (BRAND-001 — light backgrounds are default, no dark Eigengrau backgrounds)
- **Primary accent:** Teal #12A38C
- **Secondary:** Deep Green #107569 (CTAs, stat numbers)
- **Alerts/urgency:** Pumpkin #FF692E (never decorative)
- **Text:** Eigengrau #101828 (text only, never a background)
- **Secondary text:** #475467
- **Muted:** #9CA3AF
- **Borders:** #F0F0F0
- **Logo:** GREEN Bookmarked logo PNG in top-left corner. The file `bookmarked-logo.png` in the roi-calculator repo is the WHITE logo (invisible on white backgrounds). Use `bookmarked-logo-green.png` (the teal horizontal logo with book icon). Source: `/Users/stevewandler/github-repos/bookmarked-os/claude-output/design/bookmarked-logo-horizontal-green.png`
- See `marketing-brand-design-system` in G-Brain for full canonical spec

**Logo pitfall:** The roi-calculator repo's root `bookmarked-logo.png` is a white-on-transparent logo meant for dark backgrounds. For any dashboard on a white/light background, always use the green variant. A copy lives at `board/bookmarked-logo-green.png`.

## Agent Role Split — Product Development Workflow

Established June 17, 2026. This is the canonical role assignment for product development:

| Agent/Human | Role | Owns |
|-------------|------|------|
| **Johnny (CPO)** | Prioritization & product judgment | Decides WHAT gets built and in what order. Reviews epics for quality. Does NOT write epics himself. |
| **Scout** | Epic & ticket creation | Builds epics and tickets to spec. Expert in epic format, ticket structure, and Jira mechanics. Pulls from Priya's feedback hub. |
| **Sarah** | Human in the loop | Confirms, adds context, catches gaps. Works with Scout on epic creation. Does NOT make product strategy calls. |
| **Priya** | Feedback intake & classification | Structures and routes product feedback. Does NOT decide roadmap priority. |

- **Flow:** Priya classifies feedback → Johnny decides "build this, not that, here's why" → Steve approves → Scout builds the epic and tickets to Johnny's spec → Sarah confirms/adds context → engineering receives clean tickets
- **Feedback-to-Epic Gate (June 18, 2026):** No feedback becomes an epic without Steve's approval. Training period. Johnny recommends with evidence bar (Is the problem real? Not one person's opinion? Consequence of inaction?). Steve approves/redirects/defers Friday 3pm. Temporary — delegates to Johnny after 3-4 clean cycles.
- **Weekly rhythm:** Mon-Thu Priya intake + Sarah quality review → Thursday Priya synthesis + Johnny/Sarah prepare recommendation → Friday 3pm Sarah presents to Steve → following week Scout builds approved epics.
- **Urgent escalation:** Johnny → Steve in #product (C0AE4HG85TK) for genuine fires (churn risk, production trust, renewal blockers). High bar, rare use.

**Key principle:** Johnny must be the one saying "build an epic for this, don't build one for that, and here's why." Without that gate, Scout turns every piece of feedback into an epic, or Sarah makes product strategy calls she's not equipped to make.

## Layer 1 Product Metrics — Measure Now (June 2026)

Five metrics. All pullable from Jira if fields are filled in correctly. Start measuring forward from now — don't chase retroactive data on undated epics.

| Metric | What It Answers | How We Get It |
|--------|----------------|---------------|
| **Epic Cycle Time** | How fast do we ship features? | Days from epic start date → epic resolved date |
| **Planning Accuracy** | Are we hitting our dates? | Original due date vs. actual ship date (Jira changelog tracks every due date move) |
| **Feedback → Epic Conversion** | Are we listening to customers? | Priya feedback items that become epics within 14 days / total feedback items |
| **Throughput** | Is velocity increasing? | Tickets completed per week, trended over time |
| **Epic Health** | Are we shipping complete or leaving things half-done? | % of epics at Shipped Complete vs. Shipped Partial vs. stalled |

**Why these five:**
- *Cycle time* = "are we gaining product velocity?"
- *Planning accuracy* = "are our estimates improving?" When a date moves, ask WHY — that's where daily/weekly improvement comes from.
- *Feedback conversion* = closes the Priya loop. If feedback sits 30 days without becoming an epic, the system is broken.
- *Throughput* = raw engine speed, trended weekly.
- *Epic health* = catches partial shipping problem (features going to prod before full epic is done).

**Layer 2 (future, once product analytics exist):** Customer retention impact, feature adoption, NPS, usage metrics.

**Jira fields that make this work** (most already exist in BOOK next-gen project):
- Epic Start Date (`customfield_10015`) — when work begins
- Epic Due Date (`duedate`) — target ship date
- Resolution Date — auto-stamps when epic transitions to Done
- Jira changelog — already tracks every field change including due date moves. No setup needed, just query it.

**One canonical dashboard, one source of truth.** Build it right once, then slice for audience (board gets summary cards, team gets detail). No separate tracking systems.

## The Epic View — Core Dashboard Element

The primary table Steve wants. One row per active epic:

| Epic | What It Is | Tickets Completed | Tickets Remaining | Target Ship Date | Status |
|------|-----------|-------------------|-------------------|-----------------|--------|

**TERMINOLOGY (Steve's preference — use these terms, not Jira jargon):**
- "Ticket" = generic term for any item in Jira (story, bug, task). Use "ticket" in all reporting and conversation with Steve.
- "Epic" = a group of related tickets that together deliver a complete capability. The epic IS the feature.
- "Story" = a ticket that describes a user outcome. Same as a ticket, just a type. Don't use "story" in dashboards — use "ticket."
- A story does NOT become an epic. They're different levels. An epic contains tickets.

**Status values:**
- Not Started (gray): defined but no work begun
- In Development (blue): actively being built
- Shipped Partial (orange): some tickets in the epic went to production but the full epic isn't finished
- Shipped Complete (green): entire epic is in production and working

**Target Ship Date tracking:**
- Every active epic MUST have a target ship date — when the full epic is expected to be in production
- Dashboard shows original target vs. current target to track planning accuracy
- If a date moves, it's visible — no quiet pushes
- Over time this shows how accurate planning is and where to improve

**Key rule Steve cares about:** if something ships to production before the full epic is complete, that's visible as "Shipped Partial." This catches the gap Sarah had where features went to prod with incomplete epics.

## Epic Structure Standard

What Sarah/Johnny/Scout must enforce:

1. Every active product initiative lives under an epic with a clear name a non-engineer can understand (e.g., "Staff Invite" not "BOOK-162 refactor")
2. Epic description follows the 6-field template (see below)
3. Every epic has tickets as children linked via the parent field. No orphan tickets floating with labels only
4. Every active epic must have a target ship date
5. When all tickets in an epic are Done, the epic gets marked Done immediately
6. "Shipped Partial" flags when tickets go to production before the full epic is complete

### Epic Description Template (v2 — merged Steve + Johnny CPO input, June 17 2026)

See `references/epic-template.md` for the full template with worked example.

The v2 template has 6 description sections (up from 3 in Steve's original):
1. **WHY THIS EXISTS** — plain English problem statement
2. **EVIDENCE / WHY NOW** — signal source (Johnny addition: prevents speculative epics)
3. **WHO THIS HELPS** — user personas
4. **WHAT THIS IS NOT** — explicit non-goals (Johnny's #1 anti-scope-creep tool)
5. **HOW WE KNOW IT WORKED** — observable outcomes
6. **DEPENDENCIES** — what must happen first (Johnny: #1 reason epics stall)

Plus Jira fields: Title, Start Date, Due Date, Dependencies, Feedback Source (FB-ID), Status, Tickets count, Product Area.
Plus "[DATE SHIFT]" comment convention when due dates move (required for Planning Accuracy metric).

**Feedback Source field:** Every epic must have a Feedback Source. If it came from product feedback, cite the FB-ID from Priya's Confluence hub (e.g., FB-047). If strategic/internal, state the origin (e.g., "Steve direction," "Board priority"). This is the connective tissue between the feedback loop and the product pipeline — without it, Feedback → Epic Conversion can't be measured automatically.

**Reference example in Jira:** BOOK-1491 — labeled `[EXAMPLE]` with tags `epic-example` and `reporting-template`. Created June 16, 2026 as a teaching artifact for Sarah, modeled on the real BOOK-1031 (Order Intelligence v2.1) which had 15/15 tickets done but was still marked "To Do" with a technical description no stakeholder could parse.

**Before/after coaching pattern:** When explaining this to Sarah, show the same feature described two ways: BOOK-1031 (technical: "React/Vite/Zustand app, flag-buddy-book codebase audit") vs. BOOK-1491 (plain English: "Districts need to order books through a simple drag-and-drop workflow that automatically flags compliance concerns"). Same 15 tickets. Zero engineering changes. Only the epic-level description changes.

**Key coaching message for Sarah:** "Your job isn't to write weekly reports. Your job is to keep Jira's epic layer clean — plain English names, 6-field descriptions, tickets linked, statuses current. If Jira is clean, the report writes itself. Agents and dashboards pull directly from it."

See `references/epic-template.md` for the full copyable template with examples.

## Pulling Epic Data from Jira

The BOOK project is **next-gen (team-managed)**. Critical implications:
- `jira_get_epic_issues()` FAILS with 400 error on next-gen projects
- Use JQL with `parent` field instead: `project = BOOK AND parent in (BOOK-1416)`
- Most active work currently uses LABELS not epic parents — the goal is to fix this
- See `atlassian-mcp` skill for full Jira pitfalls

**Query pattern for dashboard automation:**
```
# Tickets linked to a specific epic
project = BOOK AND parent = BOOK-1416 ORDER BY status ASC

# All tickets under multiple epics (batch audit)
project = BOOK AND parent in (BOOK-1416, BOOK-1252, BOOK-1031) ORDER BY parent ASC, status ASC

# Recently completed work (any parent)
project = BOOK AND status changed TO Done AFTER -7d ORDER BY updated DESC

# Open bugs
project = BOOK AND issuetype = Bug AND status != Done ORDER BY priority DESC
```

## Dewey Discovery Pattern — Before Changing Agent Behavior

When Steve wants to update how agents handle product/epic/ticket work, DO NOT cascade changes immediately.

**Full pattern:** See `references/agent-update-cascade-pattern.md` for the complete 7-step cascade workflow with ownership tables and pitfalls.

**Quick version:**
1. Send Dewey a **read-only capabilities report request** in #ai-ceo-team (`C0AR85TMVS8`) — what can Johnny/Scout/Priya do today? Skills, access, guardrails, model, prohibitions.
2. Dewey reports back. **No cascading, no delegation, no changes.**
3. Steve and personal Hermes analyze gaps between current capabilities and desired state.
4. **Route questions to agents through Dewey** — don't go directly to Johnny/Scout. Frame as "relay these questions to Johnny and bring his answers back." This maintains chain of command and ensures Dewey has full context for the cascade phase. Johnny gives better answers when Dewey frames it as consequential.
5. Steve and personal Hermes reconcile agent feedback into final standards.
6. Package all updates in one numbered message to Dewey with brake pedal.
7. Steve says go, Dewey cascades.

**The message must include explicit brakes:** "Do not change anything. Do not cascade this to Ford or any other agent. This is discovery only."

**Why this matters:** Dewey will correctly interpret an operational packet as "start coordinating implementation" — that's what CEO-agent should do. So if you don't tell him to stand down, he'll activate Ford and the cascade starts before you've analyzed the gaps.

**Key channel:** #ai-ceo-team = `C0AR85TMVS8` (private, C-level agents only). Not visible in public channel list. Steve's personal Hermes has access.

## Communicating to Bookmarked Agents via Slack — Dewey Cascade Pattern

**For consequential product changes (templates, metrics, role updates):**
1. Send discovery request to Dewey in #ai-ceo-team. Include "Do not change anything."
2. Analyze Dewey's report with Steve.
3. Ask Dewey to relay questions to Johnny for CPO input. Don't message Johnny directly — Dewey needs full context for the cascade.
4. Reconcile Johnny's feedback with Steve.
5. Send full update package to Dewey with approval gate.
6. Dewey reviews, asks questions, then Steve gives "Go."
7. Dewey cascades: updates skills → dispatches to Johnny → Johnny cascades to Scout + @mentions Sarah → Sarah tests.

**Key rule:** Woz owns all infrastructure changes (model upgrades, access provisioning). Not Raju for agent config. Dewey flags Woz, doesn't do it himself.

When sending messages to Johnny, Scout, Sarah about product standards:
- Write in FIRST PERSON as Steve ("I want" not "Steve wants")
- @mention Steve Wandler so replies tag him back into the thread
- Send to Scout's home channel #ticket-creation (C0B2BPF46Q0) and @mention others
- Be explicit: "do not take action until I give the green light" — agents WILL execute if not told to stand down
- Reinforce what's working (ticket quality) before addressing what needs to change
- Give context on WHY — so everyone in the business can see what's being built without asking someone

## Business Dashboard Sections (in order)

For Charlie, board, and team. Clean. No ticket numbers.

1. **Data Source Bar** — immediately below header. States "Data pulled directly from Jira (BOOK project) — if anything looks wrong, the fix is in Jira." Forces ownership of data accuracy. Include a "Live Data" indicator.
2. **Summary Cards** — Active epics count, tickets completed (trailing 21 days), open bugs, districts migrated
3. **This Week's Highlights** — 3-4 cards with plain language wins: features shipped, intelligence improvements, migrations, security. No technical jargon — "False positive ban flags fixed" not "LLM signal + genre prior added"
4. **Delivery by Product Area Charts** — horizontal bar chart showing tickets completed by area + donut chart showing epic completion status. Visual, scannable, tells the story without reading tables.
5. **Active Epics Detail Cards** — NOT a flat table. Each epic gets its own card with: name, 1-2 sentence description of what it is and why it matters, tickets completed, tickets remaining, target ship date, progress bar, and status badge. ALL FIELDS must have values or visible placeholders (e.g., "TBD — needs scoping" in pumpkin). The dashboard should look like the ideal state even before data is perfect — show what it WILL look like so everyone sees the standard.
6. **Open Bugs** — critical/high only. Plain descriptions of customer impact, not code-level details. Security issues get red callout.
7. **Customer Feedback — SEPARATE DASHBOARD.** Customer feedback is NOT on the main product dashboard. It will be its own page/dashboard once the Priya template is finalized.

**What is NOT on the business dashboard:** Individual BOOK-XXXX ticket numbers, Jira priority labels (High/Medium), the full list of completed tickets, Jira hygiene callouts, technical implementation details. All of that goes on the detailed product team dashboard.

## Customer Feedback Loop

**Current state (June 2026):** Priya (agent) manages intake in #product-feedback. Template confirmed and updated June 15, 2026. Priya had a solid 5-field template based on YC "Closed Loop" methodology. Steve adopted it with 3 additions. **Two extraction runs completed:**
- **Run 1 (June 15):** 14 items across 10 districts posted to #product-feedback via G-Brain search + Slack.
- **Run 2 (June 16):** 10 additional items across 7 districts (Belton x2, Argyle x2, Canyon, Bosqueville, Killeen x3, San Marcos, Conroe, plus a multi-district Orders item). Deeper transcript mining with more specific queries yielded higher-quality items with exact quotes and multi-source evidence chains.

Steve can now proceed to step 3 (message team with examples).

**Finalized template (8 fields):**
1. District/Customer — who is affected (district name + contact)
2. Date Reported — when did we hear this
3. Product Area — Book Intelligence / Orders / Staff Management / Parent Portal / Library Management / SFTP & Rostering / Reporting / Onboarding / Other
4. Core User Problem — the friction, NOT the solution they're asking for
5. Requested Feature/Gap — what they want or what's missing
6. Business Impact — churn risk, onboarding blocker, workflow friction, compliance gap
7. Frequency — First report / Heard from multiple districts / Recurring theme
8. Evidence/Source — transcript link, Slack thread, email, meeting name

**What was added to Priya's original:** Date Reported (track how long requests sit), Product Area (group and see patterns), Frequency (distinguish one-off from systemic pattern). **What was dropped:** Priya suggested Expected ROI and Technical Risk — Steve dropped both because those are product team decisions, not something Jan or Patrick should estimate when logging feedback.

**Team workflow (deployed June 15, 2026):**
1. Jan, Teela, Patrick, Sarah take customer call transcripts → paste into Claude with the extraction prompt → Claude outputs formatted feedback items → paste into #product-feedback
2. Priya classifies, detects patterns, recommends urgency
3. Weekly: top 5 customer requests aggregated on a SEPARATE customer feedback dashboard (not the product epic dashboard)
4. Closed-loop: source hears what happened (built it, deferred it, declined it)

**The extraction prompt** is saved at `roi-calculator/board/customer-feedback-prompt.md` and was posted to #water-cooler (C05CG6Z14DP) on June 15. See `references/customer-feedback-template.md` in this skill for the full prompt, template, G-Brain search strategy, known feedback sources, and product area pattern analysis.

**Hermes-driven G-Brain extraction (proven June 15):**
The most productive approach is NOT asking the team to paste transcripts into Claude. It's having Hermes search G-Brain directly for all customer-facing transcripts, meetings, and email threads, then post formatted items to Slack. This yields more comprehensive coverage because:
- G-Brain has transcripts the team may not think to search (internal syncs where district feedback came up, forwarded emails, synthesis pages)
- The agent can cross-reference across districts to identify frequency patterns
- One extraction run covers 3 months of transcripts in ~15 minutes vs. asking each team member to search their own calls

**IMPORTANT: Keep feedback extraction and product strategy SEPARATE (Steve correction, June 16):**
The feedback extraction for Priya and the Content Scanner / Layer 3 prototype work for Raju are TWO SEPARATE WORKSTREAMS. Do not conflate them in one thread. When Steve asks to "pull transcripts and send feedback to Priya," that is purely about loading #product-feedback with structured customer evidence — nothing else. The fact that a cluster of BI trust feedback also validates the Content Scanner need is true but is a SEPARATE conversation. Don't pivot a feedback extraction thread into a PRD thread. Stay on task.

When BI trust patterns emerge (re-flagging, ISBN matching, false positives, source quality), note the pattern in the feedback items themselves (via the Frequency field) but keep posting to Priya. Route Content Scanner strategy to `bookmarked-strategy` in a separate session.

**Extraction run checklist:**
1. Read last 50 messages in #product-feedback to build a duplicate-avoidance list
2. Search G-Brain with named districts first (highest-signal accounts), then broaden
3. Use `since` parameter to stay in time window
4. Search compiled_truth pages, meeting transcripts, synthesis/reflections, and emails
5. Send each item as its own Slack message (not batched)
6. Report summary: items sent, districts, product area frequency breakdown

**Slack messages sent June 15:**
- Updated template → #product-feedback (C0AMSNW8YSZ) @mentioning Priya, Sarah, Steve
- Team extraction prompt → HELD. Steve deleted the premature team message. Rule: Steve leads by example first — extract real feedback from his own transcripts, send it to Priya as the gold standard, THEN message the team showing what it looks like and asking them to do the same. Never send a process change to the team before demonstrating it yourself.

**Transcript extraction prompt for Steve's Hermes (separate thread):**
- Include an expertise/role preamble: "You are a product operations analyst with expertise in SaaS customer feedback extraction, product management workflows, and EdTech user experience patterns"
- Specify tool access: G-Brain (search, query) and Slack (send_message)
- Include Bookmarked product context so the agent knows the domain
- Add rule: check for duplicates before posting, and give a summary count when done
- List named districts with known feedback as starting seeds (currently: San Marcos, Killeen, Bosqueville, Canyon, Ferris, Alba-Golden, Olney, Belton, Conroe, Argyle, ESC Region 9)
- Specify "work from most recent backward" — recency matters for product prioritization
- Specify "send each item individually" — not batched into one giant message
- Include product area categories in the prompt so the agent classifies consistently

**Priya's channel:** #product-feedback (C0AMSNW8YSZ)
**Priya cannot:** decide roadmap priority, create feature tickets, promise timelines, or bypass Johnny/Sarah

**June 17, 2026 — Priya Rebuilt:**
Priya's role was narrowed to pure product feedback intake and classification. She no longer creates Jira tickets (Scout handles that). She no longer proposes tickets. She classifies feedback into the Confluence Product Feedback Hub (page 88047617 in PROD space) using a 7-step Q&A intake process. Weekly synthesis moved from Sundays to Thursdays 2 PM CT. Model upgraded to claude-sonnet-4. Atlas dotted line removed — reports to Johnny only. Full spec: load skill `priya-product-feedback-hub`. The old 8-field template below is superseded by Priya's new schema (see the skill for current fields).

## Priya Agent Refinement — Active Work (June 2026)

Steve is refining Priya as the model for how all Bookmarked Hermes agents should be governed. The core thesis: Priya should be the product feedback expert — understanding OnShelf entirely, taking feedback, classifying it, and making it queryable in Confluence so humans and agents can make informed decisions on what to build, change, refine, stop, or focus on.

**Current Priya config (from Dewey audit, June 17 2026):**
- Model: `deepseek/deepseek-v4-flash` (OpenRouter)
- Reports to: Johnny (CPO), dotted line Atlas (CCSO)
- Skills: `process-customer-transcript`, `triage-product-feedback`, `escalate-cs-to-product`, `weekly-voc-reporting`, `weekly-product-report`, `atlassian`, `bookmarked-role-boundary-request-triage`
- Cron: two Sunday jobs — VoC sync (18:00 UTC) chained to synthesis (23:00 UTC), delivering to thread in #product-feedback
- Guardrails: `role-guard.py` pre-tool-call hook, `role-reminder.py` pre-LLM hook, SOUL-level prohibitions, skill-level Jira board rules
- Has Jira read-write on V2KAN (Board 67), read-only on BOOK (Board 1), ignores BMKEDV1 (Board 34)

**Identified gaps to close (from Steve + Hermes analysis, June 17):**
1. **Channel mismatch:** SOUL says `#customer-feedback` but team posts to `#product-feedback` (C0AMSNW8YSZ). Getting `not_in_channel` errors. Must fix to monitor #product-feedback.
2. **Jira ticket creation guardrail:** Sarah requested no support ticket creation. Priya's `escalate-cs-to-product` skill currently files V2KAN tickets. Decision needed: propose-only (Confluence/Slack) or create V2KAN but never support tickets?
3. **No Confluence feedback hub:** Output goes to Slack threads and Jira epic proposals only. Need structured Confluence pages with categorized feedback buckets that anyone (human or agent) can query.
4. **No internal team feedback path:** Intake is customer transcripts and HubSpot. No mechanism for Patrick, Jan, Teela, Sarah to drop their own product observations. Steve wants ONE channel (#product-feedback) for both, with Priya classifying source type.
5. **Model capability:** DeepSeek V4 Flash may lack reasoning depth for pattern detection and classification at the level Steve wants. Consider upgrade for synthesis work.
6. **Weekly-only cadence:** Sundays only. May need daily classification with weekly synthesis for faster loop closure.

**Feedback source taxonomy (Steve's direction, June 17):**
Three source types, not two:
1. **Customer** — district name, role (librarian, teacher, superintendent, curriculum director), deal size
2. **Team member** — who on Bookmarked team, in what context (support call, demo, onboarding, renewal conversation, product usage observation). Patrick reporting something from a customer call ≠ Patrick reporting something he noticed during a migration. Same person, different weight.
3. **Agent** — when Scout, Pixel, Ellie, etc. surface something through their own work (QA finding, data quality issue, pattern detection)

**Five decision buckets for feedback classification:**
1. What should we build next
2. What should we change
3. What should we refine
4. What should we stop doing
5. What should we focus on — and why

**Additional classification dimensions Steve wants:**
- Product area (book intelligence, circulation, orders, onboarding, UI, etc.)
- Frequency / pattern detection (one-off vs systemic)
- Revenue weight (district deal size)
- Severity

**Process for refining Priya (established June 17):**
1. Steve and personal Hermes define what Priya should be (spec)
2. Ask Dewey what Priya currently is (gap analysis) — DONE
3. Compare the two, find delta — IN PROGRESS
4. Give Dewey the updated mandate → cascades through Ford → Johnny → Priya

**Key principle:** Priya is the model agent for governance. Whatever guardrails, feedback taxonomy, Confluence structure, and closed-loop process we build for her becomes the template for all Bookmarked agents.

## Feedback → Epic Pipeline (established June 18, 2026)

No feedback becomes an epic without Steve's approval. This is the training period while the system proves it works. Johnny and Sarah recommend. Steve decides. Once 3-4 clean cycles complete, Steve delegates tactical approvals to Johnny within existing priorities.

### The Pipeline

```
INTAKE (Mon-Thu ongoing)
  Feedback → Priya asks clarifying questions about the PROBLEM (not the solution)
  Priya classifies with tier: Customer Feedback / Team Observation / Strategic Signal
  Sarah reviews using 5-question checklist (see priya-product-feedback-hub skill)
  Sarah confirms → Priya writes to Confluence with FB-ID

DELIBERATION (Thursday)
  Johnny reviews the week's classified feedback in Confluence
  Johnny and Sarah discuss: which patterns are strong enough to recommend?
  Johnny prepares recommendation with evidence

DECISION (Friday 3pm, 15 min standing meeting)
  Sarah presents Johnny's recommendation to Steve
  Steve reviews evidence, asks questions, approves / redirects / defers
  Approved items get tagged "Steve-approved"

EXECUTION (following week)
  Scout builds approved epics on V2KAN with the merged template
  Scout links FB-IDs, sets dates, fills Dependencies
  Sarah confirms epic is complete and accurate

URGENT ESCALATION (anytime, high bar)
  Active customer impact, churn risk, or production trust issue only
  Johnny DMs Steve with evidence
  Steve approves or defers in real time
  Scout builds immediately
```

### Key Guardrails

- **Johnny can recommend epics but cannot approve them.** His governance skill says ≥3 independent customer sources to promote to roadmap. He must cite evidence threshold. Single signals stay in discovery.
- **Johnny does NOT create Jira labels, roadmap pillars, or Scout instructions from unvalidated signals.** He recommends. He doesn't execute until Steve approves.
- **Scout does not build any epic without Steve-approved status.** If Johnny tells Scout to draft an epic, Scout's first question: "Has Steve approved this?" If no, Scout holds and flags.
- **Sarah does not direct agents to "incorporate into strategy" or "commit to memory."** She recommends with Johnny. She does not accelerate past the intake process.
- **All agents must @mention people by Slack handle** when asking follow-up questions. Typing a name without @mention means the person never sees it.

### Sarah's Role (coaching context — June 2026)

Sarah's pattern: feedback comes in → she jumps to action. She accelerates instead of validates. The fix is clear role definition:

**Sarah's job:** Ensure feedback quality (5-question checklist), work with Johnny on weekly recommendations, present to Steve Friday, confirm epic accuracy after Scout builds.

**NOT Sarah's job:** Directing agents to incorporate feedback into strategy, telling Johnny to commit items as strategic pillars, bypassing Priya's intake process, making product prioritization calls.

**Coaching approach:** Don't lead with what she did wrong. Lead with what the system needs from her. "Your value is in making sure the feedback that comes in is complete, well-understood, and properly classified. Then working with Johnny on which patterns are strong enough to recommend as epics."

### Positioning for Johnny

Frame as "the system is new" not "you lost authority." Johnny just contributed good CPO input to the epic template and measurement framework. The approval gate is temporary — Steve needs to validate the full cycle works before delegating. Johnny's recommendation authority is the core of the system.

## Sarah Coaching Context

Steve is frustrated with Sarah's reporting quality. Three months of asking for "layman's terms" weekly reports has produced one Confluence page from April. The pattern: Sarah builds infrastructure (process docs, operating models, cron jobs) instead of shipping outcomes.

## June 16, 2026 — Epic Structure Coaching Session

Steve had a 1:1 with Sarah at ~2:30pm to walk through the new epic standard. Key framing Steve used:
- "I don't need you to write me a weekly report. I need you to keep Jira's epic layer clean so the report writes itself."
- Epics are the BUSINESS layer (for Charlie, board, team). Tickets are the ENGINEERING layer (for Raju's team). Sarah owns the epic layer.
- Showed her the before/after: BOOK-1031 (technical description, "To Do" despite 15/15 done) vs BOOK-1491 (plain English, structured, dated)
- Used dates as Jira fields not description text: Due Date = target ship, Start Date = work began, Resolved = auto-stamps on Done
- Not asking her to rewrite every old epic — just clean up active ones and use the new format going forward
- Transcript from this call should be in G-Brain once synced — search for "meeting-2026-06-16-sarah" to find it

**Immediate deliverables Steve expects from Sarah:**
1. Close the 9 done epics (20 minutes of work)
2. Link orphan tickets to the 3 active epics
3. New epics follow the template going forward

**Coaching pattern to watch for:** Sarah tends to build process/infrastructure rather than executing the ask. Steve's directive is: do the small thing first (close 9 epics), demonstrate competence, then layer on improvements. Don't build a system before proving the basics work.

**What Steve does NOT want:** Sarah writing manual weekly reports. The whole point is that clean Jira data lets agents and dashboards generate reports automatically.

## Feedback-to-Epic Pipeline (established June 17-18, 2026)

**Core rule:** No feedback becomes an epic without Steve's approval. Training period until 3-4 clean cycles prove the system works, then tactical approvals delegate to Johnny.

**Evidence Bar (replaces rigid ≥3 customer rule):**
Every epic recommendation must answer three questions:
1. Is the problem real? (customer complaint, lost deal, churn risk, credible industry data — not "someone thinks this would be cool")
2. How do we know it's not one person's opinion? (3+ customer sources = automatic strong evidence; fewer requires stronger justification)
3. What happens if we don't do it? (churn risk, lost deals, compliance gap, competitive disadvantage — or nice-to-have?)

**Classification tiers (Priya tags every entry):**
- Customer Feedback — real customer reported real problem from actual usage (strongest signal)
- Team Observation — team member noticed something, shared article, strategic connection (valuable but weaker for building product)
- Strategic Signal — industry trend, competitive intel, market context (informational, not actionable alone)

**Weekly Operating Rhythm:**
- Mon-Thu: Feedback in → Priya classifies with Q&A → Sarah reviews quality
- Thursday 2pm CT: Priya synthesis → Johnny reviews with Sarah → prepare recommendation
- Friday 3pm CT: Sarah presents Johnny's recommendation to Steve (15 min standing meeting)
- Following week: Scout builds approved epics

**Sarah's quality gate on Priya intake (5 questions):**
1. Do we understand the actual problem — not the solution being requested?
2. Do we know who specifically feels this pain — districts, roles, workflows?
3. Do we know how many times we've heard this — first time or pattern?
4. Is it customer evidence or team opinion? Is Priya tagging it correctly?
5. Could Johnny make a prioritization decision from this entry alone?

**Sarah's quality gate on Johnny's recommendations (6 questions):**
1. Is the problem real and verified? What's the actual evidence?
2. How do we know it's not one person's opinion?
3. What happens if we don't do it?
4. Does the epic have all four sections (Why, Who, What This Is NOT, How We Know)?
5. Are all Jira fields filled (Start Date, Due Date, Dependencies, Feedback Source)?
6. Does this pull engineering away from something more important?

**Urgent escalation:** Johnny can escalate in #product (C0AE4HG85TK) with evidence for genuine fires (churn risk, production trust, renewal-blocking). High bar, rare use.

**Clean cycle definition (delegation trigger):** One week where every recommendation has evidence, zero premature Confluence writes, zero @mention failures, cadence runs clean, Steve doesn't have to ask "where's the evidence?"

**Critical behavioral pattern to watch (June 18, 2026):** Sarah's instinct is to direct agents to act on feedback immediately rather than letting the intake process complete. In the Teela/TCEA thread, Sarah told Johnny to incorporate feedback into strategy and commit it as a strategic pillar BEFORE Priya finished classifying. Johnny then created a full roadmap pivot without Steve's approval. This is the exact pattern the guardrails are designed to prevent. Sarah recommends, she does not direct. Johnny recommends, he does not execute strategic decisions.

**What Steve wants from Sarah weekly (Thursday by 3pm):**
- Epic view table with accurate data for active epics
- Tickets linked to epics in Jira — no orphans
- Target ship dates on every active epic
- "So what" context: why each shipped item matters to a customer
- Customer feedback top 5

**How to present product concepts to Steve:**
- Use "ticket" not "story" in conversation and dashboards — Steve prefers plain language
- Present ONE piece at a time, get feedback, iterate. When Steve says "there's a lot here" or "I didn't read through it all" — you over-delivered. This happened in this session: Steve asked for the measurement framework and got a 5-section wall of text he couldn't consume. The fix: lead with the ONE thing he said (epic view), get buy-in, THEN layer on the next piece. Don't front-load the whole framework.
- When presenting a Slack draft to Steve for review, show the FULL draft each time he requests changes. Don't describe the change — show him the complete updated message. He iterates by reading the whole thing, not by tracking diffs.
- Explain Jira hierarchy simply: epic = the feature (group of tickets), ticket = one buildable piece, bug = something broken
- A story does NOT become an epic — they're different levels. Don't assume Steve knows this; explain when relevant.
- Don't over-engineer for week one. Binary success: did the report show up Thursday with accurate data? Yes or no.
- When Steve says "does that make sense?" — it's not rhetorical. Confirm you understand by playing it back concisely, or flag what's unclear.
- When communicating to agents on Steve's behalf, write in FIRST PERSON ("I want") and @mention Steve so replies tag him. Never say "Steve wants" or "Steve is working on" — it sounds like you're speaking FOR him instead of AS him. He IS the one sending it. Don't tell agents to give feedback — they will automatically. Just lay out the standard and tell them to discuss/share thoughts.
- When Steve says "don't say Steve is working on it, say I" — this is a hard rule. The message comes from him. Use "I" throughout. @mention him so agents reply in the thread and he can read it.
- When agents need to stand down, be EXPLICIT: "do not reorganize, create, close, or modify any tickets until I give the green light." Bookmarked agents will execute immediately if not told to wait.

**Steve's actual frustration:** He can't tell what product is doing without asking someone. The dashboard and epic structure fix that by making Jira queryable and self-explanatory.

## Product Velocity Measurement Framework (June 17, 2026)

Five metrics agreed between Steve and Johnny. All pullable from Jira if fields are filled correctly. Measurement starts forward-looking — no retroactive data on undated epics.

| Metric | What It Answers | How We Get It | Johnny's Input |
|--------|----------------|---------------|----------------|
| **Epic Cycle Time** | How fast do we ship features? | Days from epic start date → resolved date | Johnny wants Discovery:Delivery Ratio added later (layer 2) |
| **Planning Accuracy** | Are we hitting our dates? | Original due date vs. actual ship date. Scout adds "[DATE SHIFT]" comment when dates move with reason. | Johnny: "Reason for Shift" is critical — without it, you see movement but can't learn from it |
| **Feedback → Epic Conversion** | Are we listening to customers? | Priya feedback items → epics within 14 days / total items | — |
| **Throughput** | Is velocity increasing? | Tickets completed per week, trended over time | — |
| **Epic Health** | Shipping complete or half-done? | % epics at Shipped Complete vs. Shipped Partial vs. stalled | — |

**Layer 2 metrics (deferred — need product analytics):**
- Discovery:Delivery Ratio — time in pre-spec validation vs. time in Jira (Johnny suggestion)
- Complexity-based estimation accuracy — small tickets vs. large epics (Johnny suggestion)
- Value Realization — did the feature solve the problem after shipping (Johnny's biggest blind spot)
- Customer retention impact, feature adoption, NPS

**Jira field requirements for measurement:**
- Epic Start Date (`customfield_10015`) — when work begins
- Epic Due Date (`duedate`) — target ship date
- Resolution Date — auto-stamps on Done transition
- Jira changelog — already tracks every field change. No setup needed, just query it.
- "[DATE SHIFT]" comment convention — Scout adds when due date moves, with reason

**Johnny's Jira hygiene warning:** Current instance has inconsistent labeling (codenames, missing versions). Scout's triage board must enforce strict inputs or report data will be noisy.

## Agent Role Split — Product Pipeline (confirmed June 17, 2026)

| Agent | Role | Jira Access | Key Boundary |
|-------|------|-------------|--------------|
| **Johnny (CPO)** | Decides what gets built and in what order. Reviews epics. Synthesizes feedback patterns. | READ-ONLY on V2KAN + BOOK | Never creates tickets/epics. Never routes directly to engineering. |
| **Scout** | Builds epics and tickets to spec. Owns V2KAN artifacts. Sets dates per Johnny's direction. | CREATE/UPDATE on V2KAN. READ-ONLY on BOOK. | Never writes to BOOK. Never initiates work from Priya feedback without Johnny's decision. |
| **Priya** | Classifies and structures feedback in Confluence. | READ-ONLY on all Jira. | Never creates tickets. Never decides roadmap. |
| **Sarah** | Human in the loop. Confirms, adds context, catches gaps. | Human access to both boards. | Does not write manual reports — clean Jira = automatic reporting. |

**Flow:** Priya classifies → Johnny decides (Build Now / Validate / Defer / Decline) → Scout builds on V2KAN → Engineering pulls to BOOK → Scout watches BOOK (read-only) and marks V2KAN done when BOOK ticket completes.

**V2KAN → BOOK completion sync:** This is not duplication — it's a clean boundary with status sync. Product side sees completion without touching engineering's workspace. Scout has READ-ONLY on BOOK specifically for this watching function.

**Sync mechanism (decided June 17):** Daily scheduled cron job under Scout's profile. Scout polls BOOK once per day for completed tickets, cross-references V2KAN children, syncs completions back to V2KAN. When all tickets under a V2KAN epic are done in BOOK, Scout auto-transitions the V2KAN epic to Done. No human review gate — it's a status mirror, not a judgment call. If something looks wrong, Scout flags to Johnny.

**"Stalled" = report-only.** Not a Jira status or label. Johnny reports stalled epics (no ticket movement in 7+ days) as part of the Epic Health metric in his weekly report. Scout provides the raw data.

## Agent Model Decisions (June 17, 2026)

| Agent | Current Model | Decision |
|-------|--------------|----------|
| **Johnny** | `deepseek/deepseek-v4-flash` | **Upgrade to `anthropic/claude-sonnet-4`** — product judgment, feedback synthesis, and roadmap work require reasoning depth Flash can't consistently deliver |
| **Scout** | `deepseek/deepseek-v4-flash` | **Keep** — her work is rubric-driven (1,444-line skill). Flash is fine for "follow this checklist precisely." Upgrade only if quality issues emerge |
| **Priya** | `anthropic/claude-sonnet-4` | Already upgraded (prior session) |

## Custom Field IDs for V2KAN Epics (June 17, 2026)

Fields created via Jira UI on V2KAN team-managed project (NOT via REST API — see atlassian-mcp pitfall):

- **Feedback Source:** Short text, Required. Created on Epic screen via UI.
- **Dependencies:** Paragraph text, Not Required (Steve removed required — some epics have no deps). Created on Epic screen via UI.
- **Start Date:** `customfield_10015` (pre-existing)
- **Due Date:** `duedate` (system field, pre-existing)

**CRITICAL:** The REST API field IDs (customfield_10289–10292) are ghost entries that never materialized on V2KAN because it's team-managed. After creating fields via UI, verify actual field IDs via createmeta endpoint. Tell agents the real IDs once verified.

## V2KAN ↔ BOOK Completion Sync

Scout creates on V2KAN. Engineering pulls into BOOK. Product agents never write to BOOK.

- **Mechanism:** Daily cron job under Scout's profile (job `ea9cf29196ed`, 8am UTC)
- **Behavior:** Polls BOOK for completed tickets → cross-references V2KAN → mirrors status → auto-transitions epics to Done when all children complete
- **"Stalled" = report-only:** No Jira status/label. Johnny reports 7+ calendar day no-movement epics in weekly report
- **Open:** V2KAN↔BOOK ticket identity mapping needs audit — Scout was asked to check whether engineering clones, moves, links, or recreates tickets. This determines whether the sync can match automatically.

## Dewey Cascade Protocol for Product Changes

When changing Johnny, Scout, or Priya skills/config:
1. Discovery request to Dewey in #ai-ceo-team (C0AR85TMVS8)
2. Dewey audits and reports back
3. Steve + personal Hermes analyze gaps, draft update package
4. Package to Dewey with approval gate ("do not implement until I say go")
5. Dewey reviews, asks questions
6. Steve gives go-ahead
7. Dewey cascades: skill updates → Johnny → Scout (Sarah @mentioned)
8. Woz handles infrastructure (model upgrades, access provisioning) — not Raju
9. Sarah tests end-to-end
10. Dewey confirms completion

Key: Always get Johnny's CPO input on product standards before finalizing. Chain of command: Dewey → Johnny → Scout. Ford tracks but doesn't execute.

## Agent Capability Discovery Pattern (June 17, 2026)

When assessing agent capabilities before making changes, use the Dewey discovery pattern:

1. **Ask Dewey for capabilities report** — skills, access, permissions, guardrails, model, relationships
2. **Analyze gaps** between current state and desired state (Steve + personal Hermes)
3. **Ask the relevant agent for CPO/domain input** — route through Dewey to maintain hierarchy and context
4. **Reconcile** agent feedback with Steve's requirements
5. **Package updates** and cascade through Dewey → Ford → C-level owners → sub-agents

**Key rule:** Don't go directly to Johnny or Scout. Route through Dewey. This maintains chain of command and ensures Dewey has full context for the cascade phase.

**Brake pedal:** Every discovery message must include "Do not change anything" and "Report back only." Bookmarked agents will execute immediately if not explicitly told to wait.

## Epic Structure Standard — Gold Standard Example (June 16, 2026)

BOOK-1491 is the reference example epic. 7 child tickets (BOOK-1492 through BOOK-1498) show the full standard. Use this as the benchmark when coaching Sarah or auditing epic quality.

**Epic description template (3 sections):**
1. **Why This Exists** — 1-2 plain English sentences. What problem does it solve?
2. **Who This Helps** — Which user personas benefit?
3. **How We Know It Worked** — 3-5 testable acceptance criteria (observable outcomes, not technical specs)

**Epic fields (use Jira fields, NOT description text):**
- Title: Plain English feature name (no code names, no version numbers, no BOOK-XXXX references)
- Start Date (`customfield_10015`): When work began
- Due Date (`duedate`): Target ship date
- Feedback Source (`customfield_10293`): FB-ID from Priya's hub (e.g., "FB-047") or source (e.g., "Steve direction," "Board priority"). Required. Created June 17, 2026 via Jira UI (team-managed projects require UI creation — API returns 201 but fields are ghosts).
- Dependencies (`customfield_10294`): What must happen first or in parallel. If none, "None." Not required. Created June 17, 2026 via Jira UI.
- Status: To Do → In Progress → Done (Resolved date auto-stamps as actual ship date)
- Also available: Target Start/End (`customfield_10022`/`customfield_10023`) for Advanced Roadmaps timeline

**"Reason for Shift" convention:** When a due date moves on any epic, Scout adds a Jira comment with old date, new date, and reason. Not optional. This is the data source for the Planning Accuracy metric.

**Ticket standard for engineering (match BOOK-1035/BOOK-1032/BOOK-1040 format):**
- Stories: User Story + Context + Existing Infrastructure (file paths, components, API endpoints) + Acceptance Criteria (PASS/FAIL) + Technical Notes (implementation guidance, related tickets)
- Bugs: Bug Description + Steps to Reproduce (numbered) + Expected/Actual + Impact + Root Cause (suspected) + Files (exact paths) + Environment
- Tasks: Task Description + Checklist (concrete items) + Files + References

**Key coaching point for Sarah:** The epic layer is for the business (Charlie, board, team). The ticket layer is for engineering. Sarah's job is to keep the epic layer readable by humans and agents. Tickets stay in engineering's format. The two layers serve different audiences — don't mix them.

**Jira hygiene rule:** When all tickets in an epic are Done, the epic MUST be transitioned to Done immediately. 9 completed epics were sitting at "To Do" as of June 16, 2026 — this is the #1 reporting problem.

**What this enables for agents:** Once epics are clean, Johnny can query Jira and auto-generate the product section of the weekly update, the dashboard pulls real numbers, and Sarah stops being a manual report writer.

## Reporting Cadence

- **Thursday by 3pm:** Sarah updates the dashboard / delivers product report
- **Friday 15-min session:** Product walkthrough of past week's updates (no future roadmap)
- **Weekly to Charlie:** Product section feeds into the weekly board update (see `weekly-chairman-update` skill)

## Implementation Status — June 17, 2026 Update Package

Full system update cascaded through Dewey → Johnny → Scout → Sarah. Status:

| Step | What | Status |
|------|------|--------|
| Johnny model upgrade to Sonnet 4 | Woz | ✅ Done |
| Scout Confluence PROD access | Woz | ✅ Done |
| Johnny epic template + measurement skills | Dewey | ✅ Done |
| Scout epic template skill | Dewey | ✅ Done |
| Scout daily BOOK poll cron (8am UTC, job ea9cf29196ed) | Dewey | ✅ Done |
| Johnny → Scout cascade with Sarah @mentioned | Johnny | ✅ Done |
| Custom fields created in Jira | Steve's Hermes | ✅ Done (instance level) |
| Custom fields added to V2KAN screen | Woz | ❌ Pending |
| Priya added to #product-feedback | Woz | ❓ Verify |
| Scout V2KAN↔BOOK cross-reference audit | Scout | ❓ Pending results |
| Sarah end-to-end test | Sarah | ⏳ Waiting on above |

**Custom field IDs (created June 17 2026 via Jira UI — NOT API):**
- `customfield_10293` — Feedback Source (short text, required)
- `customfield_10294` — Dependencies (paragraph, not required)
- IDs 10289–10292 are ghost entries from failed API creation attempts. Do not use them.

**Critical pitfall discovered:** Instance-level custom fields don't appear on team-managed (next-gen) project screens automatically. Must be explicitly added by Jira admin. Scout reported fields "don't exist" even though API creation returned 201. See `atlassian-mcp` skill for the full pitfall.

**V2KAN↔BOOK sync open question:** How do tickets move from V2KAN to BOOK? Clone, move, or new creation? Scout was tasked with a historical audit to determine the cross-reference pattern. Without this, the daily sync cron can't reliably match tickets across boards.

**Agent role split (finalized June 18):**
- Priya: classifies feedback → Confluence hub with FB-IDs. Tags signal-strength tier (Customer/Team/Strategic). Does NOT write to Confluence until all questions answered.
- Johnny: recommends epics to Steve (does NOT approve). Reviews with Sarah Thursdays. Evidence bar: is it real, is it more than one opinion, what happens if we don't. Model: Sonnet 4.
- Scout: builds Steve-approved epics only on V2KAN → watches BOOK for completions → mirrors status back → "Reason for Shift" comments. Does NOT build any epic without Steve-approved status.
- Sarah: human quality gate at TWO points: (1) reviews Priya's intake quality (5-question checklist), (2) reviews Johnny's epic recommendations (6-question checklist). Presents to Steve Friday 3pm. Does NOT direct agents to create pillars, commit to memory, or bypass intake.
- Steve: approves all epics during training period. After 3-4 clean cycles, delegates tactical approvals to Johnny.
- Flow: Priya classifies → Sarah reviews quality → Johnny reviews weekly with Sarah → Johnny recommends → Sarah presents to Steve Friday 3pm → Steve approves → Scout builds

**Steve approval gate (training period, June 18 2026):** Every epic requires Steve approval. Clean cycle = evidence bar met on every recommendation + zero premature Confluence writes + zero @mention failures + Thursday→Friday cadence runs + Steve approves without asking "where's the evidence?" After 3-4 clean cycles, tactical approvals delegate to Johnny.

**Urgent escalation:** Johnny → #product (C0AE4HG85TK) with evidence. Bar: "lose a customer or break trust this week."

**Evidence bar (replaces rigid ≥3 rule):** 3+ customer sources = automatic strong evidence. Fewer requires stronger justification. Johnny must answer: Is the problem real? How do we know it's not one opinion? What happens if we don't?

**Critical pitfall (June 18):** Johnny took a single Team Observation (Teela sharing a TCEA article) and created a full roadmap pivot memo ("Proof of Value/Audit Defense") with 6 new epics, pruned existing epics including BOOK-1491 (our example epic), and declared it the Q3 priority — all without Steve's approval. Sarah directed Johnny to do this before Priya finished intake. This is the exact failure the Steve-approval gate and evidence bar are designed to prevent.

**Dewey communication pattern that worked:**
1. Discovery request (report back, don't change anything)
2. Relay questions to sub-agents through Dewey (maintains chain of command)
3. Analyze responses between Steve and personal Hermes
4. Send full update package with approval gate
5. Dewey reviews, asks questions, gets answers
6. Steve gives go — Dewey executes in parallel where possible
7. Corrections sent in-thread (e.g., "Woz only, not Raju")
8. Each agent skillifies their updates

This pattern — discovery → analysis → package → review → go → execute → verify — should be the standard for all multi-agent system changes.

## Related

- `references/v2kan-book-sync-and-agent-roles.md` — V2KAN↔BOOK sync mechanism, agent role split, Dewey communication pattern, all Jira custom field IDs for epics
- `references/epic-template.md` — gold-standard 6-field epic description template with worked example (BOOK-1491) and naming conventions. Use when creating new epics or coaching Sarah.
- `references/epic-audit-2026-06-15.md` — full audit of 9 completed + 3 empty epics with ticket counts
- `references/customer-feedback-template.md` — finalized 8-field template, extraction prompt for team, known feedback sources in G-Brain
- `references/priya-dewey-audit-2026-06-17.md` — full read-only audit of Priya's SOUL, skills, guardrails, cron jobs, and channel wiring from Dewey. Baseline for refinement work.
- `references/sarah-feedback-loop-coaching-june18.md` — Full incident report: Sarah bypassed intake process <24hrs after being told not to, specific messages, coaching message sent, both checklists, graduation path. Use for future Sarah coaching sessions.
- `references/dewey-agent-capabilities-audit-template.md` — reusable template for asking Dewey to report on any agent's capabilities before making changes. Includes all 10 audit questions and rationale.
- `references/agent-update-cascade-pattern.md` — 7-step pattern for cascading agent updates through Dewey → C-level → sub-agents. Includes ownership table template, brake-pedal rules, and Slack truncation pitfall.
- `references/agent-cascade-protocol.md` — Step-by-step protocol for cascading product standard changes through Dewey → Johnny → Scout, with Jira field inventory and board architecture
- `atlassian-mcp` — Jira/Confluence access patterns and pitfalls
- `weekly-chairman-update` — Charlie's weekly update (product section feeds from this)
- `bookmarked-strategy` — broader GTM and product strategy context
- Dashboard design reference: `roi-calculator/board/pipeline.html`
