---
name: supabase-security
description: "Supabase/PostgreSQL security and performance for backend-only projects: RLS audits, anon-role lockdown, SECURITY DEFINER hardening, dead row bloat, cron job health, missing indexes, slow queries, and vacuum management. Covers both security hardening and database optimization for G-Brain and similar service-key-only databases."
version: 1.1.0
author: agent
tags: [supabase, security, rls, row-level-security, gbrain, postgres, database, security-definer, functions]
references:
  - references/rls-lockdown-2026-06.md  # Full technique: audit query, batch ALTER, verification — plus G-Brain-specific notes
  - references/full-security-audit-2026-06.md  # Complete beyond-RLS audit: functions, views, SECURITY DEFINER, search_path — run after every RLS fix
---

# Supabase Security Hardening

## When to load this skill

- Supabase security advisory email arrives (subject: "Action required: security vulnerabilities detected")
- Adding new tables to G-Brain or any Supabase project — RLS must be enabled at creation time
- Routine security audit of the G-Brain project (`vaevjtfxbduyqcfuvzfv`)
- Any work touching `pg_tables`, `information_schema.role_table_grants`, or RLS policies

---

## The Core Distinction: Backend-Only vs. User-Auth Projects

G-Brain is **backend-only** — no end-users authenticate, all access is via the **service role key**. This distinction determines the correct fix:

| Project type | Fix |
|---|---|
| User-auth (app has logged-in users) | Enable RLS + write per-user policies (`auth.uid()`) |
| Backend-only (service key only) | Enable RLS, **no policies needed** — service role bypasses RLS entirely |

For backend-only projects, enabling RLS with zero policies is the right answer. It blocks `anon` and `authenticated` completely while leaving the service role untouched. Do NOT add permissive policies "just in case" — that defeats the purpose.

---

## Step 1: Audit — What's Exposed?

```python
# Get all tables with RLS disabled + their anon grants
import psycopg2, os

conn = psycopg2.connect(os.environ['DATABASE_URL'])
cur = conn.cursor()

# Tables with RLS off
cur.execute("""
SELECT tablename, rowsecurity
FROM pg_tables
WHERE schemaname = 'public' AND rowsecurity = false
ORDER BY tablename;
""")
print("RLS DISABLED:", [r[0] for r in cur.fetchall()])

# Confirm anon has grants (the actual exposure)
cur.execute("""
SELECT DISTINCT table_name, grantee
FROM information_schema.role_table_grants
WHERE table_schema = 'public'
  AND grantee IN ('anon', 'authenticated')
ORDER BY table_name;
""")
print("ANON/AUTH GRANTS:", cur.fetchall())
```

**Note on DATABASE_URL in Hermes terminal sessions:** The `gbrain` CLI requires `DATABASE_URL` which is NOT in the Hermes shell environment. Get it from the launchd plist:

```bash
export DATABASE_URL=$(plutil -extract EnvironmentVariables.DATABASE_URL raw \
  ~/Library/LaunchAgents/com.gbrain.sync-all.plist)
```

---

## Step 2: Fix — Enable RLS on All Affected Tables

```python
import psycopg2, os

conn = psycopg2.connect(os.environ['DATABASE_URL'])
conn.autocommit = False
cur = conn.cursor()

# Get all tables with RLS disabled
cur.execute("""
SELECT tablename FROM pg_tables
WHERE schemaname = 'public' AND rowsecurity = false
ORDER BY tablename;
""")
tables = [r[0] for r in cur.fetchall()]

for table in tables:
    cur.execute(f'ALTER TABLE public."{table}" ENABLE ROW LEVEL SECURITY;')
    print(f"  ✓ {table}")

conn.commit()
print(f"Done. {len(tables)} tables secured.")
```

**Use `conn.autocommit = False` + explicit `commit()`** so if anything fails mid-batch, nothing is partially applied.

---

## Step 3: Verify — Service Key Still Works

After enabling RLS, immediately confirm G-Brain is operational:

```bash
export DATABASE_URL=$(plutil -extract EnvironmentVariables.DATABASE_URL raw \
  ~/Library/LaunchAgents/com.gbrain.sync-all.plist)
gbrain search "canonical architecture"
```

And via Python:

```python
cur.execute('SELECT COUNT(*) FROM public.pages;')
print("pages:", cur.fetchone()[0])  # Should be ~12,000+
```

If this reads correctly, the service key is working — RLS did not break anything.

---

## Step 4: Full Security Audit — Beyond RLS

After fixing RLS, run a deeper audit. RLS is just one layer. The Supabase advisor does not catch all of these.

### 4a. SECURITY DEFINER functions callable by anon

```sql
SELECT n.nspname, p.proname, p.proowner::regrole, p.proconfig
FROM pg_proc p
JOIN pg_namespace n ON p.pronamespace = n.oid
WHERE p.prosecdef = true
  AND n.nspname NOT IN ('pg_catalog', 'information_schema', 'auth', 'storage');
```

For each: check if `anon` has EXECUTE. If yes and it's an internal/cron function — revoke it:

```sql
REVOKE EXECUTE ON FUNCTION public.<fn>() FROM anon;
REVOKE EXECUTE ON FUNCTION public.<fn>() FROM authenticated;
```

Also check `proconfig` — if NULL, the function has no pinned `search_path`, which is a schema injection risk for SECURITY DEFINER functions. Pin it:

```sql
ALTER FUNCTION public.<fn>() SET search_path = public, pg_catalog;
```

### 4b. Views with open anon grants (even when underlying table has RLS)

```sql
SELECT table_name, grantee, privilege_type
FROM information_schema.role_table_grants
WHERE table_schema = 'public'
  AND table_name IN (SELECT table_name FROM information_schema.views WHERE table_schema = 'public')
  AND grantee IN ('anon', 'authenticated');
```

Views do NOT automatically inherit the RLS protection of their underlying tables in all configurations. If a view has anon grants and the backend never exposes it to anonymous callers — revoke:

```sql
REVOKE ALL ON public.<view_name> FROM anon;
REVOKE ALL ON public.<view_name> FROM authenticated;
```

### 4c. Internal trigger/event functions callable by anon

Functions like `auto_enable_rls()`, `notify_job_change()`, `update_search_vector()`, `bump_generation_*()` are trigger functions — they fire internally, never from anon clients. Revoke EXECUTE:

```sql
REVOKE EXECUTE ON FUNCTION public.<trigger_fn>() FROM anon;
REVOKE EXECUTE ON FUNCTION public.<trigger_fn>() FROM authenticated;
```

### 4d. What to leave alone

- **pgvector / pg_trgm extension functions** (vector_*, halfvec_*, cosine_distance, etc.) — Supabase grants these to anon by default. They are pure math functions with no data access. Safe.
- **`supabase_etl_admin`** role — Supabase-managed internal role with bypassRLS. Not yours to modify.
- **`auth.*` schema** — Supabase manages entirely. Do not touch.
- **Realtime publication** — if empty, that's fine (no tables streaming to public).

---

## Step 5: Confirm Advisory Clears

Supabase clears security advisories within ~24 hours of the fix being applied. No manual action needed at `https://supabase.com/dashboard/project/vaevjtfxbduyqcfuvzfv/advisors/security`.

---

## Pitfalls

- **Double-quoting table names in ALTER statements.** Use `f'ALTER TABLE public."{table}" ENABLE ROW LEVEL SECURITY;'` to handle any table names with special characters or reserved words.
- **psycopg2 not in Hermes venv.** Install with: `~/.hermes/hermes-agent/venv/bin/pip install psycopg2-binary -q`
- **Single-quoted schema names in WHERE clauses.** Use single quotes for string literals in SQL (`'public'`, `'pg_catalog'`), not double quotes — double quotes are for identifiers.
- **NOT IN with double-quoted strings causes `UndefinedColumn` error.** Always use single quotes: `WHERE schemaname NOT IN ('pg_catalog', 'information_schema')` — never double quotes.
- **Don't add permissive policies for backend-only tables.** There are no users to write policies for. Adding `USING (true)` policies re-opens the table to `anon` just like before.
- **New tables added by migrations will default to RLS=false.** Run the audit query after any schema migration to catch newly added tables. The `auto_enable_rls` event trigger should handle this automatically if installed — but verify it's present.
- **Views don't inherit RLS from their underlying tables.** After enabling RLS on tables, separately check view grants. A view on top of a now-RLS-protected table can still be queried by anon if the view itself has grants.
- **SECURITY DEFINER without pinned search_path.** Any SECURITY DEFINER function with `proconfig = NULL` is vulnerable to schema injection. Always pin `search_path = public, pg_catalog` after creating or auditing such functions.
- **`auth.*` schema tables:** Supabase manages these — do not touch their RLS settings. Only act on `public.*`.

---

## New Table Creation Hygiene

Whenever a new table is added to G-Brain (via migration or manual DDL), add:

```sql
ALTER TABLE public.<new_table> ENABLE ROW LEVEL SECURITY;
```

immediately after the `CREATE TABLE` statement.

---

## Absorbed Skills (consolidated by curator 2026-06-14)
- `supabase-database-optimization` → dead row bloat audit, cron job health checks, unused index cleanup, missing index detection, slow query analysis, and G-Brain maintenance schedule all absorbed. See `references/gbrain-optimization-2026-06.md` (now under this skill) for session-specific findings.

## G-Brain Project Reference

- **Project ID:** `vaevjtfxbduyqcfuvzfv`
- **Project name:** `gbrain-brain`
- **DATABASE_URL source:** `~/Library/LaunchAgents/com.gbrain.sync-all.plist`
- **Python:** `~/.hermes/hermes-agent/venv/bin/python3`
- **Access pattern:** service role key only — no end-user auth
- **Tables as of 2026-06-10:** 58 public tables, all now RLS-enabled
