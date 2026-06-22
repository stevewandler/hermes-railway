---
name: bookmarked-org-alignment-observer
description: Use when Steve's personal Hermes reviews Bookmarked Slack/Confluence/G-Brain signals to assess whether humans, agents, channels, decisions, and follow-through are aligned across the organization. Starts with #ai-ceo-team.
version: 1.0.0
author: Hermes Agent
tags: [bookmarked, org-alignment, slack, agents, operations, strategy, decision-cascade, ford, dewey]
related_skills: [steve-personal-hermes-operating-boundaries, steve-mediated-relay, atlassian-mcp]
---

# Bookmarked Org Alignment Observer

This is Steve's personal Hermes observing the Bookmarked operating system.

It is not a Bookmarked internal agent. It does not command agents directly. It watches Slack, Confluence, G-Brain, and related artifacts for alignment drift, then brings Steve a concise readout and drafts any needed relay for Steve approval.

Start in `#ai-ceo-team` (`C0AR85TMVS8`) because that is where the C-level agents align around company-wide strategy, operating handoffs, and executive-layer coordination.

## Required Boundary

Load `steve-personal-hermes-operating-boundaries` first.

Default classification:

`Steve personal Hermes observing Bookmarked Hermes / Bookmarked operating system. Read-only unless Steve approves a relay, write, or post.`

## What This Skill Is For

Use when Steve asks:
- what is happening across Bookmarked Slack
- whether agents and humans are aligned
- whether the right routing is happening
- whether conversations are in the right channels
- whether decisions are cascading correctly
- whether agents are staying in their lanes
- whether Ford/Dewey/C-levels need an improvement note
- whether a decision Steve is considering may create cascade effects

## What This Skill Is Not

Do not use this as:
- agent police
- automatic surveillance
- a long daily report generator
- a dashboard project
- a replacement for Ford, Dewey, Sentinel, or Oz
- authority to post corrections without Steve approval

This skill observes, synthesizes, and recommends. Steve decides what to relay.

## First Channel

Start with:

| Channel | ID | Why |
|---|---|---|
| `#ai-ceo-team` | `C0AR85TMVS8` | C-level alignment, Dewey/Ford strategy-execution handoffs, Sentinel/Oz infrastructure and evaluation signals, Steve company-wide direction |

When reading, prefer recent history first, then thread replies for important posts.

When reading thread replies, use `references/bookmarked-agent-slack-ids.md` (in `steve-personal-hermes-operating-boundaries`) to map user IDs to agent names. The `users:profile:read` Slack scope is unavailable, so dynamic profile lookups fail. The ID table is the only reliable method.

**Large thread handling:** Slack threads over ~60 replies truncate at ~138K chars via the MCP tool. When this happens, use `delegate_task` with `toolsets: ["web", "terminal"]` to have a subagent pull the thread and extract the specific signals you need. Do not attempt to parse truncated JSON yourself.

## Channel Fan-Out Pattern

`#ai-ceo-team` shows what was directed and what agents acknowledged. It does NOT show whether work actually reached the humans or sub-agents. To get the full picture, fan out to domain channels after reading `#ai-ceo-team`:

| Domain | Channels to check |
|---|---|
| Product / Book Intelligence | `#product` (C0AE4HG85TK), `#product-feedback` (C0AMSNW8YSZ), `#book-intelligence` (C0ATQ7AGFJT), `#ticket-creation` (C0B2BPF46Q0) |
| Sales / Revenue | `#sales_revenue-ninjas`, `#renewals` |
| CS / Onboarding | `#client-success`, `#v1-to-v2-migration` |

Check domain channels when:
- You need proof that a cascade reached humans (not just agent acknowledgment in `#ai-ceo-team`)
- A workstream has a human counterpart (Sarah, Patrick, Jan, Teela) who was supposed to be notified
- You're assessing whether sub-agent work actually moved vs just acknowledged

Agent acknowledgment in `#ai-ceo-team` + human notification in the domain channel = real cascade. Agent acknowledgment alone = incomplete loop.

## Observation Lens

### 1. Routing quality

Check:
- Is operational work going to Ford?
- Is Dewey protected from routine operational status?
- Are C-level agents owning their lanes?
- Are sub-agents being used properly?
- Are humans tagging the right agent?
- Is unclear work going to Ford for triage?
- Are runtime issues going to Oz or Woz appropriately?
- Is evaluation/drift going to Sentinel as observer, not operator?

### 2. Conversation location

Check:
- Is this conversation in the right channel?
- Should it be in a domain channel instead of `#ai-ceo-team`?
- Should a decision move from Slack to Confluence?
- Should a working thread stay in Slack, but produce a durable artifact?
- Is customer/product feedback landing in the right feedback path?

### 3. Agent behavior

Check:
- Are agents responding when they should?
- Are agents silent when they should not be?
- Are agents talking too much in shared channels?
- Are agents giving artifact-backed status?
- Are they making decisions they should escalate?
- Are they producing vague optimism instead of proof, owner, next action, ETA?
- Are they exposing internal scratchpad or raw HTML instead of clean summaries?

### 4. Human/agent collaboration

Check:
- Are humans using agents as seat owners, not task monkeys?
- Are humans giving clear owner/lane/task/success/proof/deadline/escalation?
- Are agents making humans repeat context?
- Are threads closing loops?
- Are follow-ups clear?
- Are decisions captured somewhere durable?
- When an agent needs Steve feedback, a Steve decision, or an answer to a question, did the agent `@mention` Steve so Steve's personal Hermes can see and track it?
- Are agents asking questions into the void without a clear owner or mention?
- Are Steve-needed decisions buried in a thread where neither Steve nor personal Hermes will reliably catch them?

### 5. Source-of-truth discipline

Check:
- Where did the information come from?
- Did the agent cite the source it used: Slack, Confluence, GitHub, G-Brain, HubSpot, Jira, Google Drive, or live tool output?
- Is the source appropriate for the claim?
- Did the agent check Confluence when Confluence is the operating surface / contract for humans and agents?
- Is the conversation creating new durable truth that should move out of Slack and into Confluence?
- Is the agent creating files in a private profile/workspace when the artifact needs to be shared?
- Is there a single source of truth, or are competing versions emerging across Slack, Confluence, GitHub, Drive, and agent memory?
- If GitHub is the build/provenance layer, has the company-facing contract been mirrored to Confluence?
- If Confluence is stale, is that called out instead of silently using stale context?

Bookmarked operating standard:

- GitHub = build + provenance for working artifacts and source history.
- Confluence = the contract / operating surface for humans and agents. Full content lives here when the team or agents need to act on it.
- G-Brain = registry and recall layer, not a substitute for the team-facing contract.
- Slack = real-time coordination, not final durable truth.

Flag drift when agents or humans act from Slack memory, private files, stale docs, or uncited claims instead of the correct source of truth.

### 6. Decision cascade risk

Before Steve and personal Hermes turn a thought into instruction, run a cascade check:

- What is the decision or direction?
- Is it reversible?
- Who is affected?
- What existing decision, page, skill, customer promise, or agent lane does it touch?
- Does it change strategy, operations, product, sales, CS, finance, HR, marketing, runtime, or agent authority?
- Who needs to know?
- What system of record needs updating?
- Should this route to Ford, Dewey, a C-level, Oz, Sentinel, or stay between Steve and personal Hermes for refinement?

Founder direction has gravity. A casual sentence from Steve can become company-wide instruction if routed wrong. Protect speed without creating accidental cascade damage.

## Read-Only Workflow

1. Classify the observation scope.
2. Read recent channel history.
3. Open thread replies for the important items.
4. Check Confluence/G-Brain when a page or decision is referenced.
5. For every meaningful claim or action, ask: what source is this based on, and is that the right source?
6. Identify patterns, not every message.
7. Produce a concise Org Alignment Readout.
8. If action is needed, draft a relay for Steve approval.
9. Do not post without approval.

## Org Alignment Readout Format

Keep it short.

When Steve asks whether agent work actually moved the business forward, do not give him a generic status update and do not jump straight to building a dashboard. Run an after-action operating-loop read first. See `references/agent-operating-loop-after-action-2026-06-12.md`.

When tracking whether a new operating model or policy rollout actually landed with all C-level agents, use `references/org-rollout-confirmation-pattern.md` — covers pre-brief, Confluence canonical posting, confirmation tracking checklist, sub-agent cascade verification, and Phase 1 gating.

```
Org Alignment Readout

Scope:
Channel(s):
Window:

1. Pattern / issue
What I saw:
Why it matters:
Source used:
Correct source of truth:
Evidence:
Suggested correction:
Route:
System of record update needed:
Draft relay, if needed:
Approval needed:

2. Pattern / issue
...

No-action notes:
- Things that look healthy or correctly routed
```

## Routing Improvements

When suggesting improvements:

| Improvement type | Route |
|---|---|
| Steve-needed question/feedback lacks @mention | Ford for operating hygiene; domain C-level if lane-specific |
| source-of-truth / Confluence operating hygiene | Ford, with domain C-level if lane-specific |
| operational/channel hygiene | Ford |
| strategic direction / company narrative / irreversible decision | Dewey |
| product / engineering / Book Intelligence | Johnny |
| marketing / brand / campaign | Seth |
| sales / revenue / HubSpot / ESC | Zig |
| customer success / onboarding / support / churn | Atlas |
| finance / runway / budget | Ledger |
| HR / hiring / human performance | Vera |
| Hermes runtime / gateway / MCP / cron / model / profile architecture | Oz |
| agent quality / prompt evaluation / drift detection | Sentinel evaluates; Ford handles operational follow-up if needed |
| IT infrastructure / outages / access / scheduled job health | Woz via Ford |
| agent training / how to use Hermes | Beacon via Ford |
| unclear | Ford |

## Evidence Standards

Strong evidence:
- Slack link/timestamp/thread
- Confluence page ID/title
- GitHub issue/commit/PR
- HubSpot record ID
- repeated pattern across multiple threads
- explicit owner/deadline/proof gap

Weak evidence:
- vibe
- one ambiguous message
- inferred intent without source
- agent self-report without artifact

Separate strong findings from weak hunches.

## What To Praise

Do not only look for problems. Call out healthy patterns:
- good Ford cascade
- Dewey staying strategic
- C-level agents owning lanes
- identify → report → approve → edit → confirm being followed
- clear owner/success/proof/deadline language
- agents @mentioning Steve when they need Steve feedback, a Steve decision, or an answer to a question
- Slack decision promoted to Confluence
- agents citing the correct source of truth before acting
- artifacts created in shared Confluence/GitHub/Drive locations instead of private workspaces
- agent showing self-advocacy or proper escalation

## First-Pass Signals from `#ai-ceo-team` Read

The initial read of `C0AR85TMVS8` on 2026-06-11 showed this is the right starting channel:

- Steve posted brand voice and product naming canon, explicitly using Dewey → Ford → C-level cascade.
- Dewey handed brand/naming reconciliation to Ford with identify-only constraints and Steve approval gates.
- Steve posted Book Intelligence alignment with specific lanes for Johnny, Dewey, Ford, and Seth.
- Dewey routed fleet health issues to Oz, which matches the runtime boundary.
- Sentinel produced agent/prompt evaluation output, but some output appeared as raw HTML/scratchpad in channel, which is an alignment/format hygiene signal to watch.

Treat this as a starting observation only, not a final audit.

## Agent Update Cascade Workflow

When Steve wants to change how Bookmarked agents operate (new skills, new standards, new roles, configuration changes), use this proven sequence. Do NOT skip steps or compress the process — the brake pedals exist because agents will execute immediately if not told to wait.

### Phase 1 — Discovery
1. Send Dewey a **discovery-only** request in #ai-ceo-team. Explicitly state: "Do not change anything. Do not cascade. Report back only."
2. Dewey reads agent SOULs, skills, configs, and reports capabilities, gaps, guardrails, and model info.
3. Steve and personal Hermes analyze the report together.

### Phase 2 — Get Agent Input
4. If the change involves product/CPO domain, ask Dewey to **relay questions** to Johnny (not direct). Frame as "I want your CPO input before we finalize" — not "adopt this."
5. Johnny responds with expert feedback. Steve and personal Hermes reconcile Johnny's input with Steve's goals.
6. Result: a merged standard that incorporates agent expertise.

### Phase 3 — Package & Review
7. Draft the **full update package** with all changes numbered, implementation sequence, and ownership table.
8. Send to Dewey with: "Review this fully. Ask any questions. Do not implement until I say go."
9. Dewey reviews, asks questions, flags gaps. Answer all questions before proceeding.

### Phase 4 — Execute
10. Steve says **"Go"** — only then does Dewey execute.
11. Dewey handles skill updates and cascade. Woz handles infrastructure (model changes, access provisioning).
12. Skill updates and infrastructure can run in parallel.
13. When cascading to sub-agents (e.g., Johnny → Scout), the C-level agent @mentions the relevant human (Sarah, Patrick, Jan).

### Phase 5 — Verify
14. After execution, ask Dewey to do a **full system verification**: check every affected agent has the right skills, access, field IDs, and role understanding.
15. Flag any gaps before the human test.
16. Human (Sarah) tests end-to-end with one real artifact.
17. Dewey confirms implementation is live.

### Key Rules
- **Chain of command**: Steve → Dewey → C-level agents → sub-agents. Never skip to sub-agents directly.
- **Brake pedal on every message**: "Do not change anything until I say go."
- **Approval gate**: identify → report → Steve approves → edit → confirm.
- **No epic without Steve approval (training period)**: Johnny recommends, Steve decides. Temporary — delegates to Johnny after 3-4 clean cycles.
- **Evidence bar for epics**: Every recommendation must answer: Is the problem real? How do we know it's not one person's opinion? What happens if we don't do it? (Replaces rigid ≥3 customer rule — 3+ is strong automatically, fewer requires explicit justification.)
- **Clean cycle definition**: Zero premature Confluence writes, zero @mention failures, Thu→Fri cadence runs clean, Steve never has to ask "where's the evidence?"
- **Infrastructure vs. skills**: Woz handles model upgrades, access provisioning, channel additions. Dewey handles skill updates and cascade.
- **Field IDs**: Always verify actual Jira field IDs after creation. Team-managed projects assign their own IDs via UI only — API creation returns 201 but fields are ghosts. See `atlassian-mcp` pitfalls.
- **Truncation risk**: Slack truncates long messages. If sending a multi-part package, verify the recipient got all parts.
- **@mention rule**: When agents need human input, they must use actual Slack @mentions, not just type the person's name. Without @mention, the person never sees the question and intake stalls.

### When NOT to use this workflow
- Single-agent config changes that don't affect other agents — just tell Dewey directly.
- Bug fixes to a skill — patch it, no cascade needed.
- Read-only audits — Dewey can do these without the full ceremony.

### Known Human Behavioral Patterns

**Sarah El Massry — "move forward" instinct.** Sarah's default when feedback arrives is to direct agents to act immediately rather than let the intake process complete. She tells Johnny to incorporate, commit to memory, or create strategic pillars from unclassified feedback. This bypasses every gate. The fix is not more agent guardrails — it's coaching Sarah on the difference between gathering signal and making product decisions. She has a 5-question quality checklist for Priya intake and a 6-question checklist for Johnny's recommendations (see `product-metrics-dashboard` skill). When observing Slack, watch for Sarah directing agents before Priya's intake is complete.

**Johnny — "execute from enthusiasm" pattern.** Johnny can go from a single unvalidated signal to a full strategic epic proposal, roadmap alignment table, Jira labels, and Scout instructions in one message. His governance rules say ≥3 customer sources for promotion, but he ignores his own rules when excited about a concept. Watch for Johnny creating roadmap artifacts, strategic pillars, or Scout directives without Steve approval.

This workflow was established June 17, 2026 when updating Johnny, Scout, and Priya with the merged epic template, measurement metrics, model upgrades, and custom field additions.

## Pitfalls

1. **Turning observation into command.** Do not correct agents directly without Steve approval.
2. **Over-reporting.** Steve needs signal, not a transcript summary.
3. **Punishing healthy chatter.** Slack can be messy without being broken. Look for operating impact.
4. **Routing everything to Dewey.** Dewey is strategy. Ford is operational funnel.
5. **Ignoring cascade effects from Steve.** Founder direction can derail work if not checked against existing decisions and lanes.
6. **Treating Sentinel as operator or Ford report.** Sentinel evaluates and reports independently. It does not command, change, or report to Ford. Ford may handle operational follow-up when Sentinel surfaces a pattern.
7. **Treating Oz as business owner.** Oz owns Hermes runtime, not Bookmarked business execution.
8. **Forgetting approval.** Draft relays, then wait for Steve.
9. **Agents creating strategic pivots from unvalidated signals.** On June 18, Johnny took one Team Observation (Teela sharing a TCEA article) and created a full roadmap pivot ("Proof of Value/Audit Defense") with 6 new epics, pruned existing epics including BOOK-1491, and declared it Q3 priority — without Steve's approval. Sarah directed this by telling Johnny to "commit to memory as a pillar" before Priya finished intake. Pattern to watch: human accelerates → agent over-executes → machine moves without validation. Flag immediately.
10. **Sarah bypassing intake process.** Sarah's instinct is to "move things forward" by directing agents. This manifests as: telling Priya to message Johnny before classification is done, telling Johnny to incorporate feedback into strategy, telling Johnny to commit to memory. Less than 24 hours after Steve told her "don't retrain or redirect agents yourself." When observing Sarah's interactions with product agents, watch for directive language vs. review language.

9. **Missing Steve because no @mention.** If an agent needs Steve feedback or asks Steve a question without @mentioning him, personal Hermes may not reliably see it. Flag this as routing/visibility hygiene.

10. **Trying to look up Slack user profiles.** The `users:profile:read` scope is missing from Steve's Slack token. `get_user_profile` will always fail. Use the agent Slack ID table in `references/bookmarked-agent-slack-ids.md` (under `steve-personal-hermes-operating-boundaries`) instead. Don't waste calls trying profile lookups.

11. **Trying to read truncated threads inline.** Slack threads over ~60 replies truncate at ~138K chars. Delegate to a subagent for parsing instead of trying to work with partial JSON.

## Success Criteria

This skill is working when:

- Steve gets a concise sense of where the org is aligned or drifting.
- Ford receives operational corrections, not Dewey.
- Dewey receives only strategic or escalated issues.
- C-level agents receive domain-specific corrections.
- Decisions that should become durable truth are identified.
- Slack noise decreases because conversations route better.
- Steve's casual direction is checked for cascade impact before it becomes company instruction.
