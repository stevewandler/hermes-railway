---
name: astro-netlify-deploy
description: "Deploy Astro static sites to Netlify via GitHub: scaffold, content collections, auto-deploy wiring, and Astro v6 pitfalls. Proven on stevewandler-site (2026-06-10)."
version: 1.0.0
author: agent
tags: [astro, netlify, static-site, deployment, github]
---

# Astro + Netlify Deployment

Use when building or maintaining a static personal site, portfolio, or blog on Astro deployed via Netlify.

## Stack
- **Astro v6** (current as of 2026-06-10) — static site generator
- **Netlify** — CDN + auto-deploy (free tier for personal sites)
- **GitHub** — source of truth; push to main → Netlify rebuilds automatically
- **`netlify-cli`** — local auth and manual deploy if needed

## Quick scaffold
```bash
cd ~/sites
npm create astro@latest my-site -- --template minimal --no-install --no-git --skip-houston --yes
cd my-site && npm install
```

## Netlify CLI setup
```bash
npm install -g netlify-cli
netlify --version  # verify install
netlify login      # opens browser, auth to account
```

## netlify.toml (required for auto-detect)
```toml
[build]
  command = "npm run build"
  publish = "dist"

[build.environment]
  NODE_VERSION = "20"
```

## Connect GitHub → Netlify
1. Push repo to GitHub: `gh repo create <name> --private --source=. --remote=origin --push`
2. In Netlify dashboard → "Import a Git repository" → GitHub → pick repo
3. Netlify detects `netlify.toml` — build command and publish dir auto-filled
4. Every `git push origin main` triggers a rebuild

## Content Collections (Astro v6)

### BREAKING CHANGE from Astro v5: config file location moved
```
# v5: src/content/config.ts
# v6: src/content.config.ts  (root of src/)
```
And collections now require a `loader`:
```typescript
// src/content.config.ts
import { defineCollection, z } from 'astro:content';
import { glob } from 'astro/loaders';

const blog = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './src/content/blog' }),
  schema: z.object({
    title: z.string(),
    date: z.coerce.date(),
    excerpt: z.string().optional(),
    draft: z.boolean().optional().default(false),
  }),
});
export const collections = { blog };
```

### BREAKING CHANGE: `post.slug` → `post.id`
In v6 with glob loader, use `post.id` for URL slugs. Update all template references.

### BREAKING CHANGE: `post.render()` → `render(post)`
```typescript
// v6:
import { getCollection, render } from 'astro:content';
const { Content } = await render(post);
```

## Markdown post frontmatter
```yaml
---
title: "Post Title Here"
date: 2026-06-10
excerpt: "One sentence teaser."
draft: false
---
Body content here...
```
Set `draft: true` to write without publishing. Filter drafts: `.filter(p => !p.data.draft)`.

## AI-driven posting workflow (for personal sites where the owner doesn't edit)
```bash
# 1. Write the markdown file
cat > ~/sites/my-site/src/content/blog/my-post.md << 'EOF'
---
title: "Post Title"
date: 2026-06-10
excerpt: "Teaser."
draft: false
---
Post body here.
EOF

# 2. Build + verify locally
cd ~/sites/my-site && npm run build
npm run preview -- --port 4399

# 3. Push → auto-deploy
git add -A && git -c user.email="..." -c user.name="..." commit -m "Add: Post Title"
git push origin main
# Netlify rebuilds in ~30 seconds. Verify at live URL.
```

## Local preview + headless screenshot (for visual QA)
```bash
# Start preview server (background)
cd ~/sites/my-site && npm run preview -- --port 4399 &
sleep 4

# Screenshot with headless Chrome
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
"$CHROME" --headless --disable-gpu --no-sandbox --hide-scrollbars \
  --window-size=1400,900 --virtual-time-budget=2500 \
  --screenshot=/tmp/preview.png "http://localhost:4399/" 2>/dev/null

# Then: vision_analyze /tmp/preview.png to inspect visually
```
This is the only reliable way to QA rendering — the Hermes browser tool can't reach `localhost` reliably.

## Pitfalls

### TypeScript lint errors on `astro:content` virtual module
The `astro:content` module only resolves at build time. Standalone `tsc` will show `TS2307`. Safe to ignore — build succeeds.

### `gh repo create` with existing files
Always run from INSIDE the project directory with `--source=.`:
```bash
gh repo create my-site --private --source=. --remote=origin --push
```

### Background preview servers keep getting killed
Use `terminal(background=true, notify_on_complete=false)` for the preview server (it never exits naturally). Don't use foreground terminal for servers — they compete with the timeout.

### Port conflicts on re-run
If Astro says "Port 4399 is in use, trying 4400" — check `lsof -nP -iTCP:4399 -sTCP:LISTEN`. Kill stale node process with `pkill -f "astro preview"` before relaunching.

### SVG viewBox headroom + preserveAspectRatio (critical: both required together)
When embedding an SVG inside a container with `padding-top`, elements near y=0 clip at the top even when viewBox headroom is added — because `xMidYMax slice` anchors to the **bottom** and crops the top, eating the headroom.

**Both required together:**
```svg
<!-- WRONG: YMax crops top, killing headroom -->
<svg viewBox="0 -20 1200 170" preserveAspectRatio="xMidYMax slice">

<!-- CORRECT: YMin anchors to top, crops bottom — headroom is preserved -->
<svg viewBox="0 -20 1200 170" preserveAspectRatio="xMidYMin slice">
```
All existing x/y coordinates remain valid. Elements at y=50 now have 70px of viewBox space above them at the top of the rendered area.

### SVG rotating text — use CSS writing-mode over the SVG, never SVG rotate()
SVG `rotate()` transforms break when the SVG scales non-uniformly. Position HTML elements absolutely over the SVG instead:
```html
<div style="position:relative;">
  <a href="/" style="position:absolute; bottom:0; left:72px; writing-mode:vertical-rl; transform:rotate(180deg);">HOME</a>
  <svg ...>...</svg>
</div>
```

### Tumblr archive migration
Tumblr exports as `posts.zip` inside the main ZIP. Inside that: `html/` folder with one HTML file per post (named by post ID). The HTML files have line numbers prepended (e.g. `123|<div>`) — strip with `re.sub(r'^\d+\|', '', line)` when parsing.

Most Tumblr archives are ~99% old tweets/reblogs. Filter by text length: posts with <40 words are almost certainly reblogs, not original writing. Migrate only substantive posts (120+ words).

Post ID → date: long numeric IDs (snowflake format) encode timestamp via `ms = (id >> 22) + 1288834974657`. Short legacy IDs need manual date estimation from content era.

## References
- See `steve-personal-brand-web` skill for full design architecture of stevewandler.com
