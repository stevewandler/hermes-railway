---
name: send-as-steve-email
description: "Use for the full draft/revise/send workflow as Steve Wandler. Enforces explicit send approval, account/recipient/body review, BCC/HubSpot logging, Gmail raw-MIME send, verification, and post-send CRM hygiene."
version: 1.0.0
author: agent
tags: [email, send, workflow, steve, bookmarked, hubspot, gmail, bcc]
related_skills: [steve-email-voice, bookmarked-outreach-email, google-workspace]
---

# Send Email as Steve Wandler — Full Workflow

## Native Hermes Routing

Use this skill for the process of drafting, revising, sending, and cleaning up after an email sent as Steve. For voice/style, always load `steve-email-voice` first; for district/customer outreach, also load `bookmarked-outreach-email`; for live thread/account facts, load `google-workspace`; for relationship/account context, query G-Brain.

Source-of-truth order:
1. Steve's explicit instruction and final approval state.
2. `steve-email-voice` for language.
3. Google Workspace for live Gmail account/thread/send mechanics.
4. G-Brain/HubSpot for relationship and CRM context.
5. This skill for send gate, BCC, raw MIME, verification, and post-send cleanup.

Output mode before sending: show From, To, CC/BCC, Subject, full body, account, and what will be logged. Wait for explicit approval. Never infer approval.

This skill is the PROCESS for drafting, iterating, sending, and cleaning up after
an email sent as Steve. For **voice rules and style**, always load `steve-email-voice`
first — that skill IS the voice; this one is the machine that sends it.

Before drafting or sending any email that crosses personal/work context, could use either Steve account, touches Bookmarked, districts, TALAS, investors, customers, Slack, Confluence, GitHub, or Bookmarked Hermes agents, load `steve-personal-hermes-operating-boundaries` and classify:

1. Environment: Steve personal Hermes or Bookmarked Hermes?
2. Domain: personal, Bookmarked, or mixed?
3. Account: `steve@bookmarked.com` or `stevewandler@gmail.com`?
4. Authority: draft only or send?
5. Approval: has Steve explicitly approved the final send?

---

## ⛔ HARD GATE — NEVER SEND WITHOUT EXPLICIT APPROVAL

**Do not send email unilaterally. Ever.**

Draft → show Steve (From / To / Subject / full body) → wait for explicit "send it" → send → confirm with message ID.

What does NOT count as send approval:
- "That's a good email"
- "That would be great" (about a related task like creating a reminder)
- "We're constructing this email"
- Contextual implication that the email should go out
- A prior session that produced a draft

What DOES count: Steve explicitly saying "send it," "go ahead and send," or equivalent.

**This rule was violated on 2026-06-10.** An IMTA funding email went to Michael Ruiz (Garland ISD, a key relationship) without Steve's knowledge. The email itself was not damaging, but the trust breach was real. Steve found out by asking where the email was. That cannot happen again.

---

## Step 0: Load the voice

```
skill_view(name="steve-email-voice")
```

Non-negotiable. Every email draft starts by loading the voice profile. If you
draft without it, you'll miss something and Steve will catch it.

---

## Step 1: Research before drafting

Before writing a single word, pull real context:

1. **G-Brain** — search for the contact's page, recent meeting notes, deal status.
   `gbrain search "FirstName LastName district"` and `gbrain get <slug>` if a page exists.
2. **HubSpot** — check the contact record and active deal. Is there a renewal? What stage?
   Any recent activity notes?
3. **Gmail thread history** — search `from:<contact> OR to:<contact>` to see the last
   exchange and how long the gap has been.

A single remembered detail from a past conversation is the most powerful thing in the email.

---

## Step 2: Draft

Write the full email applying ALL voice rules from `steve-email-voice`. Key reminders:

- **No em dashes.** Check every sentence.
- **Short.** If the job is "get a meeting," every sentence serves that one ask.
- **First sentence IS the point.** No pleasantries before it.
- **Specific numbers.** Not "significant savings" but "$31,794 for the year."
- **Own gaps on "we."** Never make the recipient feel bad.
- **One clear ask near the end.** Open-ended enough to be hard to decline.
- **Sign-off:** "Steve" / "Thanks, Steve" / "Talk soon, Steve" — nothing else.

Present the full draft including Subject line.

---

## Step 3: Iterate (expect 3–9 rounds)

Steve edits hard. This is normal and healthy. The process:

1. He'll flag a word, a sentence, a tone issue.
2. Make the SINGLE change he asked for.
3. Re-present the ENTIRE email clean — not a diff, the full thing so he can read it fresh.
4. Repeat until he says send.

**Don't argue small stuff.** If he says "I don't like that word," change it. If he says
"too long," cut. If he says "doesn't sound like me," ask him to say it out loud or type
it the way he would, then shape that.

---

## Step 4: Send with BCC

### BCC Rules (critical, confirmed 2026-06-09)

For **any Bookmarked district/sales email**, BCC both:

| BCC Recipient | Address | Purpose |
|---------------|---------|---------|
| Jan Gilboy | `jan@bookmarked.com` | Sales visibility |
| HubSpot logging | `39855019@bcc.hubspot.com` | Steve's HubSpot portal CRM logging |

- The HubSpot address goes in **BCC, NEVER CC**.
- When Steve says "BCC HubSpot" he means `39855019@bcc.hubspot.com`.
- Default send account: `steve@bookmarked.com` (work token).

### Why raw MIME is required

The `google_api.py` CLI wrapper supports `--to`, `--cc`, `--from`, `--html` but has
**NO `--bcc` flag**. To send with a true BCC header, you must build a raw MIME message
and send it through the Gmail API directly.

### Send technique (Python, using work token)

```python
#!/usr/bin/env python3
import base64
import json
from pathlib import Path
from email.mime.text import MIMEText
from google.oauth2.credentials import Credentials
from googleapiclient.discovery import build

TOKEN_PATH = Path.home() / ".hermes" / "google_token.json"

TO = "recipient@district.org"
BCC = "jan@bookmarked.com, 39855019@bcc.hubspot.com"
SUBJECT = "subject here"
BODY = """Email body here.

Steve"""

creds = Credentials.from_authorized_user_file(str(TOKEN_PATH))
service = build("gmail", "v1", credentials=creds)

# Confirm sending identity
profile = service.users().getProfile(userId="me").execute()
sender = profile.get("emailAddress")
print("SENDING AS:", sender)

msg = MIMEText(BODY)
msg["To"] = TO
msg["Bcc"] = BCC
msg["From"] = sender
msg["Subject"] = SUBJECT

raw = base64.urlsafe_b64encode(msg.as_bytes()).decode()
sent = service.users().messages().send(userId="me", body={"raw": raw}).execute()
msg_id = sent.get("id")
print("SENT:", json.dumps({"id": msg_id, "threadId": sent.get("threadId")}))
```

Run with: `~/.hermes/hermes-agent/venv/bin/python3 <script>`

The `bookmarked-outreach-email` skill has this as a ready-to-edit script at
`scripts/send_email_with_bcc.py` — edit TO/BCC/SUBJECT/BODY and run.

### For HTML email

Replace `MIMEText(BODY)` with `MIMEText(BODY, "html")` — same technique otherwise.

### For personal account sends

Swap `TOKEN_PATH` to `Path.home() / ".hermes" / "google_token_personal.json"`.
Send identity will be `stevewandler@gmail.com`. Personal emails typically don't
need BCC to HubSpot.

---

## Step 5: Verify after sending (ALWAYS)

Re-fetch the sent message by ID with `format=metadata` and confirm all headers:

```python
verify = service.users().messages().get(
    userId="me",
    id=msg_id,
    format="metadata",
    metadataHeaders=["To", "Bcc", "Subject", "From", "Date"]
).execute()
headers = {h["name"]: h["value"] for h in verify["payload"]["headers"]}
print("VERIFIED:", json.dumps(headers, indent=2))
```

Confirm:
- `To` matches the intended recipient
- `Bcc` includes BOTH `jan@bookmarked.com` AND `39855019@bcc.hubspot.com`
- `From` is `steve@bookmarked.com`
- `Subject` is correct

**Do not tell Steve "sent and verified" until you've actually run this check.**

---

## Step 6: HubSpot cleanup (offer after district emails)

After sending a district/sales email, proactively offer HubSpot housekeeping:

### 6a. Ensure the contact exists

Search for the contact in HubSpot. If they don't exist, create them.
HubSpot Private App token is in `~/.hermes/config.yaml` under
`mcp_servers.hubspot` → env → `PRIVATE_APP_ACCESS_TOKEN`.

```bash
# Search for contact
curl -s "https://api.hubapi.com/crm/v3/objects/contacts/search" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"filterGroups":[{"filters":[{"propertyName":"email","operator":"EQ","value":"contact@district.org"}]}]}'
```

### 6b. Merge duplicate contacts

District contacts often have duplicates (different email variants, Plaud transcription
errors creating stubs, etc.). When you find duplicates:

```bash
# Merge: primaryObjectId survives, objectIdToMerge is absorbed
curl -s -X POST "https://api.hubapi.com/crm/v3/objects/contacts/merge" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"primaryObjectId": "<surviving_id>", "objectIdToMerge": "<duplicate_id>"}'
```

**Important:** Merge returns a NEW surviving contact ID. Use that ID for all
subsequent operations (deal association, etc.).

### 6c. Associate contact with the deal

If there's an active deal (renewal, new business), link the contact:

```bash
# Link contact to deal
curl -s -X PUT \
  "https://api.hubapi.com/crm/v4/objects/deals/<dealId>/associations/default/contacts/<contactId>" \
  -H "Authorization: Bearer $TOKEN"
```

### 6d. Log a note (optional)

If the email was a significant re-engagement, log a note on the contact record
summarizing the outreach and expected next steps.

---

## Worked Example: Melissa Leigh / Humble ISD (June 9, 2026)

**Context:** Dr. Melissa M. Leigh, Sr. Dir. Personalized Student Success, Humble ISD.
~10 weeks of silence. $44,382 renewal at 50%. Standing meetings existed all year,
essentially none happened. Charlie Clines' home district. Strategically important.

**Draft process:** ~8 revision rounds. Key corrections:
- Cut "It's been too long" (she knows)
- "ragged" → rejected, "grind" → rejected
- Don't quote her numbers back
- Em dashes → all removed
- Subject: "the one meeting we keep missing" (owns it on the shared "we")

**Final email:** See `steve-email-voice` skill, reference file
`references/melissa-leigh-reengagement-email.md` for the complete text and edit arc.

**Send mechanics:**
1. Built raw MIME with BCC to `jan@bookmarked.com` + `39855019@bcc.hubspot.com`
2. Sent via Gmail API as `steve@bookmarked.com`
3. Verified headers: To (melissa.leigh@humbleisd.net), Bcc (both addresses), Subject confirmed
4. Post-send HubSpot cleanup:
   - Found duplicate contact: "Melissa Lee" (Plaud transcription error) and "Melissa Leigh"
   - Merged duplicates via `POST /crm/v3/objects/contacts/merge`
   - Linked surviving contact to 26/27 Humble ISD renewal deal via
     `PUT /crm/v4/objects/deals/<dealId>/associations/default/contacts/<contactId>`
   - Created canonical G-Brain page at `melissa-leigh-humble-isd` with aliases
     including the misheard "Melissa Lee"

---

## Quick Checklist Before Hitting Send

- [ ] Loaded `steve-email-voice` skill
- [ ] Researched the contact (G-Brain, HubSpot, Gmail history)
- [ ] Draft reviewed against voice checklist (no em dashes, no pleasantries, short, specific)
- [ ] Steve approved final text
- [ ] BCC includes `jan@bookmarked.com` AND `39855019@bcc.hubspot.com` (for district/sales)
- [ ] Send via raw MIME (not google_api.py CLI — no --bcc support)
- [ ] Verified sent message headers (To, Bcc, From, Subject all correct)
- [ ] Offered HubSpot cleanup (contact exists, no dupes, linked to deal)

---

## Investor / VC Email Register

Investor emails are a distinct register from district outreach. The voice rules (no em dashes, short, no pleasantries) all still apply — but the specific pitfalls are different:

### Key differences from district outreach

1. **Don't sidestep the specific ask, even when apologizing.** If the investor asked for something concrete on the call (data room, deck, intro, numbers) and you're writing to apologize for going quiet — you must address that ask directly in the reply. Burying or omitting it reads as avoidance and erodes trust faster than the delay itself did.

2. **Acknowledge what you committed to on the call.** Investors take notes. If you said "I'll assemble the data room and share it" — the apology email needs to say what's happening with that commitment, even if the answer is "end of June." Vague check-ins without referencing the open commitment feel like you forgot what was discussed.

3. **Set a concrete re-engagement window.** "Let's reconnect" with no date is worse than nothing. Even a "first week of July" is enough to keep the investor from closing their file. Be specific.

4. **Keep it short — shorter than district emails.** Investors get hundreds of founder emails. Three to four sentences is ideal for an apology/hold email. If it's longer, cut.

### Template: Investor apology / hold email

```
Hi [First Name],

Really sorry for going quiet on you. [One clause acknowledging what got in the way — end of school year, heads down on X.]

[Address the open commitment directly — "I haven't forgotten about the data room" / "I'm getting the deck updated" / "I'll have X to you by [date]."]

Let's reconnect [specific window — "first week of July" / "after [date]"]. [Optional: "Happy to jump on a call when you're back from [thing]."]

Thanks for your patience.

Steve
```

### Worked example: Alexey Korablev / DFG elements (June 2026)

**Context:** Intro'd via Dmitry Butalov (DataArt EdTech head) in late April. Alexey is an Associate at DFG elements (Cyprus VC). Call happened ~May 19-22 after Steve booked a slot post-intro. On that call Steve said he'd assemble a data room for due diligence. Alexey followed up June 1 (9 days unanswered) specifically asking for the data room. Steve wanted to apologize for the delay, signal he hasn't forgotten them, hold until end of June / early July.

**The trap:** Steve's initial instinct was a general "sorry for going quiet, we're heads down, let's reconnect." The right draft also had to explicitly say "I haven't forgotten about the data room" — otherwise the email reads as acknowledging the relationship but not the open commitment. Investors notice the omission.

**Final draft shape:**
- One sentence owning the delay (end of school year, heads down)
- One sentence addressing the data room commitment directly with a date
- One sentence setting a re-engagement window
- "Thanks for your patience." + "Steve"

No BCC to Jan or HubSpot required for investor emails (personal relationships, not district CRM).

---

## Reference Files

- `references/melissa-leigh-reengagement-email.md` — full edit arc and final text for the Humble ISD re-engagement (June 2026); see also `steve-email-voice` skill
- `references/investor-contacts.md` — investor/VC contact register with open commitments, timeline, and Mailroom cron job reference (Alexey Korablev / DFG elements as of June 2026)

---

## Reference Files

- `references/melissa-leigh-reengagement-email.md` — full edit arc, Humble ISD re-engagement (Jun 2026)
- `references/dfg-elements-alexey-korablev-state.md` — DFG Elements / Alexey Korablev investor thread state, transcript location, data room status (Jun 2026)
- `references/mailroom-thread-setup.md` — Mailroom thread purpose, skills to load, cron jobs wired (Jun 2026)

---

## Step 6b: Reply-All Threading (when replying to an existing thread)

When Steve needs to reply to an existing email and keep others CC'd:

1. **Fetch the original message headers first** — get `Message-ID`, `References`, `Cc` from the message you're replying to.
2. **Set `In-Reply-To`** = the original `Message-ID`.
3. **Set `References`** = original `References` + original `Message-ID` concatenated.
4. **Set `threadId`** in the send body to keep it in the same Gmail thread.
5. **`Cc`** = whatever was in the original `Cc` field (reply-all pattern).

```python
orig = service.users().messages().get(
    userId="me", id=REPLY_TO_MSG_ID,
    format="metadata",
    metadataHeaders=["Message-ID", "References", "Cc", "Subject"]
).execute()
headers = {h["name"]: h["value"] for h in orig["payload"]["headers"]}

msg["In-Reply-To"] = headers.get("Message-ID", "")
msg["References"] = (headers.get("References", "") + " " + headers.get("Message-ID", "")).strip()
msg["Cc"] = headers.get("Cc", "")  # reply-all

sent = service.users().messages().send(
    userId="me",
    body={"raw": raw, "threadId": THREAD_ID}
).execute()
```

Note: `threadId` in the send body is what actually keeps Gmail threading correct. `In-Reply-To` + `References` are the RFC headers that make other mail clients thread correctly.

---

## Step 7: Inbox Triage After Sending (offer proactively)

After handling an email task, proactively offer to:

### 7a. Archive sent threads
Remove `INBOX` label from threads that have been replied to — they're handled, not pending.

```python
service.users().messages().modify(
    userId="me", id=msg_id,
    body={"removeLabelIds": ["INBOX"]}
).execute()
```

### 7b. Sweep inbox for spam/marketing/noise
Pull `is:inbox` (max 50), classify each message:
- **Archive immediately**: marketing blasts, cold outreach, automated tool notifications (GitHub bots, CI alerts), product announcement emails, recurring digest/recap emails from SaaS tools, Stripe failed-payment retries for non-critical subscriptions, forwarded CC'd noise (Natasha/team outbound emails Steve doesn't need to act on).
- **Leave for Steve**: anything from a named human, any financial alert (AWS past due, real payment failures), any from Charlie/investors/board, any district/customer contact, any calendar invite requiring a decision, physical mail notifications, security alerts.
- **When in doubt, leave it.** One false archive is worse than a full inbox.

### 7c. Create Google Tasks for follow-ups
For every thread that needs a future action but isn't actionable today, create a Google Task with:
- Clear title: `[Person/Org] — [action needed]`
- Notes: context, what was committed, email reference
- Due date: realistic deadline (not arbitrary)

```python
tasks_service = build("tasks", "v1", credentials=creds)
tasklists = tasks_service.tasklists().list().execute()
default_list = tasklists["items"][0]["id"]

tasks_service.tasks().insert(
    tasklist=default_list,
    body={"title": "...", "notes": "...", "due": "2026-07-07T00:00:00Z"}
).execute()
```

After the sweep, report: threads archived, tasks created, and what's still in inbox that needs Steve's eyes — categorized by urgency.

---

## Relationship to `bookmarked-outreach-email` skill

The `bookmarked-outreach-email` skill was the original v1 of this workflow (voice rules +
send mechanics combined). This `send-as-steve-email` skill supersedes it as the
authoritative send workflow — it's more complete on verification, HubSpot cleanup,
and the worked example. The `bookmarked-outreach-email` skill still has useful
reference files (`references/voice-corrections-from-live-edits.md`) and the ready-to-edit
`scripts/send_email_with_bcc.py`. Both skills' scripts are functionally identical.

**When to load which:**
- Drafting voice → `steve-email-voice` (the corpus-derived profile)
- Sending workflow → `send-as-steve-email` (this skill)
- Quick banned-words check → `bookmarked-outreach-email` reference file

---

## Reply-All Threading (VC / investor threads)

When the email has multiple parties (e.g. an intro chain with a VC associate + their colleague + the mutual contact), always check the original message's `Cc:` header before building the reply. Use `gmail get <id>` with `metadataHeaders=["Message-ID","References","Cc"]` to reconstruct the full reply-all target list.

Pattern confirmed (Jun 2026, Alexey Korablev / DFG elements):
- Original thread: To = Alexey, Cc = Alex Varlamkin (colleague) + Dmitry Butalov (intro)
- Reply built with `In-Reply-To` + `References` headers for proper threading
- `CC` field set to everyone from the original `Cc:` minus Steve himself
- `threadId` passed in the send body to keep it in the same Gmail thread

```python
# Get headers from the message you're replying to
orig = service.users().messages().get(
    userId="me", id=MESSAGE_ID,
    format="metadata",
    metadataHeaders=["Message-ID", "References", "From", "To", "Cc", "Subject"]
).execute()
headers = {h["name"]: h["value"] for h in orig["payload"]["headers"]}

# Build reply
msg["In-Reply-To"] = headers["Message-ID"]
msg["References"] = headers.get("References", "") + " " + headers["Message-ID"]
msg["Cc"] = headers.get("Cc", "")  # preserves full CC chain

# Send with threadId to keep it threaded
service.users().messages().send(
    userId="me",
    body={"raw": raw, "threadId": THREAD_ID}
).execute()
```

---

## Text Message Drafting Rules (Steve's preferences, confirmed June 2026)

Text messages follow different rules than email. These fired as corrections this session:

1. **Chunk texts — never send a wall.** If a text would be more than 3-4 sentences, split it into 2-3 separate messages. Each text stands alone and can breathe. Steve sends texts as a conversation, not a newsletter.
2. **No italics in text or email drafts presented for review.** When drafting messages for Steve to review or send, present them in plain text — no markdown formatting, no italics, no bold. Steve reads drafts as they'll appear in the message, not as formatted documents. This is a hard rule — he explicitly called this out.
3. **Text tone is pure friend-to-friend.** No formality, no sign-off, no structure. Just how a person texts someone they know.
4. **Stagger the texts.** Present them as separate numbered messages with natural gaps between — Text 1 now, Text 2 after he replies or 30 min later, Text 3 same day. Don't present them as one combined message.
5. **Drafts presented for Steve's review must be in plain text always** — not just texts. Emails, messages, any draft shown to Steve for approval: plain prose, no markdown, no formatting. He reads it as it will appear when sent.

## Creating a Gmail Draft (vs sending)

When Steve says "put this in my email draft so I can see it there" or "drop it in drafts," the correct action is to CREATE a draft, not send. Use `service.users().drafts().create()`.

Key mechanics:
- Build raw MIME same as send workflow.
- Set `In-Reply-To` + `References` headers to thread correctly into the original message.
- Pass `threadId` in the message body for Gmail threading.
- No BCC needed for drafts — BCC is only enforced at send time for district/sales emails. Board/governance emails (Charlie, investors) do not get BCC to Jan or HubSpot.
- Report the `draftId` to Steve so he knows it's there. He reviews and sends manually.
- Never say "sent" when you created a draft. Confirm "draft created, threaded into [subject], ready for your review."

```python
draft = service.users().drafts().create(
    userId="me",
    body={"message": {"raw": raw, "threadId": THREAD_ID}}
).execute()
print("DRAFT CREATED:", draft.get("id"))
```

## Pitfalls

1. **Non-district emails don't need BCC to Jan/HubSpot.** VC/investor emails, internal team emails, and personal replies should NOT be BCC'd to `jan@bookmarked.com` or `39855019@bcc.hubspot.com`. BCC rules are for district/customer outreach only. Sending a VC reply with HubSpot BCC looks unprofessional.

2. **google_api.py has no --bcc.** You MUST use raw MIME. Every time. No exceptions.
   If you forget and use the CLI, the BCC addresses won't be included.

2. **HubSpot BCC goes in BCC, never CC.** If it lands in CC, the recipient sees
   HubSpot's logging address, which looks unprofessional and breaks trust.

3. **Merge returns a new contact ID.** After merging duplicates, the old IDs are
   gone. Use the new surviving ID for deal association. If you use the old ID,
   the association call will 404.

4. **Steve revises 3–9 times. This is the process, not a problem.** Don't shortcut
   it, don't get impatient, don't try to pre-optimize by guessing his edits.
   Present each revision clean and complete.

5. **"Him and his colleague" / "you and your colleague" — never write this.** Steve rejected this phrasing explicitly (Jun 2026). If there are multiple people on the call or thread, either name them specifically or drop the reference entirely. "Continuing the discussion" beats "continuing the discussion with you and your colleague" every time. See `steve-email-voice` skill for the full rule.

6. **Personal token (stevewandler@gmail.com) expired as of Jun 2026.** Before
   sending from the personal account, verify the token works. If expired, Steve
   needs to re-auth (see `google-workspace` skill setup steps).

6. **Hermes redacts secrets in terminal subprocess env.** When reading the HubSpot
   token from config.yaml for API calls, read it at Python runtime inside the
   script — don't pass it through an f-string or terminal env var.

7. 8. **Internal team emails: don't end with Steve making the call if he said to let the team decide.** A common draft error is ending with "I'll decide from there" when Steve specifically said "you and Jan can decide." Read the intent carefully — Steve often delegates decisions to Jan + Teela on conference/event questions. If he said they decide, the closing ask should direct back to them, not loop back to Steve for approval.

9. **Don't draft without Steve's green light.** Draft, iterate,
   wait for the green light. The only exception is if Steve explicitly pre-authorized
   a send in the task instructions.
