---
name: slack-daily
description: "Use when Steve wants a private daily Slack action queue across selected Bookmarked Slack channels. Surfaces what needs response, routing, source-of-truth update, watch, or ignore."
version: 1.0.0
author: Hermes Agent
tags: [slack, daily, steve, bookmarked, action-queue, alignment, agents]
related_skills: [bookmarked-org-alignment-observer, steve-mediated-relay, steve-personal-hermes-operating-boundaries]
---

# Slack Daily

Slack Daily is Steve's private Slack action queue.

It is not a Bookmarked channel. It is not a company-wide digest. It is not a dashboard.

It answers one question:

**What does Steve need to see, answer, approve, route, or ignore in Slack?**

Default delivery is private to Steve through personal Hermes. Do not post this digest to Bookmarked Slack unless Steve explicitly asks.

## Required Skills

Load first:

1. `steve-personal-hermes-operating-boundaries`
2. `bookmarked-org-alignment-observer`
3. `steve-mediated-relay` if drafting replies or relays

## Core Principle

Keep the work in the original Slack channel/thread.

Do not centralize all discussion into a new feedback channel. That strips context and creates duplicate work.

The pattern is:

Agents/humans work in the right channel → if Steve is needed, they @mention Steve → personal Hermes scans selected channels → Slack Daily gives Steve the action queue → Steve approves replies/relays → personal Hermes posts only approved messages.

## Default Channel Set

Start narrow. Expand only when needed.

| Channel | ID | Why |
|---|---|---|
| `#ai-ceo-team` | `C0AR85TMVS8` | C-level alignment, Dewey/Ford handoffs, strategic/operating doctrine |
| `#product-feedback` | `C0AMSNW8YSZ` | Customer/product feedback intake, Priya/Product loop |
| `#hermes-help` | `C0B13JX0C9M` | Agent training / Hermes usage questions |
| `#book-intelligence` | `C0ATQ7AGFJT` | Book Intelligence product/data priority |
| `#renewal-gtm-alignment` | `C0B993ADWRM` | Renewal sprint, IMTA, GTM alignment |
| `#agent-feedback` | `C0ANAL9DSMU` | Note: topic currently says IT requests only, not agent behavior. Treat as Woz/IT signal unless channel purpose changes. |

Optional later:
- `#client-success`
- `#sales_revenue-ninjas`
- `#ticket-creation`
- `#product-prioritization`
- `#ai-ui-ux`
- `#hubspot-cleanup`

## What To Collect

### 1. Needs Steve

A thread/message belongs here if:
- Steve is @mentioned
- someone asks for Steve's feedback, answer, approval, or decision
- an agent is blocked waiting on Steve
- a decision has founder gravity or cascade risk
- a thread needs Steve because it crosses lanes or changes direction

### 2. Needs routing

A thread/message belongs here if:
- it is in the wrong channel
- operational work went to Dewey instead of Ford
- domain-specific work missed the C-level owner
- runtime/tooling issues missed Oz/Woz
- agent evaluation/drift did not go to Sentinel
- no owner is clear

### 3. Needs source-of-truth update

A thread/message belongs here if:
- a Slack decision should become Confluence truth
- GitHub work needs a Confluence contract for humans/agents
- a claim lacks source citation
- an artifact is in a private workspace but needed by others
- a Confluence page is stale or missing

### 4. Watch only

A thread/message belongs here if:
- a pattern may be emerging but evidence is thin
- messy Slack is not yet creating operating impact
- there is a hunch but no action needed

### 5. Ignore / no action

A thread/message belongs here if:
- it is healthy chatter
- agents are aligned and no Steve response is needed
- the right owner is already handling it
- the thread has closed cleanly
- it is routine gateway noise such as “Gateway restarting,” “Gateway online,” or “Hermes is back and ready,” unless the user specifically asks about runtime health

## Output Format

Keep it short. Steve needs signal, not a Slack transcript.

```
Slack Daily

Window:
Channels checked:

Needs Steve
1. [Channel/thread]
   Who needs Steve:
   What they need:
   Recommended response:
   Risk if ignored:
   Evidence:

Needs routing
1. [Channel/thread]
   What happened:
   Correct route:
   Suggested correction:
   Draft relay, if needed:

Needs source-of-truth update
1. [Channel/thread]
   Slack decision / artifact:
   Correct system of record:
   Suggested update:

Watch only
- Pattern:
  Why watching:
  Confidence:

Healthy / no action
- Good signal:

Draft replies for approval
1. Target:
   Channel/thread:
   Draft:
   Approval needed before posting.
```

## Confidence Levels

Use confidence on observations:

- **High** — explicit Slack evidence, repeated pattern, or direct source.
- **Medium** — likely pattern from limited evidence.
- **Low** — hunch; watch only.

Never over-correct from low-confidence evidence.

## Action Thresholds

Use four action levels:

1. **Observe only** — minor messiness, no operating impact.
2. **Mention to Steve** — possible drift or pattern worth awareness.
3. **Draft relay** — clear operating impact, repeated issue, missing owner/source/proof.
4. **Escalate urgently** — customer trust, data integrity, public-facing content, financial/legal risk, irreversible action, agent runaway behavior.

## Follow-Through Status

If Slack Daily previously surfaced an item, track status:

- **Open** — surfaced, no action yet.
- **Routed** — Steve approved/relay sent.
- **Acknowledged** — owner/agent confirmed.
- **Resolved** — proof artifact/source-of-truth update exists.
- **Stale** — no movement; needs nudge or closure.

Loop is not closed when a message is sent. It closes when the owner acknowledges, the artifact/source of truth is updated if needed, and no further action is required.

## Drafting Replies

If a reply is needed, draft in Steve's voice and follow `steve-mediated-relay`:

- Show target
- Show channel/thread
- Show identity
- Show exact message
- Ask approval
- Do not post until Steve approves

## Source-of-Truth Rule

Use the standard from `bookmarked-org-alignment-observer`:

- Slack = real-time coordination
- Confluence = contract / operating surface for humans and agents
- GitHub = build + provenance
- G-Brain = registry and recall

Flag any Slack decision that needs to become durable Confluence truth.

## Cadence Recommendation

Manual first.

After a few useful manual runs, automate:

- Morning Slack Daily: after morning brief, focused on what Steve needs to answer today.
- Afternoon Slack Sweep: short pass near end of day, only urgent/Steve-needed items.

Do not run every 10 minutes. That creates noise.

## Pitfalls

1. **Creating a new dumping-ground channel.** The goal is a private action queue, not a new place for everyone to post.
2. **Summarizing everything.** Steve needs only what requires response, routing, source-of-truth update, or watch.
3. **Posting without approval.** Draft replies only.
4. **Ignoring original context.** Keep work in the original thread/channel.
5. **Treating every @mention as urgent.** Classify importance and risk.
6. **Missing non-mentions with cascade risk.** Some threads need Steve even if nobody tagged him. Surface those separately.
7. **Letting watch items become action items too early.** Low-confidence hunches are for watching.

## Success Criteria

Slack Daily is working when:

- Steve can quickly see everything he needs to respond to in Slack.
- Steve spends less time hunting through channels.
- Agents learn to @mention Steve when they need him.
- Decisions that matter get moved from Slack to Confluence.
- Ford/Dewey/C-level routing improves.
- Personal Hermes drafts replies, but Steve remains the approval gate.
