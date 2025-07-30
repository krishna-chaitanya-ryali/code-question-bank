🔧 Task Summary: Backfill Missing MASTER_METRIC_ID in RAP_METRICS_DETAILS
🧩 Objective
To backfill NULL values in the RAP_METRICS_DETAILS.MASTER_METRIC_ID column using existing references from related tables based on metric name and risk type.

📊 Problem Statement
Some records in the RAP_METRICS_DETAILS table have MASTER_METRIC_ID as NULL, leading to incomplete linkage and potential issues in metric-level reporting.

Investigation revealed that:

The mapping from RAP_METRICS_PACK_MAPPING.METRICS_DISP to RAP_MASTER_METRIC_DETAILS.MASTER_METRIC_NAME is valid.

However, for a given metric name, there may be multiple entries in RAP_MASTER_METRIC_DETAILS due to multiple RISK_TYPE_IDs.

🛠️ Resolution Approach
1. Build a multi-table join to trace each RAP_METRICS_DETAILS entry:

RAP_METRICS_DETAILS → RAP (via RAP_ID)

RAP → MEET_INSTC (via RAP_INSTANCE_ID)

RAP_METRICS_DETAILS → RAP_METRICS_PACK_MAPPING (via RAP_METRICS_MAPPING_ID)

RAP_METRICS_PACK_MAPPING.METRICS_DISP is joined to RAP_MASTER_METRIC_DETAILS.MASTER_METRIC_NAME

2. Apply filtering condition:

Only consider MEET_INSTC.ACT_ON_RCRD = 'insert_rap_open'

Select the MASTER_METRIC_ID associated with the minimum RISK_TYPE_ID for each MASTER_METRIC_NAME, to resolve duplicates.

🧪 Preview Query (SELECT for validation)
sql
Copy
Edit
SELECT d.RAP_ID, d.RAP_METRICS_MAPPING_ID, p.METRICS_DISP, 
       m.MASTER_METRIC_ID, m.RISK_TYPE_ID, mi.MEET_INSTANCE_ID
FROM RAP_METRICS_DETAILS d
JOIN RAP r ON d.RAP_ID = r.RAP_ID
JOIN MEET_INSTC mi ON r.RAP_INSTANCE_ID = mi.MEET_INSTANCE_ID
JOIN RAP_METRICS_PACK_MAPPING p ON d.RAP_METRICS_MAPPING_ID = p.RAP_METRICS_MAPPING_ID
JOIN RAP_MASTER_METRIC_DETAILS m ON p.METRICS_DISP = m.MASTER_METRIC_NAME
WHERE d.MASTER_METRIC_ID IS NULL
  AND mi.ACT_ON_RCRD = 'insert_rap_open'
  AND m.RISK_TYPE_ID = (
      SELECT MIN(RISK_TYPE_ID)
      FROM RAP_MASTER_METRIC_DETAILS
      WHERE MASTER_METRIC_NAME = m.MASTER_METRIC_NAME
  );
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
📁 Script Location
📂 GitHub Repo: data-cleanup-utilities
📄 Script: backfill_master_metric_id.sql

🧪 Validation Done
Verified row counts before and after update.

Sampled and validated a subset of updated records.

Ensured RISK_TYPE_ID selection uses consistent logic across metric names.

