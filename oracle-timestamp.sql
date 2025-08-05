 Likely Reasons Why MASTER_METRIC_ID Is Still NULL:
Metric name exists in RAP_METRICS_DETAILS but not inserted into RAP_MASTER_METRIC_DETAILS
→ Meaning it was missed in the insert step — usually due to RISK_TYPE_ID mismatch or detection issue.

The update query didn’t update RAP_METRICS_DETAILS properly, because:

Join on RISK_TYPE_ID didn’t match.

RAP_ID or RAP_METRICS_MAPPING_ID joins failed.

Case sensitivity / trailing spaces in metric names.

✅ Immediate Fix: Manual Debug Query for Missing Mappings
Let’s isolate what’s still missing:

sql
Copy
Edit
-- List metrics where MASTER_METRIC_ID is still NULL
SELECT d.METRICS_DISPLAY, d.RAP_ID, d.RAP_METRICS_MAPPING_ID, r.RISK_TYPE_ID
FROM RAP_METRICS_DETAILS d
JOIN RAP r ON d.RAP_ID = r.RAP_ID
LEFT JOIN RAP_MASTER_METRIC_DETAILS m
  ON m.MASTER_METRIC_NAME = d.METRICS_DISPLAY
 AND m.RISK_TYPE_ID = r.RISK_TYPE_ID
WHERE d.MASTER_METRIC_ID IS NULL
  AND m.MASTER_METRIC_ID IS NULL;
This will show you the exact missing metric names with their RISK_TYPE_ID. You can confirm:

Is RISK_TYPE_ID correct?

Is the metric name typo-free and clean?

✅ Fix Insertion & Mapping Again (Safe Retry)
sql
Copy
Edit
-- 1. Insert missing metric names again (ID is auto-generated)
INSERT INTO RAP_MASTER_METRIC_DETAILS (MASTER_METRIC_NAME, RISK_TYPE_ID)
SELECT DISTINCT d.METRICS_DISPLAY, r.RISK_TYPE_ID
FROM RAP_METRICS_DETAILS d
JOIN RAP r ON d.RAP_ID = r.RAP_ID
LEFT JOIN RAP_MASTER_METRIC_DETAILS m
  ON m.MASTER_METRIC_NAME = d.METRICS_DISPLAY
 AND m.RISK_TYPE_ID = r.RISK_TYPE_ID
WHERE d.MASTER_METRIC_ID IS NULL
  AND m.MASTER_METRIC_ID IS NULL;
sql
Copy
Edit
-- 2. Now update RAP_METRICS_DETAILS with correct IDs
UPDATE RAP_METRICS_DETAILS d
SET MASTER_METRIC_ID = (
    SELECT m.MASTER_METRIC_ID
    FROM RAP_MASTER_METRIC_DETAILS m
    JOIN RAP r ON d.RAP_ID = r.RAP_ID
    WHERE m.MASTER_METRIC_NAME = d.METRICS_DISPLAY
      AND m.RISK_TYPE_ID = r.RISK_TYPE_ID
)
WHERE MASTER_METRIC_ID IS NULL
  AND EXISTS (
    SELECT 1
    FROM RAP_MASTER_METRIC_DETAILS m
    JOIN RAP r ON d.RAP_ID = r.RAP_ID
    WHERE m.MASTER_METRIC_NAME = d.METRICS_DISPLAY
      AND m.RISK_TYPE_ID = r.RISK_TYPE_ID
);
✅ Final Check
sql
Copy
Edit
-- Verify if any are still NULL after retry
SELECT * FROM RAP_METRICS_DETAILS WHERE MASTER_METRIC_ID IS NULL;
If any remain, we’ll need to:

Check if RISK_TYPE_ID is null,

Or METRICS_DISPLAY has extra spaces/special characters.
