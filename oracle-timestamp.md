Risk Type ID Update Across RAP Tables + Prevent Future Duplicates

📌 Description:
We found duplicate RISK_TYPE_IDs in the RAP_RISK_TYPE table for the same RISK_HEADER values (e.g., "Credit Risk" having IDs: 4, 1443, 1444, 1445). These duplicates were impacting downstream tables like:

RAP

RAP_MASTER_METRIC_DETAILS

RAP_METRICS_DETAILS

To address this, we performed a data correction:

Identified the minimal RISK_TYPE_ID for each RISK_HEADER

Updated all dependent tables to use the correct minimal ID

Backfilled MASTER_METRIC_ID in RAP_METRICS_DETAILS wherever it was missing

Planned to delete redundant entries from RAP_RISK_TYPE
