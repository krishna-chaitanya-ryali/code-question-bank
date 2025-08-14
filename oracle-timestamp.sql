Title: PROD Data Fix — Backfill MASTER_METRIC_ID in RAP_METRICS_DETAILS


---

Summary:
A data inconsistency was identified in production where MASTER_METRIC_ID in RAP_METRICS_DETAILS is NULL for multiple records. These should map to entries in RAP_MASTER_METRIC_DETAILS but are missing due to application logic gaps. This ticket covers the one-time production data backfill.


---

Root Cause:

1. When new metrics were created, corresponding entries in RAP_MASTER_METRIC_DETAILS were not inserted (possible gap in Python code).


2. RAP_METRICS_DETAILS.MASTER_METRIC_ID was never populated for those metrics, resulting in null values.




---

Deployment Type:

One-time PROD Data Fix (DML execution).

Requires DBA execution in controlled deployment window.



---

Steps to be Executed in PROD:

Step 1 — Identify Null Master Metric Records:

Query to list all rows in RAP_METRICS_DETAILS where MASTER_METRIC_ID is NULL.

Match with RAP_MASTER_METRIC_DETAILS using p.METRICS_DISP (case-insensitive, trimmed).


Step 2 — Insert Missing Master Metrics:

For metrics not present in RAP_MASTER_METRIC_DETAILS, insert new rows with:

MASTER_METRIC_NAME = p.METRICS_DISP

RISK_TYPE_ID from RAP table

CREATE_DT and UPDT_DT as SYSDATE



Step 3 — Backfill MASTER_METRIC_ID:

Update RAP_METRICS_DETAILS to set MASTER_METRIC_ID from matching RAP_MASTER_METRIC_DETAILS.

Ensure no ORA-01427 multiple-row errors by using ROWNUM = 1.



---

Rollback Plan:

Backup affected rows before update:


CREATE TABLE RAP_METRICS_DETAILS_BKP_YYYYMMDD AS
SELECT * FROM RAP_METRICS_DETAILS
WHERE MASTER_METRIC_ID IS NULL;

In case of issue, rollback by:


UPDATE RAP_METRICS_DETAILS d
SET d.MASTER_METRIC_ID = NULL
WHERE d.ROWID IN (SELECT ROWID FROM RAP_METRICS_DETAILS_BKP_YYYYMMDD);


---

Validation Post Deployment:

Count of rows where MASTER_METRIC_ID is NULL should drop to zero (or only valid exceptions remain).

Cross-check newly inserted RAP_MASTER_METRIC_DETAILS entries with source data.

Random sample verification of updated rows.



---

Approvals Required:

Product Owner approval.

QA sign-off from UAT results.

DBA execution approval.



---

Attachments:

Final SQL scripts for Step 1, Step 2, Step 3.

Before/After dataset samples from UAT execution.

