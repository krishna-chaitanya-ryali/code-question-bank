

Subject: Request for Backup & TBA Support – Master Metric ID Data Fix (Scheduled for Monday)

Hi [DVE Name],

As discussed, we have raised a Jira ticket for the Master Metric ID data fix activity. This involves backfilling missing MASTER_METRIC_IDs in RAP tables and requires:

1. Backup of the impacted schema/tables before execution.


2. TBA support for running the provided SQL scripts in the database.



We would like to schedule this activity on Monday, and it will require your support for execution. Please ensure that Sanket is also available on the same day, as his presence is important during this activity.

Key Notes:

This is strictly a data fix, not a code fix.

Null values to be updated are from October 2024 till date.

We are not modifying any existing valid IDs; only focusing on missing/null values.

Code fixes (8–10) are in progress and will provide a permanent solution.

Until then, there might still be a few discrepancies even after this data fix.


The step-by-step procedure, SQL scripts, and validation queries are already documented and attached for reference.

Please confirm your availability for Monday so that we can proceed smoothly.

Thanks & Regards,
[Your Name]

Summary:
Request for Backup and TPA Support for Master Metric ID Data Fix

Description:
As part of the ongoing effort to backfill missing MASTER_METRIC_IDs in the RAP tables, we have identified discrepancies and null values that need to be fixed. This is a data fix only (not code-related) and requires database-level updates.

Before proceeding, we need to ensure database safety with a proper backup, and we also require TPA support for executing the queries in the database.

Action Items:

1. Backup Request – Take a backup of the impacted RAP schema/tables before the update (RAP_MASTER_METRIC_DETAILS, RAP_METRIC_DETAILS, RAP_METRIC_PACK_MAPPING, RAP tables).


2. TPA Support – Execute the shared SQL scripts for:

Identifying missing/incorrect MASTER_METRIC_IDs

Updating null values with correct mappings

Handling duplicate or multi-mapping scenarios with proper RISK_TYPE_ID checks



3. Validation – Post-update, run the provided validation queries to confirm the number of records updated and ensure data integrity.



Notes for Context:

Null values being fixed are from October 2024 to present (2025).

This is strictly a data fix — no changes are being made to existing valid IDs.

Code fixes (8–10) are already in progress, which will resolve this permanently. Until then, some discrepancies may still exist.

TPA execution support is required to ensure proper updates at DB level.
