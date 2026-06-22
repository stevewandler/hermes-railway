---
name: bookmarked-equity-comp-plan
description: "Use when Steve is thinking through Bookmarked's 2026 equity incentive plan, Charlie's equity compensation questions, stock options vs restricted stock, ISOs/NSOs, 409A, 83(b), vesting, advisor grants, W-2 conversion, cap table implications, and Scale/legal escalation."
version: 1.0.0
author: Hermes Agent
tags: [bookmarked, equity, stock-options, iso, nso, 409a, cap-table, charlie, scale]
---

# Bookmarked Equity Compensation Plan

## Purpose

This skill is not a tax-law autopilot. It is a bounded decision-support framework for Steve Wandler's Bookmarked 2026 equity incentive plan, especially the response to Charlie Clines' June 3, 2026 email.

The job is to help Steve reason clearly, avoid fake certainty, separate technical mechanics from business judgment, and identify what must go to Scale Firm or tax counsel before it becomes final.

Hard rule: do not make up tax/legal conclusions. If the point is not grounded in a primary source, Charlie transcript/email, Bookmarked document, or Scale guidance, label it as uncertain.

## Source hierarchy

Use sources in this order:

1. Scale Firm or company counsel guidance, when available.
2. Primary tax/legal sources: IRS, IRC, Treasury regs, official forms/instructions.
3. Bookmarked-specific source documents: Charlie emails, Steve/Charlie transcripts, cap table, equity proposal, board materials.
4. Reputable startup counsel explainers for market practice only, not as law.
5. General model knowledge only for framing questions, never for final claims.

Never present a secondary blog or generic startup norm as legal fact.

## Required companion reference

Before doing substantive work, read the source packet if available:

`references/bookmarked-equity-source-packet.md`

For the current state of the Charlie negotiation (what's settled, what's open, what Steve still needs to answer), read:

`references/charlie-june15-reply-positions.md`

If unavailable, rebuild the minimum packet from:
- Charlie's June 3, 2026 email: `gmail/bm/2026/19e8f50acc72`
- June 3 transcript: `gdoc/charlie-and-steve-2026-06-03-11-00-cdt-notes-by-gemini`
- May 29 plan: `gdoc/bookmarked-inc-2026-equity-incentive-plan-proposal`
- March 27 meeting: `meeting-2026-03-27-meeting-with-charlie-clines`
- April 1 meeting: `meeting-2026-04-01-charlie-steve-sync-up`
- April 16 sync: `gdoc/charlie-and-steve-sync-2026-04-16-08-28-cdt-notes-by-gemini`
- May 14 sync: `gdoc/charlie-and-steve-quick-sync-2026-05-14-11-31-cdt-notes-by-g`
- Post Seed Capitalization email: `gmail/bm/2026/19d9bb1f8e2e`

## Classification labels

Every material assertion must be internally labeled as one of these:

- Confirmed tax/legal mechanic
- Supported by Charlie transcript/email
- Bookmarked-specific fact
- Steve business judgment
- Open question for Scale

If you cannot label it, do not say it as fact.

Examples:

"ISOs are only available to employees." Confirmed tax/legal mechanic.

"Raju and Jan should become W-2." Steve business judgment / Open question for Scale. Needs all-in cost and classification review.

"Options are cleaner than restricted stock for this plan." Steve business judgment supported by Charlie transcript and tax/cash constraints, not universal tax fact.

"Steve should receive ISOs." Open question for Scale because of possible 10% owner rules and founder/control issues.

## Technical baseline

### Restricted stock / restricted stock grants / restricted stock awards

Use carefully. Charlie used "Restricted Stock Grants (RSGs)" to mean actual shares transferred now, subject to vesting/forfeiture.

Technical mechanics:
- Property is transferred in connection with services.
- Under IRC 83, ordinary income is generally recognized when the property is transferable or no longer subject to substantial risk of forfeiture, unless a timely 83(b) election is made.
- A timely 83(b) election generally must be made within 30 days after transfer.
- 83(b) accelerates ordinary income to the transfer date, potentially letting later appreciation be capital gain, but if the property is later forfeited, the tax paid is generally not recovered through a deduction for the forfeiture.

Bookmarked implication:
- Restricted stock can transfer current value, not just future upside.
- That can help compensate for prior sacrifice/current alignment.
- But if current company value is meaningful, it can create tax on illiquid stock. Charlie's June 3 example: 10% at $2.5M implies $250K of compensation value; 50% immediate vesting implies $125K of taxable income in his simple example.
- Steve and the team likely cannot absorb meaningful tax bills now. That makes restricted stock hard unless Scale/tax counsel designs a specific structure and recipients understand the tax exposure.

Do not say "restricted stock is bad." Say it solves a different problem and creates current tax exposure.

### Stock options

Technical mechanics:
- Options give the right to buy shares later at an exercise/strike price.
- For private companies, options are typically granted with exercise price at or above fair market value on grant date.
- Options generally do not transfer current stock value if the strike price equals current FMV. They create upside above the grant-date value.
- For most private-company nonstatutory options without readily determinable FMV, there is generally no tax at grant, but income is recognized at exercise on the spread.
- Options require plan/grant documentation, board approval, cap table tracking, and a defensible FMV/409A process.

Bookmarked implication:
- Options fit if the goal is retention, alignment, and future upside.
- Options are less direct if the goal is to give people value for past work/current value already created.
- Past service can be recognized through credited vesting or immediate vesting, but the tax/accounting/legal treatment needs Scale validation.

### ISOs

Technical mechanics:
- Incentive Stock Options are statutory options under IRC 422.
- They are only available in connection with employment, effectively W-2 employees for this discussion. Contractors/advisors do not receive ISOs.
- Must be granted under a shareholder-approved plan meeting ISO requirements.
- Exercise price generally must be at least FMV at grant.
- Maximum ISO term is generally 10 years.
- To get favorable treatment, shares generally must be held at least 2 years from grant and 1 year from exercise.
- ISO exercise generally does not create regular income tax at exercise, but the spread may create AMT exposure.
- The $100K annual first-exercisable limitation can convert excess ISO value into NSO treatment.
- 10% shareholder rules may require at least 110% FMV strike and no more than a 5-year term; Steve's situation must go to Scale.

Bookmarked implication:
- Raju and Jan only get ISO treatment if they are employees when grants are made and other ISO requirements are satisfied.
- ISO eligibility is not by itself enough reason to convert someone to W-2. The company must consider all-in employment cost, classification, benefits/payroll, operational role, and retention/accountability.
- For Steve, ISO treatment is a counsel question because of possible ownership/control rules.
- For large grants, some portion may become NSO because of the $100K limit.

Do not oversell ISOs. They are potentially favorable, not automatically better.

### NSOs

Technical mechanics:
- Non-qualified/nonstatutory stock options are more flexible.
- They can be granted to employees, contractors, advisors, board members, subject to plan and securities constraints.
- For most private-company NSOs without readily determinable FMV, there is generally no tax at grant, but ordinary income is recognized at exercise equal to FMV minus exercise price.
- Employee NSO exercises may create withholding/payroll obligations; contractor/advisor treatment can differ.
- NSOs still need FMV/409A discipline.

Bookmarked implication:
- Advisors and contractors should be assumed NSO unless counsel says otherwise.
- Natasha and any part-time contractor likely receive NSOs if included.
- Michelle, if still fractional/contractor, likely NSO if included at all. Confirm with Scale.

### 409A / FMV / strike price

Technical mechanics:
- Discounted options can create severe adverse tax consequences under 409A, including income inclusion and an additional 20% tax, plus interest/penalties.
- Standard startup practice is to get a defensible 409A valuation and grant options at or above FMV.
- Independent valuations are commonly used for safe harbor; valuation may go stale before 12 months if material events occur.

Bookmarked implication:
- Do not promise a specific strike price before the board/grant date and valuation work are done.
- The plan can discuss allocation percentages and intended recipients, but final grants need Scale/Carta/board process.
- The current cap table has unusual share counts and likely reverse split considerations. Keep share numbers subordinate to percentages until final legal docs and cap table mechanics are confirmed.

### Vesting

Technical mechanics:
- Vesting is the schedule by which the right becomes earned/exercisable/nonforfeitable.
- Standard startup time-based vesting is often 4 years with a 1-year cliff for employees, but Bookmarked can choose other structures if board/counsel approve.
- Acceleration on change of control can affect tax, retention, buyer diligence, ISO $100K treatment, and plan design.

Bookmarked implication:
- Charlie's concern is not merely that vesting varies. It is that the original plan looks like one-off judgments without a consistent philosophy.
- The answer should articulate categories:
  - Founder alignment grant
  - Core operating team
  - Long-tenured/reduced-role contributors
  - Part-time contractors
  - Advisors
  - Future hires
- Past service can be recognized by credited start dates or partial immediate vesting, but confirm with Scale.

Steve's locked vesting philosophy (session 2026-06-13):
- Everyone — including Steve — is on 4-year vesting. No exceptions. Simple and consistent.
- The round close / recap date (May 2026) is the philosophical "restart date" and the credited vesting commencement date for all active grants.
- Do NOT say "backdate." The correct Scale question is: "Can grants use a credited vesting commencement date tied to the round close/recap, and what are the tax/accounting/legal implications?"
- Because the round closed May 2026, by the time grants are signed (likely August 2026+), vesting is already several months in flight. This is intentional and shows commitment.
- Steve's 3-year / no-cliff structure from the original proposal is replaced by 4-year consistent with the team.

### Change in control acceleration

Use carefully.
- Single-trigger means vesting accelerates on a transaction itself.
- Double-trigger generally requires transaction plus termination/material role change.
- Charlie said he believes CIC acceleration is appropriate and 10-year exercise period from grant should be sufficient to reach a liquidity event.

Bookmarked implication:
- Do not assume all recipient categories get the same acceleration.
- Founder/CEO treatment, employee treatment, and advisor treatment may differ.
- Scale should validate exact language and cap table/buyer implications.

## Charlie's June 3 frame

Charlie is not blocking equity. He is forcing precision.

He distinguished:
- Allocation question: who gets what percentage.
- Instrument question: restricted stock vs options vs ISO vs NSO.
- Purpose question: current alignment/retention vs future value creation.
- Tax question: current ordinary income/capital gains possibility vs deferral/ordinary spread.
- Board communication question: how to explain this to board, Scale, and team without mixing concepts.

Charlie's key positions from June 3:
- The current 20% pool is appropriate for current team alignment and retention.
- Options and restricted stock are not interchangeable.
- Options generally award future value above current FMV; stock grants award current value.
- The structure has major tax consequences for Steve and team.
- Above a $10M threshold, there may be a separate performance/wealth-creation layer, potentially 25-30% above $10M, not necessarily uniform across employees.
- It may not be necessary to hoard too much of the 20% pool because Series A may reset the structure anyway.
- Different structures per person can be okay, but the rationale must be clear.

## Charlie's four email questions

### 1. Michelle and Jason Cochran exclusion

Known from Steve:
- Jason was a founder/board member, had founder equity, was not actively involved operationally, resigned before the recap, and his founder equity was recapitalized/crushed like Steve's.
- Steve's view: Jason does not belong in the new employee option plan because that plan is for current builders.
- Michelle was previously full-time/fractional CFO but has pulled back; current involvement is part-time at best, around 40 hours/month maximum in Steve's view. On May 14 Steve and Charlie discussed moving her to hourly and confirming actual work.

Likely framing:
- Jason is cleaner: founder equity chapter is closed; not active; not in scope of operating-team plan.
- Michelle is nuanced: still connected, but reduced fractional scope; if included, it should be separately evaluated and subordinate to active operators.

Open questions:
- Does Michelle have any contractual expectation, deferred comp, convertible note, or board/investor sensitivity that affects treatment?
- Does Scale see risk in excluding or minimally including Michelle?

### 2. Advisors: Dr. Ott, Ratliff, Capriglione

Known:
- Charlie gets Dr. Ott but asks whether Temple is renewing.
- Charlie does not recall the value proposition for Ratliff and Capriglione compared with Moak Casey.
- April 1 Charlie pushed on advisor equity: making a phone call or two should not automatically get someone onto the stockholder list.

Likely framing:
- Advisor equity should not be automatic.
- If Ratliff/Capriglione remain, define deliverables and vest over time against continued contribution.
- Consider pulling advisor grants out of the first approval package unless the value proposition is explicit.

Open questions:
- Who exactly are the three advisors and what have they done?
- Are any advisors tied to districts/customers in a way that creates ethics/procurement concerns?
- What does Scale advise for customer/superintendent/advisor equity?

### 3. Vesting

Charlie's concern:
- The proposed schedules are all over the place and need a consistent structure.
- Some immediate vesting for past service is appropriate.
- CIC acceleration and 10-year exercise period may be appropriate.

Locked response (2026-06-13):
- 4-year vesting for everyone, including Steve. No exceptions. Simplicity is the point.
- Restart date = round close / recap (May 2026) for all active grants.
- Category-based philosophy, not per-person improvisation.
- Have Scale validate credited commencement date mechanics, CIC acceleration, and exercise period language.

### 4. Raju and Jan W-2 conversion

Charlie's concern:
- What are all-in costs of moving Raju and Jan to W-2?
- Does ISO benefit justify the conversion?

Likely response:
- Do not justify W-2 conversion solely on ISO treatment.
- Evaluate W-2 because Raju and Jan function as core operators/leaders and retention/accountability may call for employment status.
- ISO eligibility is a benefit if conversion makes sense, not the only reason.
- If cost/timing is wrong, NSOs may be the interim route.

Open questions:
- Actual compensation and benefits cost.
- Employer payroll taxes, unemployment, workers comp, benefits, admin burden.
- Worker classification exposure for prior contractor period.
- Raju's tax situation as a US citizen (note: Steve Wandler is the Canadian citizen, not Raju).
- Timing relative to grant date and ISO eligibility.

### Steve's locked positions as of 2026-06-18

Updated after June 16-18 sessions. These were decided and should not be re-litigated:

- **Instrument:** Options as primary vehicle. Standard startup approach. Do NOT frame as "the team can't absorb the tax" — that presumes their finances. Say: "Options defer the tax event until exercise, which is the standard approach for early-stage teams."
- **Steve's founder grant:** Steve wants a separate Scale conversation about whether options are the right instrument for his founder grant specifically. Not a blocker for the team. Framing: "I want Scale to make sure we're using the right structure." NOT "I want special treatment." Charlie flagged the 10% voting rule himself — the door is already open.
- **Vesting philosophy:** Carta/YC standard: 4-year, 1-year cliff, monthly after cliff. Credited start dates for existing team. Link: https://carta.com/learn/equity/stock-options/vesting/. Charlie's 25% immediate/annual proposal achieves the same intent — don't penalize for time served. Let Scale confirm mechanism.
- **Steve's 10%:** Forward-facing founder alignment, not compensation for the recap loss. Scale to advise on instrument and structure.
- **CEO title:** Never use in any external or board-facing communication. Steve's work visa prohibits the CEO title. Use "founder" only.
- **Jason:** Talk to Jason directly FIRST (Steve + Charlie together). Understand what works for him professionally given the conflict-of-interest problem. Then come back with Scale-informed options. A few weeks.
- **Ratliff/Capriglione:** Dan conversation first. Three-way: Steve + Charlie + Dan. Steve to ask Charlie: "Do you want to set that up or should I?"
- **W-2 conversion:** Aligned — defer to Series A. Don't convert now for ISO treatment alone.
- **Advisor pool:** 2% framework agreed. Allocations TBD with Scale input. Moak Casey belongs in the conversation.
- **Performance pool:** Let it go. Charlie's point was valid — options already require hitting milestones for value.
- **Remaining reserve:** Ask Charlie: hold for future hires or revisit any current team allocations?

1. Build/review source packet.
2. Build issue map: what Charlie asked, concern underneath, Steve position, facts, open Scale questions.
3. Walk Steve through each topic in plain English.
4. Capture Steve's actual business judgment.
5. Red-team for unsupported claims or overcommitments.
6. Draft Charlie email in Steve's voice with collaborative posture.
7. Make the email clear that Scale should validate the legal/tax mechanics before docs are finalized.

## Red-team checklist

Before producing any Charlie-facing draft:

- Did we confuse restricted stock, RSU, RSA/RSG, stock options, ISO, or NSO?
- Did we imply options give current value when they generally only give upside above strike price?
- Did we say W-2 conversion makes sense without actual all-in cost?
- Did we say ISO is better without AMT/holding-period/10% owner caveats?
- Did we include advisor grants without defined contribution?
- Did we overcommit to a vesting structure before Scale review?
- Did we cite 409A/strike price with enough precision?
- Did we contradict Charlie's last conversation?
- Did we mark open questions for Scale?
- Did we sound like Steve, not a tax memo?

## Output formats

### Pitfalls (learned from June 2026 sessions)

- **Steve's grant is 10% of the fully diluted company, NOT 2%.** The proposal doc shows Steve goes from 0.005% to 10.005%. He gets 50% of the 20% pool = 10% of the company. Always verify grant math against the source doc: `gdoc/bookmarked-inc-2026-equity-incentive-plan-proposal`. Never calculate from abstract percentages.
- **Charlie's vesting proposal (25% immediate + 25%/yr) departs from Carta/YC standard.** Market standard: 4-year, 1-year cliff, monthly after cliff. Credited start dates achieve Charlie's intent within the standard. Source: https://carta.com/learn/equity/stock-options/vesting/
- **Don't draft equity emails without discussing each topic first.** Walk through every point with Steve, explain what it means, get his position, THEN draft. He explicitly corrected this workflow.
- **Steve's founder grant may need a different instrument than the team.** If >10% voting ownership, ISO rules are less favorable (110% FMV strike, 5-year exercise window). Scale to advise. Steve's frame: "I want Scale to make sure we're using the right structure" — not "I want special treatment."
- **At $40M valuation, Steve's tax bill at exercise is $1.1-1.6M.** He cannot exercise before a liquidity event. Same-day sale at liquidity or early exercise with 83(b) at current low valuation are the practical paths. This is a Scale conversation, not a Charlie email topic.
- **Live equity state page is the single source of truth.** Always pull `ceo-private/equity/live-equity-state` before any equity discussion. Updated after every conversation.

### Plain-English explainer for Steve

Use simple language:

"If we give someone stock, they may own current value and may owe tax now. If we give options, they don't own the current value. They get upside above today's value, and the tax is generally pushed later. That is why Charlie is separating the instrument question from the allocation question."

### Charlie-facing strategic language

Use precise but collaborative language:

"Your framing helped me separate the allocation question from the instrument question. I am aligned that we should not treat restricted stock, options, ISOs, and NSOs as interchangeable. My current thinking is that options are the cleaner primary vehicle for the operating team because the purpose is retention and future value creation, and because I do not think the team can reasonably absorb current tax exposure on restricted stock. I would still want Scale to validate the mechanics before we lock the documents."

### Scale question list

Use direct legal/tax questions:

"Can you confirm whether credited vesting for prior service creates any tax/accounting issues if the grant is structured as options at current FMV?"

"Can you confirm Steve's ISO eligibility given the 10% owner rules and whether NSO treatment may be preferable?"

"Can you confirm whether any advisor/customer equity grants raise securities, conflict, or procurement concerns?"

## Title rule — CRITICAL

Steve's work visa does not allow him to hold the CEO title. Always use "Founder" in any board-facing, legal, equity, or Charlie-facing document or email. Never write "Founder/CEO" — just "Founder." This came up in the June 13 equity email draft and must be caught before any Charlie/board draft goes out.

## HARD RULE — Charlie communications

**NEVER send anything to charlie@bookmarked.com without Steve's explicit review and approval.** This means no auto-send, no direct send from any tool, no send via delegate or subagent. Always create a Gmail draft only. Steve opens it, reads it, and sends it himself. No exceptions, no edge cases, not even if the draft looks perfect.

This rule was stated explicitly by Steve on 2026-06-17: "don't send anything to charlie without my review...EVER!"

## Vesting market standard (confirmed Carta + YC, June 2026)

**Standard: 4-year vesting, 1-year cliff, monthly vesting after cliff.**
- Nothing vests for first 12 months
- 25% vests at month 12 cliff
- 1/48th of total grant vests monthly for months 13-48
- Fully vested at 4 years

Source: https://carta.com/learn/equity/stock-options/vesting/
> "For VC-backed and bootstrapped corporations, the most common recipe for equity grants is a four-year vesting schedule with a one-year cliff. This structure applies to both founders and early employees."

**Charlie's June 15 proposal** was 25% immediate + 25% per anniversary year — done at year 3, annual cadence. Departs from standard in two ways: annual (not monthly) cadence, and completes at year 3 not year 4.

**Resolution**: Charlie's intent and Steve's intent are the same — don't penalize people for time already served. The credited vesting commencement date (backdated to actual start) achieves this within the standard structure. Let Scale confirm the cleanest mechanism. Bring the Carta link as grounding — not as pushback, as homework.

**How to frame it**: "I pulled the Carta standard — 4-year, 1-year cliff, monthly after that. I think your 25% immediate / annual structure is solving the same problem I want to solve: not penalizing people for time served. The credited start date gets us there within the standard structure. Happy to let Scale confirm the cleanest mechanism."

---

## ISO/NSO tax mechanics — plain English for Steve

### Why options, not RSGs
RSGs transfer actual shares now. IRS treats vested shares as ordinary income in the year they vest — a real tax bill on illiquid stock nobody can sell yet. At a $4M valuation with limited cash, nobody on the team can absorb that. Options defer ALL tax until exercise. That's the core reason.

### ISO vs NSO — the real difference
**ISO (Incentive Stock Option)** — available to W-2 employees only:
- No regular income tax at grant or vesting
- No regular income tax at exercise
- If shares held 1 year after exercise AND 2 years after grant date: entire gain taxed at long-term capital gains rates (~20%), not ordinary income (~37%)
- AMT risk at exercise: the spread (FMV minus strike price) may trigger Alternative Minimum Tax even without a sale — real exposure if exercising before a liquidity event
- $100K annual first-exercisable limit — excess becomes NSO treatment

**NSO (Non-Qualified Stock Option)** — available to employees, contractors, advisors:
- No tax at grant or vesting
- At exercise: spread (FMV minus strike price) taxed as ORDINARY income in that year, even with no sale, even with no cash in hand
- Then at eventual sale: additional appreciation above exercise price taxed at capital gains rates

### Steve's specific situation — the 10% voting rule
Charlie flagged this in footnote 2. If Steve owns more than 10% of the voting stock:
- ISO strike price must be set at 110% of FMV (not 100%) — he starts slightly in the hole
- ISO exercise window drops from 10 years to 5 years

This is why Charlie flagged that NSO treatment may actually be preferable for Steve specifically. Scale must confirm Steve's exact voting ownership percentage before instrument is decided for his grant.

### Tax scenario — $4M company grows to $40M
Steve's grant: 10% of the 20% option pool = 2% of fully diluted company.
At $40M company value: 2% = $800K paper value above strike price.

**NSO path (exercise before sale):**
- Spread ($800K) taxed as ordinary income in year of exercise
- ~37% federal = roughly $296-320K tax bill due in cash that year
- No cash in hand until a sale happens

**ISO path (exercise before sale):**
- No regular income tax at exercise
- But AMT on the spread: ~28% = roughly $224K AMT exposure that year
- Still real money due without a sale

**Same-day sale at liquidity event (either instrument):**
- Exercise and sell simultaneously — cash in hand covers the tax
- ISO advantage is reduced (must hold to get capital gains) but you have the cash
- Cleanest path for most founders at pre-liquidity stage

**Practical answer for Steve right now:** Don't exercise until you can see a liquidity event. The 10-year window (if ISO) or 5-year (if NSO given 10% rule) gives time to wait until there's cash available to cover the tax. Early exercise only makes sense now if the 409A valuation is still low enough that the spread is near-zero.

### Cap table math — confirmed (June 2026)

**The correct way to think about it — Steve's framing:**
- The employee stock option pool = 20% of the fully diluted company
- Steve gets 50% of that pool (10% of 20%)
- The remaining 50% of the pool (another 10% of 20%) goes to all other employees combined
- So Steve's grant = 10% of the 20% pool = **2% of the fully diluted company**

This confused the agent early in the session. The equity proposal confirms it: Steve's grant column shows 10.00% but that is 10% of the POOL, not 10% of the company. The cap table impact section shows Steve goes from 0.005% to 10.005% fully diluted — WAIT. That says 10%.

**IMPORTANT: Go to the source document before doing this math.** The equity proposal (`gdoc/bookmarked-inc-2026-equity-incentive-plan-proposal`) shows Steve's grant as 10.00% with 2,788,544,149 shares. The cap table shows him going from 0.005% to 10.005% of the fully diluted company. That is 10% of fully diluted, not 2%.

**The resolution:** The percentages in the grant table ARE fully diluted percentages, not percentages of the pool. Steve's 10% grant IS 10% of the fully diluted company. The pool is sized such that Steve's 10% slice of the pool equals 10% of fully diluted. Don't re-derive this with abstract math — go to the source document.

- Steve's grant = **10% of the fully diluted company** (confirmed by cap table impact table)
- At $40M company value: 10% = **$4M** above strike price
- NSO tax at exercise: ~37% of $4M = roughly $1.5-1.6M — not affordable without a liquidity event
- ISO AMT at exercise: ~28% of $4M = roughly $1.1M — also not affordable without a liquidity event
- **Same-day sale at liquidity event is the practical path for Steve** — exercise and sell simultaneously, cash in hand covers the tax
- At Series A, dilution will reduce Steve's percentage further
- Steve's current grant has the lowest strike price he'll ever get from Bookmarked — get it executed before 409A rises

---

### Steve's founder equity problem — post-recap

Steve is a founder being treated like an employee in the option pool because his original founder equity was wiped out in the recap. He correctly identified this as structurally off. Things Scale should explore for his specific grant:

1. **Restricted stock with 83(b) election at current valuation** — actual shares, not options. Tax paid now on current FMV (10% of $4M = $400K current value, ~$148K tax at 37%). All future appreciation is long-term capital gains. Only makes sense if Steve can afford $148K now.

2. **Early exercise + 83(b) on options** — if options are structured to allow early exercise, exercise at grant when strike = FMV (spread = zero), file 83(b), convert future appreciation to capital gains. At risk: if company fails or Steve leaves before vesting, strike price paid is lost.

3. **Separate founder equity agreement outside the pool** — common stock with vesting, not from the 20% employee pool, at a lower strike price or as restricted stock. Requires board approval. Charlie needs to be aligned. Not standard but not unheard of.

**Steve's honest reality:** He cannot afford $1.5M+ in taxes without a liquidity event. Same-day sale at liquidity is the practical path. The 10-year exercise window (or 5-year if 10% owner + ISO) gives time to wait.

**What to bring to Scale:** One dedicated call — Steve and Scale only — about the right structure for his founder grant, separate from the team equity discussion. Before the board written consent circulates.

**What to say to Charlie Thursday (one sentence):** "I want to have a separate Scale conversation about the right structure for my founder grant before the written consent goes out — I don't think we need to hold up the team grants for that."

1. Treating ISOs as automatically superior. They are not. They have eligibility, AMT, holding-period, and $100K limit issues.
2. Treating options as compensation for past value. They mostly reward future appreciation unless structured otherwise.
3. Ignoring tax capacity. Restricted stock may be elegant but unusable if recipients cannot pay tax on illiquid value.
4. Using advisor equity casually. Charlie is right to push on this.
5. Confusing current allocation from the 20% pool with future performance equity above $10M.
6. Over-hoarding the pool without considering Charlie's point that Series A may reset everything.
7. Sending Charlie a tax lecture. He knows tax. He needs to see Steve understood and has a coherent business view.
8. Stating legal conclusions instead of asking Scale to validate.
9. Speaking for recipients' financial capacity. Do NOT write "the team can't reasonably absorb the tax." That presumes to know their finances. Instead: frame options as standard early-stage practice that defers tax to exercise and keeps focus on future value creation. Let the market norm carry the argument, not an assumption about what the team can afford.

## Charlie's June 15 reply — updated positions (2026-06-16)

Charlie responded on June 15 by annotating Steve's draft reply inline. This changed the state of all four open questions. Current positions:

**Instrument:** Fully settled. Options + ISOs for W-2 employees. No debate. Move on.

**Michelle and Jason:**
- Charlie pushes back on "future contributors only" framing. He believes past contribution matters too — specifically Jason and Tom Bailey bringing in Lyndsey McClelland/funding. Without them, no future.
- He agrees Jason and Michelle's forward contribution is limited vs the operating team, but "not appropriate to completely set aside."
- **Jason conflict-of-interest issue is live and must be addressed:** Charlie is aware of at least 2 situations where Jason's financial association with Bookmarked disqualified him from opportunities. This is why Jason resigned from the board. Framing Jason as an "advisor" on the cap table is problematic — it compounds the conflict, not resolves it. Any advisor framing for Jason must acknowledge and navigate this tension. The compensation committee will weigh in.
- Charlie agrees with Steve's Michelle framing: advisory/transitional, below operating team but above casual advisor, forward-facing rationale.

**Advisors — 2% advisor pool proposal:**
- Charlie's new proposal: create a 2% advisor pool for ALL non-employees — Dr. Ott, Ratliff, Capriglione, Jason, board members, and potentially Moak Casey itself.
- His point: if we're giving equity to non-employees who advanced the work, is there anyone more deserving than Moak Casey?
- He is uncertain about Dr. Ott specifically: "If they don't renew, how effective can he be as an advocate?" Wants clarity on Temple renewal status before committing.
- Ratliff and Capriglione: separate conversation needed with Steve + Dan before putting them on the cap table.
- Steve's position on Moak Casey equity: not yet stated — this is an open question that needs Steve's read.

**Vesting:**
- Charlie aligned. His specific recommendation locked in: **25% immediate vesting, then 25% per year for 3 years, with CIC acceleration.**
- Wants Scale to work with Carta to establish 409A valuation to peg option pricing before grants are made.
- He did not push back on Steve's "round close = restart date" framing.

**Raju and Jan W-2:**
- Charlie agrees: don't convert now for tax reasons alone. His position: address at Series A when moving them to employee status makes sense independently, then capture ISO benefit in the next equity tranche.

**Performance pool ($1M ARR milestone):**
- Charlie lukewarm. His logic: reaching $1.5-2M ARR is already the Series A threshold. The options already create that incentive implicitly — their value depends on hitting those milestones. A separate performance grant may be redundant.
- Not closed, but Steve should have a clear rationale if he wants to keep this.

**Logistics:** Charlie asked to schedule time Thursday or Friday (week of June 9) — that window passed. Need to reschedule.

## Absorbed Skills (consolidated by curator 2026-06-14)
- `charlie-equity-comms` → Charlie communication voice, the Consistency Contract, position-state tracking, Steve-to-Charlie register, collaborative workflow pattern, and draft email mechanics all absorbed into this skill. Charlie comms was the communication layer for the same equity thread.

## Verification checklist

- [ ] Source packet checked.
- [ ] All assertions classified.
- [ ] Open Scale questions listed.
- [ ] Charlie's last verbal position honored.
- [ ] Steve's actual business judgment captured.
- [ ] No unsupported tax/legal claim.
- [ ] No final-document language unless Scale validated it.
- [ ] Output fits the intended audience: Steve explainer, Charlie response, or Scale question list.
