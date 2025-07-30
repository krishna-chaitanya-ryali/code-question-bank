🔄 Data Cleanup: Risk Type and Metric ID Updates in RAP Tables
📌 Overview
This task addresses two data integrity issues in the RAP module:

Duplicate RISK_TYPE_ID values for the same RISK_HEADER in the RAP_RISK_TYPE table.

Missing MASTER_METRIC_ID values in the RAP_METRICS_DETAILS table.

1️⃣ Part A: Update Duplicate RISK_TYPE_ID Values
🎯 Objective
Normalize RISK_TYPE_ID usage across all dependent tables by:

Identifying duplicate RISK_HEADERs with multiple RISK_TYPE_IDs.

Selecting the lowest RISK_TYPE_ID as the canonical value.

Updating all references across related tables.

Cleaning up the RAP_RISK_TYPE table.

🛠️ Implementation Steps
Step 1: Create Temporary Mapping Table

sql
Copy
Edit
CREATE TABLE TMP_RISK_TYPE_MAPPING (
  OLD_RISK_TYPE_ID NUMBER,
  NEW_RISK_TYPE_ID NUMBER
);
Step 2: Populate Mapping Table

Use analytic functions to identify and map all duplicate RISK_TYPE_IDs to the minimum one per RISK_HEADER.

Step 3: Update Tables

sql
Copy
Edit
MERGE INTO RAP_RISK_TYPE tgt
USING TMP_RISK_TYPE_MAPPING map
ON (tgt.RISK_TYPE_ID = map.OLD_RISK_TYPE_ID)
WHEN MATCHED THEN
  UPDATE SET tgt.RISK_TYPE_ID = map.NEW_RISK_TYPE_ID;
Repeat similar MERGE updates for:

RAP

RAP_MASTER_METRIC_DETAILS

Step 4: Cleanup

Delete duplicate records from RAP_RISK_TYPE using the mapping table.

2️⃣ Part B: Backfill Missing MASTER_METRIC_ID in RAP_METRICS_DETAILS
🎯 Objective
Update RAP_METRICS_DETAILS.MASTER_METRIC_ID where it's NULL, using reference data from RAP_MASTER_METRIC_DETAILS.

🧩 Join Path
To trace each RAP_METRICS_DETAILS row:

scss
Copy
Edit
RAP_METRICS_DETAILS
  → RAP (via RAP_ID)
  → MEET_INSTC (via RAP.RAP_INSTANCE_ID = MEET_INSTC.MEET_INSTANCE_ID)
  → RAP_METRICS_PACK_MAPPING (via RAP_METRICS_MAPPING_ID)
  → RAP_MASTER_METRIC_DETAILS (via METRICS_DISP = MASTER_METRIC_NAME)
Filter: MEET_INSTC.ACT_ON_RCRD = 'insert_rap_open'

For a given MASTER_METRIC_NAME, select the MASTER_METRIC_ID with the minimum RISK_TYPE_ID.

✅ Final Update Query
sql
Copy
Edit
MERGE INTO RAP_METRICS_DETAILS d
USING (
    SELECT d.ROWID AS d_rowid,
           m.MASTER_METRIC_ID
    FROM RAP_METRICS_DETAILS d
    JOIN RAP r ON d.RAP_ID = r.RAP_ID
    JOIN MEET_INSTC mi ON r.RAP_INSTANCE_ID = mi.MEET_INSTANCE_ID
    JOIN RAP_METRICS_PACK_MAPPING p ON d.RAP_METRICS_MAPPING_ID = p.RAP_METRICS_MAPPING_ID
    JOIN (
        SELECT MASTER_METRIC_NAME, MIN(RISK_TYPE_ID) AS min_risk_type_id
        FROM RAP_MASTER_METRIC_DETAILS
        GROUP BY MASTER_METRIC_NAME
    ) min_m ON p.METRICS_DISP = min_m.MASTER_METRIC_NAME
    JOIN RAP_MASTER_METRIC_DETAILS m 
      ON m.MASTER_METRIC_NAME = min_m.MASTER_METRIC_NAME 
     AND m.RISK_TYPE_ID = min_m.min_risk_type_id
    WHERE d.MASTER_METRIC_ID IS NULL
      AND mi.ACT_ON_RCRD = 'insert_rap_open'
) src
ON (d.ROWID = src.d_rowid)
WHEN MATCHED THEN
UPDATE SET d.MASTER_METRIC_ID = src.MASTER_METRIC_ID;
📂 GitHub Repo Reference
Repository: data-cleanup-utilities

Script 1: update_risk_type_id_mapping.sql

Script 2: backfill_master_metric_id.sql

🧪 Validation
Count validation before and after updates.

Spot-checked affected rows.

Confirmed updates matched mapping logic.

Ensured referential consistency post-cleanup.
