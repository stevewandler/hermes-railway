---
name: steve-personal-brand-web
description: "Steve Wandler's personal brand web presence — stevewandler.com (NOW on Astro+Netlify, NOT Tumblr). Design, content, posting workflow, and site architecture. Load for any work on the site."
version: 2.0.0
author: agent
tags: [personal-brand, stevewandler, astro, netlify, design, web]
---

# Steve Wandler — Personal Web Presence

## Platform (as of 2026-06-10)

stevewandler.com is **no longer on Tumblr**. It is a custom Astro static site:

- **Repo:** `github.com/stevewandler/stevewandler-site` (private)
- **Local:** `~/sites/stevewandler-site`
- **Hosting:** Netlify — auto-deploys on every `git push origin main`
- **Domain:** stevewandler.com — DNS already pointed to Netlify ✓
- **Build:** `npm run build` → `dist/` → Netlify serves
- **Preview:** `npm run preview -- --port 4399`

**Posting workflow:** Steve does NOT edit himself. To publish a post:
1. Write markdown to `src/content/blog/<slug>.md` with frontmatter `draft: false`
2. `git add -A && git commit -m "..." && git push` → Netlify auto-rebuilds, live in ~30s

Post frontmatter format:
```yaml
---
title: "Post Title"
date: 2026-06-10
excerpt: "One sentence description."
draft: false
---
```

## Design System — "Pine & Ember"

**ALWAYS call them BLOGS, not essays.**

### Palette
| Token | Hex | Use |
|-------|-----|-----|
| Pine | `#0E2520` | Dark canvas, footer |
| Emerald | `#1B6B5B` | Lead green, towers |
| Bright | `#3FB89A` | Accents, links |
| Ember | `#D8442C` | Spark, spine nav, dates |
| Flare | `#F0843F` | Orange warmth, hover |
| Paper | `#F5F0EB` | Cream content zone |
| Ivory | `#FBF7F0` | Text on dark |

### Fonts
- **Fraunces** — display serif (headings, name, tagline, blog titles)
- **Inter** — body, captions, stats, labels

### Architecture
- **Skyline bar** (sticky, top: 0): Texas skyline SVG with ember canvas inside. HOME + WRITING nav spines side by side on the LEFT using CSS `position: absolute; writing-mode: vertical-rl` (NOT SVG `rotate()` transforms — those break with scaled SVGs)
- **Content zone** (cream `#F5F0EB`): two-column grid
  - Left sidebar (sticky, `top: 188px`): photo → name → credential → social icons → italic tagline → stats
  - Right column: blog list with orange dates + Fraunces titles

### Tagline (approved)
> "Chasing the right book for everyone, including me."

### Credential line (approved)
> ENTREPRENEUR & BUILDER

### Key content decisions (Steve-approved)
- **No bio paragraphs** in sidebar — they were removed. Just: tagline + stats.
- **Stats (four, approved 2026-06-10):** 3× Founder / 11 Years of School / 2 Exits / 1 Book That Changed Everything
  - The "1 Book" line gets ember-colored number + bold dark label — visually distinct, signals it's the point everything builds toward
  - Steve rejected "20+ Years in Education" as a résumé line. "11 Years of School" is the story.
- **Social icons:** LinkedIn, X, Instagram, Facebook (all `stevewandler`) — sit under credential in sidebar
- **No dark hero section** — skyline bar goes straight to cream content
- **Steve's photo:** `/public/steve.jpg` — black t-shirt, arms crossed, teal background. The teal blends with pine canvas naturally.

## SVG Skyline — Critical Technical Notes

See `references/skyline-pitfalls.md` for full detail.

**Short version:**
1. Use `preserveAspectRatio="xMidYMin slice"` — `meet` letterboxes; `xMidYMax slice` crops the TOP (kills headroom); `xMidYMin slice` anchors to top and crops bottom ✓
2. Nav spine text: use **CSS `writing-mode: vertical-rl`** on HTML elements positioned over the SVG. Never use SVG `rotate()` transforms for nav text — they break at non-1200px viewport widths because x/y scale factors differ
3. **viewBox headroom for tall elements**: use `viewBox="0 -20 1200 170"` WITH `xMidYMin slice`. Both required together. Current ball: `cy=62, r=14` → top edge y=48 → safely inside headroom ✓
4. `position: sticky` sidebar `top` value must be > skyline bar height. Current: `top: 188px` (168px bar + 20px buffer)
5. **Book-spine character**: all buildings should use `rx="2"` rounded corners, varied widths (10-32px), alternating twr/twr2/ember colors, tight spacing, AND narrow filler spines between landmark buildings. Pure rectangles don't read as books; interleaved narrow spines do.

## Texas Skyline — City Details

See `references/texas-skyline-research.md` for building-by-building detail.

### Dallas (right cluster) — researched from real skyline, West→East order
- **Reunion Tower**: ball on 3 visible stalk legs. Ball = glowing ember orange with twinkling dot lights. Ball `cy=65, r=14` → top sits just slightly above Fountain Place peak — Steve specified this precisely.
- **Fountain Place**: angled prism crown (asymmetric — one face highlights). Body is a rectangle topped with a triangle. NOT a pure rectangle.
- **Renaissance Tower**: second tallest. The **X-brace diagonal lines** crossing the full facade height are the signature feature. Twin antenna nubs at top.
- **Bank of America Plaza**: TALLEST. Pointed triangular spire + thin antenna line. Ember orange. Dominates the cluster.
- **Comerica Bank Tower**: stepped/tiered crown — 3 tiers narrowing to a point. Slightly shorter than BofA.
- **Chase Tower**: the **keyhole arch void** cut through the top center — MOST ICONIC Dallas building. Dark background-colored path punches through the top rectangle.

### Austin (center cluster)
- **The Independent** ("Jenga"): 4 offset stacked blocks — each block slightly offset left/right from the one below. Most distinctive Austin building.
- **Frost Bank Tower**: "owl crown" — two sharp diagonal peaks like owl ears at top of body. Ember orange.
- **Austonian**: slim tower with small stepped crown + thin pinnacle.

### Houston (left cluster) — West→East with narrow book spines between each landmark
- **Williams Tower**: tallest, gabled peaked crown (triangle path) + animated beacon dot on a thin stalk above. Beacon `cy` must stay ≥4px below viewBox top edge.
- **Wells Fargo Plaza**: twin-pointed glass peaks — two triangles split at center, forming a W/M crown shape.
- **JPMorgan Chase Tower**: five-sided Q-curve sloped top. Historically the tallest in Texas for 44 years.
- **Heritage Plaza**: Mayan stepped pyramid crown — 3 tiers narrowing above the main body. Adds a fourth recognizable building.
- **Narrow filler spines**: interleave 10px-wide `rx="2"` green rectangles between the orange landmarks. This is what makes Houston look like Dallas — books+buildings, not just buildings.

## Design Process — Lessons from 2026-06-10 Session

**Ask before building on ambiguous layout requests.** Steve's explicit rule: "If you're unsure of what to do, you need to ask." When a direction has multiple valid interpretations (e.g. "put HOME and WRITING beside each other" — left? center? right?), confirm BEFORE coding. Wasted iteration is worse than a 10-second clarification.

**Make a call and show it — don't ask everything.** The counterbalance: for non-ambiguous design work, Steve wants the agent to make a reasonable call, build it, and show a screenshot. "Show me, don't ask me." The ask-first rule applies to placements and structural decisions; it does NOT mean asking permission for every small design choice.

**Show 5 variants before committing to a direction.** For major layout decisions, building 5 distinct HTML mockups (standalone files, no live site changes) and opening them all in Chrome at once is the right workflow. Steve reviews, picks a direction or hybrid, THEN you rebuild. This session went through many small iterations that could have been resolved faster with an upfront mockup round.

**Visual QA is non-negotiable.** Steve explicitly said "you need to do a better job of quality audit." Screenshot + vision_analyze BEFORE calling a fix done. Don't describe what you think should be visible — verify it. A half-second screenshot check would have caught the clipped ball and the "H" missing from HOME immediately.

**Steve's design standards are precise.** "It's subtle but you need to fix it" — he notices fine details. An orange circle with a barely-visible flat top IS broken. A building that's almost book-like is not book-like. Hold yourself to pixel-correct QA.

**"Blogs" not "essays."** Steve corrected this explicitly. His writing is called "blogs." Anywhere the UI says "essays" is wrong.

**Platform decisions:** Steve chose Astro+Netlify because "I want it to be mostly friendly to you [the AI]." The site architecture — markdown files, git-based publishing — was deliberately chosen so I can manage it without fighting a CMS. Honor that: keep the stack simple, commit small, verify with screenshots.

Load `stevewandler-site-qa` and run the checklist. Non-negotiable.
The QA skill has the exact screenshot commands and visual checklist.

## Tumblr (legacy)

Tumblr still exists at `stevewandler.tumblr.com` as a fallback — Steve's 1,132 posts are there. The Tumblr customizer is fundamentally hostile to automation:
- Tumblr's Edit HTML editor renders as a ghost (0×0) in headless Chrome
- The `customize_api` endpoint rejects replay attacks
- CSS fields reject HTML tags (even inside `url()` data URIs)
- The "Add custom CSS" box is a different editor than Edit HTML — don't confuse them
**Do not attempt programmatic Tumblr theme saves.** If Steve ever wants to update his Tumblr theme, manual paste in his real Chrome using the documented sequence: Edit HTML → paste → Update Preview → back arrow → Save.

## Absorbed Skills (consolidated by curator 2026-06-14)
- `stevewandler-tumblr-theme` → Tumblr lessons now in `references/tumblr-lessons.md`
- `stevewandler-site` → site architecture and publishing workflow now in this skill's main body
- `stevewandler-site-qa` → visual QA protocol; use the checklist and baseline-good tag system documented in references/

## References
- `references/skyline-pitfalls.md` — SVG pitfalls for the skyline header
- `references/texas-skyline-research.md` — city-by-city building details
- `references/tumblr-lessons.md` — why Tumblr automation failed and what was learned
