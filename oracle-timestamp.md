JIRA ticket description including RAP, RAP_RISK_TYPE, and RAP_MASTER_METRIC_DETAILS tables:

Title: Update RISK_TYPE_ID Values Across RAP-Related Tables Using Temporary Mapping

Description:

To support data correction and integrity across the RAP module, the RISK_TYPE_ID values need to be updated using a predefined mapping. This change impacts the following tables:

RAP_RISK_TYPE

RAP

RAP_MASTER_METRIC_DETAILS

Tasks Completed:

Created a temporary table TMP_RISK_TYPE_MAPPING to store old-to-new RISK_TYPE_ID mappings.

Inserted mapping data into the temporary table.

Executed MERGE statements to update RISK_TYPE_ID in:

RAP_RISK_TYPE

RAP

RAP_MASTER_METRIC_DETAILS

Handled and resolved the ORA-38104 error in the MERGE by excluding the updated column from the ON clause usage.

Verified successful update with 1:1 mapping consistency and data validation post-update.

Notes:

Scripts have been deployed and validated in DEV.

Refer to update_risk_type_id_mapping.sql in the GitHub repo data-fix-risk-type-id for implementation details and rollback steps if necessary.
