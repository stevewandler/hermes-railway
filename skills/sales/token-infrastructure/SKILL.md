---
name: token-infrastructure
description: "Use when Steve asks about token spend, cost optimization, dashboard, audit, or management across OpenRouter, Anthropic, Railway, G-Brain, and all AI services. The canonical token infrastructure administrator skill."
version: 1.0.0
author: agent
tags: [tokens, cost, openrouter, anthropic, railway, gbrain, auditing]
category: sales
related_skills: [hermes-instance-tuning, hermes-model-routing, gbrain, gbrain-book-ingest]
references:
  - references/anthropic-admin-api.md
  - references/railway-services.md
---

# Token Infrastructure Management

## Native Hermes Routing

Load this skill when Steve asks about token spend, cost optimization, dashboard, auditing, or management across any provider. It is the canonical skill for token infrastructure work. Pair with `hermes-instance-tuning` for local Hermes optimization and `hermes-model-routing` for model tier decisions.

## The Audit Principle (Steve's Rule)

**Never assume remote config matches local config.** This is the #1 mistake that caused missed Anthropic spend in June 2026. G-Brain's model routing lives in MULTIPLE INDEPENDENT LOCATIONS:

| Location | How To Check | What It Controls |
|---|---|---|
| G-Brain DB (Supabase) | `gbrain config get models.dream.synthesize` | Local autopilot synthesis |
| Railway gbrain-dream-cycle | `railway variables --service gbrain-dream-cycle` | Railway dream cycle cron |
| Railway gbrain (serve) | `railway variables --service gbrain` | MCP serve queries |
| Launchd plists | plistlib read `EnvironmentVariables` | Local serve + worker-supervisor |
| Hermes config | `hermes config` | Personal Hermes sessions |
| Cron jobs | `cronjob list` | Scheduled agent jobs |
| OpenRouter dashboard | Management API | Per-key/per-model spend |

**The audit sequence:**
1. Pull real spend data from every provider (OpenRouter Management API, Anthropic Admin API)
2. Map spend to consumers (keys, models, services)
3. Check EVERY config location independently — never trust one to represent another
4. Identify drift (models that shouldn't be active, stale keys, config mismatches)
5. Fix at the source of truth for each location
6. Lock configs to prevent re-drift
7. Add monitoring (cron jobs, dashboard) to detect future drift

## OpenRouter — Data Sources

- **Management API:** `OPENROUTER_MANAGEMENT_KEY` in `~/.hermes/.env`. Endpoints: `/api/v1/keys`, `/api/v1/activity`, `/api/v1/credits`.
- **Model catalog:** `OPENROUTER_API_KEY` from `~/.hermes/hermes-agent/.env`. Endpoint: `/api/v1/models`. Used by the model optimizer to find cheaper alternatives.
- **BYOK:** Configured at openrouter.ai/settings/byok. Anthropic key added June 2026 to avoid 5.5% credit fee.

### Verified Key Map (as of June 2026)

| Key suffix | Name | 30d Spend | Purpose |
|---|---|---|---|
| ...f20a | steve-hermes-person-local | ~$1,852 | Personal Hermes + G-Brain via OR |
| ...953 | steve_openclaw | ~$757 | Bookmarked fleet (Dewey, Johnny, etc.) |
| ...27a | steve-hermes-person | REMOVED | Was stale leftover |

## Anthropic Direct — Data Sources

- **Admin API:** `ANTHROPIC_ADMIN_KEY` in `~/.hermes/.env`. Key type: `sk-ant-admin01-...` (NOT `sk-ant-api03-...`). Created at console.anthropic.com → Settings → Admin Keys.
- **Endpoints:** `GET /v1/organizations/cost_report` (USD costs, amounts in cents), `GET /v1/organizations/usage_report/messages` (token counts), `GET /v1/organizations/api_keys` (key inventory).
- **Always use `group_by[]=description`** on cost_report for model-level breakdown. Without it, returns useless lump sums.
- **1-2 hour data lag** on current-day data.

### Verified Key Map

| Key | Name | Purpose |
|---|---|---|
| sk-ant-api03-g7P... | Hermes - Steve's | All G-Brain, both Railway services, OR BYOK |
| sk-ant-api03-CUi... | partrick-gbrain | Patrick's access (minimal) |
| sk-ant-api03-KUQ... | claude_code_key_steve | Claude Code (negligible) |

## G-Brain Model Routing — Canonical Values (LOCKED June 2026)

**Do not change these without updating the Confluence Token Management page.**

| Config Key | Canonical Value | Cost/1M | Purpose |
|---|---|---|---|
| models.dream.synthesize | openai:gpt-4o-mini | $0.15 | Dream cycle synthesis |
| models.dream.synthesize_verdict | openai:gpt-4o-mini | $0.15 | Synthesis quality judgment |
| models.default | anthropic:claude-sonnet-4-6 | $3.00 | gbrain think, ad-hoc queries |
| models.tier.subagent | anthropic:claude-sonnet-4-6 | $3.00 | Subagent children |
| models.calibration_profile | anthropic:claude-haiku-4-5 | $1.00 | Calibration scoring |
| models.voice_gate | anthropic:claude-haiku-4-5 | $1.00 | Voice quality filter |

## Monitoring Stack

| Cron Job | Schedule | What It Does | Tokens |
|---|---|---|---|
| token-dashboard-gen | Daily 7am CT | Generates tokens.html | Zero (no_agent) |
| openrouter-token-watchdog | Daily 7am CT | OR spend report + optimizer | Zero (no_agent) |
| config-drift-monitor | Daily 7:15am CT | G-Brain model drift + Opus detection | Zero (no_agent) |
| gbrain-nightly-sync | Daily 4am CT | G-Brain health + sync | Zero (no_agent) |

## Dashboard

- **Unified:** `~/.hermes/dashboard/tokens.html` — three tabs (Overview | OpenRouter | Anthropic Console)
- **Regenerate:** `python3 ~/.hermes/scripts/token_dashboard.py && open ~/.hermes/dashboard/tokens.html`
- **Data sources:** OpenRouter Management API + Anthropic Admin API
- **Legacy OR-only:** `~/.hermes/scripts/openrouter_dashboard.py` → `~/.hermes/dashboard/openrouter.html`

## Confluence Documentation

Token Management page: https://bookmarked-team.atlassian.net/wiki/spaces/~63bc961124db7967212386e1/pages/154763277/Token+Management

Contains: provider summary, locked model routing table, Railway service inventory, API key map, maintenance procedures, and "if something breaks" recovery steps.

## Pitfalls

- **Railway vs local config drift.** Always check both independently. See `references/railway-services.md`.
- **Anthropic cost API amounts are in cents, not dollars.** Always divide by 100.
- **Anthropic cost API requires `group_by[]=description`** for model-level data. Without it, all fields are null.
- **Never set OpenRouter per-key credit limits** without Steve's explicit request. He rejected hard caps. Visibility + routing are the controls.
- **G-Brain API key drift across plists.** serve, worker-supervisor, and dream-cycle plists carry keys independently. When rotating, update ALL THREE.
- **Railway deploy failures after env var changes.** A failed deploy means the service uses the LAST SUCCESSFUL deployment's config. Always verify with `railway service list --json`.
