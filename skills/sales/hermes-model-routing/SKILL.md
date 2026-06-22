---
name: hermes-model-routing
description: "Model routing strategy for Steve's Hermes setup: which model tier goes where across main sessions, delegation, auxiliary tasks, and cron jobs."
version: 1.0.0
author: agent
tags: [hermes, openrouter, models, routing, cron, delegation, auxiliary]
category: morning-automation
references:
  - references/openrouter-account-administration.md
  - references/openrouter-cost-control.md
  - references/openrouter-token-management.md
  - references/openrouter-dashboard-ui-levers.md
  - references/anthropic-spend-management.md
---

# Hermes Model Routing Strategy

Steve's Hermes routes mainly through OpenRouter, but he ALSO holds direct provider
keys (Anthropic OAuth + API key, Gemini, Copilot) — see the Direct Provider
Credentials section. The OpenRouter account is on **steve@bookmarked.com** and has
THREE keys, of which the personal Hermes is NOT the biggest spender. This skill
captures the routing decisions made 2026-06-09 and the reasoning behind them — so
future sessions don't re-litigate settled questions.

For LIVE OpenRouter account work — logging into the dashboard via local CDP Chrome,
pulling real spend/credits/auto-topup data, the two-layer (OpenRouter vs
Anthropic-direct) spend map, per-key spend identification, and the red/yellow/green
audit Steve expects — read `references/openrouter-account-administration.md`. That is
the "token infrastructure administrator" workflow.

For cost-control / OpenRouter optimization work, read `references/openrouter-cost-control.md` before recommending changes. It captures the June 2026 audit lesson: GPT-5.5 is too expensive as an everyday default unless explicitly benchmarked, and the real savings come from model tiering + auxiliary routing + MCP/tool-footprint trimming + OpenRouter account guardrails.

For OpenRouter DASHBOARD UI settings — BYOK (Bring Your Own Key to bypass credit
fees), per-key spend limits (safety net), guardrails (model allowlists on keys),
ZDR (Zero Data Retention), and what NOT to bother configuring — read
`references/openrouter-dashboard-ui-levers.md` (built 2026-06-20). These are
settings that must be configured in the web UI, not through config.yaml or the API.

For the ONGOING token-management mandate — the verified key map, the management-API
analytics source (the watchdog/dashboard data), code-verified `session_id` sticky
caching (personal Hermes AND fleet — both verified), app-title per-agent attribution,
provider-routing tier-as-policy, Steve's locked tiering philosophy, the watchdog cron
job (7am CT daily, zero-token no_agent script at `~/.hermes/scripts/openrouter_watchdog.py`),
the HTML dashboard (v3 unified OR+Anthropic at `~/.hermes/scripts/token_dashboard.py`
→ `~/.hermes/dashboard/tokens.html`), and the measure-first discipline — read
`references/openrouter-token-management.md`. This is the canonical "token infrastructure
administrator" knowledge bank (built 2026-06-20, upgraded 2026-06-21).

For Anthropic DIRECT spend — the Admin API (`sk-ant-admin01-...` key), per-key spend
tracking, Railway dream cycle optimization, BYOK setup on OpenRouter, API key consolidation
across services, and the complete audit checklist for Anthropic cost anomalies — read
`references/anthropic-spend-management.md` (built 2026-06-21).

## The three OpenRouter keys — definitive map

- `...f20a` "steve-hermes-person-local" = THIS personal Hermes (only OR key in its config).
- `...953` "steve_openclaw" = the BOOKMARKED Hermes agent fleet (Dewey/Johnny/Atlas/etc.),
  NOT Claude Code despite the `~/.claude` dir. The bigger, faster-growing spender. Never
  disable it — that breaks the fleet and their crons.
- `...27a` "steve-hermes-person" = stale personal leftover (~$46), not in any config, safe
  to disable. Auto Top-Up is enabled (+$500 at <$25); manage spend via routing + per-key
  visibility, NOT hard caps (caps on an always-on fleet = outage).

## Steve's tiering philosophy (LOCKED 2026-06-20 evening)

- **Steve's personal Hermes: DeepSeek V4 Pro** ($0.43/1M) — switched from Opus 4.6
  on 2026-06-20 evening. Steve decided the 10% quality gap wasn't worth $900/mo.
  Opus 4.6 remains available via `/model` for hard problems — it's not gone, just
  not the default. Charlie board updates and dream cycle STAY on Opus (high-stakes).
- **Bookmarked fleet top tier: DeepSeek V4 Pro** ($0.43/1M input) — ~90% of Opus quality
  at 1/11th the price. Matches/beats Opus on tool-calling benchmarks (Toolathon 51.8% vs
  48.8%, Terminal-Bench tied). All reasoning-heavy fleet agents: Dewey, Johnny, Atlas,
  Priya, Zig, Ford, Seth, and Oz (main agent — kills the $901/mo GPT-5.5 line).
- **Bookmarked fleet workhorse: DeepSeek V4 Flash** ($0.09/1M input, 55x cheaper than
  Opus) — Scout, Ledger, ALL auxiliary tasks fleet-wide, ALL delegation/subagents.
- **NO Anthropic models in the fleet.** Sonnet/Opus too expensive when DeepSeek delivers
  equivalent quality. Upgrade only on evidence of quality failures, not on principle.
- Escalation (Opus 4.8/Fable) is still deliberate per-job only, never automatic.
- Goal remains: make MORE usage safe via optimization, not ration.

## The Stack (as of 2026-06-20)
## The Stack (as of 2026-06-20 evening)

| Layer | Model | Why |
|---|---|---|
| Main sessions (personal) | `deepseek/deepseek-v4-pro` via OpenRouter | Default — judgment, synthesis, coding. Opus 4.6 available via `/model` for hard problems. |
| Default delegation (leaf) | `deepseek/deepseek-v4-flash` via OpenRouter | Cheap, fast, mechanical tasks |
| ALL auxiliary tasks (13) | `deepseek/deepseek-v4-flash` via OpenRouter | web_extract, vision, compression, title_gen, approval, mcp, skills_hub, curator, monitor, triage, kanban, profile_describer, tts_audio_tags |
| Morning brief (cron) | `anthropic/claude-sonnet-4.6` via OpenRouter | First thing Steve reads — needs quality. May switch to DS V4 Pro after testing. |
| Evening email review (cron) | `anthropic/claude-sonnet-4.6` via OpenRouter | Judgment on email triage. Same note as morning brief. |
| G-Brain nightly sync (cron) | no-agent script | Mechanical health check + sync, zero tokens |
| Charlie Thursday prep (cron) | `anthropic/claude-opus-4.6` via OpenRouter | Board-level strategic writing |
| Charlie Friday draft (cron) | `anthropic/claude-opus-4.6` via OpenRouter | Board-level strategic writing |
| Railway dream cycle | `openai:gpt-4o-mini` via OpenRouter | Overnight synthesis. Was Opus 4.6 ($5.00/1M), moved to gpt-4o-mini ($0.15/1M) 2026-06-21 for 97% savings. |
| OpenRouter watchdog (cron) | no-agent script | Daily spend report + model optimizer, zero tokens |
| Token dashboard (cron) | no-agent script | Unified HTML dashboard (OpenRouter + Anthropic), zero tokens. Script: `token_dashboard.py` |

### Bookmarked Fleet (all on Raju's server, managed by Dewey)

| Agent | Default | Delegation | Aux | Role |
|---|---|---|---|---|
| Dewey | deepseek-v4-pro | deepseek-v4-flash | deepseek-v4-flash | CEO operator agent |
| Johnny | deepseek-v4-pro | deepseek-v4-flash | deepseek-v4-flash | CPO, product judgment |
| Atlas | deepseek-v4-pro | deepseek-v4-flash | deepseek-v4-flash | CCSO, client success |
| Scout | deepseek-v4-flash | deepseek-v4-flash | deepseek-v4-flash | Rubric-driven analysis |
| Priya | deepseek-v4-pro | deepseek-v4-flash | deepseek-v4-flash | Product feedback |
| Seth | deepseek-v4-pro | deepseek-v4-flash | deepseek-v4-flash | CMO |
| Zig | deepseek-v4-pro | deepseek-v4-flash | deepseek-v4-flash | CRO, sales |
| Ford | deepseek-v4-pro | deepseek-v4-flash | deepseek-v4-flash | COO |
| Ledger | deepseek-v4-flash | deepseek-v4-flash | deepseek-v4-flash | CFO, analysis |
| Oz | deepseek-v4-pro | deepseek-v4-flash | deepseek-v4-flash | Main agent (was GPT-5.5) |

All agents tagged with `X-Title: Bookmarked-<AgentName>` for per-agent spend visibility.
GPT-5.5 eliminated from Oz. No Anthropic models in the fleet.
| ALL auxiliary tasks (13) | `deepseek/deepseek-v4-flash` | $0.09/1M — switched from Haiku ($1.00) on 2026-06-20. 11x cheaper. |

### Bookmarked Fleet (key ...953, Raju's server)
| Layer | Model | Why |
|---|---|---|
| Fleet top tier (7 agents) | `deepseek/deepseek-v4-pro` | 90% of Opus quality at $0.43/1M (11.6x cheaper) |
| Fleet workhorse (2 agents) | `deepseek/deepseek-v4-flash` | $0.09/1M — rubric-driven work |
| Fleet aux tasks (all agents) | `deepseek/deepseek-v4-flash` | Pinned fleet-wide |
| Fleet delegation/subagents | `deepseek/deepseek-v4-flash` | Subagents don't need Pro |
| Oz (Hermes Main Agent) | `deepseek/deepseek-v4-pro` | Was GPT-5.5 ($901/mo), migrated |

**NO Anthropic or OpenAI models in the fleet.** Upgrade only on evidence of quality failure.

### G-Brain Model Routing (audited 2026-06-21)

G-Brain is independent of OpenRouter fleet routing. Its models are set in launchd plists AND in the Railway `gbrain-dream-cycle` service — these can DRIFT. Always check both.

**Local DB config (correct as of 2026-06-21):**
- `models.dream.synthesize = openai:gpt-5.2` (through OpenRouter key ...f20a)
- `models.dream.synthesize_verdict = openai:gpt-4o-mini`
- `models.default = anthropic:claude-sonnet-4-6`

**Railway `gbrain-dream-cycle` service — FIXED 2026-06-21:**
The local dream cycle plist (`com.gbrain.dream-cycle.plist`) is DISABLED.
Dream cycles run on Railway with its own config. Railway had `GBRAIN_CHAT_MODEL`
set to `openrouter:anthropic/claude-opus-4.6` ($5.00/1M, $865/week). FIXED by
setting `GBRAIN_CHAT_MODEL=openai:gpt-4o-mini` ($0.15/1M, ~$12/week projected).
97% reduction in Anthropic spend. Watch dream cycle output quality for 2-3 nights;
bump to `openai:gpt-5.2` if reflections feel shallow.

## Direct Provider Credentials (as of 2026-06-13)

Steve has direct credentials for Anthropic and is adding Gemini. The intent is:
- **OpenRouter stays the default** — single bill, model catalog breadth, stays as `model.provider: openrouter`
- **Direct Anthropic** — already configured (`dashboard_pkce` OAuth + `ANTHROPIC_API_KEY` in env). Use to burn Claude subscription/API tokens before hitting OpenRouter spend. Invoke with `hermes --provider anthropic` or `hermes chat --provider anthropic`.
- **Direct Google Gemini** — being added. API key from Google AI Studio (https://aistudio.google.com/app/apikey), must be from the Bookmarked Google account. Add via `hermes auth add` or set `GOOGLE_API_KEY` in `~/.hermes/.env`. Then invoke with `hermes --provider google`.

**To switch provider on demand:**
```bash
hermes --provider anthropic           # start session on direct Anthropic
hermes --provider google              # start session on direct Gemini
hermes chat --provider anthropic -q "..." # one-shot query
# Or mid-session:
/model                                # interactive picker, select provider + model
```

Hermes normalizes model names automatically — e.g. `anthropic/claude-sonnet-4.6` becomes `claude-sonnet-4-6` when routing direct. This is cosmetic, not an error.

**Google API key format:** Google AI Studio API keys do NOT always start with `AIza`. As of mid-2026, newly generated keys start with `AQ.` followed by a long base64-like string. Both formats are valid — do NOT challenge a key just because it doesn't look like the old `AIza` format. If auth fails (HTTP 401/403), then question the key; not before. Get the key from https://aistudio.google.com/app/apikey logged into the correct Google account (Bookmarked account, not personal Gmail).

## Bookmarked Agent Model Decisions (LOCKED 2026-06-20 evening)

Fleet-wide policy: DeepSeek V4 Pro for all reasoning agents, DeepSeek V4 Flash for
rubric/mechanical agents + all aux tasks + all delegation. No Anthropic or OpenAI.

| Agent | Target Model | Role |
|-------|-------------|------|
| Dewey (CEO) | `deepseek/deepseek-v4-pro` | Fleet operator — already on it |
| Johnny (CPO) | `deepseek/deepseek-v4-pro` | Product judgment, feedback synthesis |
| Atlas (CCSO) | `deepseek/deepseek-v4-pro` | Client success, heavy tool-calling |
| Priya | `deepseek/deepseek-v4-pro` | Classification, Q&A intake |
| Zig (CRO) | `deepseek/deepseek-v4-pro` | Sales tool-calling, 11 cron jobs |
| Ford (COO) | `deepseek/deepseek-v4-pro` | Operations |
| Seth (CMO) | `deepseek/deepseek-v4-pro` | Marketing, mixed workload |
| Scout | `deepseek/deepseek-v4-flash` | Rubric-driven work |
| Ledger (CFO) | `deepseek/deepseek-v4-flash` | Financial analysis, script-driven |
| Oz (Main Agent) | `deepseek/deepseek-v4-pro` | Runtime orchestration (was GPT-5.5 @ $901/mo) |

**Aux pinning (fleet-wide, all 9 agents):** web_extract, title_generation, compression,
vision → `deepseek/deepseek-v4-flash`. Delegation model → `deepseek/deepseek-v4-flash`.

**Principle:** Don't default to expensive models when cheaper ones work. DeepSeek V4 Pro
≈ 90% of Opus quality at 1/11th the price. Upgrade only on evidence of quality failure.
Fleet-wide Gemini Flash Lite pin for web_extract, title_gen, compression is a quick win.

**Decision principle (revised):** Don't upgrade to a more expensive model without
evidence the current one is failing. Test DeepSeek V4 Pro before Sonnet for agents
flagged as needing better tool-calling.

## Design Principles

**OpenRouter as the default router.** OpenRouter stays as `model.provider` in config — single bill, full model catalog. Direct provider credentials are for deliberately burning subscription/prepaid tokens (Anthropic Claude.ai subscription, Google Gemini quota) before OpenRouter spend accrues. There is no automatic fallback hierarchy; switching providers is an explicit per-session choice.

**No automatic "burn X before Y" ordering.** Hermes doesn't natively support a provider priority queue. Consuming direct quota is a manual switch (`--provider anthropic/google`) or a `/model` pick mid-session.

**Gemini with full MCP toolset will fail.** Running `--provider google` with the full MCP tool schema (HubSpot, Atlassian, Slack, G-Brain all loaded) causes HTTP 400 INVALID_ARGUMENT errors because Gemini's tool schema validator is stricter than OpenRouter/Anthropic. It rejects array fields missing an `items` type declaration. Until Hermes normalizes schemas for Gemini, direct Gemini sessions only work reliably with `--toolsets web,terminal,file` or similar minimal sets. Anthropic direct works with the full toolset.

**Tier discipline.** Two fleet tiers, both DeepSeek:
- **V4 Pro** — reasoning, tool-calling, judgment (all agents except Scout/Ledger)
- **V4 Flash** — rubric-driven, mechanical, all aux tasks, all delegation/subagents

Steve's personal Hermes stays on Opus 4.6 (quality ceiling for his own thinking).
Charlie board updates and dream cycle stay on Opus 4.6 (high-stakes writing/synthesis).

**Don't default to expensive models.** DeepSeek V4 Pro delivers ~90% of Opus quality
at 1/11th the cost and actually beats Opus on some tool-calling benchmarks. The watchdog's
model optimizer continuously checks the OpenRouter catalog for cheaper alternatives —
when something better launches, it surfaces automatically. The right model is always
the cheapest one that does the specific job well, verified by evidence not brand loyalty.

**DeepSeek V4 Flash for ALL personal Hermes auxiliary tasks (updated 2026-06-20).**
All 13 aux tasks (approval, compression, curator, kanban_decomposer, mcp, monitor,
profile_describer, skills_hub, title_generation, triage_specifier, tts_audio_tags,
vision, web_extract) switched from Haiku ($1.00/1M) to DeepSeek V4 Flash ($0.09/1M).
11x cheaper per aux call. Takes effect on next session/gateway restart.

## How to Check Current Routing

```bash
# Main model
hermes config | grep Model

# Raw source of truth when drift is suspected
python3 - <<'PY'
import yaml, pathlib
c = yaml.safe_load(pathlib.Path('~/.hermes/config.yaml').expanduser().read_text())
print('model.default:', c.get('model',{}).get('default'))
print('model.provider:', c.get('model',{}).get('provider'))
print('delegation.model:', c.get('delegation',{}).get('model'))
print('delegation.provider:', c.get('delegation',{}).get('provider'))
PY

# Cron job models
hermes cron list

# Auxiliary routing
grep -A3 "auxiliary:" ~/.hermes/config.yaml | grep "model:"

# Railway dream cycle
railway variables --service gbrain-dream-cycle | grep GBRAIN_CHAT_MODEL
```

Cost-control rule: if the default model is an Opus/GPT-5-class model on the personal
Hermes OR any Anthropic/OpenAI model on the fleet, immediately ask whether that was
deliberate. Personal Hermes default is DeepSeek V4 Pro; fleet is DeepSeek V4 Pro/Flash.
Opus is explicit-use only (/model picker, Charlie crons, dream cycle).

## How to Update

### Cron job model
Use the `cronjob` tool:
```
cronjob(action='update', job_id='<id>', model={"model": "anthropic/claude-opus-4.6", "provider": "openrouter"})
```

### Auxiliary task model
```bash
hermes config set auxiliary.<task>.provider openrouter
hermes config set auxiliary.<task>.model google/gemini-2.5-flash-lite
```

### Railway dream cycle
```bash
railway link --project responsible-creativity
railway variables set GBRAIN_CHAT_MODEL="openai:gpt-4o-mini" --service gbrain-dream-cycle
```
Note: `OPENROUTER_API_KEY` must also be set on Railway. Set both together.

### Default delegation floor
```bash
hermes config set delegation.model "anthropic/claude-haiku-4.5"
hermes config set delegation.provider "openrouter"
```

## OpenRouter Model ID Reference (confirmed live 2026-06-20)

| Model | ID | Cost/1M input | Context |
|---|---|---|---|
| DeepSeek V4 Pro | `deepseek/deepseek-v4-pro` | $0.43 | 1M |
| DeepSeek V4 Flash | `deepseek/deepseek-v4-flash` | $0.09 | 1M |
| Claude Haiku 4.5 | `anthropic/claude-haiku-4.5` | $1.00 | 200K |
| Claude Sonnet 4.6 | `anthropic/claude-sonnet-4.6` | $3.00 | 1M |
| Claude Opus 4.6 | `anthropic/claude-opus-4.6` | $5.00 | 1M |
| Claude Opus 4.7 | `anthropic/claude-opus-4.7` | $5.00 | 1M |
| Claude Opus 4.8 | `anthropic/claude-opus-4.8` | $5.00 | 1M |
| Gemini 2.5 Flash Lite | `google/gemini-2.5-flash-lite` | $0.10 | 1M |
| Gemini 2.5 Flash | `google/gemini-2.5-flash` | $0.30 | 1M |
| Gemini 2.5 Pro | `google/gemini-2.5-pro` | $1.25 | 1M |
| Grok 4.20 | `x-ai/grok-4.20` | $1.25 | 2M |
| Qwen3 Coder | `qwen/qwen3-coder` | $0.22 | 1M |

Always verify current model IDs against OpenRouter's live catalog before configuring
a new model — IDs drift with version releases.

```bash
curl -s "https://openrouter.ai/api/v1/models" \
  -H "Authorization: Bearer $(grep OPENROUTER_API_KEY ~/.hermes/hermes-agent/.env | cut -d= -f2)" \
  | python3 -c "
import json, sys
data = json.load(sys.stdin)
for m in data.get('data', []):
    mid = m.get('id', '')
    if any(k in mid.lower() for k in ['gemini','grok','haiku','sonnet','opus']):
        cost = float(m.get('pricing',{}).get('prompt',0)) * 1_000_000
        print(f'{mid:55s} \${cost:.2f}/1M ctx:{m.get(\"context_length\",0):>9,}')
" | sort
```

## Pitfalls

- **`claude-opus-4-5` does not exist on OpenRouter** — the correct ID is `claude-opus-4.6`
  (dot, not dash). Using `claude-opus-4-5` will silently fail or route to wrong model.
  Always use dots in version suffixes for Anthropic models on OpenRouter.

- **`OPENROUTER_API_KEY` is in `~/.hermes/hermes-agent/.env`, NOT `~/.hermes/.env`** —
  the main `.env` has it commented out. When building scripts that need the key:
  `grep OPENROUTER_API_KEY ~/.hermes/hermes-agent/.env | grep -v '^#' | cut -d= -f2`

- **`hermes config set fallback_providers` with Anthropic is pointless without a direct key** —
  if there's no `ANTHROPIC_API_KEY` in `.env`, setting `fallback_providers: ["anthropic"]`
  just causes confusing failures. Keep it empty (`[]`) when routing 100% through OpenRouter.

- **Cron jobs inherit `delegation.model` when `model: null`** — after setting Haiku as the
  delegation default, any cron job without an explicit model set will run on Haiku. High-value
  jobs (morning brief, email review) need explicit Sonnet pins or they silently downgrade.

- **Config changes don't apply to running sessions.** If Steve updates `model.default` in
  config.yaml (e.g., changing from gpt-5.5 back to claude-sonnet-4.6), the active session
  continues on its original model until it ends. The fix is to start a new session — confirm
  which model is running by checking the session header, not the config file. The config is
  correct; the session just needs to restart to pick it up.

- **Railway dream cycle model change requires BOTH vars** — `GBRAIN_CHAT_MODEL` and
  `OPENROUTER_API_KEY` must both be set on the Railway service. Setting just the model
  without the key will fail at runtime.

- **The correct header for app-title tagging is `X-Title`, NOT `X-OpenRouter-Title`.**
  Hermes source code and Dewey's verification confirm `X-OpenRouter-Title` is the old
  name and is not recognized by OpenRouter's dashboard. Always use `X-Title` when
  configuring per-agent attribution via `model.default_headers`.

- **NEVER set OpenRouter per-key credit limits that could block Steve from working.**
  Steve explicitly rejected hard spending caps (2026-06-20). His words: "I don't want
  to stop working. I just want to know what the budgets are and reduce costs." The
  watchdog + dashboard provide visibility. Model routing provides cost control. Hard
  limits that cause outages or block interactive sessions are the WRONG lever. If you
  set a $300/mo limit on his personal key, it will immediately show 100% used and
  block every request. Don't do it. Visibility and routing are the controls, not caps.

- **Dewey's Slack channel is `C0AR85TMVS8`, NOT DMs.** Dewey's agent does not pick
  up messages posted by bot identities in DM channels. Always use C0AR85TMVS8 and
  @mention both Dewey (U0AR21JHLFP) and Steve (U05C13KAW85).

- **Qwen3 Coder is NOT a drop-in replacement for DeepSeek V4 Pro.** Input is cheaper
  ($0.22 vs $0.43/1M) but output is 2x more expensive ($1.80 vs $0.87/1M). Only wins
  on input-heavy workloads. Don't swap the fleet without benchmarking output-heavy agents.

- **Anthropic Admin API amounts are in CENTS (minor units).** The cost_report endpoint
  returns `amount` as a decimal string in cents — divide by 100 for dollars. Admin keys
  (`sk-ant-admin01-...`) are separate from regular API keys and must be created at
  console.anthropic.com → Settings → Admin Keys. Regular keys cannot access the Admin API.

- **G-Brain Railway config and local DB config DRIFT independently.** Always check both
  when diagnosing Anthropic spend. Railway env vars (set via `railway variables`) override
  local DB config. The local `com.gbrain.dream-cycle.plist` is DISABLED — dream cycles
  run on Railway.
