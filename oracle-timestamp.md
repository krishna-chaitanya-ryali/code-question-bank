JIRA Ticket Title:
[PROD Deployment] DateTime Standardization Across RAP Application

Project: RAP Incremental Dataload
Type: Task / Change Request
Priority: High
Assignee: [Assign to yourself or responsible engineer]
Labels: prod-deployment, datetime-standardization, RAP

Description:
This ticket is to track the Production deployment of DateTime standardization changes across the RAP application. The changes have been thoroughly implemented, tested, and verified in both DEV and UAT environments.

Scope of Changes:
Database Schema Changes:

Converted CREAT_DT and UPDT_DT columns from VARCHAR to TIMESTAMP(6)

Applied default values using SYSTIMESTAMP or triggers

Implemented fallback conversion logic to handle various date formats

Created triggers for hard deletes (for 4 tables)

Code Changes:

Modified all INSERT/UPDATE queries to support timestamp columns

Updated logic to avoid null insertions

Cleaned up redundant date parsing logic in Python backend

Affected Tables (Partial List):

MAP_RAP_USER_ROLE

MEET_INSTC

METRIC_ACCESS

RAP

RAP_METRICS_PACK_MAPPING

RAP_METRICS_DETAILS

Environment Details:

Changes deployed and verified in DEV

Functionally tested and signed off in UAT

Deployment Steps for PROD:
✅ Take DB backup before deployment
✅ Apply all DB schema and data migration scripts
✅ Deploy latest code from branch timestamp-standardization-task
✅ Run sanity checks for each module post-deployment
✅ Coordinate with team for individual functionality testing

Expected Outcome:
All date-related fields should consistently use TIMESTAMP(6)

No null date insertions

Data integrity preserved across all modules

Smooth insert/update/delete operations in PROD

Dependencies / Risks:
Sync required for DB and code changes

Common tables updated — impacts multiple modules

DBA support is required during deployment

Checklist:
 Code changes merged to production branch

 DB scripts reviewed and tested

 UAT sign-off received from all teams

 DBA available during deployment window

 Post-deployment sanity testing planned
