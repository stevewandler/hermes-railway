---
name: hermes-instance-tuning
description: "Use when diagnosing or tuning Steve's personal Hermes instance: performance, memory, skills, knowledge structure, gateway reliability, MCP/tool footprint, cron health, OpenRouter cost posture, and capability-preserving optimization."
version: 1.0.0
author: agent
tags: [hermes, performance, mcp, tools, troubleshooting, openrouter, config]
category: sales
related_skills: [hermes-model-routing, hermes-agent, hermes-gbrain-operating-model, mcp-tool-allowlisting]
references:
  - references/computer-use-setup-macos.md  # Install/repair cua-driver, grant macOS permissions, AND runtime diagnostics: 0x0/blank captures, windowless apps, local-Chrome-vs-Browserbase, admin-console-only-via-computer_use
  - references/memory-structure-optimization.md  # Keep USER.md/MEMORY.md lean without losing retrievable context
  - references/knowledge-management.md  # Capability-preserving hot/warm/cold knowledge architecture and audit workflow
  - references/hermes-gbrain-operating-model.md  # How Hermes + G-Brain work together as one capability system
  - references/gbrain-mcp-cli-fallback.md  # Fallback write-through pattern when G-Brain MCP writes are unreachable
  - references/desktop-dashboard-connectivity.md  # Desktop Electron ↔ dashboard connection architecture, "HTTP 200 Internal Server Error" diagnosis
  - references/infrastructure-health-check.md  # Full diagnostic sequence, port map, version drift check, migration cleanup pattern
  - references/hardware-power-diagnostics.md  # Hardware specs, battery/power state, whether the Mac is suited for G-Brain/Hermes workload
  - references/openrouter-dashboard-audit.md  # Page-by-page OpenRouter dashboard review (every setting section)
  - references/railway-hermes-deployment.md  # Hermes-on-Railway: start command, Docker behavior, deployment checklist
---

# Hermes Instance Tuning

## Native Hermes Routing

Use this skill for Steve's personal Hermes operating health: performance, memory, skills, knowledge structure, gateway reliability, MCP/tool footprint, cron health, OpenRouter cost posture, and capability-preserving optimization. Pair with `hermes-agent` for native command/docs questions and `hermes-model-routing` for model tier decisions.

Source-of-truth order:
1. Live state from `hermes config`, `hermes tools list`, `hermes mcp list`, `hermes gateway status`, `hermes doctor`, logs, and audit scripts.
2. `hermes-agent` docs/skill for native Hermes behavior.
3. This skill's references for Steve-specific decisions and pitfalls.
4. G-Brain/session_search for prior optimization decisions and context.

Output mode: diagnose with real numbers, preserve capability over cleanup, and make reversible changes. Steve accepts slower responses when they produce better grounded help.

How to keep Steve's PERSONAL Hermes (the assistant he talks to; posts to WhatsApp,
not Slack) high-quality, grounded, cost-aware, and only as fast/lean as it can be without losing capability. Three recurring jobs live here:

1. **Performance troubleshooting** — "why is my Hermes running slow"
2. **MCP server + tool-footprint management** — keeping the prompt lean
3. **Memory structure optimization** — keeping `USER.md` / `MEMORY.md` useful instead of full

Sibling skill `hermes-model-routing` owns which model tier goes where. This skill
owns everything else about operating the instance. Always diagnose with real tool
output before recommending — Steve wants the actual numbers, not a generic list.

For memory-full / memory-structure work, use `references/memory-structure-optimization.md`: classify facts into USER.md vs MEMORY.md vs skills vs G-Brain vs session_search, and prefer compaction + `memory.write_approval: true` over raising limits. As of 2026-06-21: USER.md at 75% (1,886/2,500) and MEMORY.md at 68% (2,735/4,000) after a compaction pass — both well below danger zone. When Steve says "apply /memory approve" or asks to process pending memory items, the same reference has the full triage workflow for the `~/.hermes/pending/memory/` queue.

For capability-preserving knowledge optimization, use `references/knowledge-management.md`: optimize native Hermes hot/warm/cold routing without deleting useful context. The rule is better grounded help first, then cost control, then speed — Steve is okay with slower responses when they are substantially better. Run `python3 ~/.hermes/scripts/hermes_knowledge_audit.py` for a read-only audit before recommending skill/history changes; if unavailable, follow the same read-only inventory shape and preservation test before any mutation.

For aligning Hermes + G-Brain as one system, load the `hermes-gbrain-operating-model` skill. It packages the canonical operating model, G-Brain retrieval routing, and future strategy-measurement stub as a reusable skill. Use this skill’s `references/hermes-gbrain-operating-model.md` only for local implementation detail.

For a safe optimization pass when Steve wants to defer MCP allowlisting and deeper LLM/OpenRouter routing, use `references/non-mcp-optimization-2026-06-12.md`: compact memory, enable memory approval, stop immediate expensive-default drift, disable dead media toolsets, convert mechanical cron jobs to script/no-agent mode, verify WhatsApp gateway delivery, and audit skills/history before destructive cleanup.

For cost-cutting work, pair this skill with `hermes-model-routing` and its `references/openrouter-cost-control.md`. Do not frame cost as just a local config problem: the right audit includes model default, auxiliary routing, MCP/tool schema footprint, cron/delegation model pins, and OpenRouter account/API-key guardrails.

**CRITICAL — Railway service creation WITHOUT start command exits immediately (learned 2026-06-22).** When creating a Railway service from a Docker image via `railway add --image`, the container runs the image's default CMD. For `nousresearch/hermes-agent`, the default CMD is the interactive CLI, which exits immediately on Railway. The service shows "Completed" instead of "Online."

**The reliable fix (2026-06-22): Deploy via public GitHub repo with Dockerfile override.** Create a minimal public GitHub repo with:
```dockerfile
FROM nousresearch/hermes-agent:latest
CMD ["gateway", "run"]
```
Then connect Railway to it:
```bash
gh repo create stevewandler/hermes-railway --public
# Push Dockerfile to the repo
railway service source connect --service hermes --repo stevewandler/hermes-railway --branch main
```
The repo MUST be public — Railway can't access private repos without the Railway GitHub App installed. Once connected, `railway service redeploy --service hermes --yes` triggers a build+deploy. The Dockerfile approach is MORE RELIABLE than trying to set the start command via UI or CLI.

**Service recreation is NOT the fix.** Deleting and recreating the service may temporarily show "Online" but the container still runs the CLI and exits — it's just in a restart loop. Only the Dockerfile approach or the UI Start Command setting actually fixes the problem.

**Railway CLI pitfalls (2026-06-22):**
- `railway up` from `/tmp` hangs because of Google Drive IPC socket (`/private/tmp/drivefs_ipc.501_shell`). Always run from a directory outside `/tmp` (e.g., `~/hermes-railway-deploy/`).
- `railway service list` sometimes times out but `railway whoami` works fine — retry or use `railway service list --json` for machine-readable output.
- `railway service redeploy --service <name> --yes` triggers a deploy. No need for `railway up` from a directory.
- `railway service status` does NOT take a positional argument — use `--service <name>` or omit for linked service.
- `railway service logs --service hermes` returns "Deployment not found" when there's no active deployment — wait for deploy to finish first.

**CUA driver recovery sequence (2026-06-22):** When `computer_use` returns 0x0 or "daemon transport error," the daemon likely has a stale socket. Recovery:
```bash
rm -f /Users/stevewandler/Library/Caches/cua-driver/cua-driver.sock
pkill -9 cua-driver 2>/dev/null
sleep 1
cua-driver check_permissions  # auto-starts daemon
```
Then re-capture. Permissions check should show `accessibility: true, screen_recording: true`. If Chrome returns "no on-screen window," use Cmd+Tab to switch to it via `computer_use key keys=cmd+tab`. Chrome's AX tree will have labels but all bounds at [0,0,0,0] — keyboard navigation (Tab, Cmd+F, type, Enter) is the reliable fallback.

**Vision model configuration (2026-06-22):** The `auxiliary.vision` config in `config.yaml` controls which model is used for `computer_use` screenshot analysis. Changing it mid-session via `hermes config set` does NOT take effect — the agent reads config at session start. For the next session, set it to a vision-capable model:
```bash
hermes config set auxiliary.vision.provider openrouter
hermes config set auxiliary.vision.model google/gemini-2.5-flash
```
Current default `deepseek/deepseek-v4-flash` does NOT support vision. The error "No LLM provider configured for task=vision" indicates either no model set or model doesn't support images. G-Brain's dream cycle
runs on Railway, NOT locally. The local `com.gbrain.dream-cycle.plist` is DISABLED.
Railway has its OWN environment variables that are independent from the local G-Brain
DB config. The local DB can say `models.dream.synthesize=openai:gpt-5.2` while Railway
has `GBRAIN_CHAT_MODEL=openrouter:anthropic/claude-opus-4.6`. Always verify BOTH:

**Config drift monitor (cron `config-drift-monitor`, daily 7:15am CT):** This no-agent
script checks for missing model config keys. As of 2026-06-22, it flagged four unset keys:
`models.dream.synthesize`, `models.dream.synthesize_verdict`, `models.calibration_profile`,
`models.voice_gate`. These should be set:

```bash
gbrain config set models.dream.synthesize openai:gpt-4o-mini
gbrain config set models.dream.synthesize_verdict openai:gpt-4o-mini
gbrain config set models.calibration_profile anthropic:claude-haiku-4-5
gbrain config set models.voice_gate anthropic:claude-haiku-4-5
```

Note: `models.voice_gate` is a DB config key — the voice gate source code hardcodes the
model at `voice-gate.ts:162`. See gbrain skill `references/optimization-preferences.md`
section "Voice gate — definitive fix" for the patching procedure. The config key alone
won't fix voice gate failures; the source patch is ALSO required.

**Full infrastructure audit (2026-06-22):** See `references/infrastructure-audit-2026-06-22.md`
for the complete inventory of every component, tool, cron job, LaunchAgent, MCP server,
source, and data flow in Steve's setup. Covers: 5 MCP servers, 14 cron jobs, 62 skills,
8 cron scripts, 6 G-Brain sources, 3 Railway services, 21 active LaunchAgents, and the
Railway migration map. Use this as the reference document for any architecture or
migration planning.

**Railway migration plan (2026-06-22):** The full step-by-step migration plan is at
`~/.hermes/plans/2026-06-22_hermes-railway-migration.md`. 10 phases covering: pre-migration
fixes, audit & backup, stop dead LaunchAgents, build Hermes-native transcript pipeline,
deploy Hermes on Railway, config/skills/cron/memory migration, G-Brain source relocation,
cron registration, WhatsApp re-auth, observability, verification soak, and local cleanup.
Rollback plan included.

**Railway CLI deployment techniques (2026-06-22):** See `references/railway-cli-deployment.md`
for the complete reference on creating Docker image services via CLI, start command
configuration, volume attachment, env var management, and common pitfalls. Key discovery:
`railway add --image <docker-image> --service <name>` creates a service from a Docker image
directly — no web UI needed. This bypasses `railway up` indexing hangs and is the preferred
method for image-based services.

### Operational principle: read the source before asking the user (2026-06-22)

When investigating an unknown script, LaunchAgent, or automation, the source code is
on disk and readable. Read it. Do not ask Steve "what does this do?" when the script,
plist, or config file is accessible. During the 2026-06-22 audit, Steve corrected a
question about bill-receipt-sync: "you should be able to tell me what the bill-receipt
sync is, or at least articulate what you think it is. Shouldn't you be able to read
what it is about, how it's set up, and what it's for?"

This applies to: LaunchAgent plists (`plutil -p`), Python scripts (read headers +
logic), bash scripts, cron scripts, config files. Read first, present findings.
Only ask Steve when the source is genuinely inaccessible or the purpose is ambiguous
after reading.

### LaunchAgent audit & migration decision framework (2026-06-22)

When auditing scheduled tasks for a migration (e.g., laptop → Railway), classify
every agent into one of four categories:

1. **STOP** — Redundant with Hermes cron jobs, dead code (script/working directory
   doesn't exist), or superseded by newer tooling (MCP servers replacing API scripts).
2. **MIGRATE** — High-value and cloud-ready (only calls cloud APIs: Gmail, Drive,
   Calendar, HubSpot, Atlassian, Slack). Becomes a Hermes cron job on Railway.
3. **RETHINK** — Valuable but wrong shape for target environment (e.g., polling every
   5 min is wasteful on Railway). Redesign as event-driven or batched post-migration.
4. **CAN'T MOVE** — Hardware-bound (USB device, local filesystem, macOS-only tools).

**Audit sequence:**
```bash
ls ~/Library/LaunchAgents/
for f in ~/Library/LaunchAgents/com.bookmarked.*.plist; do
  echo "=== $(basename $f) ==="
  plutil -p "$f" 2>/dev/null | grep -E "ProgramArguments|StartCalendarInterval|StartInterval|WorkingDirectory"
done
# Then read each script, cross-reference with hermes cron list, classify
```

**2026-06-22 decisions (Steve's personal instance):**
- STOP (4): morning-brief (Bookmarked variant — redundant with Hermes cron),
  hubspot-stale-deals (superseded by HubSpot MCP), stub-watchdog (pipeline health
  check, irrelevant on Railway), skillsync (dead code — directory doesn't exist)
- MIGRATE to personal Hermes (6): gmail-triage, eod-brief, meet-sync,
  transcript-extract, transcript-merger, enrich-people
- MIGRATE to Bookmarked context (1): bill-receipt-sync
- RETHINK (3): meet-intraday, pre-meeting-brief, atlassian-sync
- CAN'T MOVE (1): plaud-drive-sync (USB Plaud device)

```bash
# Local DB config
DATABASE_URL=$(grep DATABASE_URL ~/.zshenv | head -1 | sed 's/.*=//' | tr -d '"') \
  /opt/homebrew/bin/gbrain config get models.dream.synthesize

# Railway env vars
cd ~/github-repos/gbrain && railway variables --service gbrain-dream-cycle | grep GBRAIN_CHAT_MODEL

# Railway service status
railway service list --json | python3 -c "import json,sys; [print(f\"{s['name']:30s} {s.get('status','?')}\") for s in json.load(sys.stdin)]"
```

Railway CLI note: syntax changed mid-2026. Current: `railway variables --service NAME`,
`railway service NAME redeploy --yes`, `railway service list --json`.
Old `railway variables set --service NAME` still works but `railway service` subcommands differ.

For the full Railway audit workflow including Anthropic Admin API integration,
see `references/railway-token-audit.md`.

For the full OpenRouter token-management playbook — the two-layer spend map (Anthropic-direct vs OpenRouter), state.db cost queries, the read-only OpenRouter `/credits` + `/key` API checks, the dashboard deep-dive sequence (activity/Explore/credits/keys), how to MATCH keys to agents instead of asking Steve, the verified key map (`...f20a`=personal Hermes, `...953` steve_openclaw=Bookmarked fleet [NOT Claude Code], `...27a`=stale leftover), and the fix (per-key spend LIMITS + tame Auto Top-Up, never blind-disable a production key) — use `references/openrouter-token-management.md`. Core rule: bound uncapped keys before optimizing model mix; an accelerating spend curve + Auto Top-Up + no per-key cap is the actual fire.

**Token watchdog + dashboard system (built 2026-06-20, unified 2026-06-21):**
- Watchdog script: `~/.hermes/scripts/openrouter_watchdog.py` — daily 7am CT cron, no_agent (zero tokens). Pulls management API, reports per-key/per-model spend, spike detection, off-policy alerts, and MODEL OPTIMIZER that auto-compares every active model against cheaper alternatives in the OpenRouter catalog.
- **Unified HTML dashboard: `~/.hermes/scripts/token_dashboard.py` → `~/.hermes/dashboard/tokens.html`**. Regenerates daily at 7am alongside watchdog. Self-contained HTML with Chart.js — three tabs (Overview | OpenRouter | Anthropic Console). Overview shows combined daily spend as stacked bar chart. Each provider tab has KPI cards, daily spend chart, spend-by-model donut, model breakdown table with policy badges. Anthropic tab adds token volume cards and cache hit rate.
- Data sources: OpenRouter Management API (`OPENROUTER_MANAGEMENT_KEY` in `~/.hermes/.env`) + Anthropic Admin API (`ANTHROPIC_ADMIN_KEY` in `~/.hermes/.env`). The Anthropic Admin key is an `sk-ant-admin01-...` key (NOT a regular `sk-ant-api03-...` key), created at console.anthropic.com → Settings → Admin Keys with `usage:read` + `costs:read` scopes. Endpoints: `GET /v1/organizations/cost_report` (USD costs, group_by=description for model-level) and `GET /v1/organizations/usage_report/messages` (token counts). Amounts are in cents (minor units).
- Cron jobs: `openrouter-token-watchdog` (text report), `token-dashboard-gen` (HTML). Both no_agent, both 7am CT.
- Run on-demand: `python3 ~/.hermes/scripts/token_dashboard.py && open ~/.hermes/dashboard/tokens.html`
- Key finding from first unified run (2026-06-21): Anthropic direct ($1,023/7d) exceeds OpenRouter ($622/7d). The G-Brain dream cycle on Opus 4.6 is the single biggest cost center. Combined burn rate: ~$235/day.
- Old standalone dashboard: `~/.hermes/scripts/openrouter_dashboard.py` → `~/.hermes/dashboard/openrouter.html` still works independently.

**CRITICAL — never set OpenRouter per-key credit limits without Steve's explicit request.** Steve rejected hard spending caps (2026-06-20). The watchdog + dashboard provide visibility; model routing provides cost control. Hard limits that block interactive sessions are the wrong lever.

**CRITICAL — remote config ≠ local config: verify both (learned 2026-06-21).** When auditing token spend, do NOT assume Railway/cloud config matches local DB config. Steve's local G-Brain DB correctly had `models.dream.synthesize = openai:gpt-5.2`, but Railway's `GBRAIN_CHAT_MODEL` was independently set to `openrouter:anthropic/claude-opus-4.6`. Result: $865/week in undetected Anthropic spend. The lesson: any service with its own env vars (Railway, launchd plists, cron jobs, agent configs) must be checked independently — the local config is NOT ground truth for remote services. Always query Railway variables, plist EnvironmentVariables blocks, and cron job model configs separately. Never say "the config says X" without confirming WHICH config — local DB, Railway env, plist env, and launchd wrapper scripts can all differ.

## Communicating with Bookmarked Agents via Slack

**Dewey (CEO agent):** Post in channel `C0AR85TMVS8`. NOT the DM channel
`D0ARJQ8FXK3` — Dewey's agent does not pick up bot messages in DMs. Always
@mention both Dewey (`U0AR21JHLFP`) and Steve (`U05C13KAW85`).

**Autonomous agent-to-agent coordination pattern (learned 2026-06-20):**
When Steve wants Hermes to coordinate with Dewey without Steve's involvement:
1. Post brief + action items in C0AR85TMVS8, @mention both parties
2. Set up a follow-up cron (Haiku, cheap) to check for Dewey's reply every 90min
3. Follow-up checks thread for Dewey's user_id in replies
4. If no reply and no existing nudge → post one nudge. Anti-double-nudge: check
   for existing "Reminder" messages from bot before posting another.
5. If Dewey replied with substance → summarize and report to Steve
6. Remove the follow-up cron once coordination is complete

This pattern worked end-to-end on 2026-06-20: briefed Dewey on token management,
Dewey read all 9 agent configs, reported back with discovery data, then executed
model migrations — all while Steve napped.

For the standing token infrastructure — the daily watchdog (`~/.hermes/scripts/openrouter_watchdog.py`, cron `openrouter-token-watchdog`, 7am CT, no_agent), the unified HTML dashboard (`~/.hermes/scripts/token_dashboard.py`, output `~/.hermes/dashboard/tokens.html`, cron `token-dashboard-gen`, 7am CT, no_agent), the fleet migration state, Dewey communication patterns, and the model optimizer — see `references/openrouter-token-management.md` for the canonical record.

**Dewey Slack channel:** Always `C0AR85TMVS8`, never DMs. Dewey's agent doesn't pick up DM bot messages. @mention both Dewey (`U0AR21JHLFP`) and Steve (`U05C13KAW85`).

---

## 1. Performance Troubleshooting

### "Is my Mac optimized for this?" — hardware & power check

When Steve asks what his laptop has or whether it's suited for G-Brain/Hermes, use `references/hardware-power-diagnostics.md`. It has the full batch of commands (system_profiler, sysctl, pmset, df, vm_stat, ps) and interpretation guidance: what the thresholds are, when to say "plug in," and what process counts are normal vs concerning.

### "Why is my Hermes slow?" — diagnostic sequence

Slow Hermes is almost never the model or the agent backend. The usual culprit is
the **desktop (Electron) app's renderer or GPU process pegging CPU** — a stuck
render loop, often a very long chat transcript or a streaming view that never
settled. When that happens everything else feels slow because the renderer is
starving the box.

Run these first (real numbers, not guesses):

```bash
# Load average + top CPU/mem processes
uptime
ps aux | sort -nrk 3 | head -8        # by CPU
ps aux | sort -nrk 4 | head -8        # by memory

# Isolate Hermes processes
ps aux | grep -i hermes | grep -v grep
```

Read the CPU% AND the accumulated CPU-time column. A renderer showing 38% CPU with
19 minutes of CPU time burned in the last hour is a runaway — that's the target.

### Fix: kill the stuck renderer

The desktop app respawns its renderer clean, so killing it is safe:

```bash
kill <renderer_pid> <gpu_pid>          # PIDs from the ps output
sleep 3; uptime; ps aux | grep -i hermes | grep -v grep   # verify load dropped
```

Or just quit and reopen the Hermes desktop app — same effect. If Steve doesn't want
to lose state, tell him to close the long session tab first (that's what pins the
renderer), then no kill is needed.

### Secondary clutter to look for (rarely the root cause)
- Orphaned Chrome processes with `--remote-debugging-port` left over from browser
  automation (e.g. the Tumblr profile) — safe to kill if idle.
- Stale `tui_gateway.slash_worker` processes from old sessions.
- `state.db` size — informational; tens of MB is fine, not a bottleneck.

### Sizing the load
- `state.db` session/message counts: `SELECT count(*) FROM sessions/messages`.
- Prune old sessions to keep `session_search` fast: `hermes sessions prune --older-than 30`.
- `hermes insights --days 7` shows token burn, model mix, tool-call volume — the
  evidence base for "what's actually expensive."

---

## 2. MCP Server & Tool-Footprint Management

### Diagnosing reported G-Brain MCP flakiness

When another agent (or Steve) reports that G-Brain MCP is "flaky," the real cause is almost always one of three things — check in this order:

**1. Mac sleep / wifi drop (most common).** When the Mac sleeps or wifi drops, DNS resolution to the Supabase host (`db.<project>.supabase.co`) fails. gbrain's worker-supervisor detects 3 consecutive DB probe failures, exits, and launchd restarts it. The 30-second restart window is what other agents experience as "MCP unavailable." This is normal recovery behavior, not a gbrain bug. Signal: `worker-supervisor-error.log` contains `getaddrinfo ENOTFOUND` and `FATAL: DB unreachable after 3 probes. Exiting for process-manager restart.`

```bash
tail -80 ~/.gbrain/worker-supervisor-error.log | grep -E "ENOTFOUND|FATAL|restart"
```

**2. Inflated worker crash count.** `gbrain status` shows a `crashes=N` counter in the Workers section — this includes sleep/wake restarts. A high number (60+) does NOT necessarily mean the MCP server is broken. Check the timestamp of the last event:

```bash
gbrain status 2>&1 | grep -A5 "Workers"
# If "last event" is hours ago and the server is currently up, it's old noise.
```

**3. connect_timeout too low.** The active timeout is under `mcp_servers.gbrain.connect_timeout` — NOT `mcp.servers.gbrain.connect_timeout` (the dot-nested `mcp:` block is a different key that Hermes does not read for MCP server config). Default is 60s; if set to 30 (older configs), bump it:

```bash
hermes config set mcp_servers.gbrain.connect_timeout 60
# Verify it landed in the right place:
python3 -c "
import yaml
with open('/Users/stevewandler/.hermes/config.yaml') as f:
    cfg = yaml.safe_load(f)
print(cfg.get('mcp_servers', {}).get('gbrain', {}).get('connect_timeout'))
"
```

**NOTE on config key confusion:** `hermes config set mcp.servers.gbrain.*` writes to a *different* nested block (`mcp: → servers: → gbrain:`) that Hermes ignores for MCP transport. Always use `mcp_servers.gbrain.*` (underscore). Verify with the Python snippet above, not just by greping the raw YAML.

**Quick health check to confirm MCP is actually working:**
```bash
hermes mcp test gbrain 2>&1 | grep -E "Connected|Tools|Error"
# Expected: ✓ Connected (Xms) + ✓ Tools discovered: 82
```

### Where the config actually lives

MCP servers are configured under the **`mcp_servers:`** key in
`~/.hermes/config.yaml` — NOT under a `mcp:` key (that block is often empty `{}`
and is a red herring). To inspect:

```bash
grep -n "mcp_servers:" ~/.hermes/config.yaml      # find the line, then read the block
hermes mcp list                                    # shows servers, transport, status
```

Each server entry has `command`/`args` (stdio) or `url`/`headers` (HTTP),
`enabled: true/false`, and `env:` (often with inline tokens — see pitfall below).

### Steve's MCP servers (as of 2026-06-09, personal instance)

| Server | Transport | What it's for |
|---|---|---|
| `atlassian` | node @xuandev/atlassian-mcp | Jira + Confluence (bookmarked-team.atlassian.net) |
| `gbrain` | http localhost:7432/mcp | G-Brain personal knowledge brain |
| `hubspot-unified` | node custom (~/.claude/mcp-servers/hubspot-unified/index.js) | Single consolidated HubSpot server — full CRM (contacts/companies/deals/tickets/properties/associations/engagements) + lists/pipelines/sequences/workflows. Key: `HUBSPOT_API_KEY` env var. **As of 2026-06-13, this is the ONLY active HubSpot server.** |
| `slack` | npx @modelcontextprotocol/server-slack | Slack — this PERSONAL instance posts to WhatsApp, but Steve DOES read/post Bookmarked Slack where tools allow, so don't blindly disable it |
| `openmessage` | http SSE localhost:7007/mcp/sse | LIVE — local SQLite message store, `mcp_openmessage_*` tools, every send requires explicit human approval; `mailroom-evening-accountability` cron uses it. NEVER disable. Don't judge it dead from curl or a 30-day state.db query (see verification discipline above). |

**HubSpot consolidation (done 2026-06-20):** the old disabled `hubspot` and `hubspot-extended` entries (both carrying the revoked `pat-na2-b75a44b5` key) were removed entirely from `config.yaml` via a YAML-safe Python rewrite (back up first to `config.yaml.bak-<ts>`, then `del` the keys, dump with `sort_keys=False`, verify `hubspot-unified` survives). `hubspot-unified` is the only HubSpot server — do NOT re-add the other two.

### Auditing MCP footprint by real usage (do this BEFORE any trim)

For the verified method — querying `state.db`'s `tool_name` column for real per-tool
usage, the current server inventory with usage counts, and the capability-preserving
cleanup tiers — see `references/tool-footprint-tuning.md` (MCP section, 2026-06-20).
Always pull real usage numbers before recommending a trim; never guess which tools
Steve uses. The inventory in the table below is older (2026-06-09) and incomplete
(missing `openmessage`, the dead `hubspot`/`hubspot-extended` entries still in config);
treat the reference's verified inventory as current.

**Trim methodology and session records:** `references/mcp-tool-trimming.md` — full
workflow (audit → categorize → propose → execute → verify), risk-tier framework,
and per-session trim decisions. Load this before proposing any MCP tool trimming.

### Before declaring a server/tool "unused" — verification discipline (learned 2026-06-20)

Do NOT claim an MCP server or tool is unused, dead, or "never called" from a single `state.db` `tool_name` query. That column retains only ~30 days AND misses calls logged under a different name or routed through an approval flow. Steve caught a false "openmessage is unused" call built exactly this way — the server is live and he'd used it the day before. Two specific traps:

- **state.db is a 30-day, name-exact window, not ground truth.** `SELECT tool_name, COUNT(*) FROM messages WHERE tool_name LIKE 'mcp_<server>_%'` returning zero means "not in this narrow slice," not "never used." Cross-check `session_search` (and G-Brain) for the server/tool name BEFORE any negative claim. "I didn't find it" is not "it doesn't exist."
- **A plain `curl` to an SSE endpoint won't respond normally.** `curl http://127.0.0.1:7007/mcp/sse` returning empty does NOT mean the server is down — SSE holds the connection open. Curl silence ≠ dead server. Use `hermes mcp test <name>` or check actual usage, not curl, to judge liveness.

General rule: before recommending disable/remove of ANY server, verify it's genuinely idle across session history + live test, and present removal as a proposal Steve approves — never act on a single-source "looks unused" read. Removing the two dead HubSpot servers (already disabled, revoked key) was safe because both signals agreed and Steve explicitly asked; openmessage failed that bar and should have stayed off the chopping block.

### The footprint problem

All servers default to exposing `all` tools. Five servers at "all" = 150+ tool
schemas injected into the system prompt on EVERY turn, before the model even reads
the question. That's slower responses, fatter prompts, and the main driver of token
burn. Steve uses maybe ~20 of those tools day to day; the unused ~130 ride along on
every message.

### How to manage it properly (durable levers, in order of impact)

1. **Trim tools per server** — Two approaches:
   - **Interactive:** `hermes mcp configure <name>` opens a curses checkbox UI. Select only the tools you use.
   - **Programmatic (faster):** Write `tools.include` lists directly to `~/.hermes/config.yaml` under each MCP server entry. Use `execute_code` (Python `yaml.dump`) to write. Verify with `hermes mcp list` — should show "N selected" instead of "all."
   Full workflow, decision principles, and current trim state in the `mcp-tool-allowlisting` skill. Load it before proposing or executing any MCP tool trim.
2. **Disable, don't delete, unused servers** — `hermes mcp` toggle / set `enabled: false`.
   On the personal instance, Slack is dead weight (it posts to WhatsApp). Disabling
   keeps the config for later.
3. **Tool changes apply on a fresh session** (`/reset` or new `hermes` launch), not
   mid-conversation — model and tools are locked per-session to protect prompt caching.

### Provider switching: burning direct tokens before OpenRouter

Steve pays for Anthropic and Gemini directly and wants to burn those tokens before paying OpenRouter. There is no automatic priority order — you must switch explicitly per session:

## Communicating with Bookmarked Agents via Slack

When Steve's personal Hermes needs to communicate with Dewey or other Bookmarked agents:

**Channel:** Always use `C0AR85TMVS8`. This is the channel Dewey monitors.
DMs (e.g. `D0ARJQ8FXK3`) do NOT trigger Dewey's agent — messages sit unread.

**User IDs:** Steve = `U05C13KAW85`, Dewey = `U0AR21JHLFP`.

**Pattern:** Always @mention both Steve and Dewey in messages (`<@U0AR21JHLFP> <@U05C13KAW85>`). Post the main brief as a channel message, then follow up in the thread.

**App-title header correction:** The canonical OpenRouter attribution header is `X-Title`, NOT `X-OpenRouter-Title`. Hermes source code confirms the old name was never recognized by the dashboard. Dewey discovered this when implementing fleet-wide tagging. Config key: `model.default_headers`.

**Follow-up pattern for async work with Dewey:**
1. Post the brief/instructions in `C0AR85TMVS8` with @mentions
2. Set up a recurring cron job (Haiku, every 90m, 3-4 repeats) that checks the thread for Dewey's reply using `mcp_slack_slack_get_thread_replies`
3. If no reply, send one nudge. If nudge already exists, don't double-nudge.
4. If Dewey replies with substantive content, summarize and confirm receipt.

**Write guard:** Dewey cannot modify his own `config.yaml` (Hermes security guard blocks it). Config changes to Dewey's profile need Raju to apply manually, or Dewey works around it via terminal/execute_code.

### Provider switching: burning direct tokens before OpenRouter

Steve pays for Anthropic and Gemini directly and wants to burn those tokens before paying OpenRouter. There is no automatic priority order — you must switch explicitly per session:

```bash
hermes --provider anthropic          # full session on Anthropic direct, all tools work
hermes chat --provider anthropic -q "..."   # single query

# In-session switch (within current conversation):
/model    # interactive picker, choose provider there
```

Gemini direct is configured but parked (see Gemini section above — schema incompatibility with full MCP toolset). Use Anthropic for now.

OpenRouter remains the default and fallback. Nothing needs to change in config — just pass `--provider anthropic` when you want to route direct.

### Pitfalls

- **CRITICAL: Railway vs local G-Brain config drift (diagnosed 2026-06-21).** When troubleshooting Anthropic spend, do NOT assume the local G-Brain config (`gbrain config get models.dream.synthesize`) matches what Railway uses. The dream cycle runs on Railway's `gbrain-dream-cycle` service, NOT locally. `com.gbrain.dream-cycle.plist` is DISABLED. Railway has its own environment variables set via `railway variables --service gbrain-dream-cycle`. In the June 2026 audit, local config said `openai:gpt-5.2` but Railway's `GBRAIN_CHAT_MODEL` was `openrouter:anthropic/claude-opus-4.6` — burning $865/week. Always check BOTH: `gbrain config get models.dream.synthesize` AND `railway variables --service gbrain-dream-cycle | grep MODEL`. When fixing model routing, change Railway's env vars, not just local config.
  (`cronjob action='run'`) consumes one of the N repeats. After that single run the job
  marks itself `completed` and `enabled: false`. For a genuinely recurring job that runs
  N times, use `"every Xm"` as the schedule — that treats each repeat as a separate
  scheduled tick. Learned the hard way: test-firing a `"once in 90m" repeat:4` job left
  it at `1/4 completed` with no future runs.

- **Gemini direct provider fails with the full MCP toolset.** Running `hermes --provider google` with all MCP servers loaded (HubSpot x2, Atlassian, Slack, G-Brain) causes HTTP 400 INVALID_ARGUMENT from Gemini's strict tool schema validator. It rejects array fields missing an `items` type — one of the HubSpot search tool definitions triggers this. Anthropic direct works fine with the full toolset. Until Hermes normalizes schemas for Gemini upstream, use `--provider anthropic` for full-tool sessions; use `--provider google --toolsets web,terminal,file` only for stripped sessions that don't need MCP tools.

- **Specifying `--provider google` requires also specifying `-m gemini-<model>`.** Without it, Hermes passes the default model name (`anthropic/claude-sonnet-4.6`) to Gemini's endpoint, which returns HTTP 404. Always pair `--provider google` with `-m gemini-2.0-flash` or another valid Gemini model name.

- **Posting to Dewey (or any Bookmarked agent) via Slack:** Always use channel `C0AR85TMVS8`, NOT DM channels. Dewey's agent does not pick up messages from bot identities in DM channels (tested 2026-06-20: DM channel `D0ARJQ8FXK3` was ignored). @mention both Dewey (`U0AR21JHLFP`) and Steve (`U05C13KAW85`). This applies to any Bookmarked agent communication via Slack from Steve's personal Hermes.

- **Hermes cron `repeat` + `once in Xm` schedule:** using `schedule: "once in 90m"` with `repeat: 4` fires only once and marks complete. Use `schedule: "every 90m"` for recurring with a repeat count. Also: a manual test fire via `cronjob(action='run')` consumes one of the repeat count — account for this when setting up finite-repeat jobs.

- **HubSpot has been consolidated to a single `hubspot-unified` server (2026-06-13).**
  The old `hubspot` (official @hubspot/mcp-server) and `hubspot-extended` (custom) entries
  were removed from `~/.mcp.json` and are disabled in `config.yaml`. Do NOT re-add them.
  `hubspot-unified` covers everything both old servers did. The active API key is in
  `config.yaml` under `mcp_servers.hubspot-unified.env.HUBSPOT_API_KEY`; the old key
  (`pat-na2-b75a44b5-...`) is dead. Current key prefix: `pat-na2-98342ea4-...`.

- **`~/.mcp.json` and `config.yaml` are separate MCP configs.** `~/.mcp.json` feeds
  Conductor/Claude Code; `~/.hermes/config.yaml` feeds Hermes. They can drift. When
  rotating a key or removing a server, check BOTH files. After removing entries from
  `~/.mcp.json`, verify the JSON is still valid (no trailing commas) — the patch tool's
  lint check will catch this.

- **Inspect a custom MCP server's tools by reading its source, not by running it.**
  `node index.js --help` throws if it requires a token env var (e.g.
  `PRIVATE_APP_ACCESS_TOKEN is required`). Instead grep the file for tool/name
  registrations to enumerate capabilities without booting it.

- **Recursive grep over `~/.hermes` times out** — the `sessions/` dir and `state.db`
  are huge. Scope greps to `~/.hermes/config.yaml` and specific files, or use
  `search_files` instead of shell `grep -r`.

- **Model/tool config changes need a fresh session to take effect.** Setting
  `model.default` or trimming MCP tools won't change the running session — tell Steve
  it lands on his next `/reset` or relaunch.

- **Tokens sit inline in `config.yaml` `env:` blocks** (Atlassian, HubSpot, Slack,
  gbrain bearer). Not a speed issue, but that file gets read/copied around. Steve's
  preference is `security.redact_secrets=false` with full access, so this is by design —
  just be aware when sharing or pasting the file.

## 4. Hermes Desktop App Connectivity

The Hermes Desktop app is a thin Electron client that connects to the `hermes dashboard` backend. It is NOT the same as the gateway API server.

### Architecture (critical distinction)

| Component | Port | What it is |
|-----------|------|------------|
| Gateway API server | 8642 | Raw OpenAI-compatible API (feeds Open WebUI, programmatic access) |
| Dashboard backend | 9119 (default) | Web UI backend the Desktop Electron app requires |
| G-Brain MCP server | 7432 | G-Brain local HTTP server (launchd) |

**The Desktop app talks to the dashboard, NOT the gateway API.** If no dashboard is running, Desktop either fails silently or tries to spawn one from its packaged binary path and enters a broken state.

### "HTTP 200 Internal Server Error" — what it actually means

This contradictory-sounding error is an MCP-over-HTTP envelope mismatch: the HTTP transport layer returns 200 (request received), but the JSON-RPC payload inside contains an error. The Desktop surfaces both layers simultaneously as "HTTP 200 Internal Server Error."

Common triggers in Steve's stack:
1. **No dashboard running** — Desktop in local mode looks for :9119, finds nothing, partially boots, gets a 200 from the gateway API on :8642 but fails on the WebSocket/dashboard protocol.
2. **G-Brain MCP returning error inside 200** — Supabase connection timeout, broken reranker call, or OAuth issue wrapped in a 200 JSON-RPC envelope.
3. **Stale `connection.json`** — Desktop stores connection config at `~/Library/Application Support/Hermes/connection.json`. May have old remote URLs (e.g., a previous Hetzner IP).

### Diagnostic sequence

```bash
# 1. Is the dashboard actually running?
hermes dashboard --status
lsof -i :9119 -i :9120 -P -n | grep LISTEN

# 2. Check Desktop connection config
cat ~/Library/Application\ Support/Hermes/connection.json
# Look for: mode (local vs remote), remote.url (stale IP?), remote.authMode

# 3. Is the gateway API server running? (different from dashboard)
curl -s http://127.0.0.1:8642/health
# Returns: {"status": "ok", "platform": "hermes-agent", "version": "X.Y.Z"}

# 4. Is the G-Brain MCP server healthy?
curl -s http://localhost:7432/health
# Returns: {"status":"ok","version":"0.42.x","engine":"postgres"}

# 5. Check Desktop Electron processes
ps aux | grep -i "Hermes" | grep -i -E "electron|desktop|renderer" | grep -v grep

# 6. Check for error logs
tail -50 ~/.gbrain/gbrain-http-error.log
tail -30 ~/.hermes/logs/gateway.log
```

### Fix: start the dashboard (persistent via launchd)

A launchd plist at `~/Library/LaunchAgents/com.hermes.dashboard.plist` auto-starts
the dashboard on boot and keeps it alive. See `references/desktop-dashboard-connectivity.md`
for the full plist template.

**CRITICAL: use `.venv/bin/hermes`, NOT `venv/bin/hermes` in the plist.**
Steve's install has TWO venv directories — `venv/` and `.venv/`. The gateway uses
`.venv/bin/python -m hermes_cli.main`. Using `venv/bin/hermes` in the dashboard plist
may work but creates a version mismatch between gateway and dashboard. Always match
the gateway's venv path. Check with:
```bash
ps aux | grep "gateway run" | grep -v grep  # shows which venv the gateway uses
```

```bash
# One-time: create the plist, then load it
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.hermes.dashboard.plist

# Verify
curl -s http://127.0.0.1:9119/api/status
# Should return JSON with version, gateway_state, gateway_platforms, etc.
```

**Port collision on first load:** If the dashboard was started manually (or by the
Desktop app auto-spawn) before the launchd plist was loaded, the plist instance fails
with `[Errno 48] address already in use` and enters a crash loop. Fix: kill the manual
process, then the plist instance grabs the port on its next KeepAlive restart.
The Desktop app itself may also auto-spawn a dashboard on a random port (port=0) —
check `ps aux | grep dashboard` for multiple instances and kill the extras.

**Two venv directories exist — always use `.venv/`:** Steve's hermes-agent install has
both `venv/` and `.venv/`. The gateway uses `.venv/bin/python -m hermes_cli.main`. The
dashboard launchd plist MUST use `.venv/bin/hermes` to match. Using `venv/bin/hermes`
may work but creates a version mismatch. Verify which the gateway uses:
```bash
ps aux | grep "gateway run" | grep -v grep  # shows the actual venv path
```

### Fix: stale connection.json

Location: `~/Library/Application Support/Hermes/connection.json`

If `connection.json` has a stale remote URL (e.g., a decommissioned VPS IP), clear it:
```json
{"mode": "local", "remote": {"url": "", "authMode": "oauth"}, "profiles": {}}
```

When decommissioning infrastructure, sweep for stale references — see the
"Infrastructure migration cleanup pattern" in `references/desktop-dashboard-connectivity.md`.

### Pitfalls

- **Desktop renderer can peg CPU** — see section 1 (Performance Troubleshooting). A stuck renderer with a long chat transcript starves the box and makes everything feel broken.
- **Dashboard ≠ API server ≠ Open WebUI.** Three different web services on three different ports. Desktop needs the dashboard; Open WebUI needs the API server; G-Brain has its own MCP HTTP server. Don't cross-wire them.
- **`connection.json` mode matters.** In `"local"` mode, Desktop tries to find/start a local dashboard. In `"remote"` mode with `"authMode": "oauth"`, it tries OAuth against the remote URL. An empty/stale remote URL in remote mode = immediate failure.
- **The Desktop app path on Steve's Mac:** `/Users/stevewandler/.hermes/hermes-agent/apps/desktop/release/mac-arm64/Hermes.app` (bundled with hermes-agent, NOT /Applications/Hermes.app which is the installer).

---

## 5. Chrome CDP Browser Setup (Non-Headless)

Steve's Hermes is configured to use Chrome via CDP (local, visible, non-headless).

### Config (already set as of 2026-06-10)
```bash
hermes config set browser.engine cdp
hermes config set browser.cdp_url http://127.0.0.1:9222
```

### Launching Chrome with debugging enabled

macOS will NOT pass `--remote-debugging-port` if Chrome is launched via `open -a` or
via a background process spawned through Hermes — macOS sandboxing strips the flag.
Steve must run this directly in his own terminal:

```bash
/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --remote-debugging-port=9222
```

Chrome opens visibly. Verify it's listening:
```bash
curl -s http://127.0.0.1:9222/json/version
```

### Connecting from a Hermes session (CLI only)
```
/browser connect
```
Auto-connects to `http://127.0.0.1:9222`. Browser tools then control the visible window.

**Important:** `/browser connect` is CLI-only — does not work in WhatsApp/gateway.

### Pitfalls
- **`open -a "Google Chrome" --args --remote-debugging-port=9222` does NOT work** —
  macOS ignores the flag this way. Must use the full binary path directly.
- **Launching via Hermes `terminal()` also fails** for the same reason — use a separate
  terminal window.
- Orphaned Chrome `--remote-debugging-port` processes from old sessions are safe to kill
  if idle (they show up in `ps aux | grep remote-debugging`).

---

## Hermes update / restart operations

`hermes update` is intentionally high-impact: it can restart the gateway and kill running agents. Even with `approvals.mode: smart`, the approval layer may block agent-run update commands as genuinely dangerous. Preferred workflow for Steve:

1. Diagnose first with real output:
   - `hermes --version`
   - `hermes update --check`
   - `cd ~/.hermes/hermes-agent && git fetch origin main --tags --prune && git rev-list --left-right --count HEAD...origin/main`
   - `cd ~/.hermes/hermes-agent && git status --short --branch`
2. Explain what the banner means in plain English. The login banner's `⚠ update available` is Hermes itself, not macOS/Homebrew. If needed, inspect the screenshot, then confirm by checking the local commit vs `origin/main`.
3. Before recommending the update, summarize the update shape instead of just saying "run it":
   - count commits behind (`git rev-list --left-right --count HEAD...origin/main`)
   - list top commits (`git log --oneline HEAD..origin/main -n 20`)
   - bucket subjects by `fix:`, `feat:`, `docs:`, `refactor:`, `test:` so Steve can see whether this is bugfix/hardening vs a risky feature jump.
4. Check for uncommitted local files. If `git status` shows local modifications, name them and decide whether they are expected maintenance artifacts. Example: `scripts/whatsapp-bridge/package.json` and `package-lock.json` may be local npm-audit/Baileys vulnerability repairs; don't erase them silently.
5. If update is needed, ask Steve to run `hermes update --backup --yes` from his own terminal, or approve the exact pending command in the UI. Do not work around a smart-approval block by rephrasing the same update command.
6. After Steve runs it, verify with real output:
   - `hermes --version`
   - `hermes update --check`
   - `hermes status --all` should show gateway running.
   - `hermes doctor` should show config/version consistency.
   - Re-check any dependent services, especially G-Brain MCP if this was part of a broader maintenance window.
7. Leave `approvals.mode` as Steve chose it. If he temporarily set `smart`, mention it in the handoff instead of silently reverting.

Pitfalls:
- A blocked `hermes update` is not a permissions failure in Git or Python. It is the Hermes approval layer protecting a restart/agent-kill operation.
- Don't tell Steve to update until you've checked what is actually pending. His default question is usually "what update is this and do we need it?" not "blindly install it."
- Don't bury the answer in process. Give the read: "yes, update" / "not urgent" / "hold off because..." with the evidence underneath.
- **cua-driver download can time out during `hermes update`.** The update pulls 100+ commits, rebuilds Python/Node deps and the desktop app — the cua-driver download is the very last step and the default 120s timeout can kill it. When this happens, the main update succeeds but cua-driver stays at the old version. Recovery is one command: `hermes computer-use install --upgrade`. Don't re-run `hermes update` (it'll say "Up to date" and skip). Verify with `cua-driver --version` after.

### Post-update: discover new features

After `hermes update` completes, surface what actually changed for the user. Don't just report the version bump — do a structured git log scan:

```bash
cd ~/.hermes/hermes-agent
# Count and bucket commits
git log --oneline <old-commit>..<new-commit> | wc -l
git log --oneline <old-commit>..<new-commit> | grep "^[a-f0-9]* feat:" | head -20
# New user-facing: slash commands, config keys, tools
git diff <old-commit>..<new-commit> -- hermes_cli/commands.py | grep "^\+.*CommandDef"
git diff <old-commit>..<new-commit> -- hermes_cli/config.py | grep "^\+.*\".*\":"
git diff --name-only --diff-filter=A <old-commit>..<new-commit> -- tools/
```

Focus your summary on what changes Steve's actual workflow: delegation behavior, config options worth enabling, new slash commands, tool changes. Skip i18n, desktop app UI, and internal refactors unless they have user impact.

**Background delegation (as of v0.17.0):** Single-task `delegate_task` calls from the top-level agent now run async by default — the parent turn returns immediately and the subagent's result re-enters the conversation as a new message. No config needed. Batch tasks (>1 item) stay synchronous.

### Post-update config drift — adopt new defaults

Hermes defaults evolve but **explicit config values override new defaults**. After an update, compare your config against current defaults for these high-impact keys:

- `compression.hygiene_hard_message_limit` — old default 400, new default 5000. If your config has 400 explicitly, bump it: `hermes config set compression.hygiene_hard_message_limit 5000`
- `compression.in_place` — not in most older configs. New default False. Worth enabling: `hermes config set compression.in_place true` (keeps same session ID during compaction)

Check with: `python3 -c "import yaml; c=yaml.safe_load(open('/Users/stevewandler/.hermes/config.yaml')); print(c.get('compression',{}))"`

---

## Homebrew / macOS package maintenance

For Steve's macOS host, use `references/homebrew-maintenance.md` when fixing Hermes doctor warnings that come from Homebrew or shell PATH state. It captures the verified pattern for installing `ripgrep`, upgrading outdated formulae/casks, removing deprecated casks, fixing `/opt/homebrew/bin` PATH order in `~/.zprofile`, and handling root-owned `/usr/local/include/node` headers without losing them.

## Verify changes

```bash
hermes config | grep -i model           # confirm main model
hermes mcp list                          # confirm enabled servers + status
hermes tools list                        # confirm disabled optional toolsets stay out of new sessions
hermes doctor                            # verify dependency/security warnings after changes
```

---

## 5. Tool-footprint triage: separate token load from doctor noise

When Steve asks whether optional tools are eating tokens, do not rely only on `hermes doctor`. Doctor reports every known optional provider/dependency, including things that are not enabled for the current platform. The token-footprint source of truth is:

```bash
hermes tools list
```

Rules:
- If a toolset appears as `✗ disabled`, it should not load into new sessions.
- If a warning appears only in `hermes doctor` but the toolset is absent from `hermes tools list`, treat it as doctor noise, not token load.
- Tool changes require a fresh session / gateway restart to affect the model prompt.

Steve's personal Hermes deliberately disables unused lifestyle/side-channel tools unless he asks for them:

```bash
hermes tools disable homeassistant
hermes tools disable spotify
hermes tools disable yuanbao
```

**Auxiliary task model routing (updated 2026-06-20):** All 13 aux tasks switched from
Haiku ($1.00/1M) to DeepSeek V4 Flash ($0.09/1M) — 11x cheaper. This includes:
approval, compression, curator, kanban_decomposer, mcp, monitor, profile_describer,
skills_hub, title_generation, triage_specifier, tts_audio_tags, vision, web_extract.
Config was updated via Python yaml write (not hermes config set — that can lose
structure). Backup at `config.yaml.bak-20260620-181006`. See `hermes-model-routing`
skill for full routing table and policy.

Discord/Discord-admin may report as platform-scoped or unavailable on CLI; don't chase that unless Steve is configuring a Discord platform. Feishu/Lark may show in doctor as a missing optional dependency even when not present in `hermes tools list`; don't chase that either unless he needs Feishu.

## 6. WhatsApp bridge vulnerability repair

When `hermes doctor` reports WhatsApp bridge npm vulnerabilities:

```bash
cd ~/.hermes/hermes-agent/scripts/whatsapp-bridge
npm audit --audit-level=moderate || true
npm audit fix
npm audit --audit-level=moderate || true
```

If Baileys remains critical with GHSA-qvv5-jq5g-4cgg, `npm audit fix` is not enough. That advisory affects Baileys `<7.0.0-rc12` / `<6.7.22`; upgrade Baileys explicitly:

```bash
npm install @whiskeysockets/baileys@7.0.0-rc13
npm audit --audit-level=moderate
```

Then restart gateway and re-run doctor:

```bash
launchctl kickstart -k "gui/$(id -u)/ai.hermes.gateway"
hermes doctor
```

Expected clean line: `✓ WhatsApp bridge deps (no known vulnerabilities)`.

---

## 3. Post-update Cleanup: Doctor Warnings, Tool Footprint, and Bridge Dependencies

When Steve asks to clean up Hermes warnings after an update, separate **real risks** from **optional provider noise**.

### WhatsApp bridge npm vulnerabilities

Doctor may report vulnerabilities under `scripts/whatsapp-bridge`. Fix the bridge first because WhatsApp is Steve's live outbound channel.

```bash
cd ~/.hermes/hermes-agent/scripts/whatsapp-bridge
npm audit --audit-level=moderate || true
npm audit fix
npm audit --audit-level=moderate || true
```

If `@whiskeysockets/baileys` remains critical with advisory `GHSA-qvv5-jq5g-4cgg`, `npm audit fix` may not be enough when Hermes pins a vulnerable Git commit / rc version. Check the patched version and upgrade explicitly:

```bash
npm view @whiskeysockets/baileys version dist-tags --json
npm install @whiskeysockets/baileys@7.0.0-rc13
npm audit --audit-level=moderate
```

Then restart the gateway so the bridge uses the new dependency tree:

```bash
launchctl kickstart -k "gui/$(id -u)/ai.hermes.gateway"
sleep 5
hermes doctor
```

As of 2026-06-11, `7.0.0-rc13` cleared the Baileys advisory plus protobufjs / qs / ws vulnerabilities.

### Tool footprint cleanup

If Steve says he doesn't use a tool class, disable it instead of leaving it in the prompt surface:

```bash
hermes tools disable homeassistant
hermes tools disable spotify
hermes tools disable yuanbao
# Discord toolsets are platform-scoped; if not configured for this personal instance,
# treat Discord warnings as optional noise rather than trying to wire a bot token.
```

Tool changes generally land on the next fresh session / gateway restart, not necessarily the current running conversation.

### Adding Google Gemini as a direct provider

Steve has a Gemini account (Bookmarked Google account, not personal Gmail). To add it:

2. Go to https://aistudio.google.com/app/apikey — **logged into the Bookmarked account**
2. Copy the API key — as of mid-2026, Google AI Studio keys start with `AQ.`, NOT `AIza`. Do NOT challenge a key just because it doesn't match the old format. Only question it if auth returns HTTP 401/403.
3. Add to `~/.hermes/.env`:
   ```
   GOOGLE_API_KEY=AQ....
   ```
4. Verify: `hermes chat --provider google -m gemini-2.0-flash -q "hello"` — must specify a Gemini model explicitly or it tries to pass the default `anthropic/claude-sonnet-4.6` model name to Gemini (HTTP 404).

**Status as of 2026-06-13:** Gemini key is stored and auth works. HOWEVER, running `--provider google` with the full MCP toolset (HubSpot x2, Atlassian, Slack, G-Brain) causes HTTP 400 INVALID_ARGUMENT — Gemini's strict schema validator rejects an array field in the HubSpot search tool definition that's missing an `items` type. Anthropic direct works fine with the full toolset. Use `--provider anthropic` for full-tool sessions; Gemini is parked until Hermes normalizes tool schemas upstream.

The key Steve uses is from his Bookmarked Google account (steve@bookmarked.com), not personal Gmail.
**Key format pitfall:** Google AI Studio API keys do NOT always start with `AIza`. As of mid-2026, newly generated keys start with `AQ.` — this is a valid format, not an OAuth fragment. Do NOT challenge a key just because it doesn't match the old `AIza` pattern. Only question the key if auth returns HTTP 401/403. The key Steve uses is from his Bookmarked Google account (steve@bookmarked.com), not his personal Gmail.

### Nous Portal login — PTY required

`hermes portal login` uses a device-code OAuth flow that **requires a real interactive terminal (PTY)**. Running it from inside the Hermes GUI chat terminal will hang silently — no URL appears, no code, nothing. The process just sits.

**Correct procedure:**
1. Open a real macOS Terminal window (separate from the Hermes GUI)
2. Run `hermes portal login` there
3. It will display a URL and device code → authorize in browser with GitHub (or whatever identity you signed up with)
4. Terminal confirms completion

**Signs you hit the PTY problem:** command was run, browser may have opened a Nous Portal tab, but no confirmation appeared and `hermes portal status` still shows "not logged in."

**After success, verify:**
```bash
hermes portal info
# Should show: Auth: logged in + Tool Gateway tool inventory
```

As of 2026-06-13, Steve has not yet completed Nous Portal login. His Hermes runs on OpenRouter; portal login would unlock Nous models and Tool Gateway (hosted web, image-gen, video-gen, STT, browser cloud routing).

### Provider/auth warnings: classify before configuring

Doctor's missing provider warnings are usually optional. Don't configure everything just to make doctor quiet.

Worth considering:
- `GITHUB_TOKEN` in `~/.hermes/.env` — improves Skills Hub GitHub API rate limit.

Usually optional unless Steve explicitly wants that provider/tool:
- Nous Portal auth (see PTY note above — must be done from real terminal)
- OpenAI Codex OAuth
- Google Gemini OAuth (Steve IS adding this — see above section)
- MiniMax OAuth
- xAI OAuth / `XAI_API_KEY`
- Discord / Discord admin
- Feishu, Home Assistant, image/video generation, Spotify, Yuanbao

### Approval mode note

`approvals.mode=smart` is a reasonable temporary middle ground for maintenance, but it can still block genuinely disruptive commands like `hermes update` because update restarts gateway / kills running agents. If smart blocks `hermes update`, Steve must run/approve it directly; don't bypass with `approvals.mode=off` unless he explicitly accepts the security tradeoff.

---

## 4. Credential Pool Troubleshooting

For G-Brain software update checks, see `gbrain` skill reference `references/upgrade-currency-protocol.md`.

---

## 3. Credential Pool Troubleshooting

### Symptom: "API call failed after 3 retries: HTTP 429: This request would exceed your account's monthly spend limit"

This is **not a rate limit** (too many requests/minute). It's a **billing cap** — an account has hit its monthly token budget. The retries are Hermes exhausting the pool trying each credential in turn.

### Diagnosing the pool

Two sources — live state and the pre-update snapshot:

```bash
# Live credential pool
cat ~/.hermes/auth.json | python3 -c "
import json, sys
d = json.load(sys.stdin)
pool = d.get('credential_pool', {}).get('anthropic', [])
for c in pool:
    print('id:', c.get('id'), '| label:', c.get('label'), '| source:', c.get('source'), '| auth_type:', c.get('auth_type'))
    print('  status:', c.get('last_status'), '| error_code:', c.get('last_error_code'))
    print('  reset_at:', c.get('last_error_reset_at'))
"

# Quick list via CLI
hermes auth list anthropic
```

Request dumps (in `~/.hermes/sessions/request_dump_*.json`) also contain the exact
error message and `request_id` if you need to trace a specific failure.

### The OAuth consumer token trap

Hermes's credential pool accepts **two fundamentally different kinds of Anthropic credentials**:

| Type | Source label | Auth type | Billing |
|---|---|---|---|
| **API key** | from console.anthropic.com | `api_key` | Pay-per-token, no monthly cap |
| **OAuth token** | `dashboard_pkce`, `hermes_pkce`, `claude_code` | `oauth` | Tied to Claude.ai subscription — has monthly token limit |

The OAuth tokens come from logging into Claude.ai via a browser OAuth flow. They look
like `sk-ant-oat01-...`. They are **not** the same as API keys (`sk-ant-api03-...`)
from console.anthropic.com.

If you see `dashboard_pkce`, `hermes_pkce`, or `claude_code` as the source, those are
consumer subscription tokens. They share the monthly limit of that Claude.ai account.
When that account's monthly allotment runs out, every credential of that type returns 429.

**Steve's setup note:** Steve's personal Hermes uses OpenRouter as the primary provider.
Direct Anthropic credentials in the pool are from OAuth flows that accumulated over time —
they are NOT needed for normal operation.

The Anthropic API key (`sk-ant-api03-g7P...`) lives in TWO places by design:
1. **G-Brain launchd plist** (`~/Library/LaunchAgents/com.gbrain.serve.plist`) — feeds `gbrain think` and the local MCP server. Added 2026-06-09.
2. **Railway gbrain-dream-cycle service** — feeds nightly synthesis. Added 2026-06-09.
3. **`~/.hermes/.env` as `ANTHROPIC_API_KEY`** — added 2026-06-10 so Hermes's credential pool can use it when G-Brain subagents explicitly route `provider: anthropic`. This is ADDITIVE — OpenRouter remains the primary Hermes provider.

**WARNING: API key drift across G-Brain launchd plists (diagnosed 2026-06-15).** Three plists carry API keys independently: `com.gbrain.serve.plist`, `com.gbrain.worker-supervisor.plist`, and `com.gbrain.dream-cycle.plist`. When a key is rotated, ALL THREE must be updated. The serve plist is the source of truth (it's the one that gets tested first because Hermes talks to it). If the worker-supervisor plist has a stale key, all dream cycle subagent jobs die with "invalid x-api-key" while the MCP server works fine. See `gbrain` skill `references/optimization-preferences.md` section "API key drift across launchd plists" for the full diagnostic and sync script, and `references/dream-cycle-full-repair-checklist.md` for the end-to-end repair checklist that covers filing rules, API keys, wrapper script config, model routing, and live verification.

To retrieve the key from the plist (e.g. to wire it somewhere new):
```python
import plistlib
with open('/Users/stevewandler/Library/LaunchAgents/com.gbrain.serve.plist', 'rb') as f:
    p = plistlib.load(f)
key = p['EnvironmentVariables']['ANTHROPIC_API_KEY']
```
Use `execute_code` or `patch` to write it — **never `terminal`** (Hermes redacts secrets in subprocess env, storing `***` instead of the real value).

### Fix: remove exhausted OAuth credentials

```bash
hermes auth list anthropic        # see all credentials + indices
hermes auth remove anthropic 1    # remove by 1-based index (e.g. the exhausted one)
hermes auth reset anthropic        # clear any remaining exhaustion flags
```

`hermes auth remove` takes the **1-based index** as shown by `hermes auth list`.
Always `list` first — never guess indices.

After removal, verify the clean credential remains:
```bash
hermes auth list anthropic
```

### Pitfalls

- **HTTP 429 "monthly spend limit" ≠ rate limit.** Don't add retry delays or increase
  retry counts — the account is capped for the month. The fix is removing the credential
  or raising the billing cap at console.anthropic.com → Billing → Spend limits.

- **The exhausted credential has a `last_error_reset_at` timestamp** (Unix epoch). That's
  the billing cycle reset date. If you want to keep the credential in the pool and just
  wait, you can — it'll auto-clear on that date.

- **Multiple OAuth credentials from the same Claude.ai account all share the same cap.**
  Having `dashboard_pkce` at index 1 and 2 doesn't double your budget — they're both
  drawing from the same subscription.

- **Session state file vs live auth.json.** The snapshots in
  `~/.hermes/state-snapshots/*/auth.json` may show credentials no longer in the live
  `~/.hermes/auth.json`. Always read the live file for current pool state.

- **Never write API keys via `terminal` or `hermes config set`.** Hermes redacts
  secrets in subprocess environments — the key gets stored as `***`. Use `execute_code`
  (Python file I/O) or the `patch` tool to write credential values to `.env` or plist
  files. This applies to any secret: API keys, tokens, passwords.

See `references/credential-pool-diagnostics.md` for the full session trace from the
2026-06-10 diagnosis.

---

## Cron Script Environment Pitfall: launchd plist env passthrough

**Operational discipline (reinforced 2026-06-15):** When a health check reveals a
failure, don't report "this should self-heal tonight" without verifying the exact
mechanism. Steve's words: "I keep hearing this, and then I keep getting these fails."
Before saying something will fix itself, trace the chain: which job runs it → what
schedule → what env/config it needs → whether that env/config is actually in place.
If you can't name the specific cron/launchd job, its schedule, and confirm it has the
right inputs — you don't actually know it will self-heal. Fix it now or say you can't.

Hermes cron scripts that shell out to `gbrain` (or any tool configured via launchd)
must pass the **full** `EnvironmentVariables` dict from the gbrain launchd plist
(`~/Library/LaunchAgents/com.gbrain.serve.plist`), not just `DATABASE_URL`.

**The bug (diagnosed 2026-06-15, FIXED same session):** `gbrain_nightly_sync.py`
cherry-picked only `DATABASE_URL` from the plist. But `gbrain sync` also needs
`VOYAGE_API_KEY` (for embeddings), `OPENAI_API_KEY`, `OPENROUTER_API_KEY`, etc.
Without them, every nightly sync failed with `embedding_credentials_missing` — exit
code 1, reported as `last_status: error` in Hermes cron but kept running other
phases, so it looked like a G-Brain problem rather than a Hermes script bug.

**The fix pattern:**

```python
import plistlib
from pathlib import Path

PLIST = Path.home() / "Library/LaunchAgents/com.gbrain.serve.plist"

def _plist_env() -> dict[str, str]:
    """Pull ALL EnvironmentVariables from the gbrain launchd plist."""
    if PLIST.exists():
        try:
            with PLIST.open("rb") as f:
                data = plistlib.load(f)
            return {k: str(v) for k, v in (data.get("EnvironmentVariables") or {}).items()}
        except Exception:
            pass
    return {}

# In the subprocess runner:
env = os.environ.copy()
for k, v in _plist_env().items():
    env.setdefault(k, v)  # existing env vars take precedence
```

**Key principle:** Use `setdefault` so real env vars (from the shell, from Hermes
cron runner) take precedence over the plist. The plist is the fallback, not the
override.

**Diagnostic signal:** If a no-agent cron job reports `last_status: error` and the
output log shows `embedding_credentials_missing` or similar credential errors, check
whether the script is passing the full plist env or just DATABASE_URL.

**G-Brain autopilot launchd crash: "Select a project" (diagnosed 2026-06-18).**
`com.gbrain.autopilot` runs via `~/.gbrain/autopilot-run.sh`, which sources
`~/.zshrc` for env vars. TWO problems compound:

1. **`.zshrc` has interactive-only constructs.** Steve's `.zshrc` contains a `cc()`
   function with a zsh `select` menu that echoes "Select a project:" when sourced by
   bash (which autopilot-run.sh uses via `#!/bin/bash`). This doesn't crash the
   script but pollutes stdout and can confuse stdin-dependent prompts.

2. **`DATABASE_URL` only lives in `.zshrc`.** launchd runs non-interactively —
   `.zshrc` sourcing may fail silently or partially, so `DATABASE_URL` never reaches
   gbrain. Without it, gbrain falls back to an interactive "Select a project:" prompt
   from its Supabase init flow, which hangs and dies.

The error log (`~/.gbrain/autopilot.err`) shows: `No database URL: database_url is
missing from config.`

**Fix (applied 2026-06-18):**
1. Created `~/.zshenv` with `export DATABASE_URL="..."` — sourced by ALL zsh/bash
   invocations including non-interactive launchd.
2. Patched `~/.gbrain/autopilot-run.sh` to source `.zshrc` with stdin closed
   (`source ~/.zshrc </dev/null 2>/dev/null`) to prevent interactive prompts from
   blocking.
3. Cleared stale lockfile: `rm ~/.gbrain/autopilot.lock`
4. Reinstalled: `gbrain autopilot --uninstall && gbrain autopilot --install`

**Verify:** `launchctl list | grep autopilot` should show exit code 0 (not 1).
Check `~/.gbrain/autopilot.err` for clean startup (no "database_url is missing").
Check `~/.gbrain/autopilot.log` for "Autopilot starting" + sync dispatches.

**General rule for launchd env vars on Steve's Mac:** Any env var that gbrain or
Hermes tools need MUST be in `~/.zshenv`, not just `.zshrc`. This includes
`DATABASE_URL`, `ANTHROPIC_API_KEY`, `VOYAGE_API_KEY`, `OPENROUTER_API_KEY`,
`GBRAIN_EMBEDDING_MODEL`, `GBRAIN_EMBEDDING_DIMENSIONS`, and PATH entries.

As of 2026-06-18, `~/.zshenv` contains all critical env vars (DATABASE_URL,
ANTHROPIC_API_KEY, VOYAGE_API_KEY, OPENROUTER_API_KEY, GBRAIN_EMBEDDING_MODEL,
GBRAIN_EMBEDDING_DIMENSIONS, and PATH for .npm-global, .local/bin, .bun/bin,
Python 3.9). The gbrain launchd plists ALSO carry their own copies in
`EnvironmentVariables` blocks — both paths work, but `.zshenv` is the safety net
for any new service (like autopilot) that sources shell profiles instead of plists.

If a new gbrain service or phase fails with "ANTHROPIC_API_KEY unset" or
"embedding_credentials_missing" when running via launchd, check `.zshenv` first,
then the relevant plist's `EnvironmentVariables` block.

**Don't confuse Hermes cron sync with G-Brain dream cycles (clarified 2026-06-15).**

**Cron job pitfall: no_agent scripts cannot call MCP tools (learned 2026-06-20).**
A `no_agent=true` cron runs the script directly and delivers stdout — it has NO access
to MCP servers (Slack, HubSpot, Atlassian, G-Brain, etc.). If a cron job needs to read
or write via MCP tools (e.g., check Slack threads, post messages, query HubSpot), it
MUST be an agent-based cron (`no_agent=false`, the default). To keep the agent's tool
footprint from ballooning, set `enabled_toolsets=[]` (empty array = all default tools
including MCP) rather than listing specific toolsets — listing only named toolsets like
`["web"]` will EXCLUDE MCP tools. Use `no_agent=true` only for pure data-pull scripts
that talk to external APIs directly (like the OpenRouter watchdog, which uses urllib).

The
The Hermes nightly sync (`gbrain_nightly_sync.py`, cron job `gbrain-nightly-sync`,
runs at 4am CT) only runs `gbrain sync` + `gbrain doctor --fast` + `gbrain stats`.
It does NOT run dream cycles. The dream cycle runs via gbrain's own autopilot
scheduler through the launchd `com.gbrain.serve.plist` service (~10:30 PM CT /
3:30 AM UTC). When Steve asks "why hasn't the dream cycle run," check the
autopilot-cycle jobs in G-Brain's job queue (`mcp_gbrain_list_jobs(name=
"autopilot-cycle")`), not the Hermes cron output. When jobs show
`result.status: partial`, examine `result.report.phases` for `status: fail` entries
— that's where the real problem is.

---

## 4. Overnight Maintenance Patterns

For Steve's personal Hermes + G-Brain overnight maintenance, see
`references/overnight-maintenance-2026-06-11.md`. It captures three reusable
patterns from the 2026-06-11 session:

- `approvals.mode: smart` is useful, but `hermes update` may still need Steve to run it directly because it restarts gateway / kills agents.
- WhatsApp bridge audit repair may require `npm audit fix` plus an explicit Baileys upgrade to a patched rc (`@whiskeysockets/baileys@7.0.0-rc13`).
- Skills Hub's GitHub rate-limit warning can be fixed by writing the existing `gh auth token` into `~/.hermes/.env` as `GITHUB_TOKEN` without printing the token, then restarting gateway.
