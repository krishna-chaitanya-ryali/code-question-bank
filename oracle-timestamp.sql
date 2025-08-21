Update on Backfilling Missing Master Metric IDs

Hi Team,

I have attached three screenshots that detail the step-by-step procedure I’m following to backfill the missing MASTER_METRIC_IDs and the challenges we faced while resolving the NULL values. The document outlines:

Duplicate RISK_TYPE_ID cleanup and dependency updates

Removal of duplicate MASTER_METRIC_ID entries in RAP_MASTER_METRIC_DETAILS

The backfilling approach for handling missing MASTER_METRIC_IDs


Additional Notes:

1. When a parent metric ID is changed, there is a possibility of having multiple MASTER_METRIC_IDs associated with that same metric. This needs to be accounted for during cleanup.


2. We are not modifying any existing data or IDs that are already associated in production. While there might be discrepancies in historical data, those are out of scope. Our focus here is only on refilling the missing MASTER_METRIC_IDs to restore referential integrity.



Please review the attached screenshots for the detailed workflow and let me know if you have any questions or suggestions.

Thanks,
[Your Name]
