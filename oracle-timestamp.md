📝 Confluence Page: DateTime Standardization Across RAP Application
📌 Project: RAP Incremental Dataload
Owner: R Krishna Chaitanya
Start Date: [Insert actual start date]
UAT Deployment Date: 28-July-2025
Environment: DEV / UAT
Status: ✅ Completed and deployed to UAT
🔍 Objective
Standardize all datetime fields across the RAP application by:

Converting all CREAT_DT and UPDT_DT columns from VARCHAR to TIMESTAMP(6)

Unifying all date/time parsing logic in the Python backend

Adding default value support and triggers for consistent auditing

📂 Scope of Work
1. Tables Affected (22 total, including but not limited to):
MAP_RAP_USER_ROLE

MEET_INSTC

METRIC_ACCESS

RAP

RAP_METRICS_PACK_MAPPING

RAP_METRICS_DETAILS

[Add others as needed]

2. Development Activities
Cleaned and analyzed existing date formats (DD-MON-YY, DD-MM-YYYY HH24:MI:SS, etc.)

Converted to TIMESTAMP(6) columns using fallback logic

Implemented fallback conversion using PL/SQL blocks

Added new temporary columns for transition: CREAT_DT_TMP, UPDT_DT_TMP

Backfilled values using multiple format logic

Renamed TMP columns back to actual fields post validation

3. Triggers and Defaults
Created BEFORE INSERT/UPDATE triggers to auto-set CREAT_DT and UPDT_DT

Added SYSTIMESTAMP default in DB wherever supported

For hard delete tables, created *_DELETED backup tables and triggers to archive records with deletion timestamps

4. Code Changes
Updated Python logic in all CRUD operations to support timestamp handling

Modified insert/update queries to handle default or explicit timestamp values

Removed any manual conversions in backend logic

5. Testing Performed
✅ Unit tested with malformed and valid dates

✅ Verified all triggers and default value behaviors

✅ Validated data in DEV after each conversion step

✅ Performed full testing in UAT before deployment

✅ Handled edge cases for values like 0, null, incorrect months, etc.

6. Challenges & Resolutions
Issue	Resolution
Mixed formats in VARCHAR columns	Used fallback conversion PL/SQL block
ORA-01843, ORA-01830, ORA-00933 errors	Handled with conditional logic and validations
Timezone issues in triggers	Confirmed DB timezone; used SYSTIMESTAMP consistently
DBA delays in Dev	Raised with team lead to expedite support

🚀 Deployment Details
Environment	Deployment Status	DB Updated	Code Updated
DEV	✅ Completed	✅ Yes	✅ Yes
UAT	✅ Completed	✅ Yes	✅ Yes
PROD	🔜 Planned	🔜 Pending	🔜 Pending

🧪 Sign-Off Plan
Each team member is requested to:

Test their individual modules/flows in UAT

Validate all insert/update/delete operations

Confirm date/time fields are updated correctly

Update sign-off status in the table below

Team Member	Module	Sign-Off Status	Comments

📌 Confluence Attachments
🔗 GitHub Branch: timestamp-standardization-task

📄 PL/SQL Scripts: [Attach as downloadable or link to repo]

📑 Test Scenarios Executed: [Attach test doc or paste]

📷 Screenshots of issues resolved: [If applicable]

📣 Final Notes
Any further datetime-related development should follow the new standard

Common tables were impacted — all consumers should pull the latest code and sync with DB changes

Please ensure Dev → UAT → Prod DB sequence is followed for future changes

Let me know if you want this turned into a downloadable doc or inserted directly into a real Confluence page via REST API or markdown.


