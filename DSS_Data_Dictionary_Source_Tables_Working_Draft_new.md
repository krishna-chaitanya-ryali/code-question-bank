# DSS Data Dictionary – Source Tables Working Draft

> Source: source tables/columns shown in the supplied Data Dictionary screenshots.
>
> Records: 57 source-column rows.
>
> IMPORTANT: Format, description, classification, masking, HBIM object and property-type values below are working assumptions based on the source column names. Validate with Ram/DSS before final submission.
>
> `SUPPLIER_KEY_TEXT` = Highly Restricted / Y and `SUPPLIER_NORMALISED_BUSINESS_NAME` = Internal / N are retained from the supplied screenshot.

| Table Name | Element name | Format | Real world description | Classification | Is the field to be masked? | HBIM Metadata Classification - Describes Object | Has Property Type |
| --- | --- | --- | --- | --- | --- | --- | --- |
| DA_GP_TPM_ENGAGEMENT_PERSONNEL | ENGAGEMENT_RISK_OWNER_EMAIL_ID | Email | Email address of the engagement risk owner | Highly Restricted | Y | Engagement Personnel | Yes |
| DA_GP_TPM_ENGAGEMENT_PERSONNEL | ENGAGEMENT_RISK_OWNER_EMPLOYEE_ID | Employee ID | Employee identifier of the engagement risk owner | Highly Restricted | Y | Engagement Personnel | Yes |
| DA_GP_TPM_ENGAGEMENT_PERSONNEL | TPM_EMAIL_ID | Email | Email identifier associated with the TPM record | Highly Restricted | Y | Engagement Personnel | Yes |
| DA_GP_TPM_ENGAGEMENT_PERSONNEL | TPM_EMPLOYEE_ID | Employee ID | Employee identifier associated with the TPM record | Highly Restricted | Y | Engagement Personnel | Yes |
| DA_GP_TPM_ENGAGEMENT_SUMMARY | ALTERNATIVE_SUPPLIERS | Text | Information identifying alternative suppliers | Internal | N | Supplier | Yes |
| DA_GP_TPM_ENGAGEMENT_SUMMARY | ENGAGEMENT_ID | Identifier | Unique identifier for the engagement | Internal | N | Engagement | Yes |
| DA_GP_TPM_ENGAGEMENT_SUMMARY | IMPORTANT_THIRD_PARTY_SERVICE_IND | Indicator | Indicator showing whether the service is an important third-party service | Internal | N | Engagement | Yes |
| DA_GP_TPM_ENGAGEMENT_SUMMARY | INBUILT_SERVICE_IND | Indicator | Indicator showing whether the service is an inbuilt service | Internal | N | Engagement | Yes |
| DA_GP_TPM_ENGAGEMENT_SUMMARY | PREFERRED_SUPPLIERS | Text | Information identifying preferred suppliers | Internal | N | Supplier | Yes |
| DA_GP_TPM_ENGAGEMENT_SUMMARY | SERVICE_DISCONTINUE_ON_SUPPLIER_EXIT_IND | Indicator | Indicator showing whether the service is discontinued when a supplier exits | Internal | N | Service | Yes |
| DA_GP_TPM_ENGAGEMENT_SUMMARY | SERVICE_ONBOARD_TIME | Time/Duration | Service onboarding time or duration | Internal | N | Service | Yes |
| DA_GP_TPM_ENGAGEMENT_SUMMARY | SURVEY_TASK_ID | Identifier | Identifier of the survey task | Internal | N | Task | Yes |
| DA_GP_TPM_ISSUES | ISSUE_DESC | Text | Description of the identified issue | Internal | N | Issue | Yes |
| DA_GP_TPM_ISSUES | ISSUE_NAME | Text | Name or title of the identified issue | Internal | N | Issue | Yes |
| DA_GP_TPM_ISSUES | ISSUE_RESPONSE_EXPLANATION_TEXT | Text | Explanation associated with the issue response | Internal | N | Issue | Yes |
| DA_GP_TPM_ISSUES | ISSUE_RESPONSE_NAME | Text | Name of the issue response | Internal | N | Issue | Yes |
| DA_GP_TPM_ISSUES | ISSUE_RISK_AREA_NAME | Text | Risk area associated with the issue | Internal | N | Issue | Yes |
| DA_GP_TPM_ISSUES | ISSUE_STATUS_NAME | Text | Current status of the issue | Internal | N | Issue | Yes |
| DA_GP_TPM_ISSUES | ISSUE_SUBSTATUS_NAME | Text | Sub-status of the issue | Internal | N | Issue | Yes |
| DA_GP_TPM_ISSUES | ISSUE_TYPE_NAME | Text | Type or category of the issue | Internal | N | Issue | Yes |
| DA_GP_TPM_ISSUES | RISK_ACCEPTANCE_VALIDITY_PERIOD_DATE | Date | Date defining the validity period of risk acceptance | Internal | N | Risk Acceptance | Yes |
| DA_GP_TPM_ISSUES | SME_ADVICE_NAME | Text | Name or reference associated with SME advice | Internal | Y | Issue / Personnel | Yes |
| DA_GP_TPM_TASKS | ISSUE_ID | Identifier | Identifier of the issue associated with the task | Internal | N | Issue | Yes |
| DA_GP_TPM_TASKS | TASK_DESC | Text | Description of the task | Internal | N | Task | Yes |
| DA_GP_TPM_TASKS | TASK_FREQUENCY_TYPE_NAME | Text | Frequency type of the task | Internal | N | Task | Yes |
| DA_GP_TPM_TASKS | TASK_ID | Identifier | Unique identifier of the task | Internal | N | Task | Yes |
| DA_GP_TPM_TASKS | TASK_NEXT_REVIEW_DT | Datetime | Date/time scheduled for the next task review | Internal | N | Task | Yes |
| DA_GP_TPM_TASKS | TASK_SHORT_DESC | Text | Short description of the task | Internal | N | Task | Yes |
| DA_GP_TPM_TASKS | TASK_STATUS_NAME | Text | Current status of the task | Internal | N | Task | Yes |
| DA_GP_TPM_TASKS | TASK_TYPE_NAME | Text | Type or category of the task | Internal | N | Task | Yes |
| DA_SPS_CONTRACTS_DETAIL | CONTRACTS_DETAIL_CONTRACT_DESC | Text | Description of the contract | Internal | N | Contract | Yes |
| DA_SPS_CONTRACTS_DETAIL | CONTRACTS_DETAIL_CONTRACT_ID | Identifier | Unique identifier of the contract | Internal | N | Contract | Yes |
| DA_SPS_CONTRACTS_DETAIL | CONTRACTS_DETAIL_CONTRACT_NAME | Text | Name of the contract | Internal | N | Contract | Yes |
| DA_SPS_CONTRACTS_DETAIL | CONTRACTS_DETAIL_CONTRACT_NUMBER | Contract Number | Business/reference number of the contract | Internal | N | Contract | Yes |
| DA_SPS_CONTRACTS_DETAIL | CONTRACTS_DETAIL_CONTRACT_STATUS_CODE | Code | Status code of the contract | Internal | N | Contract | Yes |
| DA_SPS_CONTRACTS_DETAIL | CONTRACTS_DETAIL_REGIONAL_COVERAGE_TEXT | Text | Regional coverage information for the contract | Internal | N | Contract | Yes |
| DA_SPS_CONTRACTS_DETAIL | CONTRACTS_DETAIL_SUPPLIER_NOTICE_PERIOD_DAYS_NUM | Number | Supplier notice period in days | Internal | N | Contract | Yes |
| DA_SPS_CONTRACTS_DETAIL | CONTRACTS_DETAIL_TERMINATED_TEXT | Text/Indicator | Text indicating whether the contract is terminated | Internal | N | Contract | Yes |
| DA_SPS_CONTRACTS_DETAIL | CONTRACTS_DETAIL_TERMINATION_CONVENIENCE_RIGHT_IND | Indicator | Indicator for the contract termination convenience right | Internal | N | Contract | Yes |
| DA_SPS_CONTRACTS_DETAIL | CONTRACTS_DETAIL_TERMINATION_NOTICE_LENGTH_TEXT | Text/Duration | Termination notice length information | Internal | N | Contract | Yes |
| DA_SPS_CONTRACTS_DETAIL | CONTRACTS_DETAIL_TERMINATION_NOTICE_TEXT | Text | Termination notice information | Internal | N | Contract | Yes |
| DA_SPS_CONTRACTS_DETAIL | CONTRACTS_DETAIL_TERMINATION_REASON_CODE | Code | Code representing the contract termination reason | Internal | N | Contract | Yes |
| DA_SPS_SUPPLIER_DETAIL | SUPPLIER_DNB_GLOBAL_ULTIMATE_BUSINESS_NAME | Text | Global ultimate business name of the supplier | Internal | N | Supplier | Yes |
| DA_SPS_SUPPLIER_DETAIL | SUPPLIER_KEY_TEXT | Identifier | Supplier key or reference identifier | Highly Restricted | Y | Supplier | Yes |
| DA_SPS_SUPPLIER_DETAIL | SUPPLIER_NORMALISED_BUSINESS_NAME | Text | Normalised business name of the supplier | Internal | N | Supplier | Yes |
| DA_SPS_TPM_ENGAGEMENT_DETAIL | ENGAGEMENT_DETAIL_APPLICATION_INSTANCE_ID | Identifier | Identifier of the application instance associated with the engagement | Internal | N | Application | Yes |
| DA_SPS_TPM_ENGAGEMENT_DETAIL | ENGAGEMENT_DETAIL_CATEGORY_NAME | Text | Category associated with the engagement detail | Internal | N | Engagement | Yes |
| DA_SPS_TPM_ENGAGEMENT_DETAIL | ENGAGEMENT_DETAIL_CATEGORY_NAME | Text | Category associated with the engagement detail | Internal | N | Engagement | Yes |
| DA_SPS_TPM_ENGAGEMENT_DETAIL | ENGAGEMENT_DETAIL_DESC | Text | Description of the engagement detail | Internal | N | Engagement | Yes |
| DA_SPS_TPM_ENGAGEMENT_DETAIL | ENGAGEMENT_DETAIL_DESC | Text | Description of the engagement detail | Internal | N | Engagement | Yes |
| DA_SPS_TPM_ENGAGEMENT_DETAIL | ENGAGEMENT_DETAIL_ENGAGEMENT_ID | Identifier | Unique identifier of the engagement | Internal | N | Engagement | Yes |
| DA_SPS_TPM_ENGAGEMENT_DETAIL | ENGAGEMENT_DETAIL_ENGAGEMENT_NAME | Text | Name of the engagement | Internal | N | Engagement | Yes |
| DA_SPS_TPM_ENGAGEMENT_DETAIL | ENGAGEMENT_DETAIL_ENGAGEMENT_STATUS_NAME | Text | Current status of the engagement | Internal | N | Engagement | Yes |
| DA_SPS_TPM_ENGAGEMENT_DETAIL | ENGAGEMENT_DETAIL_IMPORTANT_BUSINESS_SERVICE_NAME | Text | Name of the important business service associated with the engagement | Internal | N | Business Service | Yes |
| DA_SPS_TPM_ENGAGEMENT_DETAIL | ENGAGEMENT_DETAIL_INHERENT_RATING_TEXT | Text/Rating | Inherent risk rating associated with the engagement | Internal | N | Engagement | Yes |
| DA_SPS_TPM_ENGAGEMENT_DETAIL | ENGAGEMENT_DETAIL_IS_ENGAGEMENT_AN_IMPORTANT_BUSINESS_SERVICE_FLAG_TEXT | Indicator | Indicator showing whether the engagement is an important business service | Internal | N | Business Service | Yes |
| DA_SPS_TPM_ENGAGEMENT_DETAIL | ENGAGEMENT_DETAIL_MATERIALITY_ASSESSMENT_OUTCOME_TEXT | Text | Outcome of the engagement materiality assessment | Internal | N | Engagement | Yes |
