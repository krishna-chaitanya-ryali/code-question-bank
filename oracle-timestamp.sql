Change Title

PROD Data Fix: backfill and re-associate MASTER_METRIC_ID in RAP_METRICS_DETAILS, dedupe RAP_MASTER_METRIC_DETAILS, and harden referential consistency with RAP_METRICS_PACK_MAPPING

Justification

Historical UI behavior (dashboard section / risk type changes) intermittently set RAP_METRICS_DETAILS.MASTER_METRIC_ID to NULL.

Prior risk type dedupe created valid canonical RISK_TYPE_IDs but left duplicate master metrics (same name + same risk type, different MASTER_METRIC_IDs) in RAP_MASTER_METRIC_DETAILS.

Reporting and downstream analytics depend on a stable MASTER_METRIC_ID reference; current inconsistencies cause wrong aggregations and orphan references.

This CR standardizes master metric identities, re-associates detail rows to canonical IDs, and backfills remaining nulls via deterministic rules.


Customer/Business Impact

No customer-facing impact; data fix affects internal analytics only.

Read performance may temporarily degrade on the three impacted tables due to updates; we’ll run after-hours and in controlled batches.


Technical Impact

Affects tables: RAP_METRICS_DETAILS, RAP_MASTER_METRIC_DETAILS, (read-only: RAP, RAP_METRICS_PACK_MAPPING, RAP_RISK_TYPE).

Row counts impacted (order of magnitude):

Re-association in RAP_METRICS_DETAILS: O(10^3–10^4) rows (depends on env).

Deletion of duplicate masters after re-association: hundreds previously observed.

Backfill of MASTER_METRIC_ID: thousands previously observed.


Locks: row-level; plan to batch + commit.

No code deploy; pure SQL data fix.


Implementation Plan (step-by-step)

> Notes

Adjust the mapping table’s metric name column once: it’s either p.METRICS_DISP or p.METRICS_DISPLAY. Replace <<MAP_NAME_COL>> accordingly.

Column names used below:

RAP_METRICS_DETAILS(METRIC_DETAIL_ID, RAP_ID, RAP_METRICS_MAPPING_ID, MASTER_METRIC_ID, METRICS_DISPLAY)

RAP_METRICS_PACK_MAPPING(RAP_METRICS_MAPPING_ID, <<MAP_NAME_COL>>) 

RAP_MASTER_METRIC_DETAILS(MASTER_METRIC_ID, MASTER_METRIC_NAME, RISK_TYPE_ID)

RAP(RAP_ID, RAP_INSTANCE_ID, RISK_TYPE_ID)


Optional filters (e.g., MEET_INSTC, ACT_ON_RCRD) are omitted for the prod full run; uncomment if you need to scope for dry-runs.





---

Step 0 – Pre-checks (read-only)

-- 0.1 How many detail rows are NULL today?
SELECT COUNT(*) AS null_details
FROM RAP_METRICS_DETAILS
WHERE MASTER_METRIC_ID IS NULL;

-- 0.2 Duplicate master metrics (same name + risk type, different IDs)
SELECT TRIM(UPPER(MASTER_METRIC_NAME)) AS metric_name_norm,
       RISK_TYPE_ID,
       COUNT(DISTINCT MASTER_METRIC_ID) AS id_count,
       LISTAGG(MASTER_METRIC_ID, ',') WITHIN GROUP (ORDER BY MASTER_METRIC_ID) AS ids
FROM RAP_MASTER_METRIC_DETAILS
GROUP BY TRIM(UPPER(MASTER_METRIC_NAME)), RISK_TYPE_ID
HAVING COUNT(DISTINCT MASTER_METRIC_ID) > 1
ORDER BY metric_name_norm, RISK_TYPE_ID;

-- 0.3 Sanity view of “multiple master IDs per mapping id” currently in DETAILS
SELECT p.RAP_METRICS_MAPPING_ID,
       COUNT(DISTINCT d.MASTER_METRIC_ID) AS master_id_count,
       LISTAGG(DISTINCT d.MASTER_METRIC_ID, ',') WITHIN GROUP (ORDER BY d.MASTER_METRIC_ID) AS master_ids
FROM RAP_METRICS_DETAILS d
JOIN RAP_METRICS_PACK_MAPPING p ON p.RAP_METRICS_MAPPING_ID = d.RAP_METRICS_MAPPING_ID
WHERE d.MASTER_METRIC_ID IS NOT NULL
GROUP BY p.RAP_METRICS_MAPPING_ID
HAVING COUNT(DISTINCT d.MASTER_METRIC_ID) > 1
ORDER BY master_id_count DESC, p.RAP_METRICS_MAPPING_ID;


---

Step 1 – Backups

-- 1.1 Backup only rows we might touch in DETAILS (NULL master + rows that reference duplicate masters)
CREATE TABLE RAP_METRICS_DETAILS_BKP_YYYYMMDD AS
SELECT d.*
FROM RAP_METRICS_DETAILS d
LEFT JOIN RAP_MASTER_METRIC_DETAILS m ON m.MASTER_METRIC_ID = d.MASTER_METRIC_ID
WHERE d.MASTER_METRIC_ID IS NULL
   OR EXISTS (
        SELECT 1
        FROM RAP_MASTER_METRIC_DETAILS m2
        WHERE TRIM(UPPER(m2.MASTER_METRIC_NAME)) = TRIM(UPPER(m.MASTER_METRIC_NAME))
          AND NVL(m2.RISK_TYPE_ID,-1) = NVL(m.RISK_TYPE_ID,-1)
          AND m2.MASTER_METRIC_ID <> m.MASTER_METRIC_ID
     );

-- 1.2 Full backup of master table (small enough to snapshot)
CREATE TABLE RAP_MASTER_METRIC_DETAILS_BKP_YYYYMMDD AS
SELECT * FROM RAP_MASTER_METRIC_DETAILS;


---

Step 2 – Build canonical master-ID map for duplicates

-- 2.1 Map every duplicate master to a canonical (lowest) ID
CREATE GLOBAL TEMPORARY TABLE MASTER_METRIC_ID_MAPPING
( OLD_MASTER_METRIC_ID NUMBER,
  NEW_MASTER_METRIC_ID NUMBER )
ON COMMIT PRESERVE ROWS;

INSERT INTO MASTER_METRIC_ID_MAPPING (OLD_MASTER_METRIC_ID, NEW_MASTER_METRIC_ID)
SELECT m.MASTER_METRIC_ID AS OLD_ID,
       MIN(m.MASTER_METRIC_ID) OVER (
         PARTITION BY TRIM(UPPER(m.MASTER_METRIC_NAME)), m.RISK_TYPE_ID
       ) AS NEW_ID
FROM RAP_MASTER_METRIC_DETAILS m
WHERE EXISTS (
  SELECT 1
  FROM RAP_MASTER_METRIC_DETAILS x
  WHERE TRIM(UPPER(x.MASTER_METRIC_NAME)) = TRIM(UPPER(m.MASTER_METRIC_NAME))
    AND NVL(x.RISK_TYPE_ID,-1) = NVL(m.RISK_TYPE_ID,-1)
    AND x.MASTER_METRIC_ID <> m.MASTER_METRIC_ID
);

-- 2.2 Remove identity mappings (OLD=NEW) if any
DELETE FROM MASTER_METRIC_ID_MAPPING
WHERE OLD_MASTER_METRIC_ID = NEW_MASTER_METRIC_ID;


---

Step 3 – Re-associate DETAILS to canonical master IDs

-- Use inline view to avoid ORA-01779 and guarantee single-row subquery
UPDATE RAP_METRICS_DETAILS d
SET d.MASTER_METRIC_ID = (
  SELECT map.NEW_MASTER_METRIC_ID
  FROM MASTER_METRIC_ID_MAPPING map
  WHERE map.OLD_MASTER_METRIC_ID = d.MASTER_METRIC_ID
)
WHERE d.MASTER_METRIC_ID IN (
  SELECT OLD_MASTER_METRIC_ID FROM MASTER_METRIC_ID_MAPPING
);


---

Step 4 – Delete duplicate rows in MASTER table (safe now)

DELETE FROM RAP_MASTER_METRIC_DETAILS m
WHERE m.MASTER_METRIC_ID IN (
  SELECT OLD_MASTER_METRIC_ID FROM MASTER_METRIC_ID_MAPPING
);


---

Step 5 – Insert missing master metrics required for backfill

Create masters only for (name, risk type) pairs that appear in DETAILS/Mapping but don’t exist in MASTER:

-- 5.1 Candidate (name, risk type) pairs that need a master row
WITH needed AS (
  SELECT DISTINCT
         TRIM(UPPER(p.<<MAP_NAME_COL>>)) AS NAME_NORM,
         r.RISK_TYPE_ID
  FROM RAP_METRICS_DETAILS d
  JOIN RAP r ON r.RAP_ID = d.RAP_ID
  JOIN RAP_METRICS_PACK_MAPPING p
    ON p.RAP_METRICS_MAPPING_ID = d.RAP_METRICS_MAPPING_ID
  WHERE d.MASTER_METRIC_ID IS NULL
),
missing AS (
  SELECT n.NAME_NORM, n.RISK_TYPE_ID
  FROM needed n
  LEFT JOIN RAP_MASTER_METRIC_DETAILS m
    ON TRIM(UPPER(m.MASTER_METRIC_NAME)) = n.NAME_NORM
   AND NVL(m.RISK_TYPE_ID,-1) = NVL(n.RISK_TYPE_ID,-1)
  WHERE m.MASTER_METRIC_ID IS NULL
)
INSERT INTO RAP_MASTER_METRIC_DETAILS (MASTER_METRIC_NAME, RISK_TYPE_ID, CREATE_DT, UPDT_DT)
SELECT NAME_NORM, RISK_TYPE_ID, SYSTIMESTAMP, SYSTIMESTAMP
FROM missing;

> If your env auto-uppercases names in MASTER, keep NAME_NORM; otherwise remove UPPER() in both places.




---

Step 6 – Backfill NULL MASTER_METRIC_ID in DETAILS

Deterministic single-row rule: join by (normalized mapping name, RAP.RISK_TYPE_ID) and pick the lowest master ID if (rarely) multiple remain.

UPDATE RAP_METRICS_DETAILS d
SET d.MASTER_METRIC_ID = (
  SELECT MIN(m.MASTER_METRIC_ID)  -- single-row guarantee
  FROM RAP r
  JOIN RAP_METRICS_PACK_MAPPING p
    ON p.RAP_METRICS_MAPPING_ID = d.RAP_METRICS_MAPPING_ID
  JOIN RAP_MASTER_METRIC_DETAILS m
    ON TRIM(UPPER(m.MASTER_METRIC_NAME)) = TRIM(UPPER(p.<<MAP_NAME_COL>>))
   AND NVL(m.RISK_TYPE_ID,-1) = NVL(r.RISK_TYPE_ID,-1)
  WHERE r.RAP_ID = d.RAP_ID
)
WHERE d.MASTER_METRIC_ID IS NULL
  AND EXISTS (
    SELECT 1
    FROM RAP r2
    JOIN RAP_METRICS_PACK_MAPPING p2
      ON p2.RAP_METRICS_MAPPING_ID = d.RAP_METRICS_MAPPING_ID
    JOIN RAP_MASTER_METRIC_DETAILS m2
      ON TRIM(UPPER(m2.MASTER_METRIC_NAME)) = TRIM(UPPER(p2.<<MAP_NAME_COL>>))
     AND NVL(m2.RISK_TYPE_ID,-1) = NVL(r2.RISK_TYPE_ID,-1)
    WHERE r2.RAP_ID = d.RAP_ID
  );

> Optional: if you need the forward/backward fill within the same mapping (fill gaps between known non-nulls ordered by METRIC_DETAIL_ID), run that after the join-based backfill.




---

Step 7 – Post-implementation verification

-- 7.1 No NULL masters remain (or expected residual count if any are intentionally allowed)
SELECT COUNT(*) AS null_details_after
FROM RAP_METRICS_DETAILS
WHERE MASTER_METRIC_ID IS NULL;

-- 7.2 Duplicates in MASTER eliminated
SELECT TRIM(UPPER(MASTER_METRIC_NAME)) AS metric_name_norm,
       RISK_TYPE_ID,
       COUNT(DISTINCT MASTER_METRIC_ID) AS id_count
FROM RAP_MASTER_METRIC_DETAILS
GROUP BY TRIM(UPPER(MASTER_METRIC_NAME)), RISK_TYPE_ID
HAVING COUNT(DISTINCT MASTER_METRIC_ID) > 1;

-- 7.3 Spot-check: a mapping ID with multiple master IDs before should now be stable
SELECT p.RAP_METRICS_MAPPING_ID,
       COUNT(DISTINCT d.MASTER_METRIC_ID) AS master_id_count,
       LISTAGG(DISTINCT d.MASTER_METRIC_ID, ',') WITHIN GROUP (ORDER BY d.MASTER_METRIC_ID) AS master_ids
FROM RAP_METRICS_DETAILS d
JOIN RAP_METRICS_PACK_MAPPING p ON p.RAP_METRICS_MAPPING_ID = d.RAP_METRICS_MAPPING_ID
GROUP BY p.RAP_METRICS_MAPPING_ID
HAVING COUNT(DISTINCT d.MASTER_METRIC_ID) > 1;


---

Rollback Plan

If any verification fails, revert using the backups:

-- ROLLBACK MASTER table
DELETE FROM RAP_MASTER_METRIC_DETAILS;
INSERT /*+ APPEND */ INTO RAP_MASTER_METRIC_DETAILS
SELECT * FROM RAP_MASTER_METRIC_DETAILS_BKP_YYYYMMDD;

-- ROLLBACK DETAILS (only rows we backed up)
MERGE INTO RAP_METRICS_DETAILS d
USING RAP_METRICS_DETAILS_BKP_YYYYMMDD b
   ON (d.METRIC_DETAIL_ID = b.METRIC_DETAIL_ID)
WHEN MATCHED THEN UPDATE SET
  d.MASTER_METRIC_ID    = b.MASTER_METRIC_ID,
  d.RAP_ID              = b.RAP_ID,
  d.RAP_METRICS_MAPPING_ID = b.RAP_METRICS_MAPPING_ID,
  d.METRICS_DISPLAY     = b.METRICS_DISPLAY
-- (include any other columns present in your backup structure);
;

> If you only want to revert the master-ID column in DETAILS:



MERGE INTO RAP_METRICS_DETAILS d
USING RAP_METRICS_DETAILS_BKP_YYYYMMDD b
   ON (d.METRIC_DETAIL_ID = b.METRIC_DETAIL_ID)
WHEN MATCHED THEN UPDATE SET
  d.MASTER_METRIC_ID = b.MASTER_METRIC_ID;

Finally, drop the temp mapping if desired:

TRUNCATE TABLE MASTER_METRIC_ID_MAPPING;


---

Blackout/Execution Window

Run off-hours (low traffic window).

Expect up to N minutes of row-level locking on the impacted tables (size dependent).

Batch the updates if needed (e.g., WHERE METRIC_DETAIL_ID BETWEEN …) to keep redo manageable.


Post-implementation Verification Plan

1. Run all SQL under Step 7; paste results into the CR as evidence.


2. Manually spot-check a few previously problematic mappings (e.g., mapping id 25, expecting canonical IDs like 2631/2640 behaviors resolved).


3. Confirm reporting/ETL consumers complete successfully on next cycle.



Risks & Mitigations

Risk: ORA-01427 (multi-row subquery) if names/risk types still duplicated.
Mitigation: Step 2 canonicalization + MIN(m.MASTER_METRIC_ID) in Step 6 ensures single-row results.

Risk: ORA-01779 (update key-preserved view).
Mitigation: All updates target base table with inline scalar subqueries; no view updates.

Risk: Performance/redo spikes.
Mitigation: Batch commits, use off-hours, monitor AWR/ASH.



---

One-line Summary for the CR header

Backfill missing and inconsistent MASTER_METRIC_IDs in RAP_METRICS_DETAILS, dedupe RAP_MASTER_METRIC_DETAILS (name+risk type), and ensure deterministic joins to mapping names and RAP risk types—no customer impact; full rollback via table backups.
