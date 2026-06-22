---
name: steve-personal-brand
description: "Steve Wandler's personal brand — voice, design tokens, content pillars, and channel strategy for any public-facing content or design work (Tumblr/stevewandler.com, LinkedIn, IG, X, quote graphics). Distinct from Bookmarked company brand and from steve-email-voice."
version: 1.0.0
author: agent
tags: [personal-brand, content, design, voice, tumblr, stevewandler, marketing]
---

# Steve Wandler — Personal Brand

Use this skill for ANY work on Steve's personal public presence: his Tumblr blog
(stevewandler.com), LinkedIn/IG/X content, quote graphics, bio copy, or design refreshes
of his personal channels.

## Step 0 — ALWAYS pull the source of truth first

The complete, authoritative brand spec lives in **G-Brain** on the page `marketing-steve`
(type: concept). Read it before designing or writing anything:

```python
# via HTTP MCP — token read at runtime (see gbrain skill for the full pattern)
call("get_page", {"slug": "marketing-steve"})
# Source material it derives from: page `bookmarked-founder` (origin story + voice fingerprint)
```

Do NOT improvise a brand from scratch — it's already written. This skill is a fast index;
`marketing-steve` is canonical and may be newer. Search BOTH that page and `bookmarked-founder`
when you need source scenes/quotes.

## Positioning

*The founder who couldn't graduate is building the company that helps every kid find the book
that changes their life — and he's still one of those kids.*

3x founder (2 exits), dropped out of high school, dyslexia + ADHD, 20+ yrs at the
education×tech intersection. NOT a polished LinkedIn influencer — a founder who fought into
the room and builds in public. **Steve's brand ≠ Bookmarked's brand.** They reinforce but never
merge: Steve is the voice of the mission, Bookmarked is the company executing it. If a post reads
like "here's why Bookmarked is great," it belongs on the company channel, not Steve's.

## Design tokens (personal brand — different from Bookmarked)

| Token | Value | Use |
|-------|-------|-----|
| Primary text | `#1A1A1A` near-black | direct, no-nonsense |
| Accent | `#C0392B` deep red | passion, urgency — links, rules, emphasis |
| Background | `#FFFFFF` clean | base |
| Warm neutral | `#F5F0EB` | section backgrounds, cards |
| Quote/heading font | Georgia (humanist serif) | pull-quotes, headings |
| Body/caption font | Inter | body text, captions |

## HARD LANGUAGE RULES (2026-06-10 — explicit corrections)
- His posts are **"blogs"** or **"writing"** — NEVER "essays." Steve corrected this explicitly mid-session.
- **"Building in public"** — Steve: "I don't like that. I don't know what that means." Never use it.
- **"Education at heart"** — rejected as a credential. Sounds like someone else's tagline.
- **Credential line:** "Entrepreneur & Builder" — simple, his words, approved.
- **Tagline (site, approved 2026-06-10):** "Chasing the right book for everyone, including me."

## DESIGN CRITIQUE ESCALATION — stop iterating, show alternatives
When Steve says *"I really think we need to rethink your design capabilities"* or *"I thought you were a really good graphic designer"* — this is NOT a request for a pixel fix. It means the fundamental direction is wrong. **STOP patching. Build mockups.**

Protocol (explicit request from Steve 2026-06-10: *"show me five different versions"*):
1. Build 4–5 standalone HTML mockups representing **genuinely different design stances** (not color variations — different layouts, structures, moods)
2. Parallelize with `delegate_task` (3 at a time)
3. Open all in Chrome: `open -a "Google Chrome" file:///tmp/sketches/A.html ...`
4. Screenshot each headlessly and QA yourself before showing anything
5. Present as a comparison table with your honest opinion
6. Steve picks direction → THEN rebuild the real thing from that foundation

**Load the `sketch` skill for the mockup workflow.** Never attempt another patch when this signal fires.

Tone: **handcrafted, not corporate. Slight roughness is intentional** — it's the authenticity.
No Bookmarked logo on Steve's channels — his own name/wordmark only. ("Founder of Bookmarked"
as a credential line is fine; the logo is not required and he'll supply an updated one only if asked.)

## Platform status (updated 2026-06-10)
stevewandler.com MOVED to Astro static site (repo `stevewandler/stevewandler-site`, Netlify,
local `~/sites/stevewandler-site`). Tumblr is FALLBACK only. Full site architecture and
posting flow in `steve-personal-brand-web` skill. **DNS swap COMPLETE (2026-06-10)** — stevewandler.com
now points to Netlify. DNS lives at Cloudflare (GoDaddy is only the registrar + email MX — never touch MX).
The full Pine & Ember design (Texas skyline sticky header, living ember canvas, cream two-column
layout, photo in sidebar) went live first build. Socials: all "stevewandler" on LinkedIn, X, Instagram, Facebook.
**Posting model:** Steve does not touch the site — agent writes `src/content/blog/*.md`, commits, pushes.

## Design Process — Explicit Preferences (2026-06-10)

**"If you're unsure of what to do, you need to ask."** — Steve said this directly. When a design/layout change has multiple valid interpretations, ask before coding. Show 2-3 options if needed.

**"Show me five different versions before you rebuild something."** — For significant design changes, build standalone HTML mockups first, open them all in Chrome, let him pick, THEN rebuild. This is not optional when the direction is unclear.

**"You need to do a better job of quality audit."** — Screenshot + vision_analyze BEFORE calling a change done. Never describe what you believe is visible — verify it with an actual screenshot.

**9 blogs migrated** from Tumblr archive (1,134 posts total; only 9 were real writing; ~1,125 old tweets/reblogs left behind deliberately). DNS swap COMPLETE — stevewandler.com live on Netlify.

## RULE: Show mockups BEFORE building any significant designn\nDo NOT patch the live site iteratively based on verbal feedback. Steve sees each version as a disappointment and loses confidence. The ONLY workflow that works for significant design changes:\n1. Articulate 4-5 genuinely different design **stances** (not color variations — different layouts, structures, moods)\n2. Build each as a standalone self-contained HTML file (use `delegate_task` to parallelize 3 at a time)\n3. Open all in Chrome: `open -a \"Google Chrome\" file:///tmp/sketches/A.html file:///tmp/sketches/B.html ...`\n4. Screenshot with headless Chrome for your own QA before showing\n5. Present as a comparison with your honest opinion\n6. Steve picks direction → THEN rebuild the real thing\n\n**Load the `sketch` skill for the full workflow.**\n\n### The escalation signal — respond by stopping, not patching\nWhen Steve says *\"I really think we need to rethink your design capabilities\"* or *\"I thought you were a really good graphic designer\"* — this is NOT a request to adjust font-weight or spacing. It means the fundamental design direction is wrong. STOP. Show alternatives. Do not attempt another patch.\n\n## Design execution standard (learned 2026-06-09 — DO NOT skip)

The brand tokens are the palette, NOT the finished look. Steve rejected a first brand-kit pass
as "basic… amateur, no design feel." Flat color blocks + a bare sand background read as a
template to him. When producing ANY visual artifact (brand kit, quote graphic, blog theme,
social mockup), the bar is **depth and flavor**, not just on-token colors:

- **Layer it:** gradients (ember→flare warm fades), a warm-dark canvas with a radial ember
  *glow* bleeding from a corner, subtle **film grain** (SVG `feTurbulence` overlay at ~6–12%
  opacity, `mix-blend-mode:overlay`), soft long shadows, glass/translucent cards. These are what
  separate "designed" from "amateur" for him.
- **Every section needs design intent, not just the hero.** Steve's exact signal for a section
  that fails: *"looks like you just slapped in some text there"* or *"I thought you were a really
  good graphic designer."* This means: no visual container, no typographic weight, floating text
  in whitespace. Fix = redesign the section's structure, not just the words. What works for
  statement-level sections: numbered editorial lines (01/02/03 in small-caps flare, large
  Fraunces 800-weight, full-width left-aligned, visible dividers). What fails: centered flex
  list with tiny bullet dots, `font-weight:500`, ocean of whitespace around it.
- **Typography weight matters.** `font-weight:500` on Fraunces at display sizes reads weak and
  placeholder-like to Steve. Use **800–900** for statements/headings. `clamp(26px,3.8vw,44px)`
  + `font-weight:800` + `letter-spacing:-.025em` is the working editorial formula.
- **Lead with HIS NAME.** On personal surfaces the marquee is **STEVE WANDLER**; the mission
  tagline ("Taking the guesswork out of books") is Bookmarked's, not his headline. "Founder of
  Bookmarked" is the sub-credential.
- **Color nuance:** he likes the ember/reddish-orange and the warm gray. `#F5F0EB` paper reads
  as "amateur beige" *in isolation* but works *in context* next to a strong ember + warm ink —
  context changes the verdict, so always show colors applied, not just as chips.
- **Display serif:** prefer **Fraunces** (has character/warmth) over plain Georgia for the
  designed-artifact layer; Georgia is the safe web-theme fallback. Inter stays for structure.
- **Offer palette OPTIONS before locking.** When color direction is open, present ~4 distinct
  named palettes (all keeping his ember + gray, varying the surrounding world), each shown as
  swatches PLUS a small applied dark+light preview, and let him pick a letter. Don't commit a
  single palette unprompted.
## Design critique escalation pattern (critical — from 2026-06-10 session)

Steve's design feedback escalates fast when something is fundamentally off. He doesn't give granular pixel fixes — he says things like *"I really think we need to rethink your design capabilities"* or *"I thought you were a really good graphic designer."*

**These are not requests for a small patch.** They are a signal to STOP, acknowledge the critique plainly, and **show genuinely different alternatives before touching the live thing again**. Trying to patch a wrong-direction layout 5-10 more times only compounds the frustration and damages his confidence in the design work.

The correct response pattern:
1. Acknowledge directly — don't explain, don't defend
2. Stop touching the live site immediately
3. Build 3-5 standalone mockup HTML files representing genuinely different design stances
4. Open all in Chrome, present with honest comparison + your own opinion
5. Let him pick a direction, THEN rebuild from that foundation

Steve explicitly asked for this process mid-session: *"show me five different versions of what you're thinking so we can maybe work from there."* This is now the standard protocol for any significant design iteration, not just when he's frustrated.

## Render-and-show loop (mandatory for any design artifact)

Build the HTML artifact → screenshot headlessly → inspect with `vision_analyze` → show Steve the screenshot (`MEDIA:<path>`). Never describe what it looks like — he needs to see it. The loop is: build → render → show → react → iterate. Skip the "describe what I built" step entirely.

Reusable artifact starters live in `references/brand-kit-design-patterns.md`.

## Blog Post Drafting Workflow (proven 2026-06-11)

The blog at stevewandler.com has been quiet — the freeze is the fourth-grade boy, not a
content problem (see personal-growth-sessions skill). The first post back was drafted in
this session using the workflow below. Use this for all long-form Steve content.

### The process that works

1. **Load G-Brain first:** `marketing-steve` (brand spec) + `bookmarked-founder` (narrative).
   Also pull `get_recent_salience` to see what's live in Steve's world — the best posts come
   from what's actually happening, not from the content calendar.

2. **Propose the angle, not the draft.** Steve rejects AI-generated prose from scratch. Present
   2–4 angle options with one sentence each on why each works. Let him pick.

3. **Get his words first.** Ask him to brain-dump voicemail-style. "Don't structure it, don't
   edit yourself — just say it." His raw language is the material. Draft FROM his phrases.

4. **Draft in his cascade structure:** specific scene → principle → systemic insight → what
   we're doing about it. End on an open question, not a CTA.

5. **Iterate on his corrections.** Steve catches things the agent won't:
   - Factual precision ("is that actually true? do we have that?")
   - Audience awareness ("who are we speaking to here?")
   - Logical threads ("these two things don't connect for the reader")
   - Wording that implies things he doesn't mean
   Each correction usually reveals a deeper structural insight. Don't just fix the word — ask
   what the correction is really about.

6. **Verify every factual claim against artifacts.** Steve will call it out if you fabricate.
   Pull the actual report cards, the actual transcript, the actual number. "I still have my
   grade 5 report card" is only safe if you've seen the card. Download and inspect source
   artifacts via Drive/G-Brain before publishing claims about them.

### Steve's editorial instincts (captured from this session)

- **Don't claim specifics you can't back up.** "Three times a year" is wrong when report cards
  happen four times. Use "every report card" or "every grading period" instead of guessing
  frequency.
- **Don't fabricate worse data to make the story stronger.** The true data is always better
  than the invented version. When he wanted to change A→B- to B→C-, the pushback was correct:
  the A is the body of evidence that love existed before school killed it.
- **Watch for logical gaps the reader won't bridge.** "Grades were bad → kid can't find books"
  doesn't connect without the report card artifact that bridges them (grade 5: "Shows Interest
  in Reading" declining = grade AND book are the same event).
- **Physical education / athletics contrast doesn't work in this context.** "Kid fails English,
  aces gym" reinforces the sorting cliché rather than refuting it. Use Art/Music/Science A's
  instead — those prove the brain was alive everywhere except where text was the channel.
  That's the dyslexia story without naming it.
- **Singular vs plural consistency matters.** "There's one report card I still have" then
  referencing a second card trips the reader. If using multiple cards, open with "There are
  report cards I still have."
- **Switzerland on the censorship/book-access topic.** Don't mention banned books, compliance,
  SB 13, or censorship in Steve's personal posts. Keep Bookmarked in pure discovery framing.
  Neither side should find anything to grab. The absence is the strategy.
- **FreshGrade framing:** Keep "venture-funded" (shows traction and belief). The lesson is
  "desire to change vs requirement to change" — not an investor-return complaint. Don't take
  shots at former investors; many will read this.
- **Audience is founders, entrepreneurs, and anyone school didn't do justice to.** Not just
  educators. Not just parents. Write to the person reading at 11pm who's still carrying a
  verdict from childhood.
- **End on an open question that ties back to books.** The last line of a Steve post should
  leave the reader sitting with something, not pitch them something.

### Source artifacts for the blog (verified 2026-06-11)

Report card scans are in Steve's personal Gmail Drive:
`https://drive.google.com/drive/folders/1WW8XyeClGvrX3gAUd8ztajQeb_GXarxx`
See `references/report-card-verified-data.md` for term-by-term grades read from the
actual scans. Use these numbers, not memory, when writing posts.

## Voice rules (from the bookmarked-founder fingerprint)

**REJECTED PHRASES (explicitly, 2026-06-10):**
- "Education at heart" — sounds like someone else's tagline, too soft
- "Building in public" — Steve: "I don't know what that means"
- Long bio paragraphs under the hero — reads like a blog bio, not a brand moment
- Current working credential: "Entrepreneur & Builder" (simple, his words)
- The who-I-am section should be 3 short statements (numbered manifesto format), not prose

**DO:** open with a specific scene/detail then zoom out · short declarative sentences for
emotional truths · cascade structure (personal moment → principle → systemic insight → what
we're doing) · contrarian reframe as the main move (undiscovered books, not banned books) ·
concrete before abstract, always · self-deprecating humor as connective tissue · end on an open
question, not a CTA.

**DON'T:** start with "I'm excited to…" / "Thrilled to…" / "Grateful for…" · polish away the
roughness · over-explain the product · use jargon (EdTech, disruption, synergy) · post opinion
without a grounding scene or fact.

**Emotional register:** quiet/matter-of-fact for childhood stories (the quiet delivery is the
power) · fierce for the literacy mission · curious for AI/building · vulnerable+direct for
fears/failures.

**Critical drafting rule (from USER profile):** do NOT generate polished prose from scratch in
Steve's voice — it reads AI-generated and he'll reject it. Have him say it out loud / type it
like a voicemail, then shape his actual words. Draft from his language, not from a blank page.

**Long-form (blog) voice rules — learned 2026-06-11 drafting "Feel It First":**
- **Em-dashes ARE allowed in long-form blog prose.** The zero-em-dash rule is for short
  messaging (email/text). Stripping dashes from a blog draft killed the cascade pacing and
  Steve rejected the "humanized" version hard ("way not near as good"). Dashes carry his rhythm
  in essays; leave them.
- **Simplest version wins.** When a closing line or transition feels clever, it's wrong
  ("sounds lame and corny", "you're trying too hard"). Cut punchlines; end flat and quiet.
  Trust the reader — don't re-explain what the post already established.
- **Never frame against educators/librarians**, even rhetorically ("that kid doesn't need a
  better report card" → "A report card doesn't make the kid. The right book can."). Switzerland
  applies to personal posts too: no anti-grades, anti-teacher, or censorship-adjacent framing.
- **Never shade the factual record for narrative effect.** Steve asked to show worse grades than
  the real A→B-; pushed back, he accepted: use real artifacts verbatim (report cards verified
  against scans). The A is the evidence the love existed before school killed it.
- **One grounding line beats a framework paragraph.** "I only figured that out this year, and it
  took real work to see it" — recent + costly, no lecture. Personal-work allusions stay at this
  level of vagueness (no Teresa, no therapy specifics, illness excluded on request).
- Iterate clause by clause; he'll flag single words. Offer 2–3 options per fix and recommend one.

## Long-form blog drafting workflow (proven 2026-06-11, "Feel It First" post)

The loop that produced a post Steve loved ("makes me want to cry"):
1. Ask for a voicemail-style brain dump on the chosen angle. He gives raw, unstructured material.
2. Name the cascade/through-line you extracted from HIS words, then draft — placing his actual
   sentences, not paraphrasing them. List the judgment calls you made as explicit veto points.
3. Iterate one section at a time on his reactions. When he wants an ending/line reworded, offer
   2–3 lettered variants with a one-line read on each and a recommendation; he picks a letter.
4. He gives the final draft the out-loud test — anywhere he stumbles is where you missed his voice.

**Pitfalls learned the hard way (do not repeat):**
- **The zero-em-dash rule applies to MESSAGING (emails/texts), NOT long-form blog prose.** His
  cascade rhythm in essays legitimately uses dashes. A "humanize" pass that stripped all em-dashes
  plus trimmed connective tissue was rejected flat: "way not near as good as the previous version."
  Humanizing ≠ sanitizing. Fix specific AI-tells he names; never bulk-rewrite an approved draft.
- **Ground claims in ONE sentence, not a paragraph.** When he asks "where does this come from /
  what's the framework," he wants a single line of origin (e.g. "I only figured that out this year,
  and it took real work to see it"), not an explanation. His standing rule: "be thoughtful about
  words, don't add things for the sake of adding things." He also rejected bold-for-emphasis
  mid-paragraph and disliked a hyphenated construction — keep typography plain.
- **Verify artifacts before factual claims.** He challenged "do you actually have that report card?"
  Chain of custody matters: trace the claim to its G-Brain source, then fetch the real artifact and
  read the actual data before publish. See `references/founder-artifacts-verified.md`.
- **Never shade facts, even when he asks.** He wanted to show worse grades than the real A→B- to
  avoid looking like "that kid." Push back with the reframe (the A is evidence the love existed
  before the system killed it; the genuinely bad grades exist elsewhere in the record). He accepts
  truth-based pushback and thanks you for it.
- **Avoid the Phys-Ed/athletic contrast** for "mismeasured not broken" — it reads as the
  "athletic, not academic" sorting cliché and confirms the verdict. Use the grade-5 Art/Music/
  Science straight-A's against the reading decline instead (dyslexia in plain sight, channel
  problem not brain problem).
- **Word-level precision he catches:** "There's one report card I still have" followed by a second
  card = trip. Mention multiple artifacts → "There are report cards I still have."
- **One diagnosis max per post.** Dyslexia was load-bearing for a reading post; ADHD was cut as
  a second thing for the reader to process. Each fact appears once, at the moment the reader asks "why."
- **Switzerland applies to personal posts too.** No censorship/banned-books/compliance/SB 13 content
  in personal essays at all — absence, not careful language. Flag the absence as a deliberate decision.
- **Personal-growth allusion ceiling:** one vague line ("doing work on myself") max; no frameworks,
  no relationship specifics, ever. He vetoed a draft angle as "a little too personal" even though he'd
  asked to consider personal context — offer the personal-depth angle, but have the founder/performance
  angle ready as the fallback.
- **Machine-check before publish** (when the post touches the inner work): ask whether he'd publish
  it identical if a specific person would never read it.

## Hard content boundaries for PUBLIC content (learned 2026-06-10, blog session)

Steve drew these lines explicitly while drafting his first blog post back. They apply to ALL
public-facing content (blog, LinkedIn, IG, X):

- **Illness is OFF LIMITS.** No mention or allusion to the ulcerative colitis / hospital story
  in public content, even though it's in the founder narrative. He declined even a soft
  "life took other things from me" line unless he asks for it.
- **The deep IFS/growth material is too personal for public.** The boys, the Machine, the
  manufactured-life framing — these can INFORM a post's insight (e.g. "feel it first, then
  think" became the spine of a post) but the therapeutic apparatus itself stays private.
  Translate the insight into founder/performance language; never expose the framework.
- **Relationships: allusion only, thoughtfully.** No names, no situation details. A line like
  "it showed up in my relationships too" is the ceiling — and even that only when he opts in.
  Publishing test (from personal-growth-sessions crossover): would he publish it identical if
  he knew Teresa would never read it? If no, it's the door, not the blog.
- **Switzerland applies to personal content too.** Zero censorship/banned-books/compliance/SB 13
  framing in personal posts — the safest position is ABSENCE of the topic, not careful language.
  Make that absence an explicit flagged decision so he knows it's deliberate. (If comments probe
  book access: "we inform, districts decide.")
- **FreshGrade framing:** KEEP "venture-funded" — it signals belief + traction, he's proud of it.
  The lesson line he approved: "the desire to change and the requirement to change are two
  different things." Do NOT frame it as investor-return tension or anything that reads bitter —
  his former investors will read it.
- **Don't trust readers to do math / catch implicit facts.** "Eleven years" of school doesn't
  communicate the dropout — say it explicitly, quiet delivery ("Eleven years, not twelve,
  because I dropped out."). The dropout is his strongest credibility receipt; don't leave it
  implicit. Same class of issue: report cards aren't universally "three times a year" (3–4x
  varies) — avoid frequency claims that can trip.
- **Don't reuse openers across surfaces.** The content calendar already uses the report-card
  A→B- opener for LinkedIn; long-form posts need a different way in.

## Long-form blog drafting workflow (PROVEN 2026-06-10 — "giggling inside" approval)

1. Pull canonical sources first (marketing-steve, bookmarked-founder, content calendar,
   recent salience) — know what's already covered so the new piece isn't a retread.
2. Propose the SHAPE before any prose: name the cascade explicitly (scene → principle →
   systemic → what we're building) and 2–3 alternative angles. Let him pick.
3. Ask for a voicemail-style brain dump in his words. He WILL give a messy dump — that's
   the raw material. Never draft from a blank page.
4. Draft by PLACING his sentences into the cascade, not rewriting them. Most load-bearing
   lines should be verbatim or near-verbatim his.
5. After the draft, list the judgment calls you made as numbered flags (what you included/
   excluded and why) — he wants vetoes surfaced, not buried.
6. Iterate via the out-loud test: "anywhere you stumble is where I missed your voice."
7. End posts unresolved with an open question — never performed arrival, never a CTA.
   Bookmarked gets ~3 sentences max in a personal post.
8. Publishing flow he agreed to consider: stevewandler.com first, then trimmed LinkedIn
   version pointing to it.

In-flight post state lives in `references/feel-it-first-draft.md`.

## Hard content boundaries (set by Steve, 2026-06-11)

- **Illness (ulcerative colitis / hospital):** OUT of public content entirely. No allusions unless he explicitly asks.
- **Teresa / relationships:** never specific or identifiable. Vague allusions ("it showed up in my relationships") acceptable but only with thought; the deep inner-work angle (the boys, the Machine, manufactured life) was rejected as "too personal" for public posts. Founder/performance framing of the same insights IS approved (feel it first, then think).
- **Censorship/SB 13 in PERSONAL posts:** stay Switzerland — omit the topic entirely rather than add careful language. Never imply censorship is good OR that keeping all books is the goal.
- **Librarians:** never imply they aren't trying or aren't helping. Frame gaps as a scale/math problem ("one librarian, hundreds of kids"), echoing "the system isn't failing because people aren't trying."
- **The dropout:** approved for public use, delivered flat ("Eleven years, not twelve, because I dropped out"). Avoid claiming report cards come a fixed number of times per year (varies 3–4).
- **FreshGrade framing:** venture-funded = proof of belief/traction, said with pride; the lesson is "desire to change vs. requirement to change." No bitterness toward investors (they'll read it).
- **Audience for founder-journey content:** founders, entrepreneurs, and anyone school didn't do justice to — not just edu/parents.
- **Endings he likes:** statement-then-question close (scene first, then the open question), e.g. the "Feel It First" blog post (first long-form post, drafted 2026-06-11, restarts stevewandler.com).

## Long-form blog drafting (learned 2026-06-11, "Feel It First" session)

Proven workflow + hard rules for blog posts on stevewandler.com. Full worked example in
`references/blog-drafting-workflow.md`.

1. **Brain-dump first, always.** Ask Steve to talk voicemail-style; shape HIS words. He approved
   drafts built this way ("wow this is really good… makes me want to cry") — the method works.
2. **Iterate in named drafts** (Draft 1, 2, 3…) and surface every judgment call as an explicit
   numbered veto point under the draft. He engages with these directly.
3. **Truth gate (CRITICAL):** every factual claim must trace to a G-Brain source artifact. When
   Steve asked to *worsen* his real grades (show B→C- instead of the real A→B-) to look "not good
   enough," the right move was a hard push-back: the A on "Shows Interest in Reading" is
   load-bearing — it proves the love existed before the system killed it ("murder record, not a
   good-student record"). He accepted. Never shade artifacts, even at his request; reframe instead.
   Real artifacts: Grade 5 "Shows Interest in Reading" A→B- (Assumption school); Grade 10 English
   48 vs class avg 65, Phys Ed 96 vs 71 (Lakeland Catholic 1986-87). Scans live in his PERSONAL
   Gmail Drive, folder `1WW8XyeClGvrX3gAUd8ztajQeb_GXarxx` — verify against the scan before
   publishing any grade number.
4. **Switzerland rule for personal posts:** zero mention of censorship, banned books, SB 13, or
   compliance in personal-brand content — absence, not careful wording. Flag the absence as a
   deliberate decision so he sees it was considered.
5. **Librarian protection:** never imply librarians aren't trying or kids aren't being helped.
   Frame as scale math: "one librarian, hundreds of kids… isn't fair to the librarian or the kid."
   Echoes his line "the system isn't failing because people aren't trying."
6. **The dropout is the receipt** — say "Eleven years, not twelve, because I dropped out" flat,
   one line, no windup. Readers never infer it from "eleven years" alone.
7. **Word choices he corrected:** "a kid" not "a student"; "somewhere out there" not "somewhere
   right now"; no report-card frequency claims ("three times a year" — varies, drop it).
8. **FreshGrade framing:** keep "venture-funded" as proof of belief/traction (he's proud of it);
   the lesson is "desire to change vs. requirement to change" — not investor-return tension.
9. **Endings:** statement-then-question closes work best; offer 2-3 labeled options (A/B/C) with a
   recommendation — he picks decisively. Cut any earlier paragraph the new ending makes redundant.
10. **Audience:** founders, entrepreneurs, anyone school didn't do justice — not just edu people.
11. **Rollout order:** stevewandler.com first, trimmed LinkedIn cut a day or two later pointing
    back to the blog. The blog restart is the bigger story.

## WandlerVision mark — asset discovered 2026-06-10

Steve has an existing personal logo system from ~2019 stored in his personal Google Drive:
`https://drive.google.com/drive/folders/1DT369lWmCga0mSasMbekXPZxSKl1nW2l?usp=drive_link`
(Personal account `stevewandler@gmail.com`, NOT the work account.)

The mark is two overlapping rounded-square tiles (one blue "W" tile, one red "V" tile) forming
a "WV" lettermark under the brand name "WandlerVision." **Do NOT use the WandlerVision name or
blue/red palette** — the brand isn't the right identity for stevewandler.com. But the
*overlapping-tile concept* is worth preserving:

**Pine & Ember reinterpretation:** a pine tile (#1B6B5B) + ember tile (#D8442C) overlapping,
with "SW" in the intersection. This becomes Steve's personal site favicon/monogram — distinct
from Bookmarked's mark, tied to his name, honors the existing mark he owns.

SVG files in the Drive are under `rgb/SVG/` folder — 9 files including `full-transparent.svg`,
`logo-transparent.svg`, `lettermark-transparent.svg`. Download via personal Google token
(token: `~/.hermes/google_token_personal.json`).

Original palette: near-black `#190b12`, royal blue `#293581`, red-orange `#ef3924`, cream `#ffecd8`.

---

## Content label rules (confirmed 2026-06-10)
- Steve's posts are **blogs**, not essays. UI labels, eyebrow text, and copy say "Writing" or "Blogs." Never "essays."
- "Building in public" — REJECTED. Steve: "I don't know what that means." Don't use it.
- "Education at heart" — REJECTED as a credential line. Sounds like someone else wrote it.
- Current working credential: "Entrepreneur & Builder" (his words, simple).
- Tagline on site: "Chasing the right book for everyone, including me." (approved 2026-06-10).
- Do NOT say "Founder of Bookmarked" as the headline. It's the credential line at most.



1. **The Founder Story** — childhood vignettes (Bic pen/pencil, the closet, the grade-5 report
   card tracking his reading love declining A→B-, Faith, the Frisco library), career as one
   continuous mission, dyslexia/ADHD vulnerability, "I'm still that kid."
2. **Education Reform POV** — systemic critique of how schools sort/filter kids, contrarian
   reframes (undiscovered > banned books), the gateway chain (right book → love reading →
   literacy), facts that reframe the debate.
3. **Building with AI** — what an AI-native company actually looks like, agents as teammates,
   honest takes on where AI falls short, small-team-enormous-leverage.
4. **The Entrepreneur's Lens** — lessons from 3 companies, personal stakes (Noah lives the same
   school experience), the yearbook "own my own business" line.

## Language hard rules for his personal brand (2026-06-10)
- His posts on stevewandler.com are **"blogs"** or **"writing"** — NOT "essays." Steve
  corrected this explicitly. Use "blogs" in conversation, "Writing" in UI labels.
- **"Building in public"** — Steve: "I don't like building in public. I don't know what that means." Never use this phrase.
- **"Education at heart"** — rejected as someone else's tagline. Don't use it.
- **Credential line:** "Entrepreneur & Builder" is the current working version. Simple, his words. Don't add edu-isms.

## Channel strategy (summary — see marketing-steve for full cadence)

- **LinkedIn** (primary, 4x/wk): 200–500w cascade posts, hook in line 1, short paragraphs.
- **Instagram** (3x/wk): quote graphics from his own words, BTS, raw 30–60s reels.
- **X** (daily-ish): one-line reframes, threads for longer takes, more POV less personal story.
- **Facebook** (2–3x/wk): reshare LinkedIn, community of parents/educators who know him.
- **stevewandler.com**: long-form home for the founder story. As of 2026-06-10 this MOVED OFF
  TUMBLR to a custom Astro site (repo `github.com/stevewandler/stevewandler-site`, auto-deploys
  to Netlify on git push, local `~/sites/stevewandler-site`). The agent writes/commits/pushes
  markdown posts on Steve's say-so — he does not edit himself. See
  `references/stevewandler-site-astro-netlify.md` for the full stack, the migration, Astro v6
  pitfalls, and the Texas-skyline / Pine & Ember design preferences he corrected. The old
  `references/tumblr-stevewandler-blog.md` is FALLBACK-ONLY history — don't invest in Tumblr
  theming again (its customizer fought automation; that's why we moved).

## Long-form blog drafting (learned 2026-06-11, "Feel It First" session)

The voicemail-style brain-dump → shape-his-words process WORKS for long-form. Full playbook
with his iteration patterns and the worked example: `references/longform-blog-drafting.md`.
The non-negotiables:

1. **Content depth boundary.** Founder/performance vulnerability = yes ("feel it first, then
   think", the verdict, the dropout). Deep personal-growth material (the Machine, the boys,
   relationship specifics, ketamine work) = "a little too personal" — he pulled back when offered.
   Illness: fully OUT unless he says otherwise. Relationships: allusion at most, never names or
   situation details, and gut-check the "so that she sees it" motive before writing.
2. **Switzerland applies to PERSONAL posts too.** Best move is total absence of the
   censorship/banned-books topic, not careful language. Flag the absence as a deliberate
   decision so he sees it was a choice.
3. **Never imply librarians aren't trying.** Library-gap framing must be a SCALE problem, not a
   people problem ("one librarian, hundreds of kids… isn't fair to the librarian or the kid").
4. **Verify factual claims against G-Brain source artifacts BEFORE he asks.** He challenged
   "are you making shit up" on the grade-5 report card. Show the chain of custody (his interview →
   G-Brain artifact table) and flag what's documented vs. what's been physically verified. Tell him
   to eyeball the real artifact pre-publish.
5. **Frequency/number claims get sanded off** ("three times a year" → "every report card") —
   readers won't do implied math (11 vs 12 years), so say the dropout explicitly: flat, four-word
   delivery, no windup.
6. **Audience for founder-journey posts:** founders, entrepreneurs, and anyone school
   shortchanged — widen closers from "kids in a classroom" to "people still carrying the verdict,"
   then swing back to books in the final beat.
7. **Rollout default:** stevewandler.com first, trimmed LinkedIn cut 1–2 days later pointing back.

## References

- `references/brand-kit-design-patterns.md` — reusable artifact starters for designed surfaces.
- `references/stevewandler-site-astro-netlify.md` — **CURRENT** stevewandler.com home (moved off
  Tumblr 2026-06-10): Astro + Netlify + GitHub stack, AI-driven markdown posting model, Astro v6
  content-collection pitfalls, headless-Chrome screenshot verification, the Tumblr-archive
  migration (curate ~9 essays, don't bulk-import), and the Texas-skyline / Pine & Ember design
  preferences Steve corrected (centered skyline, ember signature towers, grounded books, short
  credential, no city labels).
- `references/tumblr-stevewandler-blog.md` — the OLD Tumblr blog (FALLBACK/historical only;
  superseded by the Astro site — don't invest in Tumblr theming again).
- `references/founder-artifacts-verified.md` — VERIFIED report-card data (grade 5 term-by-term,
  grade 10 marks vs class averages), Drive file IDs for the scans, and the "Feel It First" post
  structure + open decisions. Read before making any factual claim about Steve's school record.
- `references/longform-blog-drafting.md` — long-form blog process, Steve's edit patterns,
  content boundaries, and the "Feel It First" worked example (2026-06-11).
