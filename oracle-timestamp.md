Identify and clean up duplicate entries in the RAP_RISK_TYPE table.

Ensure consistent RISK_TYPE_ID values across multiple related tables.

Backfill missing MASTER_METRIC_IDs in the RAP_METRICS_DETAILS table based on other relationships.

✅ 1. Create a Temporary Table for Risk Type Mapping
sql
Copy
Edit
CREATE GLOBAL TEMPORARY TABLE RISK_TYPE_ID_MAPPING (
    OLD_RISK_TYPE_ID NUMBER,
    NEW_RISK_TYPE_ID NUMBER,
    RISK_HEADER      VARCHAR2(200)
) ON COMMIT PRESERVE ROWS;
What this does:

Creates a temporary table to store a mapping from old (duplicate) RISK_TYPE_IDs to their new, correct (lowest) IDs.

This table exists only for your session, and it won’t keep data after you log out.

ON COMMIT PRESERVE ROWS means the data won’t disappear until you explicitly delete it or end your session.

✅ 2. Find Duplicate RISK_TYPE_IDs with Same RISK_HEADER
sql
Copy
Edit
WITH duplicates AS (
    SELECT RISK_HEADER, RISK_TYPE_ID,
           MIN(RISK_TYPE_ID) OVER (PARTITION BY RISK_HEADER) AS NEW_RISK_TYPE_ID
    FROM RAP_RISK_TYPE
)
SELECT DISTINCT RISK_HEADER, RISK_TYPE_ID AS OLD_RISK_TYPE_ID, NEW_RISK_TYPE_ID
FROM duplicates
WHERE RISK_TYPE_ID != NEW_RISK_TYPE_ID;
What this does:

Finds duplicate RISK_TYPE_IDs that belong to the same RISK_HEADER.

For example, if "Credit Risk" has 4 IDs (1443, 1444, 1445, 4), this query will identify 4 as the correct one (since it’s the smallest ID).

All other IDs for "Credit Risk" will be marked as duplicates (old IDs).

✅ 3. Insert Mappings into the Temporary Table
sql
Copy
Edit
INSERT INTO RISK_TYPE_ID_MAPPING (RISK_HEADER, OLD_RISK_TYPE_ID, NEW_RISK_TYPE_ID)
WITH duplicates AS (
    SELECT RISK_HEADER, RISK_TYPE_ID,
           MIN(RISK_TYPE_ID) OVER (PARTITION BY RISK_HEADER) AS NEW_RISK_TYPE_ID
    FROM RAP_RISK_TYPE
)
SELECT RISK_HEADER, RISK_TYPE_ID, NEW_RISK_TYPE_ID
FROM duplicates
WHERE RISK_TYPE_ID != NEW_RISK_TYPE_ID;
What this does:

Saves all duplicate-to-original ID mappings into the temporary table RISK_TYPE_ID_MAPPING.

This table will now tell us:

OLD_RISK_TYPE_ID = 1444

NEW_RISK_TYPE_ID = 4

RISK_HEADER = Credit Risk

✅ 4. Update RAP Table with Correct Risk Type IDs
sql
Copy
Edit
UPDATE RAP r
SET r.RISK_TYPE_ID = (
    SELECT m.NEW_RISK_TYPE_ID
    FROM RISK_TYPE_ID_MAPPING m
    WHERE m.OLD_RISK_TYPE_ID = r.RISK_TYPE_ID
)
WHERE EXISTS (
    SELECT 1
    FROM RISK_TYPE_ID_MAPPING m
    WHERE m.OLD_RISK_TYPE_ID = r.RISK_TYPE_ID
);
What this does:

Updates the RISK_TYPE_ID in the RAP table wherever it has a duplicate ID.

It replaces it with the correct one from the mapping table.

✅ 5. Update RAP_MASTER_METRIC_DETAILS Table
sql
Copy
Edit
UPDATE RAP_MASTER_METRIC_DETAILS rmd
SET rmd.RISK_TYPE_ID = (
    SELECT m.NEW_RISK_TYPE_ID
    FROM RISK_TYPE_ID_MAPPING m
    WHERE m.OLD_RISK_TYPE_ID = rmd.RISK_TYPE_ID
)
WHERE EXISTS (
    SELECT 1
    FROM RISK_TYPE_ID_MAPPING m
    WHERE m.OLD_RISK_TYPE_ID = rmd.RISK_TYPE_ID
);
What this does:

Same as the above update, but applies to the RAP_MASTER_METRIC_DETAILS table.

✅ 6. Delete Duplicate Records from RAP_RISK_TYPE
sql
Copy
Edit
DELETE FROM RAP_RISK_TYPE
WHERE RISK_TYPE_ID IN (
    SELECT OLD_RISK_TYPE_ID FROM RISK_TYPE_ID_MAPPING
);
What this does:

Deletes the unwanted duplicate risk type IDs from the original table.

Now only unique, clean RISK_HEADER-RISK_TYPE_ID combinations will remain.

✅ 7. Backfill Missing MASTER_METRIC_IDs in RAP_METRICS_DETAILS
sql
Copy
Edit
MERGE INTO RAP_METRICS_DETAILS d
USING (
    SELECT *
    FROM (
        SELECT d.ROWID AS d_rowid,
               m.MASTER_METRIC_ID,
               ROW_NUMBER() OVER (PARTITION BY d.ROWID ORDER BY m.RISK_TYPE_ID) AS rn
        FROM RAP_METRICS_DETAILS d
        JOIN RAP r ON d.RAP_ID = r.RAP_ID
        JOIN MEET_INSTC mi ON r.RAP_INSTANCE_ID = mi.MEET_INSTC_ID
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
          AND mi.ACT_ON_RCRD = 'insert-rap-open'
    )
    WHERE rn = 1
) src
ON (d.ROWID = src.d_rowid)
WHEN MATCHED THEN
UPDATE SET d.MASTER_METRIC_ID = src.MASTER_METRIC_ID;
What this does (step-by-step):

Checks for rows in RAP_METRICS_DETAILS where MASTER_METRIC_ID is NULL.

Finds the matching MASTER_METRIC_ID from RAP_MASTER_METRIC_DETAILS, using:

A match on METRICS_DISP = MASTER_METRIC_NAME

And choosing the smallest RISK_TYPE_ID if duplicates exist.

Uses a MERGE (upsert) to update the matching rows.
