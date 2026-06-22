---
name: send-as-bookmarked-email
description: "Voice rules and send mechanics for district-facing emails sent as a Bookmarked CS or Sales team member (Patrick, Jan, Bryan). Not Steve's personal voice — Bookmarked's institutional CS voice. Load alongside bookmarked-customer-comms for drafting or reviewing customer communications."
version: 1.0.0
author: agent
tags: [bookmarked, email, customer-success, patrick, jan, bryan, voice, comms]
related_skills: [bookmarked-customer-comms, v1-v2-migration-comms, send-as-steve-email]
---

# Send As Bookmarked — CS/Sales Email Voice

Use this when drafting or reviewing emails that go out from **Patrick Reid, Jan Gilboy,
Bryan**, or **Houston** — not from Steve personally.

Steve's personal email voice is in `send-as-steve-email` + `steve-email-voice`.
This is the institutional voice of Bookmarked CS and Sales.

---

## The Voice

**Warm. Human. Competent. Unhurried.**

Districts trust people, not companies. Every email from Patrick, Jan, or Bryan should
feel like it's coming from a person who knows them and has time for them — not a
support ticket or an automated sequence.

- First name in the greeting, always.
- One ask per email, near the end.
- Short. If it can be said in 4 sentences, don't write 8.
- Never apologetic about the product. Confident that we built something good.
- Never urgent. Never pressure. Never "you need to act by..."
- Own any delays or gaps with "we" — never imply the district is slow.

---

## Hard Rules (apply to all Bookmarked customer-facing content)

- ❌ No em dashes — ever. Hard ban.
- ❌ No "migration," "V1," "V2," "sunsetting," "old system"
- ❌ No AI-sounding phrases: "I hope this finds you well," "please don't hesitate,"
  "as per our conversation," "I wanted to reach out"
- ❌ No passive-aggressive follow-ups ("just circling back," "bumping this")
- ✅ Product name: see naming note below — verify against canon before asserting
- ✅ Dates are specific and formatted: "June 9-11, 2026" not "next week"
- ✅ Counts are real numbers, never placeholders in a sent email
- ✅ Tone stays warm even in non-response scenarios

---

## Sender-Specific Notes

### Patrick Reid (CS)
- The relationship owner for Wave 1 + Wave 2 districts through go-live
- Personal sends carry more weight than Houston automated sends
- M-Day minus 1 and post-transfer emails are always from Patrick, never Houston
- His name on an email signals "this matters, I'm watching it"

### Houston (automated)
- Handles checklist email, 4-day nudge, go-live confirmation when district signed off
- Districts should know who Houston is before an automated email arrives from that name
- If Houston hasn't been introduced, Patrick sends the first touch instead
- Houston sends should still sound human — not like a bot confirmation

### Jan Gilboy (Sales)
- Owns the Sales Intro (E1) — the entry point before a district enters the wave
- Renewal date accuracy is her responsibility (and Michelle's)
- BCC: `39855019@bcc.hubspot.com` on all district/sales emails
- BCC: `jan@bookmarked.com` on any outbound from Steve's account to districts

### Bryan (post-go-live CSM)
- Takes over from Patrick at M+7
- E8 (7-day check-in) and beyond are Bryan's
- His emails should feel like a new friendly relationship, not a handoff

---

## Email Structure

```
Hi [First Name],

[The point — one sentence. What's happening or what you need.]

[One or two sentences of context, specifics, or what they need to do.]

[Optional: one sentence of reassurance or "we're here if you need anything."]

[The ask — one clear, easy-to-answer question or action.]

[Your Name]
[Title] | Bookmarked
[Phone]
```

**No "Best," "Regards," or "Thanks" unless it's natural to the context.**
"Warmly" is fine for first-contact emails. After that, just the name.

---

## Pre-Send Checklist

- [ ] Product name matches canon (see naming note) — do not assume "OnShelf Review and Engage"
- [ ] No em dashes anywhere in the body
- [ ] No banned words (migration, V1, V2, sunsetting, old system)
- [ ] All bracketed placeholders filled in — never send with [District Name] still in it
- [ ] Cutover date formatted as 3-day window (announcement/checklist) or specific date (M-Day minus 1)
- [ ] Renewal date confirmed accurate (announcement email only — Jan/Michelle gate)
- [ ] Sender identity is correct (Patrick vs. Houston vs. Bryan)
- [ ] HubSpot ticket updated or note added after send
- [ ] BCC to `39855019@bcc.hubspot.com` on all outbound

---

## Reviewing Someone Else's Draft

When reviewing Patrick's or Jan's drafts (e.g., giving founder feedback):

1. **Check the hard language rules first** — em dashes, banned words, product name

> ⚠️ **Product-name conflict (flagged 2026-06-10).** This skill was built on "OnShelf
> Review and Engage." The canonical Product Vision names the product **OnShelf**, with
> "OnShelf Review" as one module. Don't assert "OnShelf Review and Engage" as correct
> until Steve resolves it. The naming/voice source of truth and full detail is in
> `bookmarked-customer-comms/references/canonical-brand-voice.md`.
2. **Check the tone** — does it feel like a person or a template?
3. **Check the ask** — is there one? Is it clear? Is it near the end?
4. **Check the data** — are counts, dates, and names filled in? Any placeholders?
5. **Flag, don't rewrite** — unless Steve explicitly asked for a rewrite, surface the
   issues and let Patrick own the fix. He built this; he should own it.

---

## HARD GATE — APPROVAL REQUIRED BEFORE SEND

**NEVER send email unilaterally.** Draft → show Steve → wait for explicit "send it" or "go ahead." This applies even when:
- The email content looks correct and non-controversial
- You drafted it earlier in the same session
- Prior context suggested it was ready to go
- Steve said "that would be great" or "that's a good email" about it

"That looks good" is NOT send approval. "Send it" IS send approval.

A violation here is a trust breach, not a workflow error. Steve discovered in session (2026-06-10) that an email went to Michael Ruiz (Garland ISD) without his knowledge. That is unacceptable regardless of email quality.

**Correct sequence:**
1. Draft the email
2. Show Steve: From / To / Subject / Body
3. Wait for explicit approval
4. Send and confirm with message ID

---

## Pitfalls

- **Reviewing vs. owning** — Steve's job on this program is to give Patrick feedback
  on communications, not to draft them himself. Keep that boundary. Draft feedback
  notes to Patrick, not replacement emails (unless asked).
- **The four pillars aren't in every email** — and that's correct. The journey delivers
  all four across the full arc. Don't stuff every email with all four.
- **"Looks good" replies from districts are the sign-off** — log as
  `checklist_signed_off = district_confirmed` in HubSpot. Don't wait for a formal form.
- **E1 (sales intro) gap** — if a district hasn't received E1 from Jan, the announcement
  email lands cold. Always confirm E1 status before sending E2.
