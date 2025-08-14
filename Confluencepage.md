Production Deployment – Risk Type & Master Metric Data Cleanup

Overview

This activity covers a 3-step data cleanup and backfilling process involving the following:

1. Duplicate RISK_TYPE_ID removal and remapping across dependent tables


2. Cleanup of duplicate MASTER_METRIC_ID records in RAP_MASTER_METRIC_DETAILS


3. Backfilling missing MASTER_METRIC_ID values in RAP_METRICS_DETAILS




---

Step 1 – Duplicate RISK_TYPE_ID Removal

Objective:
Identify and remove duplicate RISK_TYPE_ID entries in the RISK_TYPE table, and ensure all dependent tables reference the correct RISK_TYPE_ID.

Example Scenario:

Model Risk existed with two IDs:

RISK_TYPE_ID = 13

RISK_TYPE_ID = 1947


Decision: Keep the lowest RISK_TYPE_ID (13) and update all references from 1947 to 13.


Steps Performed:

1. Identify duplicates by matching RISK_TYPE_NAME values in the RISK_TYPE table.


2. Select lowest ID for each duplicate group to retain.


3. Update dependent tables:

RAP table – Updated all references from duplicate IDs to the retained ID.

RAP_MASTER_METRIC_DETAILS table – Updated duplicate RISK_TYPE_ID values to the retained ID.





---

Step 2 – Cleanup of Duplicate MASTER_METRIC_ID in RAP_MASTER_METRIC_DETAILS

Background:
After Step 1 updates, some RAP_MASTER_METRIC_DETAILS records ended up with the same RISK_TYPE_ID but different MASTER_METRIC_ID for the same metric.

Example:

Before update:

MASTER_METRIC_ID = 100, RISK_TYPE_ID = 13

MASTER_METRIC_ID = 101, RISK_TYPE_ID = 1947


After Step 1 update:

Both IDs now have RISK_TYPE_ID = 13 → Duplicate metric definition.



Dependency Consideration:

MASTER_METRIC_ID is referenced in RAP_METRICS_DETAILS.

We cannot directly delete the duplicate (101) until all references in RAP_METRICS_DETAILS are updated.


Steps Performed:

1. Identify duplicate metrics (same metric name and RISK_TYPE_ID but different MASTER_METRIC_ID).


2. Update references in RAP_METRICS_DETAILS:

All rows referencing the duplicate MASTER_METRIC_ID (e.g., 101) were updated to the retained MASTER_METRIC_ID (e.g., 100).



3. Delete duplicate records from RAP_MASTER_METRIC_DETAILS after references were cleaned up.




---

Step 3 – Backfilling Missing MASTER_METRIC_ID in RAP_METRICS_DETAILS

Root Causes Identified

Case 1 – Changing Dashboard Section or Risk Type from UI

When a metric is updated in the UI and its dashboard section/risk type is changed (e.g., from “Model Risk” to “Climate Risk”):

The frontend sends MASTER_METRIC_ID as NULL.

The backend overwrites the existing MASTER_METRIC_ID in RAP_METRICS_DETAILS with NULL.



Case 2 – Adding Existing Metric to a New Dashboard Section

When adding an already existing metric to another dashboard section:

The frontend incorrectly sends MASTER_METRIC_ID as NULL.

Backend updates the MASTER_METRIC_ID in RAP_METRICS_DETAILS to NULL instead of retaining the existing ID.


Expected Fix: Frontend should send the existing MASTER_METRIC_ID to preserve the link.



---

Challenges in Backfilling

Challenge 1 – Missing Records in RAP_MASTER_METRIC_DETAILS

Possible Cause 1:

RAP_MASTER_METRIC_DETAILS introduced in 2024, but metrics existed since 2020 and were never inserted into it.


Possible Cause 2:

Cascading from parent to child metrics, then deleting the parent, left orphaned child records without a matching entry in RAP_METRICS_MAPPING.



Resolution:

For rows in RAP_METRICS_DETAILS with:

MASTER_METRIC_ID = NULL

No matching metric name in RAP_METRICS_MAPPING
→ Create a new record in RAP_MASTER_METRIC_DETAILS, capture the new MASTER_METRIC_ID, and update the corresponding rows in RAP_METRICS_DETAILS.




---

Challenge 2 – RISK_TYPE_ID Mismatch Between Tables

Joins between RAP_METRICS_DETAILS and RAP_MASTER_METRIC_DETAILS rely on RISK_TYPE_ID.

In some cases:

RISK_TYPE_ID in RAP table was updated.

But RISK_TYPE_ID in RAP_MASTER_METRIC_DETAILS was not updated.

Result: Matching queries failed due to mismatched IDs.



Resolution:

Applied multiple conditional queries to handle mismatches:

Updated MASTER_METRIC_ID using metric name matches where possible.

Used corrected RISK_TYPE_ID for joining when direct matches failed.




---

Summary

This 3-step process ensured:

All RISK_TYPE_ID references are consistent across dependent tables.

Duplicate MASTER_METRIC_ID records are removed after proper re-association.

Missing MASTER_METRIC_ID values in RAP_METRICS_DETAILS are restored, considering multiple root causes and mismatch scenarios.


