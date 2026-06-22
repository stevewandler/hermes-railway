---
name: hubspot-pipeline-integrity
description: "HubSpot pipeline auditing, cleanup, and data integrity for Bookmarked. Use when Steve needs to audit deals, find orphans/duplicates, cross-reference pipelines, build cleanup spreadsheets, or batch-fix associations. Portal 39855019."
version: 1.0.0
author: agent
tags: [hubspot, pipeline, cleanup, data-integrity, deals, associations, google-sheets]
triggers:
  - hubspot cleanup
  - pipeline audit
  - deal data integrity
  - orphaned deals
  - duplicate deals
  - missing renewals
  - clean up hubspot
---

# HubSpot Pipeline Integrity

Auditing, cleanup, cross-referencing, and batch-fixing HubSpot deal data for Bookmarked (portal 39855019). This is the operational skill for making HubSpot the single source of truth — a decision locked June 8, 2026 (Jan + Steve).

## When to Load

- Steve says "clean up HubSpot" or "audit the pipeline"
- Building a cleanup spreadsheet for Steve + Jan + Michelle review
- Cross-referencing pipelines (e.g. "does every 25/26 Closed Won have a 26/27 renewal?")
- Checking for orphaned deals, duplicates, or test district artifacts
- Batch-associating deals to company records
- Any pipeline data pull that needs to be verified before going to Charlie

## Pipeline Architecture (source of truth)

See `weekly-chairman-update` skill → `references/hubspot-pipeline-stages.md` for exact stage names, IDs, and probabilities. Key pipeline IDs:

| Pipeline | ID | Purpose |
|----------|-----|---------|
| Sales (net-new) | `default` | Texas net-new district deals |
| 26/27 Renewal | `798674460` | Current renewal cycle |
| 25/26 Renewal | `688408429` | Prior renewal cycle |
| Testing Districts | `41834638` | Internal test deals — EXCLUDE from all reporting |
| Out of State | `67437740` | Non-Texas deals (Utah, FL, GA, OH, Canada) |
| ESC Partnerships | `61762106` | Partnership deals, not direct district revenue |
| 24/25 Renewal | `98147764` | Closed historical cycle |
| 27/28 Renewal | `2231817917` | Future cycle (early) |

## Owner ID Mapping

```
436425345 = Teela Watson
83343072  = Jan Gilboy
479487253 = Steve Wandler
83027884  = Natasha Flanders
681243224 = Michelle Rogers
81631149  = Patrick Reid
77068341  = Hunter/Prior Employee (deactivated)
587669925 = Prior Employee (deactivated)
419896888 = Prior Employee (deactivated)
1087311620 = Prior Employee (deactivated)
1854462804 = Prior Employee (deactivated)
```

Always pull fresh from `hubspot_list_owners` if an unknown ID appears. Deactivated owners won't show in the owners list — label them as prior employees.

## Cleanup Spreadsheet Workflow

When Steve asks to audit/clean HubSpot, build a Google Sheet in Sales Hub Shared Drive (`0AE6MCBZSFB-MUk9PVA`) with:

1. **Pipeline tabs** — one per pipeline, showing only current-cycle deals:
   - Sales Pipeline: active/open deals + Closed Won/Lost THIS school year only. Remove prior-year history.
   - Renewal pipelines: all deals (they're cycle-specific by definition)
   - Sort: by stage order, then amount descending within each stage

2. **Cleanup Log tab** — flagged issues with columns: Deal Name, Deal ID, Pipeline, Current Stage, Issue, Action Needed, Decision, Done, Deal Link, Status
   - Pre-populate with known issues (duplicates, INVALID labels, test districts)
   - Add a "Status" column that gets checked against live HubSpot (shows "DELETED BY STEVE" when deals are removed)

3. **Test District Cleanup tab** (if test districts are mixed into real pipelines) — every deal across ALL pipelines for each test district, showing the full trail

4. **Every row gets a Deal Link** — `https://app-na2.hubspot.com/contacts/39855019/record/0-3/{dealId}`

5. **Cross-reference column** on renewal tabs: "Has 26/27 Renewal?" — flags Closed Won deals missing a corresponding next-year renewal deal

### Google Sheets API: use RAW not USER_ENTERED for deal names

Deal names containing forward slashes (e.g. "26/27 RENEWAL | ...") can be misinterpreted by Google Sheets as dates or fractions when using `valueInputOption=USER_ENTERED`. Use `RAW` for the deal name column, or verify cell values after writing. Steve caught "26-27-0" rendering on a deal name — this was Sheets auto-formatting.

## Company Association Audit

**Critical pattern discovered June 15, 2026:** Bulk-imported deals are often NOT associated to company records. This makes them invisible from the company page in HubSpot — root cause of duplicate deal creation and reporting confusion.

### How to check
```
GET /crm/v4/objects/deals/{dealId}/associations/companies
```
Empty `results` array = orphaned deal.

### How to fix
```
PUT /crm/v4/objects/deals/{dealId}/associations/companies/{companyId}
Body: [{"associationCategory": "HUBSPOT_DEFINED", "associationTypeId": 341}]
```

### How to find the company
```
POST /crm/v3/objects/companies/search
Body: {"query": "district name", "properties": ["name"], "limit": 5}
```

Match by name overlap. Watch for: duplicate company records (Baker County has two, Plemons-Stinnett-Phillips has two), slight name variations ("City View ISD" vs "City View Isd").

### Batch workflow
1. Read deal IDs from the spreadsheet column
2. Check each deal's company associations via the API
3. Write "NO COMPANY LINKED" in a status column for orphaned deals
4. Search for company by district name extracted from deal name
5. Associate and clear the flag
6. Add a "Company Linked?" column to each pipeline tab for visibility

## Cross-Pipeline Integrity Checks

### Every Closed Won needs a next-year renewal
For each deal in 25/26 Renewal Pipeline with stage `1008389048` (Closed/Won):
- Extract the district name
- Search for a matching deal in the 26/27 Renewal Pipeline
- Flag "NO — MISSING" if no match found

**Consortium districts** (ESC 9, ESC 15, ESC 16) are typically $0 deals. Whether they get individual 26/27 renewal deals or roll under a single ESC partnership deal is a decision for Jan and Michelle.

### Test districts in real pipelines
Test districts (Godley, Clifton, North Lamar, Abilene, Canadian, etc.) should only have deals in the Testing Districts pipeline. When bulk imports create renewal deals for test districts, they appear as $0 INVALID/junk in the renewal pipeline. Check for and flag these.

### Deals in the wrong pipeline
- **Out-of-state deals in Sales Pipeline** — Utah, Fort Vermilion (Canada), Levy County (FL) belong in Out of State pipeline
- **ESC partnership deals in Sales Pipeline** — ESC 10 Partnership Discussion belongs in ESC Partnerships pipeline
- **Net-new deals that are actually renewals** — verify with Jan before moving. Don't assume based on deal name. Real example: Farwell ISD "26/27 Contract" LOOKED like a renewal but was confirmed new business by Jan.

## Pitfalls

- **Don't assume a deal is a renewal based on naming conventions.** Jan explicitly confirmed Farwell ($1,692), Triumph ($4,500), and Yantis ($930) as new business despite renewal-sounding names. Always verify with Jan before reclassifying.
- **HubSpot search API can return stale/cached results.** A deal that was just deleted may still appear in a broad search. Use direct lookup (`GET /crm/v3/objects/deals/{dealId}`) to confirm whether a deal actually exists. Steve caught this — Krum duplicate showed in search results after he'd already deleted it.
- **Deleted deals return 404 on direct lookup** — that's the reliable existence check, not search.
- **Association type 341** is the standard deal-to-company association. If a deal returns "invalid object" when you try to associate it, the deal has likely been deleted.
- **The May 20-21, 2026 bulk import** created ~36 renewal deals without company associations. This was the root cause of significant reporting confusion. Any future bulk import should be audited for associations immediately.
- **Steve doesn't want historical deals cluttering the view.** When building pipeline spreadsheets, filter to current school year only. Active/open deals + Closed Won/Lost with close dates >= start of current school year. Remove prior-year closed deals.
- **Don't remove deals from the cleanup log when Steve deletes them** — add a Status column showing "DELETED BY STEVE" so the review trail is preserved for the Jan/Michelle walkthrough.
- **Duplicate company records exist** in HubSpot (Baker County has two, Plemons-Stinnett-Phillips has two). When associating deals, pick the most recently modified company record. Flag duplicates for separate cleanup.
- **Utah SEA deal ($1.3M) is PARKED in Out of State pipeline.** Steve moved it out of Sales Pipeline June 15. Never include it in the main Sales Pipeline view or headline numbers.
- **Sales Pipeline is predominantly Texas.** Non-Texas deals (FL, GA, OH, Canada) belong in Out of State. ESC partnerships belong in ESC Partnerships pipeline. Steve actively cleaned these out June 15.

## Decision Context (from meetings)

**June 8, 2026 (Jan + Steve):**
- HubSpot is the single source of truth for all renewal data (formal decision)
- HubSpot architecture must be finalized BEFORE bulk data entry
- Michelle to architect renewal workflows using Nexus

**June 11, 2026 (Jan + Steve + Patrick):**
- Jan cleaned up "phantom deals" (the DUPLICATE/INVALID labeling in Churn)
- Patrick analyzing 62 active districts by login activity
- Districts being segmented into buckets for V1→V2 migration
- Patrick to share migration CSV for joint review

## References

- `references/pipeline-cleanup-workflow.md` — Step-by-step batch cleanup procedure with exact API calls and Python code patterns
