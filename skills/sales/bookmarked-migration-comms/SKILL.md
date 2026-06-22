---
name: bookmarked-migration-comms
description: "Bookmarked V1→V2 (OnShelf Upgrade) customer communications program — wave tracker, template index, voice rules, HubSpot field map, and review workflow for CS email sequences."
version: 1.0.0
author: agent
tags: [bookmarked, customer-success, migration, communications, onshelf, v1-v2, patrick-reid]
---

# Bookmarked Migration Comms — OnShelf Upgrade Program

Owner: Patrick Reid (Customer Success)  
Approver: Steve Wandler (strategic framing + voice)  
Steve's role: review communications only — NOT implementation, technical details, or wave sequencing. Let Patrick lead those.

---

## Where Everything Lives

| Source | URL / Path |
|--------|-----------|
| CS Journey Confluence page | https://bookmarked-team.atlassian.net/wiki/spaces/SD/pages/114982914 |
| Parent migration plan (technical) | https://bookmarked-team.atlassian.net/wiki/spaces/SD/pages/92504065 |
| GitHub comms repo | https://github.com/BookmarkED-Corp/v1-v2-migration/tree/main/communications |
| Framework doc | `communications/framework.md` in the repo |
| Email templates | `communications/templates/` in the repo |

Fetch Confluence pages via `requests` + Atlassian API (see atlassian-mcp skill).  
Fetch GitHub files via `gh api repos/BookmarkED-Corp/v1-v2-migration/contents/...` from `terminal()` — NOT from execute_code (gh not available there).

---

## Strategic Framing (CEO Direction)

> "This is not a migration in how we talk to districts. It's a major product update. The messaging should feel like good news, not an administrative notice."

**Product name:** OnShelf. OnShelf Review is the lead module. Do **not** use "V2" or "the new platform" in district-facing content. Do **not** use the retired bundled name "OnShelf Review and Engage" unless quoting old source material.

### The Four Pillars — All district comms anchor here
1. **Significant improvements** — book ordering dashboard, enhanced book intelligence, better library management tools
2. **Platform move** — district transitions to OnShelf Review and Engage on [date]
3. **Walk-through offer** — offer to show them the new features
4. **Extended access** — September 1, 2026 to explore at their own pace; current agreement renews on [date]

---

## Hard Language Rules

**Never use in district-facing content:**
- "migration" / "migrated" (use "upgrade," "transition," "moved")
- "V1" / "V2" (internal only)
- "sunsetting" / "old system"
- Em dashes (hard rule, all customer content)

**Always use:**
- "OnShelf" as the product name
- "OnShelf Review" only when referring specifically to the book review / order workflow module
- "enhanced platform" / "major product update" / "new capabilities"
- "we built this for you" / "excited to show you"

**Retired naming:** "OnShelf Review and Engage" is no longer the preferred product name. It surfaced Engage too prominently. Keep it only when quoting old artifacts; otherwise rewrite to "OnShelf" or the specific module "OnShelf Review."

---

## Email Sequence Map

| ID | Name | Trigger | Owner | Template File | Status |
|----|------|---------|-------|--------------|--------|
| E1 | Sales Intro | Before upgrade date, sales-initiated | Jan | (none yet — gap) | Draft needed |
| E2 | Announcement | District added to wave, cutover confirmed | Patrick/Houston | `announcement-email.md` | Approved |
| E3 | Data Checklist | HubSpot stage = Data Checklist Sent | Patrick/Houston | `checklist-email.md` | Approved |
| E4 | 4-Day Bump | 4 days, no checklist response | Houston (auto) | `nudge-email.md` | Approved |
| E5 | M-Day Minus 1 | 8 days total, no response, night before cutover | Patrick (personal) | `mday-minus1-email.md` | Approved |
| E6 | Go Live | Cutover complete + district signed off | Patrick/Houston | `golive-email.md` | Approved |
| E6b | Post-Transfer | Cutover complete, no prior sign-off | Patrick | `post-transfer-email.md` | Approved |
| E7 | 48-Hour Check-In | M+2 | Patrick | Confluence page 123535371 | Draft — has V2 rule violation |
| E8 | 7-Day Check-In + Verification | M+7 | Bryan | Confluence page 123699201 | Draft |
| E9 | V1 Going Away | M+37 (7 days before V1 offline) | Patrick | Confluence page 123731969 | Draft — has V1 rule violations |
| E10 | V1 Offline Final | M+44 (V1 shutdown day) | Patrick | Confluence page 123535393 | Draft — "migration" in body |

**Also:** W2 = Live V2 Orientation Webinar (M+1 to M+2, Patrick hosts, 60 min, per-wave)

---

## HubSpot Field Map

| Field | Location | Notes |
|-------|----------|-------|
| `cutover_date` | HubSpot Migration ticket | Source of truth for cutover |
| `contract_end_date` | Deal in 26/27 Renewal Pipeline (ID: 798674460) | Jan + Michelle own accuracy |
| `migration_wave` | HubSpot Migration ticket | Wave number; update if delayed |
| `checklist_signed_off` | HubSpot ticket | `district_confirmed` = signed off |

**Renewal Date Gate (hard rule):** No announcement email sends without `contract_end_date` confirmed. Slack Jan (`<@U0ADPJGL33Q>`) in #renewals if missing.

---

## Non-Response Operating Rule

4 days after checklist → no response → send 4-day bump (E4)  
8 days total → no response → send M-Day Minus 1 (E5, Patrick personally), proceed with cutover  
Post-cutover with no sign-off → send Post-Transfer (E6b), not Go-Live (E6)  
14 days post go-live with no response → assign follow-up to Bryan

Do NOT hold the cutover for non-response.

---

## Wave Status (as of session 2026-06-10)

**Wave 1 (May/June 2026):** La Grange ISD, Dodd City ISD, Olney ISD, Mason ISD, Midland ISD. Announcement emails sent May 28. W1 webinar June 2.  
**Wave 2 (June 10-11, 2026):** Krum ISD (June 10), Henrietta ISD (June 11).  
**First production migration:** Midland Academy Charter School — May 27, 2026.

---

## Known Issues / Open Flags (as of 2026-06-10)

1. **E1 (Sales Intro) doesn't exist yet** — gap in the sequence; Jan needs a deadline
2. **E7 body uses "V2" directly** — rule violation, needs rewrite before send
3. **E9 uses "V1" twice in customer-facing body** — rule violation; swap to "the original platform"
4. **E10 body says "your migration is fully closed"** — swap to "your transition is complete and verified"
5. **Houston not introduced to districts** — automated emails arrive from unknown sender; trust risk with FOIA-aware school admins
6. **E8 framing tension** — verification-heavy at M+7 may feel engineer-driven; worth discussing with Patrick whether it's a verification email or a relationship email

---

## Steve's Review Role

Steve reviews for:
- Voice and tone alignment with the Four Pillars
- Language rule compliance (no V1/V2/migration/em-dashes)
- Trust signals (who districts hear from, how it feels)
- Gaps in the sequence that sales or renewals will surface

Steve does NOT review:
- Technical migration scripts or data mapping
- Wave sequencing and M-Day scheduling
- HubSpot workflow configuration

---

## Absorbed Skills (consolidated by curator 2026-06-14)
- `v1-v2-migration-comms` → operational context (wave tracker, template issues, sender model, non-response rule) absorbed into this skill's main body. Its `references/template-review-2026-06.md` is the detailed template audit.

## Reference Files

- `references/email-templates-snapshot-20260610.md` — full text of all approved templates as of June 10, 2026 session
