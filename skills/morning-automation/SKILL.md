---
name: morning-automation
description: "Steve Wandler's morning brief: calendar, work + personal Gmail triage, open tasks — delivered to WhatsApp at 7am CT daily via Sonnet 4.6. Patrick Reid's CS workflow is a secondary sub-pattern documented separately."
version: 2.0.0
author: agent
tags: [morning, automation, hubspot, gmail, calendar, daily-brief, bookmarked, steve-wandler]
---

# Morning Brief — Steve Wandler

**CRITICAL:** This skill is primarily about STEVE WANDLER's morning brief. Do NOT conflate it
with Patrick Reid's CS workflow. Steve's brief is simple — calendar, email triage, tasks.
Patrick's 7-step HubSpot workflow is documented at the bottom as a reference only.
When Steve asks about his morning automation, deliver his brief. Do not default to Patrick's.

This skill covers two patterns:

1. **Steve's personal morning brief** (PRIMARY) — delivered to WhatsApp at 7am CT daily (cron job 0eb7583b0875). Calendar, work + personal email triage, open tasks.
2. **Patrick Reid's CS daily brief** (SECONDARY, reference only) — the 7-step HubSpot/Gmail/calendar workflow Patrick described in the June 1 2026 sync. Only use this when Patrick explicitly requests it.

## Steve's Morning Brief (Cron job 0eb7583b0875)

Runs daily at 7am CT, delivers to WhatsApp (chat ID: 231756435308660@lid).

### What it does
1. **Calendar** — today's events from steve@bookmarked.com. Flag anything needing prep.
2. **Work email** — unread inbox from steve@bookmarked.com. Max 5 action items.
3. **Personal email** — unread inbox from stevewandler@gmail.com. Max 3 action items.
4. **Tasks** — open/overdue from Google Tasks CEO Daily list.

### Model
Pinned to `anthropic/claude-sonnet-4.6` via OpenRouter (set 2026-06-09).

### Tokens
- Work: `~/.hermes/google_token.json` (steve@bookmarked.com)
- Personal: `~/.hermes/google_token_personal.json` (stevewandler@gmail.com)
- Python: `~/.hermes/hermes-agent/venv/bin/python3`

### OAuth Status (as of 2026-06-09)
Both Google accounts fully authorized: Gmail, Calendar, Drive, Tasks, Forms scopes live.
Gmail and Calendar are NO LONGER BLOCKED. Remove any fallback notes referencing Raju's OAuth.

### Format rules (WhatsApp delivery)
- No markdown headers
- Under 400 words
- Emoji only to separate sections
- End with counts: X emails need response, Y tasks open

## Evening Email Review (Cron job 3b2143e4f26b)

Runs daily at 5:30pm CT, delivers to WhatsApp.
Steve tends to miss inbox emails — this is the nudge.
Scans both inboxes for unread emails sitting more than a few hours. Also previews tomorrow's calendar.

---


---

## When To Run This Skill

Load this skill when:
- **Steve** says "run my morning", "what's on my calendar", "what emails need responses"
- The morning brief cron job fires (0eb7583b0875, 7am CT daily)
- The evening email review cron job fires (3b2143e4f26b, 5:30pm CT daily)
- **Patrick** (and only Patrick) says "run my morning automation" or "CS daily brief"

Do NOT load this skill for Steve and then run Patrick's 7-step workflow.

**Related skill:** For Tuesday L10 meeting prep (weekly leadership team), load `l10-meeting-workflow` instead — that is its own skill with its own two-cron system (Monday evening prep + Tuesday post-meeting extraction). Channel: `C0B0ATQQ5KR`.

---

## What You Need (Tools Required)

| Tool | What it does here | Status |
|------|-------------------|--------|
| HubSpot MCP (mcp_hubspot_*) | Pull sent emails, support@ emails, create/update tasks | Live |
| Google Workspace / Gmail MCP | Pull Gmail inbox, scan unread and sent | Live — token at ~/.hermes/google_token.json (work) and ~/.hermes/google_token_personal.json (personal) |
| Google Calendar MCP | Pull today's and yesterday's events | Live — same tokens |
| G-Brain (mcp_gbrain_search) | Context on contacts, deals, prior commitments | Live |
| HubSpot Extended MCP | Richer contact/deal data if needed | Live |

OAuth blocker is resolved as of 2026-06-08. Both work (steve@bookmarked.com) and personal (stevewandler@gmail.com) Google accounts are authenticated with full scope including Gmail, Calendar, Drive, Tasks, and Forms.


---

## The Seven Steps

Run these in order. Each step has a clear output — don't move to the next until the current
one is complete and summarized.

---

### Step 1 — HubSpot Email Review (Yesterday)

What: Pull all emails sent from Patrick's HubSpot account and from support@bookmarked.com
from the previous calendar day.

How:
1. Call mcp_hubspot_search_crm or mcp_hubspot_list_associations to get emails associated
   with Patrick's owner ID from yesterday (midnight to midnight CDT).
2. Also pull emails from the support@bookmarked.com inbox — these are mostly Patrick.
3. For each email: extract sender/recipient, subject, one-line summary of what was communicated,
   and whether a follow-up or commitment was implied.
4. Output: a chronological list of "here's what you did yesterday in HubSpot."

Pitfall: HubSpot may only show logged emails, not all sent. Emails sent from Gmail directly
won't appear here unless HubSpot tracking was on. Flag any gaps.

---

### Step 2 — Gmail Scan (Yesterday + Overnight)

What: Pull Gmail sent and received from yesterday and any unread since midnight.

How (when OAuth is live):
1. Call search_gmail_messages with is:unread to get overnight inbox.
2. Call search_gmail_messages with in:sent after:[yesterday's date] to get sent mail.
3. Classify each email:
   - ACTION: needs reply, decision, or follow-up
   - FYI: informational, no action needed
   - NOISE: Jira notifications, HubSpot digests, marketing emails — throw these out
4. Only surface ACTION emails in the brief. Max 5. If more, pick the highest urgency.

How (until OAuth is live — fallback):
- Note that Gmail data is unavailable.
- Surface any email threads visible through HubSpot contact timelines as a partial substitute.

Pitfall from June 1 meeting: Patrick flagged that giving the Hermes agent access to his FULL
Gmail account is a concern. Scope it to: client emails, support@bookmarked.com threads, and
anything where sender/recipient is a known Bookmarked contact in HubSpot. Filter everything
else out before surfacing.

---

### Step 3 — Calendar Review (Yesterday + Today)

What: Pull yesterday's completed meetings and today's upcoming events.

How (when OAuth is live):
1. Call get_events for yesterday — list what meetings actually ran.
2. Call get_events for today — list what's coming up with times.
3. Note: any meeting that ran yesterday without a follow-up task in HubSpot is a gap.
4. For today's meetings: flag which ones involve known clients (check HubSpot contact list).

How (until OAuth is live — fallback):
- Ask Patrick to confirm yesterday's key meetings verbally or check HubSpot contact timeline
  for any logged meeting activities.
- Note this is a gap and remind that Raju needs to complete Google OAuth.

---

### Step 4 — Yesterday's Summary (What Got Done)

What: Synthesize steps 1-3 into a clean summary of what happened yesterday.

How:
1. Combine the HubSpot emails, Gmail actions (if available), and calendar meetings.
2. Write a 3-5 bullet summary: "Here's what you accomplished yesterday."
3. Flag any promises made in emails that don't yet have a HubSpot task — these are tasks
   to create in Step 7.
4. Flag any client who got an email but hasn't responded (potential follow-up needed).

Output format:
  YESTERDAY — [Date]
  Done:
    - [Action taken] → [Client/Contact name]
    - ...
  Implied commitments with no task yet:
    - [What was said] to [who] — needs task

---

### Step 5 — Today's Preview (What Needs to Happen)

What: Surface today's priorities based on open tasks, upcoming meetings, and open threads.

How:
1. Call mcp_hubspot_list_crm_objects (tasks) filtered to: due today + Patrick as owner.
2. Pull any overdue tasks (due before today, still open).
3. Look at today's calendar meetings (from Step 3) — any prep needed?
4. Cross-reference: are there clients who sent an email but haven't gotten a response in
   24+ hours? Surface those.
5. Check the Jira board for any new UATs (Patrick mentioned this step in Feb 9 meeting):
   call mcp_atlassian_jira_search_issues with status=UAT and filter to new since yesterday.

Output format:
  TODAY — [Date]
  Tasks due:
    - [Task title] — [Contact/Deal] — [Due date]
  Overdue (needs attention):
    - [Task title] — [overdue by X days]
  Meetings:
    - [Time] [Person/Company] — [prep note if needed]
  UAT check:
    - [Jira ticket] — [status] — [action needed]

---

### Step 6 — Key Email Triage

What: The email scan from Step 2 filtered to only what needs a response or decision today.

How:
1. Take the ACTION emails from Step 2.
2. For each one: summarize in one line what's needed (reply, decision, forward, delegate).
3. Sort by urgency: client emails first, internal second, everything else last.
4. Throw out: Jira ads, HubSpot digest emails, HubSpot notifications, marketing subscriptions.

Output format:
  INBOX — [N] items need attention
  - [Sender]: [Subject] — [What's needed]
  (max 5 items — if more exist, surface only the top 5 by urgency)

---

### Step 7 — Push Tasks Back to HubSpot

What: Any commitments or follow-ups identified in Steps 4-6 that don't have a task yet
get created in HubSpot right now.

How:
1. For each implied commitment from Step 4: create a HubSpot task via mcp_hubspot_create_task
   or mcp_hubspot_extended (whichever has task creation).
   - Title: clear action label ("Follow up with [Name] re: [topic]")
   - Due date: today or tomorrow unless context implies otherwise
   - Owner: Patrick Reid (get his owner ID from mcp_hubspot_list_owners)
   - Associate to the relevant contact/deal if known
2. For overdue tasks from Step 5 that are still open: update their due date to today unless
   Patrick says otherwise.
3. Confirm back: "Created [N] tasks in HubSpot."

Pitfall: HubSpot agent reliability for writes. Steve flagged in the April 29 meeting that the
agent sometimes says it did something but didn't. After creating each task, do a read-back to
verify the task exists (mcp_hubspot_get_crm_object by the returned task ID). If the read-back
fails, flag it explicitly — don't silently assume success.

---

## Full Output Format

Deliver a single clean brief at the end. No walls of raw data. No bullet soup.
Everything is scannable in under 2 minutes.

  MORNING BRIEF — [Day, Date]

  YESTERDAY
    [3-5 bullets: what got done]
    [Implied commitments found: N → created as tasks]

  TODAY — [N] tasks due, [N] meetings
    Tasks:
      - [Task] — [Contact] — [Due]
    Meetings:
      - [Time] [Person] — [note]
    UAT: [N new items / nothing new]

  INBOX — [N] items need attention
    - [Sender]: [Subject] — [action needed]

  TASKS CREATED — [N] new tasks pushed to HubSpot
    - [Title] → [Contact/Deal]

  BLOCKER REMINDER (while OAuth is pending)
    Gmail and Calendar data unavailable. Raju needs to push Google OAuth to team.
    HubSpot-only data used for this brief.

---

## Cron Job Definition

Schedule: weekdays at 7:30am CDT (12:30 UTC, adjusted for daylight saving — use 13:30 UTC
in winter when CDT becomes CST, i.e., UTC-6).

Cron expression: 30 12 * * 1-5  (UTC, CDT season)
                 30 13 * * 1-5  (UTC, CST season — November to March)

Recommended: set to 30 12 * * 1-5 and adjust in November.

Delivery: origin channel (wherever Hermes is configured — no special setup needed).

Prompt for cron job (self-contained, no prior context assumed):

  "You are running the Bookmarked CS morning automation for Patrick Reid.
  Load the skill named 'morning-automation' and follow all seven steps in order.
  Today is [date]. Patrick's HubSpot owner ID is available via mcp_hubspot_list_owners
  (look for Patrick Reid). Use the HubSpot MCP tools for email and task data. Gmail and
  calendar tools may not be available yet (OAuth pending from Raju Datla). If they are
  available, use them for steps 2 and 3. If not, note the gap and continue.
  After completing all steps, deliver the final Morning Brief in the format defined in
  the skill. Do not ask clarifying questions — run the full sequence and deliver output."

Enabled toolsets for cron: hubspot, hubspot-extended, gbrain (MCP), atlassian (for Jira UATs)

---

## Pitfalls (From Real Conversations)

1. Gmail full-inbox access concern (Patrick, June 1 2026): Do not give the agent blanket
   access to Patrick's Gmail. Scope strictly to: client emails, support@bookmarked.com,
   and contacts already in HubSpot. Filter noise before surfacing.

2. HubSpot write reliability (Steve, April 29 2026): Agent may report success on a write
   operation when nothing actually changed. Always read back after writing a task.
   Silently claiming success on a failed write is worse than flagging the failure.

3. Email logging gap: Emails sent from Gmail (not from HubSpot) may not appear in HubSpot
   unless tracking was active. This means Step 1 will have gaps if Patrick sends from Gmail.
   The long-term fix is to have Patrick send client emails from HubSpot. Note this gap in
   the brief rather than pretending coverage is complete.

4. OAuth status (updated 2026-06-08): stevewandler@gmail.com is now authorized via
   Google Workspace skill (token at ~/.hermes/google_token.json). steve@bookmarked.com
   (work account) is NOT yet authorized — still needs the same OAuth flow.
   Steps 2 and 3 using personal Gmail are now live for Steve's personal account.
   Team OAuth (Patrick, Raju etc.) still pending via Raju.
   Use python3 from ~/.hermes/hermes-agent/venv/bin/python3 for google_api.py —
   the system python3 (3.9) fails on the str|None union syntax in that script.

5. HubSpot Breeze vs Hermes scope: HubSpot's native Breeze agents are better at HubSpot
   internal config (workflow design, field setup). This skill uses Hermes + HubSpot MCP
   for read/write data operations, not for Breeze-style workflow design.
   Keep these roles separate.

6. UAT step (Jira) is optional but Patrick wanted it: When Jira is accessible, checking
   new UATs is part of the morning run. Don't skip it without a reason.

7. Over-explanation risk: Steve's explicit instruction is to deliver a clean brief, not
   narrate every tool call. Run the steps, then produce one output. If a step fails,
   note it briefly in the brief — don't write a paragraph about why.

---

## Context: Why This Exists

Patrick described the workflow on Feb 9 2026 team water cooler and in more detail on
June 1 2026 Patrick/Steve sync. His words: "I almost need: here are the things you've
done, these are the emails you sent — give me a review of those emails and then create
a task list of things I need to do today." Steve's response: "add those tasks into
HubSpot so that it's all in one spot so Jan and everybody can see it."

The morning automation skill is built (2026-06-08). SOUL.md updated to reflect it.
The next version of this skill should be triggered when Raju completes Google OAuth
for the Hermes environment — at that point Steps 2 and 3 become live and the
fallback notes in those sections should be removed.

Steve also mentioned loading an "Oscar" communication expert skill that generates
high-quality client emails. That's a future add-on to Step 6: after triaging what needs
a reply, Oscar drafts it for review before send.

---

## References

- `references/source-quotes.md` — Verbatim transcript excerpts from G-Brain that define
  what each step should do. Load when recalibrating step behavior or resolving ambiguity
  about what Patrick and Steve actually agreed to.
