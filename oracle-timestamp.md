🔧 Task Summary: Risk Type ID Update Across RAP Tables
📌 Objective
Update RISK_TYPE_ID values using a predefined mapping across key RAP-related tables to ensure consistency and integrity.

🗂️ Affected Tables
RAP_RISK_TYPE

RAP

RAP_MASTER_METRIC_DETAILS

🛠️ Implementation Steps
Created temporary table TMP_RISK_TYPE_MAPPING:

Structure includes OLD_RISK_TYPE_ID and NEW_RISK_TYPE_ID.

Populated with the required mapping values.

Executed update queries using MERGE for each affected table:

Ensured proper aliasing to avoid ORA-38104 errors by keeping updated columns out of ON conditions.

Updates applied on:

RAP_RISK_TYPE

RAP

RAP_MASTER_METRIC_DETAILS

Validated updates:

Verified that all old RISK_TYPE_ID values were successfully updated to new ones.

Performed data checks post-update to ensure referential integrity.

✅ Outcome
Data correction completed successfully in DEV environment.

Scripts available in GitHub repo: data-fix-risk-type-id

📄 Script Name: update_risk_type_id_mapping.sql

Includes update logic and rollback guidance.
