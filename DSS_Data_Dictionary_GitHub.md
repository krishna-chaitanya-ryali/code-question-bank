# DSS Data Dictionary – Working Draft

> **Fields:** 385  
> **Purpose:** GitHub/Markdown copy-paste source for the DSS Excel Data Dictionary.  
> **Note:** Masking recommendation is intentionally blank for DSS review.

| Element name | Format | Real-world-description | Classification | Is the field to be masked? | Describes Object | Has Property Type | Masking recommendation |
| --- | --- | --- | --- | --- | --- | --- | --- |
| DOCUMENT_ID | INT | Unique identifier for the document metadata record. | Internal | No | Document | Identifier |  |
| WORKBOOK_NAME | VARCHAR(1000) | Name of the source workbook. | Internal | No | Document | Name |  |
| DOCUMENT_STATUS | VARCHAR(50) | Processing or lifecycle status of the document. | Internal | No | Document | Status / Indicator |  |
| DOCUMENT_ERROR | VARCHAR(MAX) | Error details recorded during document processing. | Confidential | No | Document | Attribute |  |
| SHEET_NAME | VARCHAR(500) | Name of the worksheet within the source workbook. | Internal | No | Document | Name |  |
| HEADER_ROW | INT | Row number containing the column headers in the source worksheet. | Internal | No | Document | Attribute |  |
| MATCHING_COLUMNS | VARCHAR(MAX) | Columns used to match source data to the target structure. | Internal | No | Document | Attribute |  |
| MATCHING_ROWS | VARCHAR(MAX) | Rows or row criteria identified for matching source data. | Internal | No | Document | Attribute |  |
| ENGAGEMENT_ID | VARCHAR(100) | Unique identifier of the related engagement. | Internal | No | Document | Identifier |  |
| SUPPLIER_NAME | VARCHAR(1000) | Name of the supplier or third party. | Internal | No | Document | Name |  |
| THIRD_PARTY_ID | VARCHAR(100) | Unique identifier of the related third party. | Internal | No | Document | Identifier |  |
| THIRD_PARTY_NAME | VARCHAR(1000) | Name of the related third party. | Internal | No | Document | Name |  |
| RUN_BATCH_ID | VARCHAR(36) | Unique identifier for the processing batch. | Internal | No | Document | Identifier |  |
| GENERATED_AT | DATETIME | Date and time when the record was generated. | Internal | No | Document | Date / Timestamp |  |
| TARGET_SHEET | VARCHAR(500) | Name of the target worksheet for the extracted data. | Internal | No | Document | Attribute |  |
| CREATED_AT | DATETIME | Date and time when the record was created. | Internal | No | Document | Date / Timestamp |  |
| EXTRACTED_PAYLOAD_JSON | NVARCHAR(MAX) | JSON payload containing extracted document data. | Confidential | No | Document | Attribute |  |
| ID | INT | Unique identifier for the record. | Internal | No | Business Continuity / BCM Record | Identifier |  |
| BCPU_ID | VARCHAR(100) | Identifier for the BCPU record. | Internal | No | Business Continuity / BCM Record | Identifier |  |
| BCPU_NAME | VARCHAR(500) | Name of the BCPU record. | Internal | No | Business Continuity / BCM Record | Name |  |
| BCPU_DESCRIPTION_TEXT | VARCHAR(MAX) | Business description of the BCPU. | Confidential | No | Business Continuity / BCM Record | Description / Text |  |
| BCPU_MAXIMUM_DISRUPTION_TIME_DESC | VARCHAR(200) | Description of the maximum acceptable disruption time. | Internal | No | Business Continuity / BCM Record | Description / Text |  |
| BCPU_CRITICALITY_STATUS_NAME | VARCHAR(100) | Criticality status assigned to the BCPU. | Internal | No | Business Continuity / BCM Record | Status / Indicator |  |
| BCPU_BIA_ID | VARCHAR(100) | Identifier of the related business impact assessment. | Internal | No | Business Continuity / BCM Record | Identifier |  |
| BCPU_BIA_NAME | VARCHAR(500) | Name of the related business impact assessment. | Internal | No | Business Continuity / BCM Record | Name |  |
| BCPU_BIA_DESC | VARCHAR(MAX) | Description of the related business impact assessment. | Internal | No | Business Continuity / BCM Record | Description / Text |  |
| BCM_STRATEGY_ID | VARCHAR(100) | Identifier of the business continuity strategy. | Internal | No | Business Continuity / BCM Record | Identifier |  |
| BCM_STRATEGY_NAME | VARCHAR(500) | Name of the business continuity strategy. | Internal | No | Business Continuity / BCM Record | Name |  |
| BCM_STRATEGY_DESC | VARCHAR(MAX) | Description of the business continuity strategy. | Confidential | No | Business Continuity / BCM Record | Description / Text |  |
| BCM_COMMENT_TEXT | VARCHAR(MAX) | Comments relating to the business continuity record. | Confidential | No | Business Continuity / BCM Record | Description / Text |  |
| BCM_OPERATING_PROCEDURE_DESC | VARCHAR(MAX) | Description of the business continuity operating procedure. | Confidential | No | Business Continuity / BCM Record | Description / Text |  |
| BCM_BUSINESS_APPLICATION_ID | VARCHAR(100) | Identifier of the related business application. | Internal | No | Business Continuity / BCM Record | Identifier |  |
| BCM_BUSINESS_APPLICATION_NAME | VARCHAR(500) | Name of the related business application. | Internal | No | Business Continuity / BCM Record | Name |  |
| BCM_ALTERNATE_BUSINESS_APPLICATION_ID | VARCHAR(100) | Identifier of the alternate business application. | Internal | No | Business Continuity / BCM Record | Identifier |  |
| BCM_ALTERNATE_BUSINESS_APPLICATION_NAME | VARCHAR(500) | Name of the alternate business application. | Internal | No | Business Continuity / BCM Record | Name |  |
| BCM_LEAD_NAME | VARCHAR(300) | Name of the business continuity lead. | Confidential | Yes | Business Continuity / BCM Record | Name |  |
| IMPORTANT_PROCESS | VARCHAR(100) | Indicator or description identifying an important business process. | Internal | No | IT Asset | Measure / Numeric Value |  |
| PROCESS_HANDOFF | VARCHAR(100) | Indicates the process handoff associated with the record. | Internal | No | IT Asset | Attribute |  |
| BUSINESS_APPLICATION_ID | VARCHAR(100) | Identifier of the business application. | Internal | No | IT Asset | Identifier |  |
| BUSINESS_APPLICATION_NAME | VARCHAR(500) | Name of the business application. | Internal | No | IT Asset | Name |  |
| EUC | BIT | Indicates whether the asset is an end-user computing asset. | Internal | No | IT Asset | Status / Indicator |  |
| DOMINO | BIT | Indicates whether the asset is associated with Domino technology. | Internal | No | IT Asset | Status / Indicator |  |
| HAS_HAD_AN_INCIDENT | VARCHAR(20) | Indicates whether the asset has had an incident. | Internal | No | IT Asset | Attribute |  |
| APP_STATUS | VARCHAR(100) | Current status of the application. | Internal | No | IT Asset | Status / Indicator |  |
| BIA_OVERALL_SCORE | VARCHAR(100) | Overall score from the business impact assessment. | Internal | No | IT Asset | Measure / Numeric Value |  |
| TRMF_RTO | DECIMAL(10,4) | Target recovery time objective used in the technology risk management framework. | Internal | No | IT Asset | Measure / Numeric Value |  |
| TRMF_RPO | DECIMAL(10,4) | Target recovery point objective used in the technology risk management framework. | Internal | No | IT Asset | Measure / Numeric Value |  |
| TRMF_AVAILABILITY_CORE | DECIMAL(10,4) | Core availability requirement recorded in the technology risk management framework. | Internal | No | IT Asset | Attribute |  |
| TRMF_AVAILABILITY_ENHANCED | DECIMAL(10,4) | Enhanced availability requirement recorded in the technology risk management framework. | Internal | No | IT Asset | Attribute |  |
| TRMF_ADDITIONAL_CAPACITY | DECIMAL(10,4) | Additional capacity requirement recorded in the technology risk management framework. | Internal | No | IT Asset | Attribute |  |
| OWNER | VARCHAR(300) | Name or identifier of the record owner. | Internal | No | IT Asset | Attribute |  |
| DISASTER_RECOVERY_STATUS | VARCHAR(100) | Current disaster recovery status. | Internal | No | IT Asset | Status / Indicator |  |
| STATUS | VARCHAR(100) | Current status of the record or asset. | Internal | No | IT Asset | Status / Indicator |  |
| RTO | INT | Recovery time objective. | Internal | No | IT Asset | Measure / Numeric Value |  |
| RPO | VARCHAR(100) | Recovery point objective. | Internal | No | IT Asset | Measure / Numeric Value |  |
| RTA | VARCHAR(50) | Recovery time assessment or target. | Internal | No | IT Asset | Measure / Numeric Value |  |
| DC_RTO_MINS | INT | Data-centre recovery time objective in minutes. | Internal | No | IT Asset | Measure / Numeric Value |  |
| DC_RPO_MINS | INT | Data-centre recovery point objective in minutes. | Internal | No | IT Asset | Measure / Numeric Value |  |
| LAST_COMPLETION | DATE | Date of the last completed activity or test. | Internal | No | IT Asset | Attribute |  |
| TESTING_DUE | DATE | Due date for the required test. | Internal | No | IT Asset | Attribute |  |
| SCHEDULED_TEST | DATE | Scheduled date for the test. | Internal | No | IT Asset | Attribute |  |
| ASSOCIATED_IBS | INT | Identifier of the associated important business service. | Internal | No | IT Asset | Attribute |  |
| LAST_12_MONTH_OUTAGE_COUNT | INT | Number of outages recorded during the last 12 months. | Internal | No | IT Asset | Measure / Numeric Value |  |
| SERVICE_INSTANCES | VARCHAR(200) | Service instance or instances associated with the record. | Internal | No | IT Asset | Attribute |  |
| SERVICE_TYPE | VARCHAR(100) | Type of service. | Internal | No | IT Asset | Type |  |
| LEGAL_ENTITY | VARCHAR(200) | Legal entity associated with the record. | Internal | No | IT Asset | Attribute |  |
| DIRECT_INDIRECT_MAPPING | VARCHAR(100) | Indicates whether the relationship is direct or indirect. | Internal | No | IT Asset | Attribute |  |
| SOURCE | VARCHAR(200) | Source system or source of the record. | Internal | No | IT Asset | Attribute |  |
| IMPORTANT_ASSET | VARCHAR(300) | Indicates or identifies whether the asset is important. | Internal | No | IT Asset | Measure / Numeric Value |  |
| AVAILABILITY | VARCHAR(100) | Availability requirement or status. | Internal | No | IT Asset | Attribute |  |
| ID | INT | Unique identifier for the record. | Internal | No | Business Service | Identifier |  |
| SERVICE_INSTANCES | VARCHAR(500) | Service instance or instances associated with the record. | Internal | No | Business Service | Attribute |  |
| LEGAL_ENTITY | VARCHAR(500) | Legal entity associated with the record. | Internal | No | Business Service | Attribute |  |
| OWNER | VARCHAR(300) | Name or identifier of the record owner. | Internal | No | Business Service | Attribute |  |
| CUSTOMER | VARCHAR(100) | Customer classification or indicator. | Internal | No | Business Service | Attribute |  |
| MARKET | INT | Market classification or identifier. | Internal | No | Business Service | Attribute |  |
| FIRM | INT | Firm classification or identifier. | Internal | No | Business Service | Attribute |  |
| TFD | INT | Time to functional disruption threshold. | Internal | No | Business Service | Attribute |  |
| SRTO | INT | Service recovery time objective threshold. | Internal | No | Business Service | Measure / Numeric Value |  |
| INCIDENTS_LAST_12M | INT | Number of incidents recorded during the last 12 months. | Internal | No | Business Service | Attribute |  |
| OUTAGES_LAST_12M | INT | Number of outages recorded during the last 12 months. | Internal | No | Business Service | Attribute |  |
| App ID | VARCHAR(50) | Business application identifier. | Internal | No | Technology / Application | Identifier |  |
| App Name | VARCHAR(500) | Business application name. | Internal | No | Technology / Application | Name |  |
| App Status | VARCHAR(100) | Current status of the application. | Internal | No | Technology / Application | Status / Indicator |  |
| Direct/Indirect Mapping | VARCHAR(100) | Indicates whether the relationship is direct or indirect. | Internal | No | Technology / Application | Attribute |  |
| Source | VARCHAR(200) | Source associated with the bso technology thresholds record. | Internal | No | Technology / Application | Attribute |  |
| Importance Justification | VARCHAR(500) | Reason for the importance classification. | Internal | No | Technology / Application | Description / Text |  |
| Demise Date | VARCHAR(50) | Date on which the application or service is planned to cease. | Internal | No | Technology / Application | Date / Timestamp |  |
| BIA Overall Score | VARCHAR(100) | Bia overall score associated with the bso technology thresholds record. | Internal | No | Technology / Application | Measure / Numeric Value |  |
| Owner | VARCHAR(255) | Owner associated with the bso technology thresholds record. | Internal | No | Technology / Application | Attribute |  |
| Tier | VARCHAR(50) | Technology or application service tier. | Internal | No | Technology / Application | Attribute |  |
| Compliance | VARCHAR(100) | Compliance status or classification. | Internal | No | Technology / Application | Status / Indicator |  |
| Status | VARCHAR(100) | Status associated with the bso technology thresholds record. | Internal | No | Technology / Application | Status / Indicator |  |
| RTO (hours) | DECIMAL(10,2) | Recovery time objective in hours. | Internal | No | Technology / Application | Measure / Numeric Value |  |
| RTA | VARCHAR(100) | Recovery time assessment or target. | Internal | No | Technology / Application | Measure / Numeric Value |  |
| Last Completion | VARCHAR(50) | Date of the last completed activity or test. | Internal | No | Technology / Application | Attribute |  |
| IT DR Testing Due | VARCHAR(50) | Due date for IT disaster recovery testing. | Internal | No | Technology / Application | Attribute |  |
| Scheduled DR Test | VARCHAR(50) | Scheduled date for the disaster recovery test. | Internal | No | Technology / Application | Attribute |  |
| Incidents | INT | Number of incidents. | Internal | No | Technology / Application | Attribute |  |
| Outages | INT | Number of outages. | Internal | No | Technology / Application | Attribute |  |
| Service Instance | INT | Identifier of the service instance. | Internal | No | Technology / Application | Attribute |  |
| RPO | VARCHAR(100) | Recovery point objective. | Internal | No | Technology / Application | Measure / Numeric Value |  |
| Target_availability | VARCHAR(10) | Target availability requirement. | Internal | No | Technology / Application | Attribute |  |
| ID | INT | Unique identifier for the record. | Internal | No | Business Service Engagement | Identifier |  |
| BUS_ARCH_OBJECT_TYPE_CODE | VARCHAR(100) | Business architecture object type code. | Internal | No | Business Service Engagement | Type |  |
| BUS_ARCH_OBJECT_NAME | VARCHAR(500) | Name of the business architecture object. | Internal | No | Business Service Engagement | Name |  |
| SERVICE_IMPORTANCE_IND | BIT | Indicator showing whether the service is important. | Internal | No | Business Service Engagement | Status / Indicator |  |
| BUS_ARCH_OBJECT_STATUS_NAME | VARCHAR(100) | Status of the business architecture object. | Internal | No | Business Service Engagement | Status / Indicator |  |
| ENGAGEMENT_ID | VARCHAR(100) | Unique identifier of the related engagement. | Internal | No | Business Service Engagement | Identifier |  |
| ENGAGEMENT_NAME | VARCHAR(500) | Name of the engagement. | Internal | No | Business Service Engagement | Name |  |
| ENGAGEMENT_STATUS_NAME | VARCHAR(100) | Status of the engagement. | Internal | No | Business Service Engagement | Status / Indicator |  |
| BUSINESS_APPLICATION_ID | VARCHAR(100) | Identifier of the business application. | Internal | No | Business Service Engagement | Identifier |  |
| business_application_id | VARCHAR(100) | Business application id associated with the bus service record. | Internal | No | Business Application | Identifier |  |
| business_application_name | VARCHAR(500) | Business application name associated with the bus service record. | Internal | No | Business Application | Name |  |
| business_application_active_ind | VARCHAR(20) | Indicator showing whether the business application is active. | Internal | No | Business Application | Status / Indicator |  |
| business_application_operational_status_code | VARCHAR(100) | Operational status code of the business application. | Internal | No | Business Application | Status / Indicator |  |
| business_application_built_type_name | VARCHAR(100) | Build type of the business application. | Internal | No | Business Application | Name |  |
| business_application_install_type_name | VARCHAR(100) | Installation type of the business application. | Internal | No | Business Application | Name |  |
| business_application_start_date | VARCHAR(50) | Start date of the business application. | Internal | No | Business Application | Date / Timestamp |  |
| business_application_demise_date | VARCHAR(50) | Date when the business application is planned to cease. | Internal | No | Business Application | Date / Timestamp |  |
| business_application_cloud_start_date | VARCHAR(50) | Date when the business application started on cloud infrastructure. | Internal | No | Business Application | Date / Timestamp |  |
| business_application_strategic_status_code | VARCHAR(100) | Strategic status code of the business application. | Internal | No | Business Application | Status / Indicator |  |
| business_application_bia_rating_code | VARCHAR(100) | Business impact assessment rating code. | Internal | No | Business Application | Code |  |
| business_application_business_criticality_code | VARCHAR(100) | Business criticality code of the application. | Internal | No | Business Application | Code |  |
| business_application_internal_users_quantity_text | VARCHAR(100) | Number or description of internal users of the application. | Internal | No | Business Application | Description / Text |  |
| business_application_external_users_quantity_text | VARCHAR(100) | Number or description of external users of the application. | Internal | No | Business Application | Description / Text |  |
| business_application_desc | VARCHAR(5000) | Business description of the application. | Confidential | No | Business Application | Description / Text |  |
| business_application_data_classification_code | VARCHAR(100) | Data classification code assigned to the application. | Internal | No | Business Application | Code |  |
| business_application_it_asset_categorisation_ind | VARCHAR(20) | Indicator showing whether the application is categorised as an IT asset. | Internal | No | Business Application | Status / Indicator |  |
| business_application_critical_asset_ind | VARCHAR(20) | Indicator showing whether the application is a critical asset. | Internal | No | Business Application | Status / Indicator |  |
| business_application_important_it_asset_ind | VARCHAR(20) | Indicator showing whether the application is an important IT asset. | Internal | No | Business Application | Status / Indicator |  |
| business_application_ibs_supporting_asset_ind | VARCHAR(20) | Indicator showing whether the application supports an important business service. | Internal | No | Business Application | Status / Indicator |  |
| business_application_it_service_owner_id | VARCHAR(100) | Identifier of the IT service owner. | Internal | No | Business Application | Identifier |  |
| business_application_it_service_owner_email_name | VARCHAR(300) | Email address or email name of the IT service owner. | Confidential | Yes | Business Application | Email Address |  |
| eim_application_instance_id | VARCHAR(100) | EIM identifier of the application instance. | Internal | No | Business Application | Identifier |  |
| business_application_id | VARCHAR(100) | Business application id associated with the bus service loader record. | Internal | No | Business Application | Identifier |  |
| business_application_name | VARCHAR(500) | Business application name associated with the bus service loader record. | Internal | No | Business Application | Name |  |
| business_application_active_ind | VARCHAR(20) | Indicator showing whether the business application is active. | Internal | No | Business Application | Status / Indicator |  |
| business_application_operational_status_code | VARCHAR(100) | Operational status code of the business application. | Internal | No | Business Application | Status / Indicator |  |
| business_application_built_type_name | VARCHAR(100) | Build type of the business application. | Internal | No | Business Application | Name |  |
| business_application_install_type_name | VARCHAR(100) | Installation type of the business application. | Internal | No | Business Application | Name |  |
| business_application_start_date | VARCHAR(50) | Start date of the business application. | Internal | No | Business Application | Date / Timestamp |  |
| business_application_demise_date | VARCHAR(50) | Date when the business application is planned to cease. | Internal | No | Business Application | Date / Timestamp |  |
| business_application_strategic_status_code | VARCHAR(100) | Strategic status code of the business application. | Internal | No | Business Application | Status / Indicator |  |
| business_application_bia_rating_code | VARCHAR(100) | Business impact assessment rating code. | Internal | No | Business Application | Code |  |
| business_application_business_criticality_code | VARCHAR(100) | Business criticality code of the application. | Internal | No | Business Application | Code |  |
| business_application_internal_users_quantity_text | VARCHAR(100) | Number or description of internal users of the application. | Internal | No | Business Application | Description / Text |  |
| business_application_external_users_quantity_text | VARCHAR(100) | Number or description of external users of the application. | Internal | No | Business Application | Description / Text |  |
| business_application_desc | VARCHAR(5000) | Business description of the application. | Confidential | No | Business Application | Description / Text |  |
| business_application_data_classification_code | VARCHAR(100) | Data classification code assigned to the application. | Internal | No | Business Application | Code |  |
| business_application_it_asset_categorisation_ind | VARCHAR(20) | Indicator showing whether the application is categorised as an IT asset. | Internal | No | Business Application | Status / Indicator |  |
| business_application_critical_asset_ind | VARCHAR(20) | Indicator showing whether the application is a critical asset. | Internal | No | Business Application | Status / Indicator |  |
| business_application_important_it_asset_ind | VARCHAR(20) | Indicator showing whether the application is an important IT asset. | Internal | No | Business Application | Status / Indicator |  |
| business_application_ibs_supporting_asset_ind | VARCHAR(20) | Indicator showing whether the application supports an important business service. | Internal | No | Business Application | Status / Indicator |  |
| business_application_it_service_owner_id | VARCHAR(100) | Identifier of the IT service owner. | Internal | No | Business Application | Identifier |  |
| business_application_it_service_owner_email_name | VARCHAR(300) | Email address or email name of the IT service owner. | Confidential | Yes | Business Application | Email Address |  |
| eim_application_instance_id | VARCHAR(100) | EIM identifier of the application instance. | Internal | No | Business Application | Identifier |  |
| U_APP_INSTANCE_ID | VARCHAR(100) | Application instance identifier. | Internal | No | Business Application | Identifier |  |
| U_EIM_APP_INSTANCE_NAME | VARCHAR(500) | EIM application instance name. | Internal | No | Business Application | Name |  |
| INSTALL_TYPE | VARCHAR(100) | Installation type of the application. | Internal | No | Business Application | Type |  |
| U_PRIMARY_SERVICE_TYPE | VARCHAR(100) | Primary service type. | Internal | No | Business Application | Type |  |
| U_SECONDARY_SERVICE_TYPE | VARCHAR(100) | Secondary service type. | Internal | No | Business Application | Type |  |
| BUSINESS_CRITICALITY | VARCHAR(100) | Business criticality classification. | Internal | No | Business Application | Attribute |  |
| contract_ref_num | VARCHAR(100) | Contract reference number. | Confidential | No | Contract | Attribute |  |
| contract_engagement_id | VARCHAR(100) | Identifier of the engagement associated with the contract. | Confidential | No | Contract | Identifier |  |
| contract_third_party_id | VARCHAR(100) | Identifier of the third party associated with the contract. | Confidential | No | Contract | Identifier |  |
| contract_id | VARCHAR(100) | Unique identifier of the contract. | Confidential | No | Contract | Identifier |  |
| contract_name | VARCHAR(500) | Name or title of the contract. | Confidential | No | Contract | Name |  |
| contract_desc | VARCHAR(1000) | Description of the contract. | Confidential | No | Contract | Description / Text |  |
| regional_coverage | VARCHAR(500) | Geographic or regional coverage of the contract. | Confidential | No | Contract | Attribute |  |
| contract_status | VARCHAR(100) | Current status of the contract. | Confidential | No | Contract | Status / Indicator |  |
| termination_notice | VARCHAR(500) | Termination notice terms recorded for the contract. | Confidential | No | Contract | Attribute |  |
| termination_notice_length | VARCHAR(100) | Length of the termination notice period. | Confidential | No | Contract | Attribute |  |
| terminated | VARCHAR(20) | Indicates whether the contract has been terminated. | Confidential | No | Contract | Status / Indicator |  |
| termination_reason | VARCHAR(200) | Reason recorded for contract termination. | Confidential | No | Contract | Attribute |  |
| supplier_notice_period_days | VARCHAR(50) | Supplier notice period in days. | Confidential | No | Contract | Attribute |  |
| termination_convenience_right | VARCHAR(20) | Indicates whether a termination-for-convenience right exists. | Confidential | No | Contract | Attribute |  |
| TPRO | VARCHAR(100) | Third-party risk or relationship classification associated with the contract. | Confidential | No | Contract | Attribute |  |
| id | BIGINT | Id associated with the dim tp eng contr busapp rel record. | Internal | No | Supplier / Engagement / Application Relationship | Identifier |  |
| supplier_dnb_global_ultimate_business_name | VARCHAR(500) | Dun & Bradstreet global ultimate business name for the supplier. | Internal | No | Supplier / Engagement / Application Relationship | Name |  |
| supplier_normalised_business_name | VARCHAR(500) | Normalised supplier business name. | Internal | No | Supplier / Engagement / Application Relationship | Name |  |
| supplier_key_text | VARCHAR(100) | Supplier key or reference value. | Internal | No | Supplier / Engagement / Application Relationship | Description / Text |  |
| engagement_detail_engagement_id | VARCHAR(100) | Identifier of the related engagement. | Internal | No | Supplier / Engagement / Application Relationship | Identifier |  |
| contracts_detail_contract_id | VARCHAR(100) | Identifier of the related contract. | Internal | No | Supplier / Engagement / Application Relationship | Identifier |  |
| contracts_detail_contract_number | VARCHAR(100) | Contract number. | Internal | No | Supplier / Engagement / Application Relationship | Attribute |  |
| supplier_dnb_global_ultimate_business_name_1 | VARCHAR(500) | Supplier dnb global ultimate business name 1 associated with the dim tp eng contr busapp rel record. | Internal | No | Supplier / Engagement / Application Relationship | Name |  |
| business_application_id | VARCHAR(100) | Business application id associated with the dim tp eng contr busapp rel record. | Internal | No | Supplier / Engagement / Application Relationship | Identifier |  |
| ENGAGEMENT_ID | VARCHAR(100) | Unique identifier of the related engagement. | Internal | No | Engagement | Identifier |  |
| SUPPLIER_NAME | VARCHAR(500) | Name of the supplier or third party. | Internal | No | Engagement | Name |  |
| MOST_STRINGENT_CUSTOMER | VARCHAR(100) | Most stringent customer threshold classification. | Internal | No | Engagement | Attribute |  |
| MOST_STRINGENT_MARKET | INT | Most stringent market threshold. | Internal | No | Engagement | Attribute |  |
| MOST_STRINGENT_FIRM | INT | Most stringent firm threshold. | Internal | No | Engagement | Attribute |  |
| TFD | INT | Time to functional disruption threshold. | Internal | No | Engagement | Attribute |  |
| min_of_4 | FLOAT | Minimum value calculated from the four threshold measures. | Internal | No | Engagement | Attribute |  |
| MOST_STRINGENT_SRTO | INT | Most stringent service recovery time objective. | Internal | No | Engagement | Measure / Numeric Value |  |
| TASK_ID | VARCHAR(100) | Identifier of the task. | Internal | No | Engagement Task | Identifier |  |
| ENGAGEMENT_ID | VARCHAR(100) | Unique identifier of the related engagement. | Internal | No | Engagement Task | Identifier |  |
| TASK_APPLICABLE_TYPE_NAME | VARCHAR(200) | Type to which the task applies. | Internal | No | Engagement Task | Name |  |
| ASSESSMENT_ID | VARCHAR(100) | Identifier of the related assessment. | Internal | No | Engagement Task | Identifier |  |
| ISSUE_ID | VARCHAR(100) | Identifier of the related issue. | Internal | No | Engagement Task | Identifier |  |
| TASK_STATUS_NAME | VARCHAR(200) | Current status of the task. | Internal | No | Engagement Task | Status / Indicator |  |
| TASK_SUBSTATUS_NAME | VARCHAR(200) | Current sub-status of the task. | Internal | No | Engagement Task | Status / Indicator |  |
| TASK_TYPE_NAME | VARCHAR(200) | Type of task. | Internal | No | Engagement Task | Name |  |
| TASK_SUBTYPE_NAME | VARCHAR(200) | Subtype of task. | Internal | No | Engagement Task | Name |  |
| TASK_SHORT_DESC | VARCHAR(MAX) | Short description of the task. | Confidential | No | Engagement Task | Description / Text |  |
| TASK_DESC | VARCHAR(MAX) | Detailed description of the task. | Confidential | No | Engagement Task | Description / Text |  |
| TASK_FREQUENCY_TYPE_NAME | VARCHAR(200) | Frequency at which the task is performed. | Internal | No | Engagement Task | Name |  |
| TASK_OUTCOME_NAME | VARCHAR(200) | Outcome associated with the task. | Internal | No | Engagement Task | Name |  |
| TASK_CLOSURE_CODE_NAME | VARCHAR(200) | Code indicating how the task was closed. | Internal | No | Engagement Task | Name |  |
| TASK_NEXT_REVIEW_DT | DATETIME2(7) | Date of the next task review. | Internal | No | Engagement Task | Date / Timestamp |  |
| TPSR_REPORT_EXPIRY_DT | DATETIME2(7) | Expiry date of the third-party service risk report. | Internal | No | Engagement Task | Date / Timestamp |  |
| engagement_id | VARCHAR(100) | Engagement id associated with the engagement record. | Internal | No | Engagement | Identifier |  |
| supplier_key_text | VARCHAR(100) | Supplier key or reference value. | Internal | No | Engagement | Description / Text |  |
| engagement_name | VARCHAR(500) | Engagement name associated with the engagement record. | Internal | No | Engagement | Name |  |
| engagement_desc | VARCHAR(1000) | Description of the engagement. | Confidential | No | Engagement | Description / Text |  |
| engagement_status | VARCHAR(100) | Current status of the engagement. | Internal | No | Engagement | Status / Indicator |  |
| category_name | VARCHAR(200) | Category assigned to the engagement. | Internal | No | Engagement | Name |  |
| important_third_party_service | VARCHAR(20) | Indicator or classification showing whether the engagement supports an important third-party service. | Internal | No | Engagement | Measure / Numeric Value |  |
| important_business_service | VARCHAR(300) | Identifier or name of the important business service associated with the engagement. | Internal | No | Engagement | Measure / Numeric Value |  |
| materiality_assessment | VARCHAR(200) | Materiality assessment for the engagement. | Internal | No | Engagement | Attribute |  |
| inherent_rating | VARCHAR(100) | Inherent risk rating for the engagement. | Internal | No | Engagement | Attribute |  |
| application_instance_id | VARCHAR(100) | Identifier of the application instance. | Internal | No | Engagement | Identifier |  |
| global_business_name | VARCHAR(300) | Global business name associated with the engagement. | Internal | No | Engagement | Name |  |
| type | VARCHAR(100) | Type of engagement. | Internal | No | Engagement | Type |  |
| tpem_employee_id | VARCHAR(100) | Employee identifier of the TPEM contact. | Confidential | Yes | Engagement | Employee Identifier |  |
| tpem_email | VARCHAR(200) | Email address of the TPEM contact. | Confidential | Yes | Engagement | Email Address |  |
| engagement_risk_owner_employee_id | VARCHAR(100) | Employee identifier of the engagement risk owner. | Confidential | Yes | Engagement | Employee Identifier |  |
| engagement_risk_owner_email | VARCHAR(200) | Email address of the engagement risk owner. | Confidential | Yes | Engagement | Email Address |  |
| engagement_id | VARCHAR(100) | Engagement id associated with the engagement level tech thresholds record. | Internal | No | Engagement | Identifier |  |
| stringent_rto | INT | Stringent recovery time objective. | Internal | No | Engagement | Measure / Numeric Value |  |
| stringent_availability | VARCHAR(100) | Stringent availability requirement. | Internal | No | Engagement | Attribute |  |
| stringent_rpo | VARCHAR(21) | Stringent recovery point objective. | Internal | No | Engagement | Measure / Numeric Value |  |
| third_party_id | VARCHAR(100) | Identifier of the third party. | Internal | No | Third-Party / Engagement / Contract Relationship | Identifier |  |
| engagement_id | VARCHAR(100) | Engagement id associated with the gtp eng contr rel record. | Internal | No | Third-Party / Engagement / Contract Relationship | Identifier |  |
| contract_ref_num | VARCHAR(100) | Contract reference number. | Internal | No | Third-Party / Engagement / Contract Relationship | Attribute |  |
| global_tp_id | VARCHAR(100) | Global third-party identifier. | Internal | No | Third-Party / Engagement / Contract Relationship | Identifier |  |
| relationship_type | VARCHAR(100) | Type of relationship between the referenced entities. | Internal | No | Third-Party / Engagement / Contract Relationship | Type |  |
| remarks | VARCHAR(500) | Additional remarks about the relationship. | Internal | No | Third-Party / Engagement / Contract Relationship | Description / Text |  |
| ID | INT | Unique identifier for the record. | Internal | No | Important Business Service | Identifier |  |
| IMPORTANT_BUSINESS_SERVICE | VARCHAR(500) | Name of the important business service. | Internal | No | Important Business Service | Measure / Numeric Value |  |
| BUSINESS_SERVICE_TYPE | VARCHAR(100) | Type of business service. | Internal | No | Important Business Service | Type |  |
| LEGAL_ENTITY | VARCHAR(100) | Legal entity associated with the record. | Internal | No | Important Business Service | Attribute |  |
| DIRECT_INDIRECT_MAPPING | VARCHAR(100) | Indicates whether the relationship is direct or indirect. | Internal | No | Important Business Service | Attribute |  |
| SOURCE | VARCHAR(200) | Source system or source of the record. | Internal | No | Important Business Service | Attribute |  |
| PROCESS_HANDOFF | VARCHAR(100) | Indicates the process handoff associated with the record. | Internal | No | Important Business Service | Attribute |  |
| ARIS_IMPORTANCE_MARKER | BIT | Indicator showing importance in ARIS. | Internal | No | Important Business Service | Measure / Numeric Value |  |
| APPLICATION_IMPORTANCE_MARKER | BIT | Indicator showing application importance. | Internal | No | Important Business Service | Measure / Numeric Value |  |
| OVERALL_IMPORTANCE_STATUS | VARCHAR(100) | Overall importance status. | Internal | No | Important Business Service | Status / Indicator |  |
| IMPORTANT_ASSET_JUSTIFICATION | VARCHAR(500) | Reason for the important asset classification. | Internal | No | Important Business Service | Description / Text |  |
| ENGAGEMENT_ID | VARCHAR(100) | Unique identifier of the related engagement. | Internal | No | Important Business Service | Identifier |  |
| ENGAGEMENT_NAME | VARCHAR(500) | Name of the engagement. | Internal | No | Important Business Service | Name |  |
| ENGAGEMENT_STATUS | VARCHAR(100) | Engagement status associated with the ibs complete data record. | Internal | No | Important Business Service | Status / Indicator |  |
| ENGAGEMENT_MANAGER | VARCHAR(300) | Name of the engagement manager. | Confidential | Yes | Important Business Service | Attribute |  |
| SUPPLIER_NAME | VARCHAR(500) | Name of the supplier or third party. | Internal | No | Important Business Service | Name |  |
| MATERIAL_ENGAGEMENT | BIT | Indicator showing whether the engagement is material. | Internal | No | Important Business Service | Attribute |  |
| INFORMATION_COMMUNICATION_TECHNOLOGY | BIT | Indicator showing whether information and communication technology is involved. | Internal | No | Important Business Service | Attribute |  |
| INFORMATION_COMMUNICATION_TECHNOLOGY_SERVICE_PROVIDER | VARCHAR(500) | Name of the ICT service provider. | Internal | No | Important Business Service | Attribute |  |
| ESTABLISHED_RTO | VARCHAR(50) | Established recovery time objective. | Internal | No | Important Business Service | Measure / Numeric Value |  |
| RESPONSE_OPTION | VARCHAR(100) | Selected response option. | Internal | No | Important Business Service | Attribute |  |
| BUSINESS_CONTINUITY | VARCHAR(100) | Business continuity status or classification. | Internal | No | Important Business Service | Attribute |  |
| CYBER_SECURITY | VARCHAR(100) | Cyber security status or classification. | Internal | No | Important Business Service | Attribute |  |
| APP_ID | VARCHAR(100) | Application identifier. | Internal | No | Important Business Service | Identifier |  |
| APP_NAME | VARCHAR(500) | Application name. | Internal | No | Important Business Service | Name |  |
| SERVICE_INSTANCES | VARCHAR(500) | Service instance or instances associated with the record. | Internal | No | Important Business Service | Attribute |  |
| OWNER | VARCHAR(300) | Name or identifier of the record owner. | Internal | No | Important Business Service | Attribute |  |
| CUSTOMER | VARCHAR(100) | Customer classification or indicator. | Internal | No | Important Business Service | Attribute |  |
| MARKET | INT | Market classification or identifier. | Internal | No | Important Business Service | Attribute |  |
| FIRM | INT | Firm classification or identifier. | Internal | No | Important Business Service | Attribute |  |
| TFD | INT | Time to functional disruption threshold. | Internal | No | Important Business Service | Attribute |  |
| SRTO | INT | Service recovery time objective threshold. | Internal | No | Important Business Service | Measure / Numeric Value |  |
| INCIDENTS_LAST_12M | INT | Number of incidents recorded during the last 12 months. | Internal | No | Important Business Service | Attribute |  |
| OUTAGES_LAST_12M | INT | Number of outages recorded during the last 12 months. | Internal | No | Important Business Service | Attribute |  |
| BUS_ARCH_OBJECT_TYPE_CODE | VARCHAR(100) | Business architecture object type code. | Internal | No | Premise / Property | Type |  |
| BUS_ARCH_OBJECT_ID | VARCHAR(100) | Bus arch object id associated with the ibs premise details record. | Internal | No | Premise / Property | Identifier |  |
| BUS_ARCH_OBJECT_NAME | VARCHAR(2000) | Name of the business architecture object. | Internal | No | Premise / Property | Name |  |
| BUS_ARCH_OWNER_NAME | VARCHAR(500) | Bus arch owner name associated with the ibs premise details record. | Confidential | Yes | Premise / Property | Name |  |
| BUS_ARCH_OWNER_EMAIL_TEXT | VARCHAR(500) | Bus arch owner email text associated with the ibs premise details record. | Confidential | Yes | Premise / Property | Email Address |  |
| BUS_ARCH_LEGAL_ENTITY_ID | VARCHAR(100) | Bus arch legal entity id associated with the ibs premise details record. | Internal | No | Premise / Property | Identifier |  |
| BUS_ARCH_LEGAL_ENTITY_NAME | VARCHAR(500) | Bus arch legal entity name associated with the ibs premise details record. | Internal | No | Premise / Property | Name |  |
| BUS_ARCH_LEGAL_ENTITY_CODE | VARCHAR(100) | Bus arch legal entity code associated with the ibs premise details record. | Internal | No | Premise / Property | Code |  |
| BUS_ARCH_LEGAL_ENTITY_REGION_CODE | VARCHAR(100) | Bus arch legal entity region code associated with the ibs premise details record. | Internal | No | Premise / Property | Code |  |
| SERVICE_IMPORTANCE_IND | BIT | Indicator showing whether the service is important. | Internal | No | Premise / Property | Status / Indicator |  |
| SERVICE_GROUP_IMPORTANT_IND | BIT | Service group important ind associated with the ibs premise details record. | Internal | No | Premise / Property | Status / Indicator |  |
| PROPERTY_ID | VARCHAR(100) | Property id associated with the ibs premise details record. | Internal | No | Premise / Property | Identifier |  |
| PROPERTY_NAME | VARCHAR(1000) | Property name associated with the ibs premise details record. | Internal | No | Premise / Property | Name |  |
| PROPERTY_COUNTRY_TERRITORY_ISO_CODE | VARCHAR(20) | Property country territory iso code associated with the ibs premise details record. | Internal | No | Premise / Property | Measure / Numeric Value |  |
| PROPERTY_COUNTRY_TERRITORY_ISO_NAME | VARCHAR(200) | Property country territory iso name associated with the ibs premise details record. | Internal | No | Premise / Property | Name |  |
| PROPERTY_REGION_CODE | VARCHAR(100) | Property region code associated with the ibs premise details record. | Internal | No | Premise / Property | Code |  |
| PROPERTY_REGION_NAME | VARCHAR(300) | Property region name associated with the ibs premise details record. | Internal | No | Premise / Property | Name |  |
| PROPERTY_CITY_NAME | VARCHAR(300) | Property city name associated with the ibs premise details record. | Internal | No | Premise / Property | Name |  |
| PROPERTY_ADDRESS_LINE1_TEXT | VARCHAR(2000) | Property address line1 text associated with the ibs premise details record. | Confidential | Yes | Premise / Property | Address |  |
| PROPERTY_ADDRESS_LINE2_TEXT | VARCHAR(2000) | Property address line2 text associated with the ibs premise details record. | Confidential | Yes | Premise / Property | Address |  |
| PROPERTY_DETAIL_PROPERTY_STATUS_NAME | VARCHAR(100) | Property detail property status name associated with the ibs premise details record. | Internal | No | Premise / Property | Status / Indicator |  |
| PROPERTY_DETAIL_PROPERTY_TYPE_NAME | VARCHAR(100) | Property detail property type name associated with the ibs premise details record. | Internal | No | Premise / Property | Name |  |
| REFERENCE_MAPPING_DIRECT_IND | BIT | Reference mapping direct ind associated with the ibs premise details record. | Internal | No | Premise / Property | Status / Indicator |  |
| REFERENCE_MAPPING_HANDOFF_IND | BIT | Reference mapping handoff ind associated with the ibs premise details record. | Internal | No | Premise / Property | Status / Indicator |  |
| ASSOCIATION_IMPORTANT_IND | BIT | Association important ind associated with the ibs premise details record. | Internal | No | Premise / Property | Status / Indicator |  |
| REPORT_DATE | DATE | Reporting date for the record. | Internal | No | Premise / Property | Date / Timestamp |  |
| ID | INT | Unique identifier for the record. | Internal | No | Important Business Service | Identifier |  |
| IMPORTANT_BUSINESS_SERVICE | VARCHAR(500) | Name of the important business service. | Internal | No | Important Business Service | Measure / Numeric Value |  |
| BUSINESS_SERVICE_TYPE | VARCHAR(100) | Type of business service. | Internal | No | Important Business Service | Type |  |
| LEGAL_ENTITY | VARCHAR(100) | Legal entity associated with the record. | Internal | No | Important Business Service | Attribute |  |
| DIRECT_INDIRECT_MAPPING | VARCHAR(100) | Indicates whether the relationship is direct or indirect. | Internal | No | Important Business Service | Attribute |  |
| SOURCE | VARCHAR(200) | Source system or source of the record. | Internal | No | Important Business Service | Attribute |  |
| PROCESS_HANDOFF | VARCHAR(100) | Indicates the process handoff associated with the record. | Internal | No | Important Business Service | Attribute |  |
| ARIS_IMPORTANCE_MARKER | BIT | Indicator showing importance in ARIS. | Internal | No | Important Business Service | Measure / Numeric Value |  |
| APPLICATION_IMPORTANCE_MARKER | BIT | Indicator showing application importance. | Internal | No | Important Business Service | Measure / Numeric Value |  |
| OVERALL_IMPORTANCE_STATUS | VARCHAR(100) | Overall importance status. | Internal | No | Important Business Service | Status / Indicator |  |
| IMPORTANT_ASSET_JUSTIFICATION | VARCHAR(500) | Reason for the important asset classification. | Internal | No | Important Business Service | Description / Text |  |
| ENGAGEMENT_ID | VARCHAR(100) | Unique identifier of the related engagement. | Internal | No | Important Business Service | Identifier |  |
| ENGAGEMENT_NAME | VARCHAR(500) | Name of the engagement. | Internal | No | Important Business Service | Name |  |
| ENGAGEMENT_STATUS | VARCHAR(100) | Engagement status associated with the important business service details record. | Internal | No | Important Business Service | Status / Indicator |  |
| ENGAGEMENT_MANAGER | VARCHAR(300) | Name of the engagement manager. | Confidential | Yes | Important Business Service | Attribute |  |
| SUPPLIER_NAME | VARCHAR(500) | Name of the supplier or third party. | Internal | No | Important Business Service | Name |  |
| MATERIAL_ENGAGEMENT | BIT | Indicator showing whether the engagement is material. | Internal | No | Important Business Service | Attribute |  |
| INFORMATION_COMMUNICATION_TECHNOLOGY | BIT | Indicator showing whether information and communication technology is involved. | Internal | No | Important Business Service | Attribute |  |
| INFORMATION_COMMUNICATION_TECHNOLOGY_SERVICE_PROVIDER | VARCHAR(500) | Name of the ICT service provider. | Internal | No | Important Business Service | Attribute |  |
| ESTABLISHED_RTO | VARCHAR(50) | Established recovery time objective. | Internal | No | Important Business Service | Measure / Numeric Value |  |
| RESPONSE_OPTION | VARCHAR(100) | Selected response option. | Internal | No | Important Business Service | Attribute |  |
| BUSINESS_CONTINUITY | VARCHAR(100) | Business continuity status or classification. | Internal | No | Important Business Service | Attribute |  |
| CYBER_SECURITY | VARCHAR(100) | Cyber security status or classification. | Internal | No | Important Business Service | Attribute |  |
| APP_ID | VARCHAR(100) | Application identifier. | Internal | No | Important Business Service | Identifier |  |
| APP_NAME | VARCHAR(500) | Application name. | Internal | No | Important Business Service | Name |  |
| BUSINESS_APPLICATION_ID | VARCHAR(100) | Identifier of the business application. | Internal | No | Business Application Resilience / DR Record | Identifier |  |
| BUSINESS_APPLICATION_NAME | VARCHAR(500) | Name of the business application. | Internal | No | Business Application Resilience / DR Record | Name |  |
| BUSINESS_APPLICATION_RESILIENCE_RAG_NAME | VARCHAR(100) | Business application resilience RAG status. | Internal | No | Business Application Resilience / DR Record | Name |  |
| BUSINESS_APPLICATION_RESILIENCE_STATUS_NAME | VARCHAR(200) | Business application resilience status. | Internal | No | Business Application Resilience / DR Record | Status / Indicator |  |
| BUSINESS_APPLICATION_DISASTER_RECOVERY_REQUIREMENT_STATUS_NAME | VARCHAR(200) | Status of the disaster recovery requirement for the application. | Internal | No | Business Application Resilience / DR Record | Status / Indicator |  |
| DISASTER_RECOVERY_TEST_LAST_COMPLETION_DATE | DATE | Date of the last completed disaster recovery test. | Internal | No | Business Application Resilience / DR Record | Date / Timestamp |  |
| BUSINESS_APPLICATION_RESILIENCE_RAG_NAME_1 | VARCHAR(100) | Business application resilience RAG status from the related source or assessment. | Internal | No | Business Application Resilience / DR Record | Name |  |
| BUSINESS_APPLICATION_RESILIENCE_STATUS_NAME_1 | VARCHAR(200) | Business application resilience status from the related source or assessment. | Internal | No | Business Application Resilience / DR Record | Status / Indicator |  |
| BUSINESS_APPLICATION_LAST_DR_TEST_REVIEW_DATE | DATE | Date of the last disaster recovery test review. | Internal | No | Business Application Resilience / DR Record | Date / Timestamp |  |
| DISASTER_RECOVERY_TEST_LAST_COMPLETION_DATE_1 | DATE | Date of the last completed disaster recovery test from the related source or assessment. | Internal | No | Business Application Resilience / DR Record | Date / Timestamp |  |
| DISASTER_RECOVERY_TEST_SCHEDULED_TEST_DATE | DATE | Scheduled date for the disaster recovery test. | Internal | No | Business Application Resilience / DR Record | Date / Timestamp |  |
| DISASTER_RECOVERY_TEST_DUE_DATE | DATE | Due date for the disaster recovery test. | Internal | No | Business Application Resilience / DR Record | Date / Timestamp |  |
| BUSINESS_APPLICATION_RECOVERY_POINT_OBJECTIVE_NAME | VARCHAR(200) | Recovery point objective for the business application. | Internal | No | Business Application Resilience / DR Record | Name |  |
| BUSINESS_APPLICATION_RECOVERY_TIME_OBJECTIVE_NAME | VARCHAR(200) | Recovery time objective for the business application. | Internal | No | Business Application Resilience / DR Record | Name |  |
| ARIS_SERVICE_ID | VARCHAR(100) | ARIS identifier of the service. | Internal | No | Service Tolerance | Identifier |  |
| SERVICE_NAME | VARCHAR(500) | Name of the service. | Internal | No | Service Tolerance | Name |  |
| SERVICE_IMPORTANCE_CODE | VARCHAR(50) | Code representing service importance. | Internal | No | Service Tolerance | Measure / Numeric Value |  |
| ARIS_SERVICE_NAME | VARCHAR(500) | ARIS name of the service. | Internal | No | Service Tolerance | Name |  |
| ARIS_SERVICE_OWNER_NAME | VARCHAR(500) | Name of the ARIS service owner. | Confidential | Yes | Service Tolerance | Name |  |
| ARIS_SERVICE_OWNER_EMAIL_TEXT | VARCHAR(500) | Email address of the ARIS service owner. | Confidential | Yes | Service Tolerance | Email Address |  |
| ARIS_SERVICE_EXECUTION_LEGAL_ENTITY_ID | VARCHAR(100) | Identifier of the legal entity executing the service. | Internal | No | Service Tolerance | Identifier |  |
| ARIS_SERVICE_EXECUTION_LEGAL_ENTITY_NAME | VARCHAR(500) | Name of the legal entity executing the service. | Internal | No | Service Tolerance | Name |  |
| ARIS_SERVICE_EXECUTION_COUNTRY_NAME | VARCHAR(200) | Country where the service is executed. | Internal | No | Service Tolerance | Name |  |
| ARIS_SERVICE_EXECUTION_COUNTRY_CODE | VARCHAR(20) | Country code where the service is executed. | Internal | No | Service Tolerance | Measure / Numeric Value |  |
| ARIS_SERVICE_TYPE_CODE | VARCHAR(100) | Code representing the service type. | Internal | No | Service Tolerance | Type |  |
| ARIS_SERVICE_IMPORTANCE_IND | BIT | Indicator showing whether the ARIS service is important. | Internal | No | Service Tolerance | Status / Indicator |  |
| DOCUMENT_TYPE_NAME | VARCHAR(100) | Type of service or supporting document. | Internal | No | Service Tolerance | Name |  |
| DOCUMENT_APPROVAL_DATE | DATE | Date on which the document was approved. | Internal | No | Service Tolerance | Date / Timestamp |  |
| DOCUMENT_VERSION_NUM | NUMERIC(10,2) | Version number of the document. | Internal | No | Service Tolerance | Attribute |  |
| IMPACT_TOLERANCE_THRESHOLD_CUSTOMER_TEXT | VARCHAR(100) | Customer impact tolerance threshold description. | Internal | No | Service Tolerance | Description / Text |  |
| IMPACT_TOLERANCE_THRESHOLD_CUSTOMER_CODE | VARCHAR(100) | Code for the customer impact tolerance threshold. | Internal | No | Service Tolerance | Code |  |
| IMPACT_TOLERANCE_THRESHOLD_CUSTOMER_DESC | VARCHAR(200) | Detailed customer impact tolerance threshold description. | Internal | No | Service Tolerance | Description / Text |  |
| IMPACT_TOLERANCE_THRESHOLD_CUSTOMER_HOURS_NUM | NUMERIC(18,2) | Customer impact tolerance threshold in hours. | Internal | No | Service Tolerance | Measure / Numeric Value |  |
| IMPACT_TOLERANCE_THRESHOLD_CUSTOMER_APPLICABLE_IND | BIT | Indicates whether the customer impact tolerance threshold applies. | Internal | No | Service Tolerance | Status / Indicator |  |
| IMPACT_TOLERANCE_THRESHOLD_FIRM_TEXT | VARCHAR(100) | Firm impact tolerance threshold description. | Internal | No | Service Tolerance | Description / Text |  |
| IMPACT_TOLERANCE_THRESHOLD_FIRM_CODE | VARCHAR(100) | Code for the firm impact tolerance threshold. | Internal | No | Service Tolerance | Code |  |
| IMPACT_TOLERANCE_THRESHOLD_FIRM_DESC | VARCHAR(200) | Detailed firm impact tolerance threshold description. | Internal | No | Service Tolerance | Description / Text |  |
| IMPACT_TOLERANCE_THRESHOLD_FIRM_HOURS_NUM | NUMERIC(18,2) | Firm impact tolerance threshold in hours. | Internal | No | Service Tolerance | Measure / Numeric Value |  |
| IMPACT_TOLERANCE_THRESHOLD_FIRM_APPLICABLE_IND | BIT | Indicates whether the firm impact tolerance threshold applies. | Internal | No | Service Tolerance | Status / Indicator |  |
| IMPACT_TOLERANCE_THRESHOLD_MARKET_TEXT | VARCHAR(100) | Market impact tolerance threshold description. | Internal | No | Service Tolerance | Description / Text |  |
| IMPACT_TOLERANCE_THRESHOLD_MARKET_CODE | VARCHAR(100) | Code for the market impact tolerance threshold. | Internal | No | Service Tolerance | Code |  |
| IMPACT_TOLERANCE_THRESHOLD_MARKET_DESC | VARCHAR(200) | Detailed market impact tolerance threshold description. | Internal | No | Service Tolerance | Description / Text |  |
| IMPACT_TOLERANCE_THRESHOLD_MARKET_HOURS_NUM | NUMERIC(18,2) | Market impact tolerance threshold in hours. | Internal | No | Service Tolerance | Measure / Numeric Value |  |
| IMPACT_TOLERANCE_THRESHOLD_MARKET_APPLICABLE_IND | BIT | Indicates whether the market impact tolerance threshold applies. | Internal | No | Service Tolerance | Status / Indicator |  |
| SERVICE_RECOVERY_TIME_OBJECTIVE_TEXT | VARCHAR(100) | Service recovery time objective description. | Internal | No | Service Tolerance | Description / Text |  |
| SERVICE_RECOVERY_TIME_OBJECTIVE_CODE | VARCHAR(100) | Code for the service recovery time objective. | Internal | No | Service Tolerance | Code |  |
| SERVICE_RECOVERY_TIME_OBJECTIVE_DESC | VARCHAR(200) | Detailed service recovery time objective description. | Internal | No | Service Tolerance | Description / Text |  |
| SERVICE_RECOVERY_TIME_OBJECTIVE_NUM | NUMERIC(18,2) | Service recovery time objective in numeric form. | Internal | No | Service Tolerance | Attribute |  |
| SERVICE_RECOVERY_TIME_OBJECTIVE_APPLICABLE_IND | BIT | Indicates whether the service recovery time objective applies. | Internal | No | Service Tolerance | Status / Indicator |  |
| CRITICAL_OPERATION_INSTANCE_NAME | VARCHAR(500) | Name of the critical operation instance. | Internal | No | Service Tolerance | Name |  |
| ARIS_CRITICAL_OPERATION_INSTANCE_ID | VARCHAR(100) | ARIS identifier of the critical operation instance. | Internal | No | Service Tolerance | Identifier |  |
| ARIS_CRITICAL_OPERATION_INSTANCE_NAME | VARCHAR(500) | ARIS name of the critical operation instance. | Internal | No | Service Tolerance | Name |  |
| CRITICAL_OPERATION_DISRUPTION_TOLERANCE_TEXT | VARCHAR(100) | Critical operation disruption tolerance description. | Internal | No | Service Tolerance | Description / Text |  |
| CRITICAL_OPERATION_DISRUPTION_TOLERANCE_CODE | VARCHAR(100) | Code for the critical operation disruption tolerance. | Internal | No | Service Tolerance | Code |  |
| CRITICAL_OPERATION_DISRUPTION_TOLERANCE_DESC | VARCHAR(200) | Detailed critical operation disruption tolerance description. | Internal | No | Service Tolerance | Description / Text |  |
| CRITICAL_OPERATION_DISRUPTION_TOLERANCE_NUM | NUMERIC(18,2) | Critical operation disruption tolerance in numeric form. | Internal | No | Service Tolerance | Attribute |  |
| CRITICAL_OPERATION_DISRUPTION_TOLERANCE_APPLICABLE_IND | BIT | Indicates whether the critical operation disruption tolerance applies. | Internal | No | Service Tolerance | Status / Indicator |  |
| REPORT_DATE | DATE | Reporting date for the record. | Internal | No | Service Tolerance | Date / Timestamp |  |
| third_party_id | VARCHAR(100) | Identifier of the third party. | Internal | No | Third Party / Supplier | Identifier |  |
| global_tp_id | VARCHAR(100) | Global third-party identifier. | Internal | No | Third Party / Supplier | Identifier |  |
| name | VARCHAR(300) | Name of the third party or supplier. | Internal | No | Third Party / Supplier | Name |  |
| status | VARCHAR(100) | Current status of the third party. | Internal | No | Third Party / Supplier | Status / Indicator |  |
