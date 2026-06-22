---
name: bookmarked-outreach-email
description: "Use when drafting Bookmarked district/customer outreach or re-engagement emails as Steve. Keep the ask short, FOIA-aware, peer-to-peer, grounded in account context, and pair with send-as-steve-email before any send."
version: 2.0.0
author: agent
tags: [email, outreach, sales, bookmarked, steve-voice, hubspot, gmail]
---

# Bookmarked Outreach Email (as Steve)

## Native Hermes Routing

Use this skill for Bookmarked district/customer outreach and re-engagement drafts. It owns outreach structure, FOIA-aware tone, district/customer ask shape, and live-edit lessons. It does not grant send authority.

Source-of-truth order:
1. Steve's current ask and any pasted words.
2. G-Brain + `district-account-pickup` for account/person context.
3. HubSpot/Google Workspace for live CRM/thread facts when needed.
4. `steve-email-voice` for corpus-derived voice.
5. `send-as-steve-email` for approval/send/BCC mechanics.

Output mode: short, warm, peer-to-peer, one ask, no feature dump. If Steve asks to send, switch to `send-as-steve-email` and enforce final approval.

How to draft and send outreach email that genuinely sounds like Steve and logs
correctly to HubSpot. This is the WORKFLOW skill (structure, voice rules, BCC,
sending mechanics). For a deep corpus-derived voice profile, also consult the
`steve-email-voice` skill once it exists (built from analysis of Steve's actual
sent mail).

The single job of a re-engagement / outreach email is usually ONE thing — get a
meeting or a reply. Resist the urge to do a feature dump. Everything that isn't
serving the one ask is cut.

---

## Voice Rules (learned from live edits — Steve corrects hard on these)

These are non-negotiable. Each one came from Steve rejecting a draft.

1. **SHORT.** Steve cuts length every time. A re-engagement email is ~4–6 short
   sentences plus a P.S. If a sentence isn't serving the ask, delete it. Save the
   product detail, PD invites, and vision for the actual meeting.

2. **NO em dashes (—).** Steve reads em dashes as AI-generated and dislikes them.
   Use commas, periods, or separate sentences instead. This applies to en dashes
   used as connectors too. Check every draft for `—` before sending.

3. **Avoid clichéd startup / filler words.** Specific words Steve has rejected:
   - "ragged" (as in "this year ran you ragged") — sounds bad
   - "grind" (as in "16-day acquisition grind")
   - "snapshot" (as in "good snapshot of where this is headed") — filler
   When in doubt, plainer is better. See `references/voice-corrections-from-live-edits.md`
   for the running banned-word list and the exact rewrites that landed.

4. **Don't quote someone's pain point back with hard numbers.** Reference that
   THEY raised it, softly. Not "the 16-day, 10-hour acquisition grind you described"
   but "which I know is something you brought up when we last spoke." It signals
   you remember without feeling like a sales callback.

5. **Own shared difficulty on "we" — never make the recipient feel bad.** When
   meetings were missed or a relationship drifted, put it on the timing/the
   relationship, not the person. "I know we tried all year to get our check-ins
   going and the timing never quite worked" — NOT "you cancelled all our meetings."

6. **Frame the ask as Steve wanting to find a way; frame feedback as valuable to
   Bookmarked, not a favor under pressure.** "More than anything I'd love to find
   a way to actually get Humble using it... that kind of feedback is gold to us."

7. **Social proof = peer momentum, not hype.** Reference a peer district doing
   the thing well (e.g. Conroe), framed as "what they've been doing and it's made
   a real difference," never "look how big we're getting."

8. **Single, open-ended ask at the end.** "What do the next couple weeks look
   like?" beats proposing a specific slot she can decline. Offer in-person OR Zoom.

9. **P.S. is a good device** for a secondary item (a link, a clip). Tell the
   reader WHAT they're about to see and WHY it matters to them specifically — that
   earns the click far better than "good snapshot."

10. **Subject lines: witty, warm, self-aware, never accusatory.** When meetings
    were missed, a subject can wink at it on the shared "we" without pointing at
    the recipient. "the one meeting we keep missing" landed. Offer 4–8 options
    when Steve is choosing; he picks fast.

---

## IMTA-Framed Emails — Different Beast

When the email is about IMTA funding availability (not general re-engagement), the voice rules still apply but the *structure* shifts:

- **Lead with the fact, not the relationship.** "We checked and you have $X.XM in unspent IMTA funds" is the opener — not rapport-building first.
- **Frame immediately: IMTA ≠ general fund.** One sentence: "This is a separate, earmarked account — the deficit picture doesn't touch it."
- **Keep it SHORT — even shorter than normal.** This is a door-opener, not a proposal. 3-4 sentences + a question.
- **Use the unspent carryover figure** (what's sitting in their EMAT account NOW), not the biennial allotment (forward-looking and abstract). Jan's EMAT-sourced number is the one to use.
- **No ROI framing, no feature list.** IMTA emails are procurement conversations, not value-sell conversations. "You have the money, we're eligible, let's talk about how you spend it" is the entire message.
- **Mention ESC 16 if relevant** — "procurement through ESC 16 means no RFP required" is a meaningful line for a finance-aware contact.
- **Don't lead with the relationship track** — keep the Bookmarked deal and the TALAS/personal track clearly separated in the email. One message should do one job.

**Source for Garland IMTA figures:** Jan Gilboy's Confluence page (Sales Hub, page 147488769). Always cross-check before quoting numbers. $2.17M = unspent carryover for Garland (the actionable number). $9.2M = biennial allotment (forward-looking).

**Keep the TALAS relationship and the Bookmarked deal on separate tracks.** When emailing Michael Ruiz: the IMTA/Bookmarked deal email goes through Taylor (Michael's scheduler) on the Bookmarked track. The TALAS/personal collaboration work is a separate relationship that Steve manages personally. Never mix the two in one email — it muddies both. The IMTA email to Michael is a deal email; it should not reference the TALAS AI infrastructure work or vice versa.

---

## Standard re-engagement structure

1. Open straight into the honest acknowledgment (no "it's been too long" preamble —
   Steve cut that; you both already know).
2. One sentence on what's improved, tied to a problem the contact actually cares about.
3. The real ask: get them using it next year + give honest feedback, with a peer
   proof point.
4. Logistics: coffee in person (offer to drive to them if they're worth it) or Zoom.
5. Single open question.
6. P.S. with the link/clip and a one-line "here's why it's worth your two minutes."

---

## Sending: BCC + HubSpot logging

**District / customer outreach email BCC rule (durable):**
- BCC `jan@bookmarked.com` (Jan Gilboy, sales) AND `39855019@bcc.hubspot.com`
  (Steve's HubSpot portal logging address).
- The HubSpot address goes in **BCC, never CC.**
- When Steve says "BCC HubSpot," it means `39855019@bcc.hubspot.com`. This is
  already in agent memory — do not ask for it.
- Send from `steve@bookmarked.com` (work token at `~/.hermes/google_token.json`).

**Technique — the google-workspace CLI has no `--bcc` flag.** `google_api.py gmail
send` supports `--to`, `--cc`, `--from`, `--html` but NOT `--bcc`. To set a true
BCC header you must build a raw MIME message and send it through the Gmail API
directly with the work token. Use `scripts/send_email_with_bcc.py` (edit the body,
to, bcc, subject, then run with `~/.hermes/hermes-agent/venv/bin/python3`). It
prints the sending identity, the message id, and you should verify headers after.

**Always verify after sending** — re-fetch the sent message metadata and confirm
To / Bcc / From / Subject are exactly right before telling Steve it's done.

---

## Drafting Process

1. **ALWAYS load `steve-email-voice` first.** It's the corpus-derived voice profile
   with annotated examples, patterns by relationship type, and the full checklist.
2. **Search G-Brain** for the contact's page, recent transcripts, how they talk about
   Bookmarked. A specific, remembered detail is the most powerful thing in the email.
3. **Draft, then expect 3–9 rounds of edits.** Steve edits hard. Each revision is a
   full clean re-draft, not a diff. Make the single change and re-present the whole
   email clean so he can read it in full. Don't argue the small stuff.
4. **After sending:** proactively flag related cleanup (HubSpot deal missing contacts,
   duplicate contact records) but don't block the send on it.

---

## Post-Send: HubSpot Cleanup Workflow

After sending a district email, offer these HubSpot cleanup steps. Steve's HubSpot
Private App token lives in `~/.hermes/config.yaml` under
`mcp_servers.hubspot.env.PRIVATE_APP_ACCESS_TOKEN`.

### 1. Ensure contact exists

```bash
# Search by email
curl -s 'https://api.hubapi.com/crm/v3/objects/contacts/search' \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"filterGroups":[{"filters":[{"propertyName":"email","operator":"EQ","value":"recipient@example.com"}]}]}'
```

If not found, create:
```bash
curl -s -X POST 'https://api.hubapi.com/crm/v3/objects/contacts' \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"properties":{"email":"recipient@example.com","firstname":"First","lastname":"Last","company":"District Name"}}'
```

### 2. De-duplicate contacts

When searching by name reveals duplicates (common with Plaud transcription imports,
different email variations, or HubSpot form fills):

```bash
# Merge duplicate INTO primary (primary survives, dupe is absorbed)
curl -s -X POST 'https://api.hubapi.com/crm/v3/objects/contacts/merge' \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"primaryObjectId":"SURVIVING_ID","objectIdToMerge":"DUPLICATE_ID"}'
```

**IMPORTANT:** Merge returns a NEW surviving contact ID — the original primary ID
may no longer be valid. Always capture the returned ID and use it for subsequent
association calls.

### 3. Associate contact with deal

```bash
# Link contact to deal (v4 default association)
curl -s -X PUT \
  "https://api.hubapi.com/crm/v4/objects/deals/$DEAL_ID/associations/default/contacts/$CONTACT_ID" \
  -H "Authorization: Bearer $TOKEN"
```

Verify the deal now shows 1+ associated contact in the HubSpot deal view.

---

## Worked Example: Melissa Leigh / Humble ISD (June 9, 2026)

Full edit arc lives at `steve-email-voice` skill →
`references/melissa-leigh-reengagement-email.md`. Summary of the workflow:

1. **Context pull:** G-Brain page `melissa-leigh-humble-isd`, HubSpot deal
   (26/27 renewal, $44,382, 50%), meeting history (stood up all year).
2. **Drafted** re-engagement email following the standard structure above.
3. **8 rounds of edits** — Steve corrected "ragged," "grind," em dashes, the P.S.
   framing, the subject line, and the ask nuance (see voice corrections reference).
4. **Sent** with raw-MIME Gmail API (BCC'd `jan@bookmarked.com` AND
   `39855019@bcc.hubspot.com`). Verified headers after send.
5. **Subject line:** "the one meeting we keep missing" — witty and warm, owning
   the shared miss lightly.
6. **HubSpot cleanup after send:**
   - Found two duplicate contact records for Melissa Leigh (different email
     variations).
   - Merged duplicates via `POST /crm/v3/objects/contacts/merge`.
   - Captured the new surviving contact ID from the merge response.
   - Associated the surviving contact to the 26/27 renewal deal via
     `PUT /crm/v4/objects/deals/<dealId>/associations/default/contacts/<contactId>`.
   - Confirmed deal now shows 1 associated contact.

---

## Support files
- `references/voice-corrections-from-live-edits.md` — running list of exact words
  Steve rejected and the rewrites that landed; grows every time he corrects a draft.
- `scripts/send_email_with_bcc.py` — raw-MIME Gmail send with true BCC support.
