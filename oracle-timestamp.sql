Subject: Request to Validate Missing MASTER_METRIC_ID Fixes in RAP Tables

Hi Shubhadip,

We've completed the end-to-end cleanup for the missing MASTER_METRIC_ID mappings in the RAP tables. This includes both:

New inserts into RAP_MASTER_METRIC_DETAILS, and

Updates to RAP_METRICS_DETAILS.MASTER_METRIC_ID (including corrections where incorrect mappings existed earlier).

📌 This also covers cases where metric names had slight variations (e.g., '30+ days delinquency' not matching exactly across tables).

📎 Kindly test and validate the updated data in UAT.

📝 Detailed documentation with all queries and logic is available here:
👉 Confluence Page – Risk Type and Master Metric Cleanup

📅 Note: I will be on leave on the 6th and 7th of August, so please reach out before or after for any clarifications.

Thanks,
Chaitanya

Let me know if you'd like me to:

Generate a PDF/DOCX version of the Confluence page

Create a Confluence summary snippet for pasting

Help with an Outlook meeting/reminder setup before your leave








Ask ChatGPT


Great! Since the MASTER_METRIC_IDs are now updated, here’s a professional email draft to Shubhadip, along with:

📩 Email message

🔗 Confluence update note

🧾 Updated documentation with full query flow (top to bottom)

📩 Email to Shubhadip
Subject: Request to Test Master Metric ID Updates for Missing Metrics

Hi Shubhadip,

We have completed the backfill of MASTER_METRIC_IDs for all metrics in the RAP_METRICS_DETAILS table, including those that were previously missed due to mismatch in METRICS_DISP and METRICS_DISPLAY values.

All new metric names not found in RAP_MASTER_METRIC_DETAILS have now been inserted appropriately, and their IDs have been mapped back to the RAP_METRICS_DETAILS table.

✅ Request:
Please test and validate if all required metrics are now mapped with a valid MASTER_METRIC_ID, especially the ones that were missing earlier (e.g., 30+ days delinquency, Net Stable Funding Ratio (NSFR), etc).

🔗 You can find the detailed update steps and scripts in the following Confluence page:
RAP - Master Metric ID Mapping Fixes

Let us know if you observe any discrepancies.

Thanks,
Krishna Chaitanya

🔗 Confluence Page Update Header
Title: RAP - Master Metric ID Mapping Fixes
Last Updated: 5-Aug-2025

This document outlines the updated SQL scripts and logic used to:

Identify and insert missing master metrics

Update the MASTER_METRIC_ID in RAP_METRICS_DETAILS

Correct earlier misassignments

🧾 Updated SQL Documentation (Top to Bottom)
🔹 1. Identify Missing Master Metric Entries
sql
Copy
Edit
CREATE TABLE METRIC_MISSING_INSERT AS
SELECT DISTINCT d.METRICS_DISPLAY, r.RISK_TYPE_ID
FROM RAP_METRICS_DETAILS d
JOIN RAP_METRICS_PACK_MAPPING p ON d.RAP_METRICS_MAPPING_ID = p.RAP_METRICS_MAPPING_ID
JOIN RAP r ON d.RAP_ID = r.RAP_ID
LEFT JOIN RAP_MASTER_METRIC_DETAILS m 
  ON m.MASTER_METRIC_NAME = d.METRICS_DISPLAY AND m.RISK_TYPE_ID = r.RISK_TYPE_ID
WHERE TRIM(p.METRICS_DISP) <> TRIM(d.METRICS_DISPLAY)
  AND m.MASTER_METRIC_ID IS NULL;
🔹 2. Insert Missing Metrics (ID is auto-generated)
sql
Copy
Edit
INSERT INTO RAP_MASTER_METRIC_DETAILS (MASTER_METRIC_NAME, RISK_TYPE_ID)
SELECT DISTINCT METRICS_DISPLAY, RISK_TYPE_ID
FROM METRIC_MISSING_INSERT;
🔹 3. Update RAP_METRICS_DETAILS with Correct MASTER_METRIC_ID
sql
Copy
Edit
UPDATE RAP_METRICS_DETAILS d
SET MASTER_METRIC_ID = (
    SELECT m.MASTER_METRIC_ID
    FROM RAP_MASTER_METRIC_DETAILS m
    JOIN RAP r ON r.RAP_ID = d.RAP_ID
    WHERE m.MASTER_METRIC_NAME = d.METRICS_DISPLAY
      AND m.RISK_TYPE_ID = r.RISK_TYPE_ID
)
WHERE EXISTS (
    SELECT 1
    FROM RAP_MASTER_METRIC_DETAILS m
    JOIN RAP r ON r.RAP_ID = d.RAP_ID
    WHERE m.MASTER_METRIC_NAME = d.METRICS_DISPLAY
      AND m.RISK_TYPE_ID = r.RISK_TYPE_ID
);
🔹 4. Final Verification Query
sql
Copy
Edit
SELECT *
FROM RAP_METRICS_DETAILS
WHERE MASTER_METRIC_ID IS NULL;
