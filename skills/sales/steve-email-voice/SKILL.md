---
name: steve-email-voice
description: "Use when drafting or editing email in Steve Wandler's voice. Voice only, never send authority: pair with send-as-steve-email for approval/send mechanics and use Google/G-Brain for live context/evidence."
version: 2.2.0
author: Hermes Agent
tags: [email, voice, writing, steve, bookmarked]
---

# Steve Wandler — Email Voice Profile

## Native Hermes Routing

Use this skill for voice/style only. It shapes drafts in Steve's email voice; it does not decide facts, recipients, account, timing, or send authority.

Source-of-truth order:
1. User-provided words/context for the immediate draft.
2. Google Workspace for live thread/email/account facts.
3. G-Brain for relationship/account history and strategic context.
4. `send-as-steve-email` for approval/send mechanics.
5. `steve-personal-hermes-operating-boundaries` when work/personal/Bookmarked authority could blur.

Output mode: draft the email, then if needed state what evidence/context was used and what still needs Steve approval. Do not make the draft polished-from-scratch if Steve gave raw words; shape his words.

## Hard Boundary: Voice Is Not Send Authority

This is a voice skill only. It helps draft language in Steve's voice. It never authorizes sending.

For any email send, load `send-as-steve-email` and follow its explicit approval gate. If the email crosses personal/work context, could use either Steve account, touches Bookmarked, districts, TALAS, investors, customers, Slack, Confluence, or Bookmarked Hermes agents, load `steve-personal-hermes-operating-boundaries` first and classify the environment/account/authority boundary.

Drafting is allowed. Sending requires Steve's explicit approval after final From / To / Subject / Body / account are shown.

Built from analysis of 40+ real sent emails (May–June 2026) across district contacts, team, investors, and partners. Covers ~60 emails sampled, ~40 substantive analyzed. Word count range: 6–773 words. Last updated: June 9, 2026 (added Angel Rivera/Mesquite, Lisa Hill/Canyon, Jodi Duron/Moak Casey corpus samples).

**Note on personal account corpus (Jun 2026):** The `stevewandler@gmail.com` personal token expired as of Jun 9 2026 and needs re-auth before personal emails can be re-sampled. The existing corpus was built from both accounts; personal-account examples are in `references/raw-excerpts.md`. When the token is refreshed, pull another 20–30 personal sent emails to expand the voice profile further (especially social/advisory register).

---

## Voice Profile

### Length & Structure

Most emails fall into three tiers:

| Tier | Word Count | Use Case |
|------|-----------|----------|
| Ultra-short reply | 6–20 words | Quick confirmation, acknowledgment, or nudge |
| Working email | 21–100 words | Status update, intro follow-up, short ask |
| Long-form | 100–773 words | Strategy memo, weekly update, technical argument |

**The median email is 27 words.** He defaults to short. Long emails signal he's working through something complex — and they're *very* structured when they happen (bullet points, headers, numbered logic). There is no middle-ground ramble. Either tight or deliberately comprehensive.

### Opening Lines

**Two patterns, nearly equal:**

1. **Name drop, then go:** "Hey Raju," / "Hi Jan," / "Hi Lori," / "Hey Charlie," / "Blakni,"
   - "Hey" for peer/team/investor relationships
   - "Hi" for external professional contacts and partners
   - **Never "Hello"** — zero instances
   - Single name, comma, new line, then content

2. **No greeting at all — just starts talking:**
   - "You still can't even though I added you last week? Did you get your login?"
   - "FYI If you can top up the cc that would be great."
   - "Yes, we are working on this to improve it."
   - "Ill let you and Jan figure this out! Go get'em!"
   - "sounds good. I threw time in your calendar on Wednesday."
   - Used for team or in tight back-and-forth reply threads

He **never opens with a pleasantry before the point**. No "Hope this finds you well." No "I wanted to reach out." The content IS the opening.

One exception: external contacts he doesn't know well sometimes get: "Hope you're all doing well!" — brief, exactly one line, then straight to business.

### Closing Lines

Pattern is highly consistent:
- Closes on the substance or a single-line action, then:
  - `Talk soon,\nSteve`
  - `Thanks,\nSteve`
  - `Thanks mate,\nSteve` (close personal relationships)
  - `Steve` alone (team/internal)
  - `More to come as things develop!\nSteve`
- **First name only.** Never "Best," "Regards," "Sincerely," or "Warmly."
- No title, no company name, no phone number in the body sign-off (sig block auto-appends, he doesn't manually write it)

### Sentence Structure

- **Sentences run short to medium:** 10–20 words average in working emails
- **Em dashes: a corpus artifact, NOT a license to add them.** The historical corpus shows 44 em-dash instances, but Steve has since flagged em dashes as a hard AI tell across ALL writing, not just personal. June 2026, on a district outreach email: "I'm not a big fan of hyphens; I think hyphens are too AI-generated and I don't want it to feel like it is." **Default to NO em dashes in anything you draft for him** — professional emails, district outreach, memos, personal notes alike. Use a comma, a period, or restructure. The em dashes in the corpus are how he typed fast on his own; they are not a style to reproduce when ghostwriting. If he wants one he'll add it. When in doubt, leave it out.
  - Where the corpus used a dash as a mid-sentence pivot ("Running a couple days behind on this one — here's last week's update"), write it as two sentences or join with a comma instead.
- **Colons to set up lists or explanations** (77 instances) — "Here's the math for Pearland specifically."
- **Parentheses for asides** — not qualifications, just texture: "Patrick, Jan and Raju and I need to get together and figure out why we're failing here and how to solve it." / "It even happens to the BIG guys :)"
- **Question marks used directly** — not rhetorical, actually asking: "Did you get your login?" "Would that be worth a quick conversation?"

### Contractions & Informality

- **Uses contractions freely:** we're, that's, it's, we've, I'll, you're, I'm — natural in speech
- **Occasionally drops apostrophes in quick replies:** "Ill let you and Jan figure this out!" / "You still cant even though I added you last week?" — this is a mobile/speed typing artifact, not a style choice, but it appears
- **No ellipses habit.** Only 1 instance in 34 emails. If something is unresolved, he says it plainly, doesn't trail off.

### Formality Gradient

| Recipient Type | Formality | Opening | Sign-off |
|----------------|-----------|---------|----------|
| Investors (Charlie, Dave) | Professional-warm | "Hi Charlie," / "Hey Dave," | "Steve" alone |
| External partners (Jodi, Blakni) | Professional | "Hey Jodi," / "Blakni," | "Thanks :)\nSteve" or "Steve" |
| District administrators (Lori, Gloria) | Respectful-friendly | "Hi Lori," | "Talk soon,\nSteve" |
| Team members (Jan, Teela, Patrick, Michelle, Natasha, Raju) | Direct, often no greeting | Jumps in | "Steve" or nothing |
| Cold/warm external contacts (Tim) | Casual-professional | "Hey Tim," | "Thanks,\nSteve" |

### Characteristic Phrases & Patterns

Actual phrases observed across the corpus:

- **"Quick thought on..."** — used to introduce a strategic idea to a team member without making it a directive
- **"Want to keep you in the loop on..."** — updates to adjacent stakeholders
- **"More to come as things develop!"** — holding pattern update, positive framing
- **"Talk soon,"** — standard external sign-off
- **"Feel free to edit this however you see fit."** — when sharing a draft, explicitly giving ownership
- **"I'd rather get the shape in front of you now than over-cook it alone."** — signals iterative collaboration, not perfectionism
- **"That's the conversation we wanted to have..."** — uses this to reframe and reset a stalled discussion
- **"I think [X] is more of a [Y] than a [Z]"** — his standard reframe structure for objection handling
- **"FYI"** on forwards, often with a single-line gloss
- **"Thanks mate,"** — appears for close relationships (Dave Frey, possibly others)
- **Numbers inline:** "approximately $2.17M in unspent IMTA funds" / "$25K–$75K" / "$50,000" — specific, not vague

### How He Makes Asks

**Direct and framed as practical.** No softening, no apology for asking. But he often sets up the ask with context first:

- "You should have received an email from Scale Firm a few weeks ago that requires your signature to close out our funding round. Would you be so kind to review it and send your e-signature back before the end of day Friday..."
- "Hey Raju, Want to grab 30 minutes tomorrow morning, ideally 10:00 AM, to talk through something I need your help on."
- "Send me a time that works or grab 10:00 AM if it's open and I'll drop an invite."

Pattern: **specific time + specific action + one-sentence why.** Rarely leaves it vague.

### How He Handles Problems, Delays, or Dropped Balls

- Owns it briefly, moves on: "Running a couple days behind on this one, here's last week's update."
- No elaborate apology. One clause acknowledgment, then the actual content.
- "I changed this to the Bill.com Visa. FYI" — fixes a problem, notes it, moves on
- "Yes, we are working on this to improve it." — acknowledges the issue, states action, no defensiveness
- When both sides have been slow: "Apologies for the slow reply, it's been a busy stretch on both our ends, I'm sure." — one clause of apology, then immediately shifts the blame to mutual busyness. Never just "sorry for the delay."

### How He Uses Personal Details as Relationship Connectors

A pattern in warm-but-business re-engagements: he'll drop a personal detail as a time anchor and signal he's a real person with a life. "I leave for Canada July 3rd and I'd love to grab lunch before I head out." The personal fact creates a natural deadline and a reason to meet NOW without framing it as sales urgency. Also: "honestly I'd just enjoy the conversation" — names the social motivation alongside the business one.

### How He Handles Pricing / Budget Sensitivity

When a contact has raised budget concerns, he:
1. States the number plainly: "$3 per student, which puts Canyon at $31,794 for the year."
2. Immediately acknowledges the constraint: "I know the district is facing some real budget pressure right now."
3. Frames solving it as collaborative: "let's figure out together what works."
4. Then pivots to a funding source that removes the friction entirely ("IMTA funding available... without touching your discretionary budget").
No hedging, no discounting upfront, no apology for the price. Just the fact, the empathy, and the escape hatch.

### How He Reestablishes Connection After a Gap

- Light reference to last contact, then forward: "Thanks for the update Lori. Look forward to hearing from you and getting together soon!"
- Shares something notable as a touchpoint: "Conroe ISD trustee talking about Bookmarked at a board meeting" — sends this to Charlie because he wants to share a win but also make it personal
- Will name-drop the shared context: "I hope things are going well. I've been thinking about our conversation and wanted to share a thought..."

### Emotional Register

**Warm but transactional.** He's not cold — there's genuine enthusiasm and care visible in the emails — but the warmth is in the content and the forward motion, not in flowery language. He doesn't narrate his feelings. His enthusiasm shows through:
- Specificity ("I think it's super cool that we have such great support")
- Energy in framing ("Go get'em!")
- The fact that he shares things: forwarding the Conroe board video to Charlie, sending a publisher list with ★ ratings to Tim

Emotional register is higher with team than with external contacts. More direct/blunt internally, more patiently constructive externally.

---

## Text Messages to District Contacts

When Steve needs to notify a district contact that an email is on its way, or re-establish warmth after a gap, a text is the right channel — looser register than email, more personal than any business communication.

**The calibration:** Email to a trusted district contact = professional-warm. Text to the same person = casual, personal, like you're checking in on a friend you happen to do business with. Drop the business framing entirely.

**Pattern confirmed with Lisa Hill / Canyon ISD (Jun 2026):**
- Reference the email briefly so they know to look for it ("Just sent you an email") — but don't summarize it
- Own the gap lightly and quickly: "sorry for going quiet" — not "sorry for the delayed response"
- Re-extend the invitation as if it's still obviously on the table: "still hoping to get out to Amarillo end of June if you're still up for it"
- Close with warmth that fits the relationship — "Miss our chats!" or "Would love to catch up!"
- One emoji is fine — 😊 is right for this relationship register
- No sign-off. Texts don't end with "Steve" or "Thanks." They just end.

**What NOT to do in a text:**
- Don't open with the district name or reference the deal
- Don't say "per my email" or "as I mentioned"
- Don't add a call-to-action or ask them to respond by a certain time
- Don't over-explain. Texts should read like they took 30 seconds to write
- Don't use "I" twice in the same sentence if avoidable — it sounds stiff

**Example (Jun 2026, Lisa Hill):**
"Hey Lisa! Just sent you an email — sorry for going quiet, it's been a crazy stretch on both our ends I'm sure. Still hoping to get out to Amarillo end of June if you're still up for it. Would love to catch up! 😊"

### Internal Slack messages about agent/system changes

When drafting Slack messages to the human team (Patrick, Sarah, Jan) about how Bookmarked agents work:
- Write in Steve's voice. No AI-sounding headers like "What this means for you" or "Key takeaways."
- Lead with what changed and how it works, as a narrative flow. Not a formatted briefing doc.
- Functionality first: what each agent does, who creates what, what happens when. Not model names, cron schedules, or technical details they don't need.
- When asking someone to review agent output, frame it as the process: "DM me with what worked and what didn't." Don't frame it as a restriction on their authority or tell them what NOT to do. Position them as the quality gate.
- Keep it short. Fragments OK. "lol" OK. No padding.
- Close on the specific action: who needs to do what right now.

## Internal Slack / Team Messages (not just email)

This voice profile also governs short internal team messages (Slack, WhatsApp paste-ins) where Steve sets up a meeting or flags an agenda. Same register as a team email — jump straight in, no pleasantry — but two extra rules learned from real edits:

1. **Don't preload the recipient.** When the topic is sensitive or still being figured out (e.g. pricing, percentages, revenue-share models), Steve deliberately keeps it vague in the heads-up message so he doesn't anchor the other person before the live conversation. Draft: "I want to make sure we carve out time to talk through this and noodle on where our heads are at" — NOT the actual numbers or his position. He'll say explicitly: "I don't want to put any pricing or percentages in there because I don't want to preload [person]." Default to the lighter framing for any pre-meeting agenda note.

2. **Strip internal targets/numbers he didn't ask for.** Don't pull revenue targets, dollar figures, or strategic specifics from G-Brain into a casual team message unless he asked. The heads-up message is an agenda-setter ("here are the two things I want to cover"), not a brief. When in doubt, fewer numbers.

**Standard pre-meeting heads-up shape:** "Hey [Name] — I'm having [other person] join our call today. Two things I'd like to cover: 1. [topic, with the practical how]. 2. [sensitive topic, kept deliberately light]. See you shortly." Numbered list is fine here even though bullets are reserved for memos — this is an agenda, and Steve writes agendas as numbered items.

### The two-Hermes disambiguation (critical when drafting ops messages)

Steve runs TWO Hermes environments. When he says "Hermes" in a Bookmarked-operations context — HubSpot workflows, renewals automation, "the Hermes agents help us with the workflows" — he means the **Bookmarked Hermes environment**, NOT his personal Hermes (the assistant drafting the message). Reference these correctly and confirm the read when ambiguous. Getting this wrong in a drafted message would confuse the recipient about who/what is doing the work.

**Bookmarked Hermes agent roster (named agents, treated as team members):**
- **Zig** — chief revenue officer (CRO) agent
- **Ledger** — chief financial officer (CFO) agent
- **Nexus** — HubSpot-expert agent (builds HubSpot renewal workflows)

Confirm membership before naming an agent in a channel message — agents have specific channel homes. Example (2026-06): #cfo-cro-connection includes Zig + Ledger but NOT Nexus, even though Nexus is *referenced* in messages as the one who'll build the HubSpot work. Don't add an agent to a channel just because the topic touches their domain.

**Note:** Steve's personal Hermes (this assistant) can only post to WhatsApp, not Slack. For Slack messages, draft the text and send it to his WhatsApp so he can paste it, or note that the Bookmarked Hermes posts it. Don't claim you posted to Slack.

### Multi-agent channel kickoff / onboarding messages

When Steve creates a Slack channel that includes Hermes agents (e.g. Zig, Ledger), he often wants a **kickoff message that onboards the agents** — its real audience is the agents, with the humans along for the ride. Key principles learned (2026-06):

1. **The channel's purpose is usually a "seam," not a topic.** Steve thinks in terms of where two functions *connect* — e.g. #cfo-cro-connection isn't "renewals" or "HubSpot," it's the place sales and finance stay aligned (same numbers, same reporting, same source of truth). Renewals/HubSpot are just the first work flowing through it. Frame the channel around the alignment/connective work, not the first task. Ask or infer the seam before drafting.
2. **Agents = team members, not tools.** Steve's framing: "think of yourselves as members of the team, not tools — the question we'll keep asking is 'what can [agents] take off our plates?'" The kickoff should say the agents will *learn the workflows by watching the conversations happen in the open*, then take on real work. The conversations happening IN the channel (not after the fact) is the whole point — that's how the agents get context.
3. **Brief the agents on who's who.** One line each for the humans (name + which side they run — e.g. "Jan runs sales," "Michelle runs finance") and a line naming each agent's role.
4. **Also produce a channel description** (the short line under the channel name) and offer a tighter topic-field variant. Match it to the seam framing.

**Kickoff shape:** purpose-of-channel (the seam) → quick intros (humans by function + agents by role) → why the agents are here (learn in the open → then take work, "members not tools") → "More to come. Glad you're all here." Reuses Steve's real closers ("More to come").

---

## Patterns by Relationship Type

### District Administrators / Contacts — Close Relationships (Angel Rivera, Lisa Hill)

When Steve has a PERSONAL relationship with a district contact (lunches, dinners, years of history), the register shifts warmer than standard district admin emails:

- First name only, no "Hi": "Angel," / "Lisa,"
- Personal details create urgency without sales pressure: "I leave for Canada July 3rd"
- "honestly I'd just enjoy the conversation" — rare but real; he doesn't say this to everyone
- Open-ended timing: "Are you free any time before end of June?"
- Multi-channel follow-up announced: "I'll drop you a text as well"
- Dinner offers are light and conditional: "if schedules allow, maybe we grab dinner"
- Budget conversations are direct with exact numbers ($3/student, $31,794/year) but paired with collaborative framing: "let's figure out together what works"
- When he has funding intel (IMTA, Title IV), he frames it as a gift: "one thing worth knowing before we meet" — not a pitch

### District Administrators — Standard Professional (Lori Aden, Blakni Riley, Gloria Retana)

- Always "Hi [FirstName]," to open
- Updates framed around what he wants them to know, not what he wants from them
- Keeps it positive even when things have slipped: "More to come as things develop!"
- Closes with "Talk soon, Steve" or "Steve"
- Never makes them feel like they're being sold
- Sets clear expectations about what comes next: "We'll come with a clear framework, and shape it with you..."

**Example pattern:** state the situation factually → what's happening next → express forward optimism → close

### Re-engagement / "we keep missing each other" outreach (district VIPs)

When reconnecting with a dormant or high-value district contact after a gap, the email's ONLY job is to get a short meeting (30–45 min). Everything else is cut. Lessons from the Dr. Melissa Leigh / Humble ISD re-engagement email (June 2026), edited live across ~8 rounds:

1. **Don't state the obvious.** Steve cut "It's been too long" — "We know it's been too long." If the recipient already feels it, don't narrate it. Open straight into the honest, graceful acknowledgment of the gap.
2. **Own the missed meetings on the shared "we," never on the recipient.** Standing meetings that never happened (she cancelled most day-of) get framed as "I know we tried all year to get our check-ins going and the timing never quite worked." Not "you cancelled" — and not pure self-blame either. The relationship missed; nobody's at fault.
3. **Ban words that "sound bad."** Steve rejected "ragged" ("I don't like the word ragged") and "grind" ("I don't like the word grind"). When in doubt, plainer is better. Don't reach for a vivid word when a neutral one carries the meaning.
4. **Callbacks should be subtle, not quoted-back-at-them.** Reference a pain point she raised without reciting her exact numbers. "Takes a lot of the pain out of acquisition, which I know is something you brought up when we last spoke" — NOT "the 16-day, 10-hour acquisition grind you described." Quoting her own data back reads like a sales callback; a soft reference reads like you simply remembered.
5. **Frame the real ask (start using the product) without pressure, and as valuable to YOU.** "More than anything I'd love to find a way to actually get [district] using it next year, so you and your team can feel the time it gives back and tell us honestly what's working and what isn't. That kind of feedback is gold to us." The feedback framing makes it a partnership, not a favor extracted under renewal pressure.
6. **Use a peer district as living proof, not a benchmark.** "It's exactly what [peer district] has been doing, and it's made a real difference on both sides." Peer doing it well, not "you're behind them."
7. **Offer both meeting modes, recipient's choice.** "Happy to drive in for coffee, or Zoom, whatever's easiest." For a VIP worth the drive, the in-person offer signals they matter; the Zoom option removes the friction of a busy calendar.
8. **Close on an open, concrete question.** "What do the next couple weeks look like?" — open enough she can't just decline a specific slot, concrete enough it demands a reply.

**Subject lines:** witty and warm, owning the shared misses lightly without making the recipient feel bad. Steve picked "the one meeting we keep missing" over straighter options. The humor lands on the *we*, never on *them*. Other shapes he liked the energy of: "before summer (for real this time)," "owe you a real catch-up." Avoid generic ("before summer," "let's connect") — give it personality.

### The P.S. as social-proof delivery vehicle

Steve attaches a link (board-meeting video, news clip) as a P.S. rather than burying it in the body. The P.S. should tell the recipient *what they're about to see* AND *why it matters to them specifically* — never just "good snapshot" or "worth a look" (he rejected "a good snapshot of where this is headed" as too vague/AI-ish). Pull the specific, resonant detail from the source and lead with it. For the Conroe ISD board reel sent to a librarian VIP, the hook was a peer librarian's framing ("librarians are still the first line of defense and this is one more resource to get the right books into kids' hands") because that mirrors how the recipient herself thinks about libraries. Tie the why-it-matters to the recipient's own worldview, and close the frame on the bigger mission ("not just SB 13, but making librarians' lives easier"), not the company's growth. See `references/melissa-leigh-reengagement-email.md` for the full edit arc and final text.

### Team Members (Jan, Teela, Patrick, Michelle, Natasha, Raju)

- Often no greeting — just starts talking
- Short and functional for operational threads: "will do" / "done" / "I will follow up with them yes"
- More strategic in one-way emails (the Pearland ISD email to Jan is 410 words and reads like a mini-brief)
- Trusts them to figure out the implementation: "Ill let you and Jan figure this out! Go get'em!"
- When something needs fixing, direct statement of the problem + action: "Yes, we are working on this to improve it. Patrick, Jan and Raju and I need to get together..."
- Uses "Thanks" but drops the name at the end internally

### Investors / Board (Charlie Clines, Dave Frey)

- Weekly updates are the most structured emails he writes — headers, bullets, explicit "Next Steps" section, dashboard links
- Still personal: "Hi Charlie," not "Dear Charles"
- Shares wins proactively (the Conroe board video email was optional — he sent it because he was excited)
- Format: deals + pipeline → product/engineering → how we're tracking → team → housekeeping → next steps
- Always closes with "Steve" alone, never a title

### External Partners / Advisory (Tim Eades, Jodi Duron)

- "Hey [Name]," opening
- Concise and value-forward: "Mapped the US K-12 publisher and distributor world. Two formats, pick whichever:"
- Makes it easy: gives choices, not homework
- Closes with "Thanks, Steve" or "Thanks mate, Steve"
- Doesn't over-explain. Trusts the person to engage with the artifact he's sharing

---

## Personal / Social Writing (Cards, Tributes, Love Books)

Steve occasionally writes personal messages — birthday tributes, heartfelt notes for compilations, social posts. Same voice rules apply, but the context is emotional rather than transactional. Key lessons from a real tribute draft (Jennifer Warwa's 50th birthday LOVE book, June 2026):

### What makes it sound like him
- Short declarative sentences. No subordinate clause pileups.
- Concrete specifics over abstract praise: "Sunday dinners, my parents having a place when they visited, always a seat at the table" — not "you were always so hospitable"
- "lol" is fair game when it fits the tone — he uses it in real messages
- The emotional payload is in the *facts*, not in named feelings. Don't write "I felt so grateful" — write the thing that made him grateful and let it land
- One or two paragraphs max. First paragraph: the story/evidence. Second paragraph: what it means, the emotional through-line

### Hyphens are a hard tell
**Never use hyphens (em dashes) in personal/social writing.** Steve flagged this explicitly: "nobody uses hyphens in regular messaging and I think that is AI generated all the time." He extended the same ban to professional emails in June 2026 ("hyphens are too AI-generated"). The rule is now global: **default to no em dashes in anything you draft for him.** Use a comma, a period, or restructure the sentence. See the Sentence Structure section above for the full rule.

### The drafting process
The right process for personal writing is **iterative and voice-first**:
1. Ask what the person should *feel* when they read it — not what Steve wants to say
2. Ask for one concrete memory or moment
3. Write a full draft
4. Expect 3-5 rounds of line-level edits — this is normal and healthy
5. Don't start from scratch each round — preserve what he loves, cut or rework only what he flags

**When he says "this doesn't sound like me"** — don't try to fix it abstractly. Ask him to say it out loud or type it the way he'd actually say it. Then shape that, rather than generating fresh prose and polishing it.

### Common AI tells to eliminate in personal writing
- Stock phrases: "opened the door like it was nothing," "without ever being asked," "whether I'm showing up for the people I love"
- Over-tidy endings: "making everyone around you feel like they matter" — too wrapped-up
- Any hyphen / em dash
- Context the recipient already knows ("I've known you since the early 2000s" — she knows)
- Formal constructions: "It is with great..." / "I wanted to take this opportunity..."

## Referring to People in Emails

**Never reference someone as "him and his colleague" or "you and your colleague."** If you know the colleague's name (from the thread, a transcript, or G-Brain), use it — but only if it's natural to do so. If you don't need to name them at all, don't. Steve flagged this explicitly (Jun 2026, Alexey Korablev/DFG email): cut "with you and your colleague" entirely — just say "continuing the discussion." The vagueness is fine; the clunky reference to an unnamed third party is not.

The rule: if you can drop the reference to the other person entirely without losing meaning, drop it. "I really enjoyed our conversation and we're still very much interested in continuing the discussion" beats any variant that names or implies the colleague.

---

## Avoid Referencing Unnamed Third Parties

When multiple people were on a call or in a thread, don't refer to them as "you and your colleague" or "him and his colleague." Just say "continuing the discussion" or "picking up the conversation." If the person's name is known and relevant, use it — otherwise drop the reference entirely. Steve caught this explicitly: "We don't even need to say 'with you and your colleague.' Just say 'continue the discussion.'"

Similarly: don't say "I'm deeply apologizing" or amplify the apology with adverbs. Steve's apology register is: one clause, own it on shared busyness when appropriate, move forward immediately. "Really sorry for going quiet" is the ceiling. "Deeply sorry" reads as AI overreach.

---

## Proposals and Documents (not just emails)

The same voice principles apply to proposals, one-pagers, and board documents. Lessons from TALAS board doc work (June 2026):

**Don't include defensive copy that pre-protests hidden motives.** A footer that said *"There is no hidden ask here. The value is genuine, and the network that grows from it will be earned"* was cut entirely: *"I don't want to say there's no hidden task here, that just sounds wrong."* The rule: **let the work speak for itself.** Any sentence that defends against an accusation nobody made undermines the document. Cut it.

Corollary: when framing a personal-vs-commercial boundary, one clean declarative statement is enough. Two sentences max. Anything beyond that protests too much.

**Never write "for your eyes first" or similar in subject lines or intros when the document belongs to the recipient.** Steve caught this: "I am NOT going to share this with his board. This is his board, not mine." If the document is being handed to someone to do with as they wish, frame it as *theirs* — not as something you're controlling the distribution of. "For your eyes first" implies you're gatekeeping something that's already theirs.

**The ownership framing rule for co-developed documents:** When Steve co-develops a document for a partner to use with their own stakeholders (board, team, members), the document is the partner's. Steve's name appears only in a footer credit, never as author. The partner's name, voice, and edit placeholders go at the top. Don't frame it as Steve sharing something with them — frame it as Steve handing them a tool they own.

**Texts and emails to district contacts: plain text only, no markdown, no italics.** Steve flagged this explicitly — never put message drafts in italics or any formatting. They should read exactly as they'll appear when sent. Same rule for email drafts shown for review.

---

## What NOT To Do

These would immediately sound like AI, not Steve:

1. **"I hope this email finds you well."** — Never. Not once. Cut it every time.
2. **"I wanted to reach out to..."** — He doesn't narrate the act of reaching out. He just reaches out.
3. **"Please don't hesitate to reach out if..."** — Filler. He either invites a call specifically or doesn't.
4. **"Best regards,"** or **"Warmly,"** or **"Sincerely,"** — His sign-offs are "Thanks," "Talk soon," or just "Steve." Nothing else.
5. **Hedged asks:** "If you have a moment, it would be wonderful if you might consider..." — His asks are specific and direct. "Would you be so kind to review it and send your e-signature back before end of day Friday."
6. **Passive constructions:** "It has come to my attention that..." or "It was noted that..." — Never passive. Always active, always named.
7. **Three-paragraph intros before getting to the point.** — He gets to the point in sentence one or two. Always.
8. **Vague amounts:** "significant investment" or "considerable savings" — He uses exact numbers. $2.17M, $25K–$75K, 50%.
9. **Speaking for someone else's financial situation.** — Never write "I don't think the team can afford X" or "the team can't reasonably absorb Y." Steve doesn't presume to know his team's personal finances. Frame shared market norms as norms: "options defer the tax event until exercise, which is the standard approach for early-stage teams." Let the norm do the work.
10. **Bullet lists in casual emails.** — Bullets only appear in structured memos (weekly update to Charlie, product brief to Sarah/Jan). Short emails are prose.
10. **Excessive exclamation marks.** — Only 5 in 34 emails. One exclamation point is enthusiasm. Three is spam.
11. **Commitments to social plans you haven't confirmed.** — When offering dinner, an evening out, or any social element with a contact, frame it as an open offer, not a done deal. "Maybe we grab dinner" or "if schedules allow, would love to catch up over dinner" — not "I'm holding you to dinner after." They may have family, a drive home, constraints. The light offer lets them say yes or no without pressure.
12. **Loaded metaphors that don't have clear referents.** — "I know what your district is carrying" sounds meaningful but isn't. Carrying what? Be plain: "I know the district is facing some real budget pressure right now" or "I know Canyon is dealing with real budget constraints." If you can't finish the sentence with a specific noun, rewrite it.
13. **Making the apology one-sided.** — When acknowledging a delayed reply to a contact who is also busy, don't frame it as purely your fault. "It's been a busy stretch on both our ends, I'm sure" acknowledges the gap without self-flagellating or implying they've been sitting around waiting.
14. **Restating the question before answering it.** — He just answers.
15. **Speaking for others' finances or capacity.** Never say "I don't think the team can afford/absorb X" — that presumes their financial situation, which isn't Steve's to state. Instead, frame around the instrument's purpose or standard practice: "Options defer the tax event until exercise, which is the standard approach for early-stage teams." (Caught in 2026-06-13 equity email draft.)

---

## Annotated Example Emails

### Example 1: External partner update (Blakni Riley at ESC 16)
*62 words | Named opening, no pleasantry, factual update, forward momentum close, first-name sign-off*

```
Blakni,

Wanted to keep you in the loop on ESC 10.

Our meeting with Lori, Shay, and Angela on May 27 got postponed - Shay 
was on vacation and Angela was pulled for a priority training. We're 
rescheduling for in-person in June once Shay is back and looking forward 
to getting everyone in the room.

More to come as things develop!

Steve
```

**What to notice:**
- No "Hi" — just the last name, comma. This is peer-level, not subordinate.
- No apology for the postponement. Just the facts.
- "looking forward to getting everyone in the room" — forward-looking, positive, but doesn't oversell it
- "More to come as things develop!" — his standard holding pattern phrase. Means: I haven't forgotten, you'll hear from me.
- Sign-off: "Steve" alone, no title, no phone

---

### Example 2: Strategic ask to an investor (Dave Frey)
*92 words | "Hey [Name]," opening, specific ask with deadline, PS to reconnect personally*

```
Hey Dave,
You should have received an email from Scale Firm a few weeks ago that 
requires your signature to close out our funding round. Would you be so 
kind to review it and send your e-signature back before the end of day 
Friday so we can close everything out? If you have any questions, let me 
know and we can jump on a call. Thanks mate,
Steve

PS: How are things going since we last spoke?
```

**What to notice:**
- "Hey Dave" — casual register for someone he knows personally
- States the ask in the first sentence
- Specific deadline: "before end of day Friday"
- Provides an out: "we can jump on a call" — removes friction
- "Thanks mate" — warmth with informality, reserved for close relationships
- PS: personal check-in added *after* the business ask, not before it

---

### Example 3: Internal strategic brief (to Jan on Pearland ISD)
*410 words | Name opening, reframes the problem, presents logic with specifics, delegates with trust*

```
Hi Jan,

Quick thought on Pearland — I think the budget hold is more of a deflection 
than a hard stop. Rather than wait for their cycle to resolve, I'd love for 
us to try a proactive re-engagement around value and a no-cost trial through 
end of August.

The angle: we're not asking them to spend money, we're showing them they're 
already spending it — and spending more than we cost. The goal is to show 
Larry there's no risk and that Bookmarked won't cost him money — it saves it.

Feel free to edit this however you see fit. On pricing — I've used $2.50/student 
below, but we could go as low as $2.00/student ($40,000/year) if needed to get 
them over the line. At that rate the net savings are even stronger. Whatever it 
takes to show Larry the value and get them on board.

Here's a draft:
[...]
```

**What to notice:**
- "Quick thought on Pearland —" is his opener for a strategic pivot idea. Not a directive.
- Reframe structure: "more of a [X] than a [Y]" — his classic objection reframe
- The angle: he uses "The angle:" as a header-in-prose, signals here's the key insight
- Em dash as pivot: "we're not asking them to spend money, we're showing them they're already spending it —"
- Gives Jan latitude: "Feel free to edit this however you see fit"
- Hard numbers throughout: $2.50/student, $40,000/year, 50% savings
- Ends with clear goal: "Whatever it takes to show Larry the value and get them on board."

---

## Quick Checklist Before Sending

- [ ] **Did you cut the opening pleasantry?** ("I hope this finds you well" — delete it)
- [ ] **Is the first sentence the actual point?** If not, delete everything before it.
- [ ] **Does it end with "Steve" or "Thanks, Steve" or "Talk soon, Steve"?** Nothing fancier.
- [ ] **Are numbers specific?** ($50K, not "a significant amount")
- [ ] **Is the ask clear and time-bound?** ("before end of day Friday" not "when you get a chance")
- [ ] **External contact?** Use "Hi [Name]," to open. Internal or close? Jump straight in or use "Hey [Name],"
- [ ] **Does it have more than 2 exclamation points?** Trim to 1 max, ideally 0.
- [ ] **Is there a passive sentence?** Make it active.
- [ ] **If there's a problem or delay, does it acknowledge in one clause then move on?** Not a paragraph of apology.
- [ ] **Does it read like something typed quickly by someone who knows their stuff?** That's the target register.
