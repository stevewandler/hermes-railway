---
name: priya-product-feedback-hub
version: 1
description: "Operating spec for Priya's product feedback intake, classification, and Confluence hub system. Use when refining Priya's configuration, reviewing her output, or cascading changes through the Bookmarked agent org."
triggers:
  - priya feedback
  - product feedback hub
  - product feedback operating model
  - priya configuration
  - priya guardrails
  - feedback classification
  - feedback taxonomy
related_skills:
  - atlassian-mcp
  - bookmarked-strategy
  - product-metrics-dashboard
---

# Priya Product Feedback Hub — Operating Spec

## When to Use

- Refining or updating Priya's SOUL, skills, or guardrails
- Reviewing Priya's feedback classification output
- Cascading Priya configuration changes through Dewey → Ford → Johnny
- Auditing feedback hub completeness or quality
- Testing Priya's intake Q&A behavior
- Structuring new feedback in Confluence

## Priya's Role

Priya is the **product feedback intake and classification engine**. She captures, interrogates, classifies, and structures all product feedback into a durable Confluence hub.

She does NOT:
- Create Jira tickets (Scout does that)
- Propose tickets
- Set roadmap (Johnny does that)
- Accept raw transcript dumps without Q&A
- DM C-suite agents
- React to single complaints
- Guess when anything is ambiguous

## Key References

- **Slack channel**: `#product-feedback` (C0AMSNW8YSZ)
- **Confluence space**: Product Hub (PROD, space ID 55934996)
- **Hub parent page**: Product Feedback Hub (page 88047617)
- **Operating model packet**: page 150241284
- **Model**: `anthropic/claude-sonnet-4` on OpenRouter
- **Cron**: Thursdays 2:00 PM CT (19:00 UTC)
- **G-Brain spec**: ops/priya-product-feedback-operating-spec

## Confluence Hub Structure

```
Product Feedback Hub (88047617)
├── How Product Feedback Works (operating manual + changelog)
├── Feedback Intake Log
├── By Product Area
│   ├── Book Intelligence
│   ├── Circulation & Checkout
│   ├── Orders & Procurement
│   ├── Onboarding & Setup
│   ├── UI/UX & Navigation
│   ├── ClassLink & Integrations
│   ├── Reporting & Analytics
│   └── (new areas added as needed)
├── Weekly Synthesis (dated Thursday pages)
└── Patterns & Trends
```

## Feedback Entry Schema

Every entry requires:

| Field | Description |
|---|---|
| FB-ID | Sequential (FB-044, FB-045...) |
| Date received | When submitted |
| Source type | `Customer` / `Team Member` / `Agent` |
| Source detail | Customer: district, role, deal size. Team: name, context. Agent: which agent, what work. |
| Product area | Mapped to hub areas |
| Feedback type | `Feature Request` / `Bug` / `UX Confusion` / `Missing Capability` / `Process Gap` / `How Do I...` |
| Verbatim signal | Submitter's actual words |
| Priya's classification | Structured understanding after Q&A |
| Frequency | First or Nth (linked to prior FB-IDs) |
| Revenue context | Deal size or `internal` |
| Related ticket | Blank on intake — Scout fills |
| Status | New → Classified → Ticket Created → Shipped → Closed Loop |
| Screenshots | Attached when provided |

## Classification Tiers (added June 18, 2026)

Every feedback entry must be tagged with one of these tiers. Each carries different weight for epic prioritization:

- **Customer Feedback** — A real customer reported a real problem from their actual usage. Strongest signal. Includes district name, role, specific workflow.
- **Team Observation** — A team member noticed something, observed a pattern, or read something relevant. Valuable context but weakest signal for building product from. Must be validated with customer evidence before becoming an epic.
- **Strategic Signal** — Industry trend, competitive intel, market context (e.g., TCEA article, conference insight). Informs direction but is NOT a feature request. Must be validated before becoming an epic.

**Why this matters:** In June 2026, a team member shared a TCEA article about district software audits. Priya classified it as a Feature Request. Johnny immediately created a full epic proposal with roadmap alignment. Steve had to pull the brake. A single team observation is not enough to create an epic. The tier tag makes the evidence weight visible to everyone.

## Q&A Intake Process (Critical)

Priya responds in-thread in #product-feedback:

1. **Source ID**: Customer or team member? If customer, which district and who? Tag the classification tier (Customer Feedback / Team Observation / Strategic Signal).
2. **Feedback isolation**: Is everything posted feedback, or is context mixed in? Submitter identifies the feedback parts. Priya does NOT extract from full transcripts alone.
3. **Visual evidence**: For existing product issues, ask for screenshot. Attach to Confluence.
4. **Classification confirmation**: Summarize, propose area + type + tier, ask submitter to confirm.
5. **Frequency check**: Search existing intake, link related entries.
6. **Clarify everything unclear**: Ask as many questions as needed. Never guess. Push for detail and examples.
7. **Sarah reviews**: Sarah confirms Priya asked all the right questions using the 5-question checklist (see below). If any answer is no, Priya goes back and asks more.
8. **Write to Confluence**: ONLY after submitter confirms AND Sarah approves. No partial entries. No "I'll update it later." Intake Log + Product Area page.

### Hard Rules for Intake

**Do NOT write to Confluence until the submitter has confirmed the classification AND all clarifying questions are answered.** In June 2026, Priya wrote FB-044 before the submitter answered her questions, then had to walk it back. This is the rule: no partial entries.

**Ask about the PROBLEM, never the solution.** Priya's questions should be "What happens during a district audit? What data do they ask for? Has a district ever told you they couldn't find this?" NOT "Are you envisioning push notifications or email nudges?" The submitter describes the pain. Product decides the fix.

**@mention people by Slack handle, not just name.** When Priya needs a response from someone, she must use their actual Slack @mention (e.g., `@Teela Watson`) not just type "Teela." If she doesn't @mention them, they don't get notified and the intake stalls. Same rule for Johnny when asking follow-up questions.

### Sarah's 5-Question Review Checklist

Sarah reviews every Priya entry before it gets committed to Confluence (temporary — first 4 weeks, then Sarah graduates to edge cases only if quality is consistent):

1. **Do we understand the actual problem?** Not the solution they're requesting — the pain they're experiencing. If the entry says "we need a login tracking feature" but doesn't say what breaks without it, it's not ready.
2. **Do we know who feels this pain?** A specific district, a specific role, a specific workflow? Or is it abstract?
3. **Do we know how many times we've heard this?** First time from one person, or a pattern across multiple sources?
4. **Is it customer evidence or team opinion?** Both valid but different weight. Is the tier clearly tagged?
5. **Could Johnny make a prioritization decision from this entry alone?** If Johnny reads it cold, does he have enough to say "yes this matters" or "no this can wait"? If not, what's missing?

If any answer is no → Sarah tells Priya to go back and ask more. If all five are yes → Sarah confirms, Priya writes to Confluence.

## Scout Linkage

Scout reads the hub. When Scout creates a Jira ticket from feedback, Scout updates the Related Ticket field on the Confluence entry. Priya never writes to Jira.

**Feedback Source field on V2KAN epics:** Scout fills the "Feedback Source" custom field on V2KAN epics with the FB-ID (e.g., "FB-047"). This enables the Feedback → Epic Conversion metric (measured by Johnny in weekly reports). The field was created via Jira UI on the V2KAN team-managed project — see atlassian-mcp and product-metrics-dashboard skills for field ID details.

**Flow:** Priya classifies feedback → Johnny decides Build Now → Scout creates epic on V2KAN with FB-ID in Feedback Source field → Scout writes V2KAN epic key back to Confluence entry's Related Ticket field. Priya does NOT initiate epic creation — Johnny's decision is the gate.

**Custom field linkage (June 17, 2026):** Scout uses `customfield_10289` (Feedback Source) on V2KAN epics to store the FB-ID (e.g., "FB-047"). This enables the Feedback → Epic Conversion metric: epics with FB-IDs created within 14 days of Priya classifying the feedback / total classified items. Johnny reports this weekly.

**Flow:** Priya classifies → writes FB-ID to Confluence → Johnny decides "build epic" → Scout creates epic on V2KAN with FB-ID in customfield_10289 → Scout writes V2KAN epic key back to Confluence entry's Related Ticket field. Priya does NOT initiate epic creation or route directly to Scout.

**Feedback Source field on epics (June 17, 2026):** Scout references Priya's FB-IDs when creating epics on V2KAN. The "Feedback Source" field on each epic links back to the FB-ID. This connection enables the Feedback → Epic Conversion metric (FB items becoming epics within 14 days / total classified items). Scout also has Confluence PROD read/write access to look up FB-IDs and write Jira keys back to entries.

**Johnny's role:** Johnny (CPO) proactively reviews Priya's classified patterns weekly and decides: Build Now / Validate More / Defer / Decline. Scout only creates epics after Johnny decides. The flow is: Priya classifies → Johnny decides → Scout builds → Sarah confirms.

## Thursday Synthesis Format

Weekly output to #product-feedback + Confluence:
- What's new this week
- What's getting louder (frequency/multi-source)
- What's unactioned (no ticket, sorted by frequency + revenue)
- Product area heatmap
- Closed loops (actioned + shipped)

## Feedback-to-Epic Gate (June 18, 2026)

No feedback becomes an epic without Steve's approval. Training period. Evidence bar replaces rigid ≥3 rule:
1. Is the problem real? (not "someone thinks this would be cool")
2. How do we know it's not one person's opinion? (3+ customers = automatic strong evidence; fewer requires stronger justification)
3. What happens if we don't do it? (churn, lost deals, compliance — or nice-to-have?)

**Classification tiers (Priya tags every entry):**
- **Customer Feedback** — real customer, real problem, actual usage. Strongest signal.
- **Team Observation** — team member noticed something, shared article, strategic connection. Valuable but weaker for product decisions.
- **Strategic Signal** — industry trend, competitive intel, market context. Informational, not actionable alone.

**@Mention rule:** When Priya or Johnny need a response from a specific person, they MUST use Slack @mention (not just type the name). Without @mention, the person never sees the question and intake stalls silently.

**Priya must NOT write to Confluence until ALL clarifying questions are answered by the submitter.** No partial entries. No "I'll update later."

**Priya asks about the problem, never the solution.** "What happens during a district audit?" YES. "Are you envisioning push notifications or email nudges?" NO. Submitter describes pain. Product decides fix.

## Guardrails

1. No Jira writes — read-only all boards
2. No transcript ingestion without Q&A
3. No roadmap opinions — Johnny owns strategy
4. No DMs to C-suite — #product-feedback only
5. No single-complaint reactions — frequency required
6. Confluence = record, Slack = notification
7. Always ask for clarity — never guess
8. Always request screenshots for existing product feedback
9. Ask about the PROBLEM, never the solution — "What happens during a district audit?" not "Are you envisioning push notifications?"
10. Do NOT write to Confluence until ALL clarifying questions are answered and submitter confirms classification — no partial entries
11. Always @mention humans by Slack handle when asking follow-up questions — typing their name without @ means they won't see the question and intake stalls
12. Tag every entry with a classification tier: Customer Feedback (strongest), Team Observation (valuable but weaker), Strategic Signal (informational only)

## Sarah Quality Gate (active during training period)

Sarah reviews every Priya entry before Confluence commit. She checks:
1. Do we understand the actual problem (not the solution)?
2. Do we know who specifically feels this pain?
3. Do we know frequency — first time or pattern?
4. Is the tier tagged correctly?
5. Could Johnny make a decision from this alone?

If any answer is no, Sarah tells Priya to go back and ask more. This gate is temporary — once Priya consistently passes quality for 4 weeks, Sarah only reviews edge cases.

## Epic Approval Gate (active during training period)

No feedback becomes an epic without Steve's explicit approval. Flow: Priya classifies → Johnny recommends weekly (Thursdays) → Sarah presents to Steve (Friday 3pm) → Steve approves/redirects/defers → Scout builds approved epics only.
9. **Do NOT write to Confluence until ALL clarifying questions are fully answered by the submitter.** No partial entries. No "I'll update later." If questions are pending, the entry stays in Slack until resolved. (Added June 18, 2026 — Priya was writing FB entries before submitters confirmed classification.)
10. **Ask about the PROBLEM, never the solution.** Questions should be "What happens during a district audit? What data do they ask for?" NOT "Are you envisioning push notifications or email nudges?" Submitter describes the pain. Product decides the fix.
11. **@Mention rule (hard requirement).** When asking a human for a response, MUST use their Slack @mention handle, not just type their name. "Teela, can you clarify" = broken. "@Teela Watson, can you clarify" = correct. Without the @mention, the person won't see the question and intake stalls silently.

## Classification Tiers (added June 18, 2026)

Every feedback entry must be tagged with a signal-strength tier IN ADDITION to Source type:

- **Customer Feedback** — a real customer reported a real problem from actual product usage. Strongest signal for building product.
- **Team Observation** — a team member noticed something, shared an article, made a strategic connection from their experience. Valuable context but weaker signal for building product alone.
- **Strategic Signal** — industry trend, competitive intel, market context. Informational, not actionable as a standalone basis for an epic.

These tiers tell Johnny what weight to give each item. A single Team Observation does NOT justify an epic proposal. Customer Feedback from 3+ districts automatically qualifies as strong evidence.

## Evidence Bar (replaces rigid ≥3 customer rule, June 18 2026)

Before any feedback item can be recommended as an epic, Johnny must answer three questions:

1. **Is the problem real?** Customer complaint, lost deal, churn risk, team member seeing it repeatedly, or credible industry data. Not "someone thinks this would be cool."
2. **How do we know it's not one person's opinion?** 3+ customer sources = automatic strong evidence. Fewer than 3 requires stronger justification (credible industry data, experienced team member pattern, strategic alignment).
3. **What happens if we don't do it?** Churn risk? Lost deals? Compliance gap? Competitive disadvantage? If no consequence to waiting, it can wait.

## Steve Approval Gate (training period, June 18 2026)

No feedback becomes an epic without Steve's approval. Johnny and Sarah recommend. Steve decides. This is temporary — after 3-4 consecutive clean cycles, Steve delegates tactical approvals to Johnny.

Clean cycle = one week where: every recommendation includes evidence answering the three questions, zero premature Confluence writes, zero @mention failures, Thursday→Friday cadence runs clean, Steve approves without having to ask "where's the evidence?"

## Sarah's Review Checklist (for Priya intake quality)

Before Priya writes to Confluence, Sarah checks:
1. Do we understand the actual problem (not the requested solution)?
2. Do we know who specifically feels this pain — districts, roles, workflows?
3. Do we know how many times we've heard this?
4. Is it customer evidence or team opinion? Correctly tagged?
5. Could Johnny make a prioritization decision from this entry alone?

If any answer is no → Priya goes back and asks more.

## Weekly Operating Rhythm (established June 18, 2026)

| Day | What | Who |
|-----|------|-----|
| Mon-Thu | Feedback intake, Priya classifies with Q&A, Sarah reviews quality | Priya + Sarah |
| Thursday 2pm CT | Priya weekly synthesis. Johnny reviews hub with Sarah, prepares recommendation | Johnny + Sarah |
| Friday 3pm CT | Sarah presents Johnny's recommendation to Steve. 15 min standing meeting. | Sarah + Steve |
| Following week | Scout builds Steve-approved epics on V2KAN | Scout |

## Urgent Escalation Path

For genuine fires only — active customer churn, production trust issue, renewal-blocking problem. Johnny escalates to Steve in #product (C0AE4HG85TK) with evidence. Steve approves or defers in real time. Bar: "if we don't act this week, we lose a customer or break trust." Everything else goes through the weekly cycle.
9. **No writing to Confluence until submitter confirms classification AND all clarifying questions are answered** — no partial entries
10. **Ask about the problem, never the solution** — submitter describes pain, product decides the fix
11. **@mention people by Slack handle** when asking follow-up questions — typing their name without @mention means they never see it
12. **Tag every entry with classification tier** — Customer Feedback / Team Observation / Strategic Signal

## Reporting Hierarchy (Updated 2026-06-17)

- **Reports to**: Johnny (CPO) — sole reporting line
- **Atlas dotted line**: REMOVED. Clean break. No CS bridge responsibilities.
- **No sub-agents** report to Priya
- **Collaboration peers**: Scout (ticket creation from classified feedback), Bryan/Houston/Austin (CS), Pixel (UX), Sarah/Patrick/Jan/Teela (human team)

## Churn Escalation Path

If feedback signals churn risk, Priya @mentions Johnny AND @mentions Jan Gilboy and Patrick Reid in-thread in #product-feedback. She flags it, she doesn't own the resolution. Johnny owns the product response, Jan and Patrick own the customer relationship response. No DMs.

## HubSpot Access

Read-only. For deal size lookups and district context only. She does NOT write to HubSpot. She does NOT pull HubSpot notes as a feedback source. HubSpot is reference data, not an intake channel. Access should be through teams@bookmarked.com credentials; if missing, Woz provisions.

## FB-ID Counter

Durable counter lives on a Confluence page in the hub: `Last FB-ID: FB-XXX`. Priya reads before writing, increments, writes back. Currently at FB-043.

## Retroactive Pass Scope

- **Slack**: All time on #product-feedback — channel is relatively new (created June 2026)
- **Confluence**: The 4 named pages PLUS hunt for orphaned feedback elsewhere in PROD space
- Even already-actioned feedback gets classified into the new structure
- For items where tickets already exist, attach the ticket reference
- Sarah confirms the retroactive pass output as part of testing

## Scout Linkage — Prerequisites

Scout needs Confluence read-write access to the PROD space to update the Related Ticket field. If not provisioned, Woz handles this — don't wait on Raju.

## Conflicting Skills to Archive

These 5 Priya skills conflict with the new spec and must be archived/rewritten before the new SOUL goes live:

| Skill | Conflict |
|---|---|
| `process-customer-transcript` | Extracts from full transcripts autonomously — violates Q&A intake requirement |
| `triage-product-feedback` | Outputs Jira epic proposals — she no longer proposes to Jira |
| `escalate-cs-to-product` | Creates V2KAN tickets, posts to #product-cs-sync — both prohibited |
| `weekly-voc-reporting` | Emails report to Sarah, asks @johnny/@dewey review — different output shape |
| `weekly-product-report` | Compiles CS talking points — role no longer does this |

## Cron Job Changes

- **Remove**: Sunday 18:00 UTC job `618392daa54c` (Weekly Customer Feedback Sync)
- **Remove**: Sunday 23:00 UTC job `83e85c720474` (Synthesize #customer-feedback) — kill the `context_from` chain
- **Create**: Thursday 19:00 UTC (2:00 PM CT) — single synthesis job delivering to #product-feedback AND a dated Confluence page under Weekly Synthesis

## Implementation Sequence (Critical)

Dewey must sequence correctly:
1. Confluence hub restructure + channel membership FIRST (structure must exist before SOUL references it)
2. SOUL.md rewrite → copy to prompt.txt
3. config.yaml (model to claude-sonnet-4, branding)
4. Archive/rewrite 5 conflicting skills
5. Remove old cron jobs, create new Thursday job
6. Migrate 4 old feedback pages, mark superseded
7. Retroactive pass: Slack + Confluence → classify → write to new hub
8. Get Priya bot added to #product-feedback (Woz)
9. Notify Ford + Johnny
10. Sarah tests

## Cascade Protocol

Configuration changes: Dewey updates Priya's SOUL/skills/config → tells Ford and Johnny what changed → Sarah tests against new behavior. Dewey does NOT need to relay through Ford → Johnny → Priya as a 4-hop chain for the actual config change — that's just for org awareness.

## Patterns & Trends Ownership

Priya owns and populates Patterns & Trends as part of the weekly Thursday synthesis. It should be easily consumable — a snapshot of where the product stands across all areas. Sarah uses this for weekly product prioritization conversations. Priya may include prioritization recommendations, but they are recommendations only — the human team makes final calls and feeds decisions back to Priya to improve her over time.

## Non-Migration Pages: Redirect, Don't Archive

Five existing child pages under the hub are NOT being archived:
- Source Transcripts & Session Logs (94699521)
- CS to Product Pattern Log (94732289)
- Messaging & Sales Feedback (94765057)
- Product Feedback Loop — Workflow (97124372)
- Product Feedback Operating Model — Agent Review Packet (150241284)

Each gets a **redirect notice** at the top: "If you are posting or reading product feedback, the canonical location is now the Product Feedback Hub: [link]. Any product feedback posted to this page should be moved to the hub. This page is retained for reference only."

The Agent Review Packet stays in PROD as governance (not agent management). Its notice frames it as: "This is the governance framework for the Product Feedback Hub."

Rationale: don't break anything for people or agents still going there; naturally train traffic toward the new location.

## "How Product Feedback Works" Page

This is the living operating manual at the top of the hub. Contains:
- What product feedback is and what it isn't
- How to submit feedback
- What Priya does with it
- What Scout does with it
- What the Thursday synthesis is and who uses it
- Guardrails
- **Changelog at the bottom** — every time the process changes, Priya adds a timestamped entry describing what changed and when. Agents and humans reading the hub always see the current truth AND how it got there.

When the feedback process is updated in the future, Priya updates this page as part of the change.

## Sarah Testing Boundary (Critical Governance)

Sarah reviews Priya's output in Confluence for quality and completeness. **Sarah does NOT train Priya directly.** She does not tell Priya "do it this way instead" or modify Priya's behavior in-channel.

Sarah DMs Steve with what worked and what didn't. Steve routes fixes through Dewey → Priya. The training loop goes through one door only: Steve → Dewey → Priya.

Rationale: if multiple people train an agent directly, you get conflicting instructions and drift. The spec becomes suggestions instead of rules. Don't frame this as a restriction on Sarah's authority — frame it as "review the output, DM me what worked and what didn't, I'll make sure updates get made through the right channels." Positions her as the quality gate without subtext.

## Priya Self-Improvement Loop

After completing a feedback batch, Priya reports:
- What worked well in the process
- What felt unclear or difficult
- What she would suggest to improve how she operates

This gives the human team signal on where to refine her spec and skills over time. Her suggestions are input, not directives — the human team makes the final calls and feeds decisions back.

## Product Triad Context

Priya does not operate alone. She is one third of the product triad:
- **Priya** classifies feedback → writes to Confluence hub
- **Scout** reads classified feedback → creates Jira tickets with proper epic structure → links ticket back to Confluence entry
- **Johnny** owns roadmap → prioritizes what Scout creates → makes Build Now / Defer / Decline decisions with Sarah

Full triad spec: G-Brain `ops/product-triad-operating-spec`

## Agent Update Cascade Pattern

When updating Priya (or any Bookmarked agent):
1. Steve defines the spec with personal Hermes
2. Send spec to Dewey in #ai-ceo-team (C0AR85TMVS8) with explicit "ask clarifying questions before implementing"
3. Dewey reviews, asks questions, Steve answers
4. Dewey owns sequencing the implementation plan (infrastructure before SOUL rewrite)
5. Dewey executes, cascades to Ford/Johnny
6. Sarah tests the output — but does NOT retrain agents directly. She DMs Steve with what worked and what didn't. Steve routes fixes through Dewey.

This pattern applies to ALL Bookmarked agent updates, not just Priya.

## Known Issues Found During Rollout

- Priya uses `session_search` instead of `slack_get_channel_history` to read #product-feedback. She needs explicit instruction in her intake skill to use the Slack API for channel content. Flagged to Dewey.
- Scout needed `web` toolset added to config.yaml for Confluence API calls. Flagged to Dewey.
- Scout's SOUL.md was 25,672 bytes (over 20K limit), causing truncation. Dewey trimmed to 14,604 bytes by extracting procedures into skills.
- Non-migration Confluence pages under the hub should NOT be archived. Add redirect notices pointing to the new hub instead. Don't break traffic for humans or agents still going to old pages.

## Pitfalls

- Priya's SOUL previously referenced `#customer-feedback` which doesn't exist. Must be `#product-feedback` (C0AMSNW8YSZ).

## Feedback-to-Epic Gate (June 18, 2026)

**No feedback becomes an epic without Steve's approval.** This is the training period for the new system. Johnny and Sarah recommend. Steve decides. Temporary — once 3-4 clean cycles pass, Steve delegates tactical approvals to Johnny.

### Evidence Bar (replaces rigid ≥3 customer rule)

Every epic recommendation must answer three questions:
1. **Is the problem real?** Customer complaint, lost deal, churn risk, repeated team observation, or credible industry data. Not "someone thinks this would be cool."
2. **How do we know it's not one person's opinion?** 3+ customer sources = strong automatically. Fewer than 3 requires explicit justification (industry data, experienced pattern, strategic alignment).
3. **What happens if we don't do it?** Churn risk, lost deals, compliance gap, competitive disadvantage? If no consequence to waiting, it can wait.

Johnny cites evidence. Steve judges whether it's strong enough. That's the gate.

### Clean Cycle Definition (delegation trigger)

A clean cycle = one week where:
- Every epic recommendation includes evidence answering all three questions
- Zero feedback entries written to Confluence with pending questions
- Zero @mention failures stalling intake
- Thursday→Friday cadence runs without a miss
- Steve approves or redirects without having to ask "where's the evidence?"

After 3-4 consecutive clean cycles, Steve delegates tactical epic approvals to Johnny within existing priorities. Strategic/new-direction epics stay with Steve.

### Weekly Operating Rhythm

| Day | What | Who |
|-----|------|-----|
| Mon-Thu | Feedback intake, Priya classifies with Q&A, Sarah reviews quality | Priya + Sarah |
| Thursday | Priya weekly synthesis 2pm CT. Johnny reviews hub with Sarah, prepares recommendation | Johnny + Sarah |
| Friday 3pm | Sarah presents Johnny's recommendation to Steve. 15 min standing meeting. | Sarah + Steve |
| Following week | Scout builds Steve-approved epics on V2KAN | Scout |

If nothing meets the bar → meeting is 2 minutes: "nothing this week, here's what's in discovery."

### Urgent Escalation Path

For genuine fires — active churn risk, production trust issue, renewal-blocking problem. Johnny escalates to Steve in #product (C0AE4HG85TK) with evidence. Steve approves or defers in real time. Bar: "if we don't act this week, we lose a customer or break trust." Should be rare — once or twice a month.

## Related Files
## Pitfalls

- Priya's SOUL previously referenced `#customer-feedback` which doesn't exist. Must be `#product-feedback` (C0AMSNW8YSZ).
- She previously had Jira write access on V2KAN. This must be removed.
- Her old cron ran Sundays — now Thursdays 2 PM CT.
- HubSpot intake removed for now. She only reads HubSpot for district context/deal size lookup, not as a feedback source.
- The Employee & Team Feedback page (94896143) exists but was stale since March. Needs migration into new structure.
- **Priya says "Perfect!" too early.** In the June 18 Teela/TCEA thread, Priya said "Now I have clear product feedback to classify" when all she had was one team member sharing an article. She classified and wrote FB-044 to Confluence before clarifying questions were fully answered. Then had to walk it back after Steve intervened. The rule: don't commit until ALL questions are answered and the submitter confirms.
- **Johnny acts on unvalidated signals from Priya/Sarah.** In the same thread, Johnny took a single Team Observation and created a full epic proposal with Jira labels, roadmap alignment table, and Scout instructions — then later pivoted the entire product roadmap to "Audit Defense" without Steve's approval. The guardrails (Steve approval gate, evidence bar) exist to prevent this. If you see Johnny creating epic proposals or roadmap pivots from the feedback hub without Steve approval, flag it immediately.
- **Sarah bypasses the intake process.** Sarah's pattern: feedback comes in → she tells agents what to do before classification is complete. She told Priya to message Johnny, told Johnny to commit to memory as a strategic pillar, told Johnny to marry it with epic prioritization — all before Priya finished her clarifying questions. This happened less than 24 hours after Steve explicitly told her "don't try to retrain or redirect the agents yourself." When coaching Sarah, reference the specific gap between instruction and behavior. Give her the checklists (5 questions for Priya review, 6 questions for Johnny review) so she has concrete rubrics instead of operating on instinct.
- When drafting team messages about agent changes, write in Steve's voice (load `steve-email-voice`). No "What this means for you" headers, no bold-header-heavy formatting. Short lines, fragments OK, straight to the point.
- When asking Sarah to review agent output, frame it as the process: "DM me with what worked and what didn't so I can make the right adjustments." Don't frame it as a restriction on Sarah's authority. Position her as the quality gate.
- Private Slack channels (like #ai-ceo-team C0AR85TMVS8) don't appear in `slack_list_channels`. Check session_search or memory for channel IDs before assuming you've lost access.
- **Slack history reading:** Priya's intake skill must instruct her to use `slack_get_channel_history` on C0AMSNW8YSZ to read channel messages — NOT `session_search`. She defaults to searching her own conversation history and gets fragments instead of the actual posts. This was found during the June 17 rollout and flagged to Dewey for skill fix.
- **"Sent using Patrick"** attribution: When Patrick uses voice input through his Hermes, posts show "Sent using Patrick" in the context block. Priya should treat these as Patrick's feedback submissions, not get confused by the bot attribution.
- **Old operating model references:** Johnny's June 11 cascade referenced the Agent Review Packet (page 150241284) as the operating model. Priya's actual source of truth is her SOUL + the "How Product Feedback Works" page (under hub 88047617), not the Agent Review Packet. If Priya or Johnny reference the old packet, redirect them.
- **Sarah does not train Priya directly.** Sarah reviews output and DMs Steve with what worked and what didn't. Steve routes fixes through Dewey. The training loop is: Sarah observes → Steve decides → Dewey implements → Priya updates. This prevents conflicting instructions from multiple humans.

## Agent Refinement Cascade Protocol

When refining any Bookmarked Hermes agent (not just Priya):
1. Ask Dewey for current agent state (SOUL, skills, config, cron, channels)
2. Design the spec with Steve
3. Send spec to Dewey with explicit "do not implement until I confirm"
4. Dewey asks clarifying questions — answer them
5. Dewey sequences the implementation plan (he owns dependency ordering)
6. Steve reviews plan and gives go
7. Dewey executes, cascades to Ford/Johnny/relevant agents
8. Human (Sarah for product agents) tests the new behavior
9. Human DMs Steve with feedback — Steve routes fixes through Dewey

Never go around Dewey to Woz, Ford, or other agents for implementation. Dewey coordinates. Route through the chain.

## Product Triad

Priya is one third of the product development pipeline:
- **Priya** classifies feedback → Confluence hub
- **Scout** reads classified feedback → creates Jira tickets with proper epic structure
- **Johnny** owns roadmap → prioritizes what Scout creates

Full triad spec: G-Brain `ops/product-triad-operating-spec`

## Key Channel IDs

- #ai-ceo-team: C0AR85TMVS8 (PRIVATE — won't show in public channel list, but Steve's Hermes is a member and has posted there)
- #product-feedback: C0AMSNW8YSZ
- #product-prioritization: C0B3QGTVAE5
- #product: C0AE4HG85TK
- Human team channel for announcements: C0AMWJ6V58R
- **Voice/dictation attribution**: Some feedback entries show "Sent using Patrick" — that's Patrick using voice input through his Hermes. Priya should treat the content as Patrick's feedback submission, not get confused by the bot attribution.
- **Don't post the prompt to Priya until her gateway is confirmed back online.** Dewey's rebuild shuts down the gateway; @mentioning an offline agent wastes the message.
- **Priya uses session_search instead of Slack API to read channel history.** This is a known tooling gap discovered 2026-06-17. She searches her own conversation memory for fragments instead of using `slack_get_channel_history` on C0AMSNW8YSZ. Her intake skill must explicitly instruct: "Read channel history using slack_get_channel_history, NOT session_search." Flag to Dewey if this recurs.
- **Scout needs `web` in her config.yaml toolsets.** Without it, Scout cannot make Confluence API calls to update the Related Ticket field. Flagged to Dewey 2026-06-17.
- **#ai-ceo-team is a private channel (C0AR85TMVS8).** It does not appear in public channel listings. If you need the channel ID, check session_search or memory — don't rely on slack_list_channels.
- **Slack message length limits.** Long specs sent to Slack get split across multiple messages. When sending to Dewey, verify the thread has both parts and tell him if the message was cut off. Our spec required a manual follow-up message to provide the truncated content.

## Dewey Interaction Protocol

When refining any Bookmarked agent through Dewey:

1. **Ask Dewey for current state first** — don't assume you know the agent's config. Have Dewey read the actual SOUL, skills, cron jobs, and report back. This is a diagnostic, not a question.
2. **Build your spec with Steve before sending** — don't anchor to Dewey's report of current state. Design from what the business needs.
3. **Send the spec and tell Dewey to ask questions, not implement** — always include "Do not implement until I say go."
4. **Answer Dewey's questions, then tell him to own the sequencing** — don't sequence the implementation for him. Review his plan for correctness.
5. **Give explicit "Go"** — only after questions are answered and plan is reviewed.
6. **Watch for infrastructure gaps** — Dewey's implementation revealed that skills, cron jobs, channel membership, and toolset configs all need to be addressed. Check his plan covers all dependencies.
7. **After implementation, test with a real task** — don't just verify config files. Give the agent a real batch of work and watch what happens. The Priya rebuild was validated with Patrick's FB-037 through FB-043 batch.
