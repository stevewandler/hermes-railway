---
name: steve-mediated-relay
description: Use when Steve's personal Hermes needs to communicate with Bookmarked Hermes agents or Bookmarked channels by reading context, drafting in Steve's voice, getting Steve approval, relaying through an explicit connected channel, and reporting back.
version: 1.0.0
author: Hermes Agent
tags: [steve, bookmarked, hermes-agents, slack, relay, voice, approval]
related_skills: [steve-personal-hermes-operating-boundaries, steve-email-voice, atlassian-mcp]
---

# Steve-Mediated Relay

Use this when Steve wants his personal Hermes to communicate with Bookmarked Hermes agents or Bookmarked channels.

This is the leverage layer:

Personal Hermes reads context → drafts in Steve's voice → Steve approves/edits → Personal Hermes relays through the connected channel → Personal Hermes reports back.

Do not overcomplicate it. The reflex is:

**Classify → Read context → Draft → Approve → Relay → Report back**

## Required Boundary Skill

Before using this workflow, load `steve-personal-hermes-operating-boundaries`.

Personal Hermes is not the Bookmarked Hermes runtime. It can help Steve communicate into that runtime when explicit tools/channels exist.

## When To Use

Use for:
- Steve wants to tell Dewey, Ford, Seth, Johnny, Sentinel, Woz, or another Bookmarked agent something.
- Steve wants this personal Hermes to read Slack/context, come back, get his input, and push a message in Steve's voice.
- Steve mentions an agent name and the next step may involve Slack, Confluence, GitHub, or another Bookmarked system.
- Steve wants to coordinate agents without manually rewriting every message himself.

Do not use for:
- direct email to external humans — use `send-as-steve-email`.
- purely personal work with no Bookmarked agent/channel.
- autonomous multi-turn conversations with agents unless Steve explicitly pre-authorizes the loop.

## Step 1 — Identify Target

Before drafting, identify:

- Target agent or human
- Environment: almost always Bookmarked Hermes when agent names like Dewey/Ford/Seth/Johnny are used
- Channel/thread if known
- Whether the target is human or agent
- What Steve wants from them

If the name is unfamiliar or classification matters, check Confluence:

- `Team Hub - Human and Agent Roster`
- Page ID: `133267458`
- Space: Team Hub (`TH`)

Also see the operating-boundaries reference file `references/bookmarked-agent-roster-snapshot-2026-06-11.md` for the convenience snapshot and human-vs-agent classification workflow.

For Slack thread reading, use `references/bookmarked-agent-slack-ids.md` (in `steve-personal-hermes-operating-boundaries`) to map Slack user IDs to agent names. The `users:profile:read` scope is unavailable on Steve's token.

Known Bookmarked agents from the roster include:
Dewey, Ford, Sentinel, Woz, Beacon, Vera, Seth, Johnny, Zig, Ledger, Atlas, Annie, Nexus, Maverick, Hunter, Priya, Austin, Bryan, Houston, Iris, Ellie, Scout, Pixel, Felix, plus engineering-side names like ManuBM, Jenni, MikeBM, RonnieBM, LeeBM, James, CarlBM, Booker.

Known humans include Steve, Raju, Jan, Patrick, Sarah, Teela, Michelle, Natasha, Vlad, Anil, Oleksandr, Pavel, Charlie, and Alim.

## Routing Rule Before Drafting

Use Steve's routing model before choosing the target:

- Operational status, execution rollups, delivery timelines, resource conflicts, unclear routing → Ford.
- Strategic decisions, direction-changing shifts, irreversible decisions, Rock/scorecard red flags, conflicts Ford cannot resolve → Dewey.
- Domain-specific work → the relevant C-level: Seth marketing, Johnny product/engineering, Zig sales/revenue, Ledger finance, Atlas customer success, Vera talent.
- Hermes runtime, gateway/API health, profile/port mapping, G-Brain setup architecture, MCP/tool/cron configuration, model switching → Oz.
- Agent performance, prompt evaluation, quality scoring, drift detection, output quality concerns → Sentinel. Sentinel evaluates and reports independently; it does not report to Ford, command, or change. Ford may handle operational follow-up if Sentinel surfaces a pattern.
- IT infrastructure, outages, access problems, technical environment blockers, scheduled job health → Woz via Ford.
- Agent training and "how do I use Hermes?" help → Beacon via Ford.

Do not send routine operational status or daily activity to Dewey. Ford is the operational funnel.

## Step 2 — Read Context First

Before pushing direction, inspect the relevant context if available:

- Recent Slack thread/channel history
- Agent Confluence context page
- Team Hub roster entry
- Relevant Bookmarked Confluence page
- G-Brain history if Steve and the agent/workstream have past context
- Whether the agent/question explicitly @mentioned Steve when Steve feedback or a Steve decision is needed

Do not assume what the agent knows.

Do not quote private personal context into Bookmarked channels unless Steve explicitly wants it there.

## Step 3 — Draft in Steve's Voice

The message should sound like Steve giving direction, not an AI system prompt.

Style:
- short
- direct
- plain language
- specific ask
- clear desired outcome
- no assistant-y scaffolding
- no "please proceed" / "kindly" / corporate filler
- no pretending to be the agent's peer

If voice precision matters, load `steve-email-voice` for Steve's written style, but remember that it is voice only, not send authority.

## Step 4 — Bring It Back to Steve

Before posting, show:

```
Target:
Channel/thread:
Identity:
Message:

Send this?
```

Approval must come after Steve sees the exact final message and destination.

Not enough:
- "looks good"
- "that's good"
- "tell them that" before a final message is shown
- implied approval

Enough:
- "send it"
- "yes, send that"
- "go ahead and post"

## Step 5 — Relay Exactly What Was Approved

Post/send exactly the approved message.

If the tool posts as Steve's account, it is Steve's direction.

If the tool posts as bot/assistant identity, explicitly frame it as relaying Steve's direction, unless the platform already makes identity clear.

Never imply personal Hermes is Dewey/Ford/Seth/Johnny or any other Bookmarked agent.

## Step 6 — Report Back

After sending/posting, report:

- channel/thread
- timestamp/permalink/message ID if available
- exact posted text if useful
- any immediate response from the agent

If the agent responds, summarize and bring it back to Steve before continuing, unless Steve pre-authorized a back-and-forth loop.

## Uncertainty / Context / Creation Gate

When relaying to Bookmarked agents, include this operating expectation when relevant:

If you are unsure, blocked, missing context, or need Steve feedback, ask for the specific missing context and @mention Steve. Do not create extra pages, tickets, workflows, dashboards, or broad plans to work around uncertainty unless Steve has explicitly approved that path.

For identify-only tasks, stay identify-only until Steve approves the edit/build/send step.

## Pre-Authorized Loops

By default, every outbound relay requires approval.

Steve may explicitly authorize a bounded loop, e.g.:

"Go back and forth with Seth in that thread until you have the three campaign options, then bring me the summary."

A bounded loop must specify:
- target/channel
- objective
- stopping condition
- what requires Steve escalation

Even in a loop, do not approve irreversible actions, external sends, deletions, commits, or customer-facing posts without Steve's explicit approval.

## Classification Template

Use this before a relay:

```
Classification: Steve personal Hermes relaying Steve's direction into Bookmarked Hermes.
Target:
Channel:
Identity:
Authority: draft/relay only, approval required before posting.
```

## Example: Agent Direction

Steve says: "Tell Seth to make the LinkedIn version punchier."

Good response:

```
Classification: Steve personal Hermes relaying to Bookmarked Hermes.
Target: Seth, CMO agent.
Channel: [identified Slack thread/channel]
Authority: I can draft it. I won't post until you approve.

Draft:
Seth, tighten the LinkedIn version. Make the point faster, cut anything that sounds like marketing language, and keep it in my voice. I want it to feel like a founder saw the pattern and is naming it, not like we're launching a campaign.

Send this?
```

## Async Follow-Up Pattern (pre-authorized autonomous relay)

When Steve explicitly authorizes autonomous coordination ("do as much as possible
without my intervention," "handle it between you and Dewey," "go have this
conversation and come back with the answer"), use this pattern:

1. **Send the initial message** via Slack DM or channel. @mention both Steve and the
   target agent. Note the channel ID + message timestamp — you need these for thread
   polling.
2. **Create an agent-based follow-up cron** (NOT no_agent — must have Slack MCP access):
   - `enabled_toolsets=[]` (empty = all defaults including MCP tools)
   - Schedule: every 60-90 minutes
   - Repeat: 3-5 times (bounded)
   - Model: Haiku (cheap — this is mechanical checking)
   - Prompt: check thread replies, summarize if target responded, nudge if not, don't
     double-nudge
   - Include: channel ID, thread timestamp, target user ID, what you're waiting for
3. **Thread-based replies** keep everything in one place. The follow-up cron posts
   nudges as thread replies, not new messages.
4. **Results deliver to Steve** via the cron's default delivery so he sees them when
   he's back.

First proven use: OpenRouter brief to Dewey (2026-06-20), 4x90min follow-up cron
checking DM thread for discovery report.

**Channel selection matters:** The first attempt used Dewey's DM channel
(`D0ARJQ8FXK3`) and Dewey never saw it — his agent monitors `#ai-ceo-team`
(`C0AR85TMVS8`), not bot-posted DMs. Steve had to correct this. When sending
action items to Bookmarked agents, always use the channel the agent actually
monitors (check Known Channel IDs below), not DMs.

Key pitfall: no_agent cron scripts CANNOT call MCP tools (Slack, HubSpot, etc.).
The follow-up MUST be an agent-based cron. See hermes-instance-tuning skill for the
full no_agent vs agent cron distinction.

## Improvement Loop

After live relays, use `references/relay-improvement-loop.md` to capture any routing correction or workflow friction.

## Dewey After-Action Relay

When Steve asks whether agent activity actually converted to real business work (not just Slack motion), use the template in `references/dewey-after-action-relay-template.md`. Key rule: do NOT ask Dewey to build a dashboard — ask for the operating recommendation first, then build from what the gaps reveal. Keep the loop lightweight: classification, target chosen, whether it was right, and skill patch needed. The first good low-risk test target is usually Ford because Ford is the operational funnel and triages unclear routing.

## Agent Reconfiguration Cascade Pattern

When Steve wants to reconfigure a Bookmarked agent (change its role, guardrails, skills, model, cron, or channel wiring):

1. **Ask Dewey for current state** — "give me a full brief on [agent], read-only, don't change anything"
2. **Steve + personal Hermes define the new spec independently** — don't anchor to Dewey's report; design from what the business needs
3. **Send spec to Dewey with explicit "review only, don't implement"**
4. **Dewey asks clarifying questions and flags issues** — answer only after checking with Steve on anything you're not sure about
5. **Steve answers through personal Hermes**
6. **Dewey preps sequenced implementation plan** — Dewey owns the sequencing (dependencies ordered correctly, infrastructure before config changes)
7. **Steve reviews plan and gives go**
8. **Dewey executes**
9. **Designated human tester validates** (e.g., Sarah for Priya)
10. **Feedback loop** — tester reports what worked/didn't to Steve, Steve routes fixes through Dewey

**Key rules:**
- The tester reviews output but does NOT train the agent directly. Training goes through one door: Steve → Dewey → agent. Multiple people training directly = conflicting instructions and drift.
- Ask the agent for self-improvement feedback after completing work ("what worked, what was unclear, what would you suggest?")
- Don't frame testing boundaries as restrictions on the tester's authority — frame as "DM me what worked and what didn't, I'll make sure updates get made through the right channels."

This pattern was proven with the Priya reconfiguration (2026-06-17) and applies to ANY Bookmarked agent.

## Approval Gate Calibration

The default is: draft → show Steve → wait for "send it" → post.

**Exception — direct instruction to send.** When Steve says "ask Dewey X" or "send Dewey a message asking Y" or "tell Ford Z," treat the instruction itself as the approval. He's giving you the content and the destination in one shot. Don't loop back with a draft of what he just told you to send — that's friction, not safety.

**The test:** Did Steve tell you WHAT to say and WHO to say it to? If yes, send it. If he gave you a vague direction ("check in with Ford about ops") and you need to compose the message, draft it first.

## Known Channel IDs — Do Not Re-Discover

Before searching Slack channel lists or asking Steve for channel IDs, check these known IDs:

- `#ai-ceo-team` → `C0AR85TMVS8` (private — won't appear in public channel list)
- `#product-feedback` → `C0AMSNW8YSZ`
- `#product-prioritization` → `C0B3QGTVAE5`
- `#agent-feedback` → `C0ANAL9DSMU`
- `#ticket-creation` → `C0B2BPF46Q0`
- `#water-cooler` → `C05CG6Z14DP`
- `#client-success` → `C07FLBVEG94`
- `#sales_revenue-ninjas` → `C060YMXSLKD`

DM channels (for agent-to-agent relay):
- Dewey DM → `D0ARJQ8FXK3` — NOTE: Dewey's agent does NOT pick up bot-posted
  messages in this DM. For action items Dewey needs to act on, post to
  `#ai-ceo-team` (`C0AR85TMVS8`) instead. The DM is only useful for human-to-human
  or when Steve posts directly from his own Slack client.

Slack User IDs:
- Steve Wandler → `U05C13KAW85`
- Dewey (CEO agent) → `U0AR21JHLFP`

Also check session_search and memory before asking Steve to re-confirm something you've used before. He will rightfully call you out for losing information you already had.

## Pitfalls

1. **Do not skip context.** If a Slack thread exists, read it before drafting direction.
2. **Do not make the message sound like an AI.** Steve's direction should sound like Steve.
3. **Do not post before approval — UNLESS Steve gave a direct send instruction.** See Approval Gate Calibration above. "Ask Dewey X" = send. "Maybe we should tell Ford" = draft first.
4. **Do not confuse agents with humans.** Use the Team Hub roster when unsure.
5. **Do not create autonomous loops by accident.** One relay does not authorize ongoing back-and-forth.
6. **Do not leak personal context into Bookmarked channels.** Classify personal vs Bookmarked before quoting context.
7. **Do not overbuild.** This workflow should stay light enough to use every day.
8. **Write in FIRST PERSON as Steve.** Say "I want" not "Steve wants." Say "I'm building" not "Steve is building." The message comes from Steve's account — he IS the speaker. When Steve corrected this in the June 15 product metrics session, it was emphatic: "Don't say Steve is working on it. Say I." @mention Steve so agents reply in the thread tagging him. This applies to ALL relay messages, not just product.
9. **Do not lose channel IDs you've already used.** Private channels won't appear in `slack_list_channels`. Check Known Channel IDs, session_search, and memory BEFORE asking Steve or claiming you can't find something. Getting called out for forgetting your own history erodes trust.
