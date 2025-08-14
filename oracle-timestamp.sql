Step 2 – Deduplication of RAP_MASTER_METRIC_DETAILS after RISK_TYPE_ID Consolidation

Background
During Step 1, we consolidated duplicate RISK_TYPE_IDs in RISK_TYPE table (e.g., 1947 → 13).
As a result, in RAP_MASTER_METRIC_DETAILS, some metrics now have the same MASTER_METRIC_NAME and RISK_TYPE_ID but different MASTER_METRIC_IDs.

Example

MASTER_METRIC_ID	MASTER_METRIC_NAME	RISK_TYPE_ID

100	MODEL RISK	13
101	MODEL RISK	1947


After Step 1 (1947 → 13):

MASTER_METRIC_ID	MASTER_METRIC_NAME	RISK_TYPE_ID

100	MODEL RISK	13
101	MODEL RISK	13



---

Why direct deletion is unsafe

RAP_METRICS_DETAILS stores a foreign key MASTER_METRIC_ID pointing to RAP_MASTER_METRIC_DETAILS.
If we delete MASTER_METRIC_ID = 101 without updating its references, we break referential integrity.


---

Steps Performed

1. Identify true duplicates

Criteria: Same MASTER_METRIC_NAME (case-insensitive, trimmed) and same RISK_TYPE_ID.

Retain the lowest MASTER_METRIC_ID as the canonical ID.

Store the mapping of OLD_MASTER_METRIC_ID → NEW_MASTER_METRIC_ID.


CREATE GLOBAL TEMPORARY TABLE MASTER_METRIC_ID_MAPPING (
  MASTER_METRIC_NAME     VARCHAR2(500),
  RISK_TYPE_ID           NUMBER,
  OLD_MASTER_METRIC_ID   NUMBER,
  NEW_MASTER_METRIC_ID   NUMBER
) ON COMMIT PRESERVE ROWS;

INSERT INTO MASTER_METRIC_ID_MAPPING (MASTER_METRIC_NAME, RISK_TYPE_ID, OLD_MASTER_METRIC_ID, NEW_MASTER_METRIC_ID)
WITH ranked AS (
  SELECT MASTER_METRIC_ID, MASTER_METRIC_NAME, RISK_TYPE_ID,
         MIN(MASTER_METRIC_ID) OVER (PARTITION BY TRIM(UPPER(MASTER_METRIC_NAME)), RISK_TYPE_ID) AS NEW_MASTER_METRIC_ID
  FROM RAP_MASTER_METRIC_DETAILS
)
SELECT MASTER_METRIC_NAME, RISK_TYPE_ID, MASTER_METRIC_ID, NEW_MASTER_METRIC_ID
FROM ranked
WHERE MASTER_METRIC_ID <> NEW_MASTER_METRIC_ID;


---

2. Update dependent records in RAP_METRICS_DETAILS
Before deletion, re-point all rows referencing the duplicate IDs to the canonical ID.

UPDATE RAP_METRICS_DETAILS d
SET d.MASTER_METRIC_ID = (
  SELECT m.NEW_MASTER_METRIC_ID
  FROM MASTER_METRIC_ID_MAPPING m
  WHERE m.OLD_MASTER_METRIC_ID = d.MASTER_METRIC_ID
)
WHERE EXISTS (
  SELECT 1
  FROM MASTER_METRIC_ID_MAPPING m
  WHERE m.OLD_MASTER_METRIC_ID = d.MASTER_METRIC_ID
);


---

3. Delete duplicate master metric rows
Only after step 2 is complete and no RAP_METRICS_DETAILS rows reference the duplicate IDs.

DELETE FROM RAP_MASTER_METRIC_DETAILS
WHERE MASTER_METRIC_ID IN (
  SELECT OLD_MASTER_METRIC_ID
  FROM MASTER_METRIC_ID_MAPPING
);


---

Outcome

All metrics in RAP_MASTER_METRIC_DETAILS are now unique per (MASTER_METRIC_NAME, RISK_TYPE_ID).

All references in RAP_METRICS_DETAILS correctly point to the retained master metric ID.

Referential integrity is preserved.



---
itle: PROD Deployment – Risk Type ID & Master Metric Data Cleanup

Summary

This document records the production changes performed to remove duplicate RISK_TYPE_ID values, update all dependent tables, and clean up duplicate MASTER_METRIC_ID records in RAP_MASTER_METRIC_DETAILS caused by the consolidation.
The activities ensured referential integrity across all related RAP tables.


---

Step 1: Risk Type ID Consolidation

Objective:
Eliminate duplicate risk type entries and standardize all references to use the lowest RISK_TYPE_ID.

Process:

1. Identification of Duplicates

Queried the RISK_TYPE table to identify multiple entries having the same RISK_TYPE_NAME but different IDs.

Example:

Model Risk → ID 13

Model Risk → ID 1479




2. Master ID Selection

Retained the lowest RISK_TYPE_ID (e.g., 13) as the canonical value.

Mapped all duplicate IDs (e.g., 1479) to the master ID.



3. Updates Performed

RAP table → Updated all matching rows to reference the master RISK_TYPE_ID.

RAP_MASTER_METRIC_DETAILS table → Updated all matching rows to reference the master RISK_TYPE_ID.




SQL Reference:

Queries executed included:

Selection of duplicate risk types.

Update statements to replace duplicate IDs in dependent tables.



Data Verification:

Count checks before and after update.

Ensured no invalid RISK_TYPE_ID references remained.

