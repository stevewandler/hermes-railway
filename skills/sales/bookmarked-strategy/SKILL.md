---
name: bookmarked-strategy
description: "Use when Steve asks about Bookmarked GTM, product strategy, pricing, PLG, defensibility, Network Intelligence, SB13, or continuing strategy work. Pull source truth from the strategy repo/G-Brain before giving a call."
version: 1.0.0
author: agent
tags: [bookmarked, strategy, gtm, product, plg, edtech, texas, sb13]
related_skills: [hermes-gbrain-operating-model]
references:
  - references/strategy-measurement-operating-system-stub.md  # Dedicated future session scaffold for measurable Bookmarked strategy operating system
---

# Bookmarked GTM / Product / Viral-Adoption Strategy

## Native Hermes Routing

Use this skill any time Steve says "continue the strategy work," "back to the GTM initiative," references any D-001–D-011 / O-001–O-005 decision, or asks about personas, pricing, PLG wedge, book-review network, Network Intelligence, defensibility engine, Texas SB13, or multi-state architecture.

Source-of-truth order:
1. `~/github-repos/bookmarked-strategy/` for canonical strategy inputs, decisions, synthesis, and handoffs.
2. G-Brain for cross-session strategic memory, takes, people/customer context, and related transcripts.
3. Confluence only as a mirror/working surface; verify currency against repo/G-Brain before relying on it.
4. HubSpot/Slack only when the strategy question depends on live account/team state.

Output mode: give Steve the terrain, the real tradeoff, your honest recommendation, and the next move. Do not create a consultant option stack unless he asks.

When Steve frames the work as business strategy, measurement, operating cadence, or proving Bookmarked is making measurable progress, use `references/strategy-measurement-operating-system.md`. L10, Charlie updates, sales reports, product feedback, and marketing cadence are downstream implementation/reporting surfaces; the high-leverage work is the measurable strategy operating system underneath them.

---

## Where everything lives

| Layer | Location | What's there |
|---|---|---|
| **Source of truth** | `~/github-repos/bookmarked-strategy/` (private, cloned locally) | All inputs, research, synthesis, decisions |
| **State anchor** | `decisions/decision-log.md` | D-001→D-011 confirmed; O-001→O-005 open |
| **Pickup brief** | `handoffs/hermes-pickup-brief.md` | Narrative through-line + resume instructions |
| **Contract mirror** | Confluence SH1 p.145588225 | May lag repo — verify currency |
| **Canonical law** | G-Brain page `bookmarked-compliance-law` | Texas legal stack with full provenance |

**Read order on pickup:** handoffs/hermes-pickup-brief.md → decisions/decision-log.md → synthesis/ (as needed for depth) → inputs/ (only for provenance). Don't re-read inputs unless a specific claim needs sourcing.

---

## The strategy spine

Bookmarked's current motion (gated enterprise, per-student pricing, "save time" value prop) is failing in a budget-stressed market. The reframe:

> **Bookmarked is the evidence/defensibility layer for the entire Texas SB 13 book lifecycle — entered product-led through the one artifact every approval-chain persona already touches (the book-order spreadsheet), monetized on a value metric that isn't per-student, justified in the only two buckets districts fund: legal mandate and hard cash.**

Key structural elements:
- **Wedge use case:** book-order review. Legally forced (SB 13 board approval per book), recurring (~6 cycles/yr), acutely painful (37 spreadsheets, ISBN hell). LCA reborn (paste a list → instant intelligence) = PLG entry point.
- **Defensibility Engine (D-008):** Defends district decisions in BOTH political directions. Ground-truth catalog vs. PEN America hearsay. Faces INWARD only — never public counter-PR.
- **Network Intelligence = statutory method (D-006):** 13 TAC §4.2 requires ≥2 of 5 evaluation methods; network intel ("consultation with similarly-situated districts") is Method #2. It's not a differentiator — it's how you legally select books.
- **Two flywheels:** (1) Defensibility — more usage → richer audit trail → stronger defensibility. (2) Validation/upload — order spreadsheet entry → "upload your catalog to confirm what's safe to reorder" → full catalog in → powers network intel + weeding.
- **Multi-state architecture (D-007):** "National Intelligence, Local Compliance" — universal data core + pluggable per-state policy profile + district-similarity weighting.

---

## Confirmed decisions (D-001–D-011)

See `references/decision-state-20260608.md` for full text. Summary:

| # | Decision |
|---|---|
| D-001 | Claude (Opus) as strategy advisor model |
| D-002 | Steve owns strategic frame; agents at gates only, must say "I don't know" |
| D-003 | Private repo: BookmarkED-Corp/bookmarked-strategy |
| D-004 | PLG (Wes Bush) + Crossing the Chasm (Moore) as diagnostic frameworks |
| D-005 | Texas legal stack from primary sources: SB 13 live, SB 412 fear engine, HB 900 partly enjoined |
| D-006 | Network intelligence = statutory evaluation method (13 TAC §4.2 Method #2) |
| D-007 | Multi-state architecture: "National Intelligence, Local Compliance" |
| D-008 | Defensibility Engine = core positioning; inward-facing only |
| D-009 | Request circulation (check-in/out) data on upload |
| D-010 | Multiple entry points via the shared order/review spreadsheet; don't enter via the librarian |
| D-011 | Ship Network Intelligence first; Book-Review Network as Phase-1 fast-follow |

---

## Open questions (O-001–O-005)

| # | Question | Current state |
|---|---|---|
| **O-001** | Lead GTM wedge persona | See §below — analysis done this session (2026-06-08) |
| O-002 | Pricing model | Resolve after conversion trigger. Per-student structurally broken. Candidates: per-user/per-campus, feature-tiered. |
| O-003 | Conversion trigger | Core unresolved PLG question. What in-product moment turns "try" into "ask for budget"? |
| O-004 | Book-Review Network design | Anonymity model, incentive/reciprocity, anti-herd safeguards, Method-#2 legal line. Resolve before build. |
| O-005 | ESC channel role | Advancing — strategic focus shifted from ESC 16 to ESC 10 (June 18, 2026). Region 10 meeting June 23. 5-deal proof model before committing 15% commission. See `references/esc-partnership-meeting-playbook-20260617.md` for full playbook. |

### O-001 — Lead GTM wedge persona (analysis 2026-06-08)

**Claude's recommendation (prior session):** Administrator / curriculum reviewer as tip of spear; board member as influence amplifier; librarian pulled in last.

**This session's sharper answer:** The right persona is **the district-level person who aggregates order spreadsheets before they go to the board**. The *function* is consistent across districts; the *title* varies.

- Large districts (10K+ students): C&I coordinator, Director of Library Services, or Asst. Supt. C&I's coordinator
- Mid districts (3K–10K): may double as principal or AP role
- Small districts (<3K): the librarian IS this person — librarian-first motion works here

Board members are not a lead wedge. They're a *diffusion mechanism* after the coordinator is hooked. Don't enter via the board — enter via the spreadsheet-holder, let them surface it upward.

**Still open:** Jan/Teela likely have a working title for who they're actually calling. That should be surfaced to finalize the persona name for external messaging.

**Sequence after O-001 resolves:** O-003 (conversion trigger) → O-002 (pricing). Pricing follows the trigger.

---

## Strategy Measurement Operating System

Steve has identified that the highest-impact business work is not L10 itself. L10 is an implementation forum. The center of gravity is a clear, well-oiled strategy and the ability to measure whether Bookmarked is succeeding.

When Steve starts the dedicated strategy measurement session, use `references/strategy-measurement-operating-system-stub.md`. Do not opportunistically fill it in without walking the process with him. The work is to define strategic bets, leading indicators, lagging outcomes, source systems, cadence, owners, decision thresholds, and reporting surfaces.

This future system should feed L10, Charlie updates, product, sales, marketing, CS, and Steve’s own operating rhythm. It should not be reduced to dashboards or activity tracking.

## Product feedback operating model work

When Steve asks about Bookmarked product feedback, Priya, Johnny, Sarah, Product Hub, Jira handoff, product-feedback Slack routing, customer education signals, or closed-loop product operations, use `references/product-feedback-operating-model-rollout-20260611.md` as the current operating pattern. Key rules: `#product-feedback` (`C0AMSNW8YSZ`) is Priya’s only visible/canonical intake; Product Hub is the product system of record; Jira is only for committed Build Now work; C-level agents cascade to sub-agents and must involve human counterparts in shared channels; avoid “ledger” as an artifact name because Ledger is the CFO agent.

## Marketing Operating System work

When Steve asks to build, restart, or automate Bookmarked marketing with Seth, Dewey, Ford, Zig, Jan, HubSpot, Postiz, or Confluence/GitHub marketing assets, do **not** start by turning on a weekly content machine. First build the marketing operating layer: source authority → strategy → campaign architecture → weekly cadence → draft-only automation → approved publishing. The tools are not the center of gravity; revenue movement is. Use `references/marketing-operating-system-20260611.md` for the current operating pattern, Confluence/GitHub structure, Seth boundaries, and approval gates.

Core rule: marketing should create revenue movement, not content volume. Content supports three jobs: market education, demand capture, and sales enablement.

Operational refinement from the 2026-06-11 rollout: Confluence is the contract; `bookmarked-os-private` is the agent skill system; a future `bookmarked-marketing-os` repo is only the campaign workspace. Do not create the repo or automate publishing before Seth has been briefed from the Confluence operating pages and the Postiz-vs-Late publishing-stack mismatch has been reconciled.

## Product feedback loop / product operating model work

When Steve asks about product feedback, roadmap workflow, Product Hub/Confluence structure, Jira handoff, Priya, Johnny, Sarah, Scout/Jenni, or Slack feedback channels, use `references/product-feedback-operating-loop-20260611.md`.

Core rule: do not start by inventing a new framework or moving pages. Start by making the existing loop close: `#product-feedback` (`C0AMSNW8YSZ`) is the canonical Slack intake; Product Hub is the system of record; Jira receives only committed Build Now work after product decision + ticket readiness. Raw signal can originate in CS/Sales/Migration/BI/design channels, but product synthesis and decisions live in Product Hub.

Hard rule for this class of work: no product decision is official because it happened in Slack unless reflected in Product Hub; no Jira ticket from product/customer feedback unless linked to a Product Feedback ID, Pattern ID, or explicit CEO/Product strategic decision. Bugs can route directly to ticket creation if reproducible/urgent, but feature/workflow/product changes must go through feedback → product decision → ticket readiness.

## Product feedback loop / product operations work

When Steve is designing or updating the Bookmarked product feedback loop, Product Hub/Jira handoff, Priya/Johnny/Sarah responsibilities, Slack channel routing, Product Pulse, or customer-education-derived product signals, use `references/product-feedback-loop-architecture-20260611.md`. Key rules: `#product-feedback` (`C0AMSNW8YSZ`) is the canonical Slack intake; Product Hub is the system of record; Jira only receives committed Build Now work; Priya structures/routes but does not prioritize; Johnny/Sarah decide; avoid the word “ledger” for product artifacts because Ledger is the CFO agent; use “Product Signal Board.” Customer education questions are signals inside the same loop, not a separate architecture, and the resolution path is not always Jira.

## Mabel — Texas School Librarian Agent (data/schema analysis discipline)

Mabel is Steve's first Hermes domain-expert agent (SOUL at `~/.hermes/profiles/default/agents/mabel/SOUL.md`; knowledge bases in G-Brain: `agents/texas-librarian-agent-knowledge-base-v2`, `...-reading-psychology-v1`, `...-regulatory-framework-v1`). She is a credentialed-librarian data analyst whose mission is "right book, right kid," and whose job on the Network Intelligence project is to understand the Bookmarked V1 production data model, then surface cross-district intelligence for individual districts' OnShelf dashboards. Mabel is invoked as a persona within Steve's personal Hermes (via delegation / persona load) — she is NOT a separately-running instance and does NOT have a live connection to Ram. Ram (separate Bookmarked instance) is reached only by Steve relaying questions; Ram's schema docs are one-way handoffs.

**Operating discipline (Steve corrections, June 18 2026 — these are hard rules for Mabel-class work):**

1. **Reason like the expert before asking.** Steve built Mabel to BE the domain expert. Do not fire off clarifying questions you could answer yourself by thinking. The canonical failure this session: asking "does ClassRoomLibrary represent the school's main library?" when the table is literally named ClassRoomLibrary. That question revealed un-done thinking and frustrated Steve. Reason to a hypothesis first, then confirm it in one sentence ("Main-library books are Book rows with NULL classRoomLibraryId — does that track?"), rather than asking an open question that exposes you haven't worked the model.

2. **Quality over speed; do the homework first.** Steve repeatedly said "this isn't about speed" and "before you ask Ram, you and I need a planning process." When given schema/product material, go deep on Confluence (Product Hub `PROD`, `Book Intelligence` page 96436240) and G-Brain FIRST, build a holistic model, THEN surface a small set of genuinely make-or-break questions. A wall of 10 questions is worse than 3 sharp ones plus "here's what I'll determine myself from the data."

3. **Never assume; ask only what you genuinely can't derive.** Steve is non-technical — frame questions in plain English, no SQL. But the bar for asking is high: it must be something that shapes how Ram pulls the data, or an external fact you cannot inspect (e.g., does the schema carry the TEA CDN join key). Things like field cleanliness, feature-usage distribution, and freshness you profile yourself once the dump lands — say so explicitly so you're not outsourcing your own job.

4. **Separate questions Ram must answer from things you'll determine yourself.** Always present both lists. This proves you've done the reasoning and protects Steve's time.

**Reusable model when raising the model tier:** when Steve upgrades the model and asks for a re-pass, don't re-ask the same questions — produce genuinely sharper reasoning. The good re-pass this session led with the realization that reframes the whole problem (presence is a copy-record count, not a title count; status-blind aggregation is a liability under SB 412; stale districts poison peer comparisons) before any questions.

See `references/mabel-network-intelligence-data-work.md` for the full operating playbook, the V1 schema reasoning established this session, and the correct vs. lazy question patterns.

## Book Intelligence / Network Intelligence alignment work

When Steve is aligning Sarah, Johnny, Dewey/Ford/Seth, or the agent fleet around Book Intelligence / Bookmarked Intelligence, use the first-surface governance pattern captured in `references/book-intelligence-first-surface-alignment-20260611.md`.

Key rules:
- Product Hub owns product truth and product-safe language; Marketing derives external copy later rather than duplicating internal alignment language.
- Do not call this work “V1” because platform V1→V2 migration already uses that language. Use “first customer-facing slice,” “initial Book Intelligence surface,” or “V2-ready Book Intelligence surface.”
- Sarah’s lane is not “define Bookmarked Intelligence.” It is to identify the first Book Intelligence surface that can safely ship inside V2 using data Bookmarked already has or can realistically collect.
- Seth may review for clarity/messaging discipline, but do not ask him to turn the internal frame into external marketing until Johnny/Sarah confirm data reality and Steve approves positioning.

---

## Three Data Plays — LMS Replacement Vision (June 18, 2026)

Steve's breakthrough creative session articulated the full product vision. Canonical pages: `concepts/product-vision-lms-replacement` and `deals/mesquite-isd-literacy-pilot`.

**The frame:** Bookmarked doesn't replace the LMS. It makes the LMS useful. Follett Destiny = filing cabinet. Bookmarked = intelligence engine on the same data.

**Play 1 — Network Trust Signal (AVAILABLE NOW):** 100+ Texas districts already on platform. Show librarians "47 Texas districts have this book." Kill the review bottleneck. "Texas trusts Texas" — culturally specific network effect. Uses existing catalog data only.

**Play 2 — Collection Benchmarking (AVAILABLE NOW):** "Here's what similar districts have that you don't. Here's what's dead on your shelf." Demographic-aware comparisons. Existing data only.

**Play 3 — Literacy Measurement (REQUIRES check-in/check-out data):** The premium tier. Measure outcomes — are second graders taking books home? Cross-district circulation patterns. The Mesquite ISD pilot ($150K, $3/student, 50K students) with Dr. Angel Rivera is the proof case. No student PII required — anonymized circulation data only.

**The sequence:** Plays 1-2 are buildable TODAY. Play 3 requires districts to share circulation data — Mesquite pilot proves it out. If Mesquite works, template it: "Give us your data, we'll give you your literacy strategy."

**Connection to existing strategy:** The three plays stack on the existing defensibility engine (D-008) and network intelligence positioning (D-006/D-011). Play 1 IS the D-011 "ship Network Intelligence first" in concrete product terms. The competitive frame ("we're not replacing your LMS, we're making it useful") is the pitch-ready version of the strategy spine.

## Founder Operating System — Multi-Agent Architecture (June 18-19, 2026)

Steve's vision for how Hermes agents work as his daily operating system. Not a single report or dashboard — a fleet of agents doing real work, with a triage surface where Steve steers. Research saved in G-Brain: `ai-chief-of-staff-research`, `research/ai-agent-dashboard-architecture`, `research/founder-ceo-dashboard-examples`, `guide/day-1-dashboard-implementation`, `guide/dashboard-design-playbook-adhd`.

**Core principle:** Agents do the work. The app is just the windshield. Each item on the triage board should be 90% done — Steve approves output, not reads alerts.

### Northy — The Strategy Agent (BUILT June 19, 2026)

**N.O.R.T.H.Y. — Never Off, Relentlessly Tracking How You're doing.**

Northy is live. SOUL at `~/.hermes/profiles/default/agents/northy/SOUL.md`. Skill at `strategy-agent`. Triage board at G-Brain `ops/northy-triage`. Intelligence feed at `ops/northy-intelligence-feed`.

Three cron jobs running:
- **Nightly Deep Scan** (9pm daily) — all five jobs: contradiction detection, dot connection, strategic drift (Science of Scaling + Start With Why + Big Leap ULP + Dare to Lead armor), opportunity surfacing, founder intelligence feed
- **Business Hours Scan** (every 3 hours) — urgent items only, doesn't touch board unless Act Now needed
- **Founder Intelligence Feed** (Monday 8am) — weekly scan of Garry Tan, Tobi Lutke, Wade Foster, Anthropic, Karpathy, YC, others. Extracts implementable patterns mapped to Steve's system.

**Personality:** Warm, direct, dry humor, Canadian energy, zero bullshit. Speaks like a person, not a report. Named after True North — the fixed point that doesn't move when everything else does.

**Key architectural decision (June 19):** Therapy and coaching are MODES of the same relationship, not separate agents. Heather (therapist) will be a separate SOUL for deep personal work. Northy catches the wound's fingerprint in work transcripts and names it (ULP, armor, thermostat). Heather goes into the wound itself. Full reasoning in `strategy-agent` skill reference `references/northy-build-session-20260619.md`.

### Other agents (designed, not yet built):
- **Sales Agent** — watches deal transcripts, HubSpot, Slack #sales. Drafts follow-ups, flags stalled deals, pre-writes one-pagers.
- **Product Agent** — watches ALL product activity (not just one person). Dev stands, Jira, #product-feedback, customer feedback.
- **Team Agent** — extracts commitments from ALL meeting transcripts, tracks whether they happened, flags overdue.
- **Articulation Agent** — triggered by new strategic content. Auto-translates into Charlie language, district language, investor language.

**Architecture pattern:** Coordinator + specialists with shared state (G-Brain). Agents do NOT talk to each other. Each writes to its own triage page. Northy reads across all of them for cross-domain synthesis. Steve is the coordinator — or a meta-agent is. Research confirmed swarm patterns create chaos (loops, context pollution). Shared state = the contract.

**Dashboard app (designed, not yet built):** Visual triage surface. Tabs by domain. Approve/edit/kill per card. "What am I missing?" button. ADHD-friendly: big text, high contrast, one decision per card. Tech stack: FastAPI + React, local, SQLite.

## Hard guardrails (do NOT violate)

1. **Switzerland** — never help ban or keep; provide evidence for the district's own choice. Defensibility faces inward only.
2. **Librarian sensitivity** — elevate, never replace. Every artifact passes the "does this threaten or elevate her" test.
3. **HB 900 vendor ratings are ENJOINED** (Book People v. Wong) — do not rely on vendor "sexually explicit/relevant" ratings in customer materials.
4. **Book-Review Network legal line** — peer review = §4.2 Method #2 (consultation), NOT Method #5 (authoritative). Don't market as board-evidence substitute.
5. **Circulation data (D-009)** — request on upload.
6. **Primary sources only for law claims** — no fabrication. "I don't know" is the correct answer when provenance is absent.

---

## Working method

- One focused question at a time. Go deep before wide.

## Content Scanner PRD / Engineering Requirements Work

When Steve asks about the Content Scanner PRD, prototype, engineering requirements for Raju, or publisher/district requirements gathering for the scanner, use `references/content-scanner-prd-planning-20260615.md`.

## Mabel — Librarian Agent for Network Intelligence Data Analysis

**Mabel** is Steve's Texas School Librarian agent, built 2026-06-18. SOUL at `~/.hermes/profiles/default/agents/mabel/SOUL.md`. Knowledge bases in G-Brain: `agents/texas-librarian-agent-knowledge-base-v2`, `agents/texas-librarian-agent-reading-psychology-v1`, `agents/texas-librarian-regulatory-framework-v1`.

**When to invoke Mabel:** When Steve asks for librarian-grade analysis of collection data, V1 data schema review, cross-district library optimization, or Network Intelligence data validation. Invoke via delegation with Mabel's SOUL context.

**Cross-instance pattern:** Mabel lives here (Steve's personal Hermes). Ram (V1 data steward) lives in the Bookmarked Hermes instance. They can't talk directly. Steve relays between instances. Ram provides schema docs and data dumps; Mabel reviews with librarian expertise and formulates questions to relay back.

**V1 data schema:** Ram produced three handoff documents describing 40+ tables, 331 columns, 10 domains. The core chain is District → Campus → ClassRoomLibrary → Book → Title. Three critical schema questions must be answered before data analysis: (1) does ClassRoomLibrary include the school's main library or only classroom collections? (2) what does Book.classRoomLibraryId = NULL mean? (3) is there an explicit CHECKED_OUT checkout status? See `hermes-soul-authoring` skill reference `references/mabel-librarian-agent-build-20260618.md` for full detail.

**Product alignment:** Mabel's analysis maps directly to the three data plays in `concepts/product-vision-lms-replacement` — Network Trust Signal (Play 1), Collection Benchmarking (Play 2), Literacy Measurement (Play 3).

**CRITICAL FRAMING (Steve correction, June 15 2026):** Customer feedback about Book Intelligence gaps (re-flagging, ISBN matching, trust deficits, "unknown" flag reasons, pre-publication data gaps) is NOT a list of individual features to write separate PRDs for. It is evidence that validates the need for the Content Scanner (Layer 3). The correct response to "districts can't trust the intelligence" is not "patch the flags" — it's "prove Bookmarked can actually read a book and tell you what's in it." When customer feedback clusters around BI trust, route the conversation toward Content Scanner prototype requirements, not feature-level bug fixes.

**Two-document deliverable (confirmed June 15):** Steve wants BOTH for Raju:
1. **Product Requirements Brief** — 1-2 pages. Problem statement grounded in customer evidence. What the user needs. What success looks like. Scope boundaries. Open questions for Raju. Send this first.
2. **Full Engineering PRD** — 5-10 pages. Everything in the brief plus user stories, acceptance criteria, data model implications, API surface, UI behavior, edge cases, testing requirements. Steve knows Raju will think it's overkill. Steve is okay with that.

**Key context:** The Content Scanner is Layer 3 of the intelligence architecture. The PRD is two-sided: district requirements (Phase 1, primary — separate page in OnShelf) and publisher requirements (Phase 2, secondary — upload/dashboard/verify portal). G-Brain page `product-content-scanner-narrative` is the canonical vision doc.

**Prototype:** 5 public domain books that are ALSO on banned/challenged lists (Huck Finn, Call of the Wild, The Awakening, Ulysses, The Jungle). All available on Project Gutenberg.

**COPYRIGHT PITFALL:** Steve will instinctively want to use high-profile PEN America banned books (Handmaid's Tale, Fahrenheit 451) for the prototype. These are NOT public domain and using them would undermine the trust position. Push back immediately — the prototype must use public domain books only. Pre-1929 publication date is the safe line for US public domain.

**G-Brain search strategy for this work:** Search for district meeting transcripts (Conroe, Mesquite, San Saba, Northside, Pasadena) for district requirements. Search for publisher conversations (Brave Books, Saddleback, Scholastic, Follett, Excalibur) for publisher requirements. The April 6, 2026 call (`gdoc/content-scanner-book-intelligence-council-publisher-pilot-pr`) is the most detailed requirements discussion with Raju.

## Product Metrics Dashboard Work

When Steve asks about product reporting, product metrics, the product dashboard for Charlie/board, Sarah's weekly reporting, epic tracking, or how to measure product progress, use `references/product-metrics-dashboard-20260615.md`.

Core rule: the dashboard is an EPIC VIEW TABLE — not a ticket list, not a sprint dump. Each row = one epic, showing what it is in plain English, stories done/left, and whether it's shipped to production. Charlie reads this in 30 seconds.

**Dashboard built 2026-06-15:** `/Users/stevewandler/github-repos/roi-calculator/board/product.html` — same design system as financial/pipeline dashboards. Not yet pushed to GitHub; Steve reviewing first. Deploy path: push to BookmarkED-Corp/roi-calculator → auto-deploys to `bookmarked-corp.github.io/roi-calculator/board/product.html`.

Key decisions (2026-06-15):
- Delivery mechanism: GitHub Pages HTML dashboard alongside the financial/pipeline dashboards in the roi-calculator repo
- Sarah's job this week: update the epic table every Thursday by 3pm. Binary success. That's it.
- Customer feedback: Priya already has a template (Steve asked her directly June 15) → review it → transcript scraping via Steve's personal Hermes → backfill Priya's dataset. Separate workstream from the dashboard.
- Don't over-engineer week 1. Improve from the last three weeks, not build the final system.
- Jira epic structure is broken — most stories tracked by labels, not epic parent links. Dashboard exposes this gap intentionally.

**CRITICAL presentation pitfall:** Steve will TELL you he wants a lot of things measured. He does, eventually. But present ONE SECTION AT A TIME and let him react. The June 15 session proved this twice:
1. A 5-section measurement framework got "there's way too much for me to consume" — he only engaged with section 1
2. A shorter 3-point summary got "that's not just yet" on points 2 and 3
Pattern: deliver one piece, let him steer, add the next when he asks. He processes by reacting to pieces, not reading finished analysis.

## Product Terminology (locked June 15, 2026 — Steve corrections)

- **Book Intelligence data = "quick intelligence data"** — NOT "content data," NOT "our content." The product surfaces intelligence about books, not the book content itself.
- **The Orders flow is an "order workflow"** where librarians build book lists for board approval — NOT a "point of purchase," NOT a "purchasing page," NOT "checkout." Districts don't buy directly through BookmarkED; they aggregate orders that go through a board approval process.
- **Don't over-claim product milestones** in any artifact. State what shipped and where it matters. Avoid superlatives like "biggest single ship event" — let the reader decide significance.
- **Content Scanner output is a SEPARATE PAGE in OnShelf** — not a tab on the existing book detail/Intelligence Card view. The Content Scanner Report is a distinct surface that links from the book card. This was a Steve decision (2026-06-15) to keep scanner intelligence visually and architecturally separate from the Layer 1-2 book intelligence.
- **Product feedback loop work:** do not start by designing a new system, dashboard, or public roadmap. First close the existing loop: feedback pattern → Johnny/Sarah decision → Jira-ready spec → engineering commitment → weekly Product Pulse → close-loop communication. Use `references/product-feedback-closed-loop-20260611.md` for the decision-ledger shape and red/yellow/green sequencing. Start with the top 5–8 patterns, not the whole backlog.
- **Sarah / junior-teammate product discovery pattern:** when Steve is using a repo or Confluence page to coach Sarah through a Book Intelligence idea, do not treat the first artifact as a build-ready spec. Preserve the original, add a clean working structure, and route the next step through a data reality gate before UI/Jira/engineering. Keep language coaching-oriented: use “next step,” “working brief,” and “data reality report,” not “assignment,” “grade,” or performance-score language. See `references/network-placement-intelligence-handoff-20260611.md` for the full pattern.
- **Book Intelligence / Network Intelligence discovery gate (2026-06-11):** for early Book Intelligence product ideas, do not jump from concept to UI/API/engineering. First place the idea in the three-layer architecture (External Intelligence / Network Intelligence / future Content Intelligence), then require a data reality report: what production fields exist, what is reliable, what cohorts meet thresholds, what cannot be claimed yet. Phase 0 data validation is the project until it proves the surface is viable.
- **Never commit a delivery date to Charlie for an initiative still behind a data gate.** Before writing "we expect Network Intelligence by end of next week" in a board update, confirm with Steve that the gate has actually cleared. If it hasn't, frame it as "we're validating the data foundation before shipping the first surface" — not a date. Steve will catch this if you don't: he asked in session "has Phase 0 actually come back yet?" before letting the section go in.
- **When mentioning Network Intelligence to Charlie:** call it "Network Intelligence" — never "Peer Placement Signal." One-line explanation that works: "a new layer that shows districts what schools across our network are doing with a given book — where it's being placed, how it's being used." Don't over-explain the architecture. Don't mention Phase 0 gates, data audits, or internal codenames.
- **Sarah coaching pattern:** Sarah may bring useful but solution-first product work. Evaluate both the idea and her operating method. Give her a tight next step / working brief, not broad strategic ownership and not language that feels like schoolwork. Do not put grades/scores in repo or Confluence. Repo = working drawer; Confluence = aligned product truth after Steve/Johnny review.
- **Naming discipline for this class of work:** avoid internal analytics names as product labels. In the 2026-06-11 Network Placement review, retire “Peer Placement Signal”; prefer internal “Network Placement Intelligence” and possible UI label “Where Schools Place This.” Avoid “peer” until a peer/similarity model exists. Avoid “V1” because Bookmarked has platform V1/V2 migration language.
- See `references/book-intelligence-network-placement-discovery-20260611.md` for the detailed Sarah handoff, data-gate checklist, naming guidance, and Confluence/GitHub artifact map.
- Cross-check every legal/product claim against the repo's documented sources before asserting it.
- Steve over-explains when processing; help land the plane.
- For Book Intelligence / Bookmarked Intelligence work, do **not** call new work "V1" unless referring to the existing legacy platform. Steve is migrating customers from platform V1 to rebuilt V2, so "V1" creates confusion. Use "first customer-facing slice," "initial Book Intelligence surface," "first release of Network Intelligence," "first usable product surface," or "V2-ready Book Intelligence surface."
- When reviewing junior team work on Bookmarked Intelligence, do not let the assignment become "figure out Bookmarked Intelligence." Narrow it to: "Identify the first Book Intelligence surface we can safely ship inside V2 using data we already have or can realistically collect." Judge the work by data reality, signal taxonomy, user surface, persona split, and governance.
- Use the reference `references/book-intelligence-surface-alignment-20260611.md` for the current internal alignment frame: compliance is the beachhead, library vitality is the destination; External Intelligence / Network Intelligence / Content Scanner; Sarah's lane; Confluence propagation recommendation.
- Agents contribute intelligence at defined gates; Steve owns the strategic frame.
- After O-001 resolves → O-003 → O-002. Respect the sequence.
- **Validate strategy before building artifacts.** Steve explicitly flagged this: "you're building the artifact before we've fully pressure-tested the strategy behind it." When starting a complex engagement (sales strategy, TALAS program design, GTM planning), run the strategic pressure-test first (what's the real goal? what does Michael actually need? what are we willing to commit to?) before committing to HTML/Google Docs/proposals. A planning session should precede the deliverable sprint.
- **For product/data-intelligence discovery, separate discovery from delivery.** Before naming, UI, Jira, or engineering scope, force the sequence: user decision → data proof → product surface → product-safe language → engineering scope. For Sarah-led Book Intelligence / Network Intelligence work, frame this as product-owner discovery, not an “assignment” or performance review. Use GitHub as the working drawer and Confluence as aligned product truth. See `references/bookmarked-product-discovery.md`.
- **Two-track clarity on Michael Ruiz communications.** There are three distinct tracks — never mix them in one message: (1) personal AI coaching → friend-to-friend text/WhatsApp, (2) TALAS organizational program → Michael as author, board as audience, (3) Bookmarked commercial deal → professional email, separate thread. Mixing tracks muddles both relationships.

---

## IMTA — The Third Door (discovered 2026-06-08)

The two-buckets rule (compliance mandate OR hard-cash reduction) describes how districts allocate their **general fund**. IMTA is a separate, earmarked account that bypasses both buckets entirely.

**What IMTA is:** Texas Instructional Materials and Technology Allotment — formula grant, every Texas district gets it automatically at $120/ADA/yr, funds do NOT expire (TEC §31.0211), they roll over into a cumulative "IMTA bank." Statewide: ~$1.4B unspent as of FY2025 end. 287 districts received TEA spending-plan letters in Sept 2025 for holding >3× annual allotment.

**Why it matters for Bookmarked:** A district with a $10M general fund deficit still has an intact IMTA balance — separate account, separate legal bucket. The constraint is category fit, not cash.

**Bookmarked's eligibility case:** Instructional software/platform + AI-enabled instructional tool (FY2026 TEA guidance explicitly named this category). Lead with curriculum alignment and compliance (SB13/HB900/SB412), NOT administrative efficiency — the latter risks the "administrative software" disqualification.

**Garland ISD specific:** $2.17M unspent IMTA (Jan Gilboy, TEA EMAT report, 2026-06-08). General fund deficit is irrelevant to this balance. At Bookmarked price points, this becomes a procurement conversation, not a budget conversation.

**GTM implication:** The 287 districts under TEA spending-plan pressure are actively looking for IMTA-eligible spend. Walking in with their public balance figure (from TEA Dec 2025 legislative report Appendix A) and a clear eligibility case is a fundamentally different conversation than a standard enterprise sale.

**One-time unlock:** Get one written IMTA eligibility confirmation (from a business manager or imta@tea.texas.gov). That opinion travels to all subsequent deals.

**Full canonical research:** `stevewandler/gbrain-mcp`, branch `IMTA-Research`, folder `strategy/imta/` — README, primer, district data, eligibility & approach.

---

## District Intelligence Portal (Sales Intelligence Infrastructure)

The portal is a live system — load the `district-intelligence-portal` skill for any work involving it.

Key signals available right now:
- **Board Intelligence** — Red/Yellow/Green tiers for 1,019 ISDs based on board minutes keyword scoring (SB 13, HB 900, compliance language)
- **IMTA Intelligence** — 1,216 entities with allotment amounts and per-student figures
- **Superintendent Movement** — 90-day rolling window of hire/interim/resign/retire events (buying signals: interim = 6–18 month vendor reassessment window)
- **HubSpot Outreach State** — 95.8% match rate against 1,625 TX companies; `approved: false` still pending review
- **District Profile** — 1,210 unified district records, JS-routed, PDF-exportable

**Current hot targets missing owners:** Arlington ISD (HOT, interim supt Steven Wurtz, ESC 11), Cypress-Fairbanks, Wimberley, Progreso, West Oso.

Portal URL: `https://bookmarked-corp.github.io/bookmarked-exports/reports/`

---

## GitHub repo for district strategy files

Steve commits district strategy context to **private GitHub repos** and shares them as the portable record across sessions. Key repo: `stevewandler/gbrain-mcp`, branches vary by thread (e.g. `School-Districts`, `IMTA-Research`).

**Critical access pattern:** Private repos return HTTP 404 from browser and raw.githubusercontent.com — identical to a missing repo. **Subagents using web_fetch or browser tools will hallucinate plausible-looking content instead of failing cleanly.** Do NOT use delegate_task or browser to fetch private repo files.

**Correct method:** `git clone` via terminal (uses Steve's local git credentials):
```bash
git clone --branch <branch> --depth 1 https://github.com/stevewandler/gbrain-mcp.git /tmp/gbrain-mcp
```
Then read files directly with `read_file`. If clone fails, ask Steve to verify credentials or paste content directly.

---

## Garland ISD — TALAS Relationship Investment Track

**Separate from the Bookmarked product sale. Never put the strategic frame in writing to Michael.**

Michael Ruiz holds two roles: (1) Director of Library Services/Instruction at Garland ISD — the product buyer, and (2) Founding President of North Texas TALAS (Texas Association of Latino Administrators and Superintendents) — the network multiplier. These are intentionally worked as parallel tracks.

**The bigger strategic frame:** Texas has ~1,000 school districts. Latino administrators run a significant portion — San Antonio, El Paso, Rio Grande Valley, Houston, Dallas. TALAS is the entry point to a community most edtech companies never reach. Steve intends to continue this relationship even if Michael says no to Bookmarked.

**The TALAS Engine — already built and partially delivered:**
- A content repurpose engine: one source doc in → blog post, LinkedIn post, member newsletter, exec summary — grounded in TALAS mission anchors and Michael's voice
- Demo PDF sent to Michael on May 20, 2026 — walked through in person the same day
- Michael's response: **no reply to the May 20 email** (thread has 1 message only)
- **May 30 Las Colinas setup session happened** — Steve set up Claude Desktop + GitHub + basic G-Brain on Michael's laptop at the NTX TALAS End of Year Celebration. No Supabase/Railway — rudimentary but functional.
- Follow-up text needed: nudge Michael to use his G-Brain ("even rambling stream of thought — the more you put in, the better")
- All TALAS source files live in Steve's Drive: `michael-ruiz-talas-ai-workflow.md`, `talas-mission.md`, `talas-engine-demo/` folder

**What TALAS is:**
North Texas chapter, founded by Michael. 47 active members, 14 districts, quarterly gatherings, 82% retention. Three 2026-27 priorities: (1) build in-between peer relationships, (2) open the pipeline to aspiring leaders, (3) amplify member work publicly. Michael wrote the strategy doc himself.

**Strategic value of the TALAS track:**
1. TALAS → wedge into TX superintendents across 14+ districts and the broader Texas Latino administrator network
2. Strengthens the personal relationship → makes the Garland product sale harder to decline
3. Michael as TLA North Texas president = referral engine to the entire region

**The AI fluency offer (Steve's instinct, June 2026):**
Help TALAS members develop AI skills so they become better at their jobs and stay relevant. The "bible study for AI" format (informal, peer-learning, people share what they're working on) landed well at Las Colinas. Jennifer (board member) specifically asked for an AI session. Build this into a concrete 2-hour format before the next in-person.

**Key people met at May 30 Las Colinas event:**
- **Bryan McCorkle** — SVP NovoDia (novodia.co — curriculum/instructional design for districts). Email: bryan@novodia.co, phone: +1-516-521-7692, LinkedIn: linkedin.com/in/bryanmccorkle. Met May 30 Las Colinas. Heavy AI user, deep TX admin network, connected Michael's circle through wife Andrea. **Coffee scheduled** (Steve texted 2026-06-10). NovoDia tagline: "Helping districts take back control of curriculum" — adjacent but not competing; natural co-seller/introducer. Also in VCF at `My Drive/00 Drive Inbox/Bryan R. McCorkle.vcf`.
- **Jennifer** — TALAS board member (NOT the diagnostician — Steve initially had these two swapped). Said "you have me so hooked in right now" and asked for a TALAS AI session. High-priority follow-up. Frisco area.
- **Monica** — TALAS member, Grand Prairie/Mansfield, runs entrepreneurship program. Steve promised coffee at Legacy West.

**TALAS Summer Leadership Summit — June 22-23, 2026 (URGENT)**
Concordia University, Austin TX. The statewide flagship event. Full board, all 9 chapter presidents, Miguel Cardona (former U.S. Secretary of Education). If Michael is attending, Steve should be there with him. Ask Michael directly.

**Competitive flag:** Magic School already holds a Plata sponsorship with TALAS statewide. Position as "most widely used AI platform in K-12 ed." Bookmarked's differentiation in TALAS conversations must be the compliance/instructional materials layer (SB13/HB900/SB412), not general AI-for-educators. Don't compete on the same axis.

**Current state / what's needed (updated 2026-06-10):**
- Text Michael: G-Brain usage nudge (pending — good first text: "hope you're leveraging G-Brain, even rambling stream of thought — the more you put in the better")
- IMTA email to Michael: context loaded, ready to draft — confirm $2.17M figure, frame as procurement not budget conversation, mention ESC 16 = no RFP
- Jennifer follow-up: no contact info yet — ask Michael directly for her name/contact; she asked for the AI session
- Monica follow-up: coffee at Legacy West promised, not scheduled; no contact info
- Bryan McCorkle: coffee scheduled (Steve texted him 2026-06-10) — explore co-selling / TALAS collaboration angle
- TALAS GitHub repo: **CREATED** — branch `TALAS-Strategy` on `stevewandler/gbrain-mcp`, folder `organizations/talas/`. Ready for brain dumps.
- Build the AI fluency workshop ("bible study for AI") into a concrete 2-hour format before next in-person — Jennifer specifically asked for it

**Key people in TALAS orbit:**
Dr. Lopez (GISD Supt — Michael's boss, voice memo needed), Ed (Dallas CFO, TALAS Treasurer), Inohosa (board member, "amazing speaker"), Taylor (Michael's scheduler — all meeting requests go through her), James Gera (JG Consulting — Steve's connection to Lopez).

**Full canonical TALAS record:** `stevewandler/gbrain-mcp`, branch `TALAS-Strategy`, folder `organizations/talas/` — README (people, current state), talas-overview.md (mission, chapter stats, 3 priorities, 5-year vision), ai-infrastructure-plan.md (Phase 1 deployed → Phase 3 member intelligence), meeting-notes/2026-05-30-end-of-year-celebration.md (full transcript analysis, key quotes, gaps).

**Personal collaboration repo:** `stevewandler/Ruiz-Wandler` (note capital R and W — GitHub moved it; use this exact casing). This is Steve AND Michael's shared workspace — what's deployed on Michael's laptop, the 4 workflow loops, brain context anchors (TALAS mission, strategic priorities, Lopez vision placeholder), session log, and ideas in progress. Distinct from the TALAS organizational strategy in gbrain-mcp.

**The boundary rule:** Personal collaboration (Steve ↔ Michael working sessions, Michael's brain, what's deployed on his machine) → `Ruiz-Wandler`. TALAS as an organization (chapter strategy, membership intelligence, Steve's strategic thinking about the play) → `gbrain-mcp/organizations/talas/`. Garland ISD deal (Bookmarked commercial track) → `gbrain-mcp/districts/garland-isd/`. These are intentionally kept separate.

**Full session detail:** `references/garland-talas-track-20260608.md` — includes May 30 transcript analysis, people profiles, conversation highlights, and prioritized next actions.

---

## IMTA Numbers — Important Correction

**The $2.17M Jan cited for Garland is unspent IMTA carryover (current cycle), NOT the biennial allotment.**

Garland ISD 2026–27 biennial allotment from TEA PDF (confirmed June 8, 2026):
- Enrollment: 51,021 students / 19,966 EB students
- Student allotment: $8,912,822.79
- EB add-on: $296,973.37
- **Total biennial allotment: $9,209,796.16** (~$4.6M/year)

The $2.17M is the more actionable figure for the Michael email — it's what's available NOW, unspent, sitting in their EMAT account. Use that number. The $9.2M is forward-looking and harder to act on.

**Also note:** Jan's Confluence page (Sales Hub, page 147488769) has better IMTA numbers than any web research. The Confluence page was authored with Bookmarked-specific context:
- $174.69/student biennial rate (not $120/year — different formula structure)
- **ESC 16 is the fiscal agent** — procurement through ESC 16 means **no RFP required**. This is significant; removes competitive bidding hurdle entirely.
- Districts can use IMTA to buy the platform AND the books that flow through it

**Always check the Confluence IMTA page before quoting numbers to Michael or other districts.** It's the canonical Jan-authored reference with the correct formula and talk tracks.

**Confluence IMTA page** (Sales Hub, page 147488769, "IMTA Funding") has better numbers than web research:
- $174.69/student **biennial** rate (not $120/year — different formula structure; IMTA is a 2-year allotment)
- **ESC 16 is the fiscal agent** — procurement through ESC 16 means **no RFP required**. This removes the competitive bidding hurdle entirely — one of the most significant procurement shortcuts available.
- Districts can use IMTA to buy the platform AND the books that flow through it
- Jan also built a live IMTA Intelligence Dashboard (from TEA biennial PDF) and a board activity cross-signal view — both accessible via the District Intelligence Portal

**Also check Confluence** for the IMTA + SB13 one-pager (flyer at `claude-output/exports/imta-sb13-one-pager-2026-04-15.html`) — already built for district finance/curriculum leaders.

---

## Open threads / TODO (as of 2026-06-10)

- Wire repo as segmented G-Brain source `bookmarked-strategy` — NOT done yet
- Confluence currency — re-run `/initiative-sync` after in-flight ingestion agent commits
- Compliance Hub (Google Shared Drive) not yet ingested
- HB 900 injunction status — re-verify before customer-facing use
- In-flight agent — `gdoc/inbox/drive/` ingestion uncommitted in working tree
- **Plaud Drive sync broken** — launchd sync stopped uploading after May 20, 2026. Recordings exist in Plaud account but aren't making it to Drive. Needs diagnosis (separate task — create an agent prompt to investigate why `com.bookmarked.plaud-drive-sync.plist` stopped syncing). When hunting for Plaud transcripts > May 20: use the Plaud MCP client directly. Plaud timestamps are in **milliseconds** (not seconds — divide by 1000 for datetime). Pattern:

```python
import asyncio, sys
sys.path.insert(0, "/Users/stevewandler/.local/share/uv/tools/plaud-mcp/lib/python3.12/site-packages")
from plaud_mcp.plaud_client import PlaudClient
from datetime import datetime

async def main():
    client = PlaudClient()
    files = await client.get_all_files(sort_by="start_time", is_desc=True, page_size=100)
    # Filter by date window (timestamps in milliseconds)
    may29_ms = 1748491200000  # May 29 2026 00:00 CDT
    jun01_ms = 1748750400000  # Jun 01 2026 00:00 CDT
    for f in files:
        st = f.get("start_time", 0)
        if may29_ms <= st <= jun01_ms:
            dt = datetime.fromtimestamp(st/1000).strftime("%Y-%m-%d %H:%M")
            print(dt, f.get("filename") or "(unnamed)", f.get("id","?"))

asyncio.run(main())
```

Use `~/.local/share/uv/tools/plaud-mcp/bin/python` (not system python) to run this. PlaudClient methods: `get_all_files()`, `get_file_detail(file_id)`, `get_transcript(file_id)`, `get_summary(file_id)`.
## Garland — Current State (updated 2026-06-10)

**Strategic question settled:** GTM investment structured as a real deal. See `references/garland-close-strategy-20260610.md`.

**IMTA email sent 2026-06-10** — "Good news on the Garland funding question" → mjruiz@garlandisd.net. Awaiting response.

**Next action:** Follow-up call with Michael — calendar + task set for Friday June 12 at 1pm. Two call goals: (1) confirm IMTA is viable as procurement path, (2) get the name of his business manager for ESC 16 purchases.

**Target pricing:** $89K/year through IMTA. Below $90K threshold, psychologically meaningful in district procurement. Founding-partner rate — permanent, not a time-limited discount. Do not price as a favor. The founding-partner frame is: Garland anchors the North Texas launch; Michael gets a leadership narrative for TALAS/TLA. Still need: is the clerk role filled? Annual materials budget? PO threshold for IMTA (cabinet vs. board approval).

**Next action:** Phone call with Michael after he responds. Confirm IMTA as procurement vehicle, get business manager contact, move to ESC 16 paperwork path.

**Still open:** Is the clerk role filled? Annual materials budget? Most acute compliance pressure? PO threshold for IMTA (cabinet vs. board approval at $89K)? Does Michael want the founding-partner/network-anchor role explicitly offered?

Deal state detail: `references/garland-deal-state-20260608.md` (base context, pre-IMTA email).

---

## IMTA — The Third Door Past the Budget Wall

The "two-buckets rule" (districts only fund compliance mandates or hard-cash reductions) applies to the **general fund**. IMTA (Instructional Materials and Technology Allotment) is a **separate, earmarked account** that bypasses both buckets.

Key facts for any Texas district conversation:
- Every Texas public district receives IMTA annually ($120/ADA FY2026; $174.69/student 2026-27 biennium)
- Funds **do not expire** — roll over indefinitely (TEC §31.0211)
- ~$1.4B statewide unspent as of FY2025; median district balance ~$287K
- 287 districts received TEA spending plan letters Sept 2025 — under pressure to spend
- **Bookmarked is IMTA-eligible**: (1) software that inventories/manages instructional materials, (2) software that analyzes suitability of instructional materials for TEKS
- ESC 16 is fiscal agent — no RFP required
- Districts can use IMTA for the platform AND books flowing through it

**Sales frame:** Don't say "can you find budget." Say "you have earmarked funds that can only be spent on exactly what Bookmarked does."

**Balance lookup:** TEA Dec 2025 Legislative Report Appendix A (first public comprehensive dataset) or PEIMS Fund Code 420. Jan Gilboy can pull current balances from TEA EMAT.

**Garland ISD:** $2.17M unspent (Jan Gilboy, TEA EMAT, 2026-06-08). Full 2026-27 biennial allotment: $9.2M.

## Network-Building as Deal Acceleration

For high-value champion relationships, the deal closes faster when the relationship has depth beyond the transaction:
1. Lead with genuine value to the **person**, not the district
2. The champion sells internally from personal experience — not Steve's pitch
3. Champions with org roles (TALAS president, TLA regional officer) open multiple doors simultaneously
4. Keep tracks separate: personal/relationship work vs. commercial Bookmarked conversation. Never conflate in the same message.

## References

- `references/decision-state-20260608.md` — full text of D-001–D-011 and O-001–O-005 as of session close 2026-06-08
- `references/imta-overview.md` — IMTA mechanics, eligibility case, district data sources, and Garland-specific context
- `references/garland-deal-state-20260608.md` — Garland ISD deal state as of 2026-06-08: proposal details, pricing, email history, contacts, IMTA path forward
- `references/garland-talas-track-20260608.md` — TALAS relationship investment track (2026-06-08): what's been built, sent, Drive file IDs, key people, strategic frame, Steve's AI fluency offer concept
- `references/talas-track-20260610.md` — Bryan McCorkle contact details + strategic angle, Jennifer/diagnostician clarification, what Steve actually set up on Michael's laptop, Plaud query patterns (sync broken — use PlaudClient directly), Confluence IMTA canonical facts (ESC 16 = no RFP, biennial formula), Garland IMTA confirmed figures, Plaud recording IDs for May 29-31
- `references/talas-ruiz-wandler-repo-structure-20260610.md` — **NEW (2026-06-10):** Complete repo map for both TALAS repos (`gbrain-mcp/TALAS-Strategy` and `Ruiz-Wandler`), folder structure, the boundary rule, key people table, what's deployed on Michael's laptop
- `references/talas-statewide-research-20260610.md` — **NEW (2026-06-10):** Full TALAS website ingestion — complete statewide leadership roster, all 9 chapters with descriptions, membership/sponsorship pricing, partner list (Magic School already a Plata sponsor — differentiation needed), Summer Leadership Summit June 22-23 (attend with Michael), El Paso chapter as NTX model, gap analysis for NTX chapter
- `references/talas-ruiz-wandler-deliverables-20260610.md` — **NEW (2026-06-10):** All four deliverables built in the 2026-06-10 session (onboarding prompts, check-in text, IMTA email, internal strategy doc, two HTML one-pagers, Google Doc). Also encodes Steve's design/tone corrections: no defensive copy, no jargon in external docs, empowering not diagnostic framing, use partner brand not Bookmarked brand, strategy before artifacts.
- `references/garland-close-strategy-20260610.md` — **NEW (2026-06-10):** Settled strategic question (GTM investment structured as real deal), $89K founding-partner offer structure, three-part justification stack (IMTA + SB13 compliance + materials efficiency), exact ask language for the next call, what can kill the deal, IMTA email sent (Gmail thread ID: 19eb324c09ec2f3a), open questions still pending.
- `references/network-intelligence-product-discovery-20260611.md` — **NEW (2026-06-11):** Product-discovery method for Book Intelligence / Network Intelligence surfaces with Sarah/Johnny: user decision → data proof → product surface → product-safe language → engineering scope; repo vs Confluence governance; naming guidance (Network Placement Intelligence / “Where Schools Place This”); Sarah coaching tone; data reality gate.
- `references/marketing-operating-system-rollout-20260611.md` — **NEW (2026-06-11):** Concrete rollout record for the Marketing Operating System: Confluence pages created, GitHub repo decision, Postiz-vs-Late mismatch, required Seth skill chain, and recommended next step to brief Seth before creating the repo or cron.
- `references/product-feedback-operating-model-20260611.md` — **NEW (2026-06-11):** Closed-loop product feedback operating model for Bookmarked: `#product-feedback` as Priya’s only canonical intake, Product Hub as system of record, Product Signal Board naming (avoid “ledger”), Priya/Johnny/Sarah/Scout roles, C-level cascade + human counterpart rule, customer education as product signal, cross-post templates, decision states, resolution paths, and first-pilot patterns.
- `references/product-feedback-operating-model-20260611.md` — **NEW (2026-06-11):** Product feedback closed-loop operating model: #product-feedback as Priya-only canonical intake, Product Hub source-of-truth, Product Signal Board naming, Johnny/Sarah decision gate, Jira Build Now gate, customer education as product signal, Slack routing templates, and Dewey/Ford rollout sequence.
- `references/product-feedback-closed-loop-20260611.md` — **NEW (2026-06-11):** Product feedback operating loop for Bookmarked's AI-agent product org: Priya → Johnny/Sarah → Jira/Raju → Product Pulse; decision ledger shape; red/yellow/green sequencing; pitfalls against over-engineering, backlog-boiling, and treating Jira creation as delivery commitment.
- `references/product-metrics-dashboard-20260615.md` — **NEW (2026-06-15):** Product metrics dashboard operating pattern
- `references/content-scanner-prd-planning-20260615.md` — **NEW (2026-06-15):** Content Scanner PRD planning session: two-sided requirements (district Phase 1 / publisher Phase 2), prototype book selection (5 public domain + banned/challenged), copyright pitfall on Handmaid's Tale/Fahrenheit 451, G-Brain source pages for district and publisher requirements, hard boundaries, open questions for Steve: epic-based reporting table (the core view), GitHub Pages HTML dashboard (same style as financial/board dashboard), customer feedback template sequence (Priya → transcript scraping → backfill), Sarah management pattern (one deliverable, binary success metric), and parked metrics for later. Includes Jira/Slack/Confluence reference data for automation.
- `references/customer-feedback-to-content-scanner-mapping-20260615.md` — **NEW (2026-06-15):** Maps the 14 customer feedback items from the first G-Brain extraction run to Content Scanner requirements.
- `references/esc-partnership-meeting-playbook-20260617.md`
- `references/founder-operating-system-architecture-20260618.md` — **NEW (2026-06-18):** Multi-agent founder operating system design: five-agent fleet (Sales, Product, Team, Strategy, Articulation), triage dashboard architecture, ADHD-friendly design principles, research findings on what exists/failed, technical stack (FastAPI+React+SQLite+Hermes cron), G-Brain pages created, build sequence. Core principle: agents do the work, app is the windshield. — **NEW (2026-06-17):** ESC partnership meeting playbook: messaging hierarchy (library vitality FIRST, compliance handled not headlined), planning-before-building workflow, Region 10 meeting prep (June 23), people dynamics, Granbury offsite feedback, partnership economics context. CRITICAL: Steve corrected compliance-first framing — do NOT lead with SB13 in ESC rooms. Separates items that validate Layer 3 need (7 items) from items on separate tracks (classroom libraries, integrations, ordering). Includes Raju call context and Confluence PRD state assessment. Use this when building the Content Scanner prototype requirements brief.
