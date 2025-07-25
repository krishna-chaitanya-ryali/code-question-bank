UPDATE MAP_RAP_USER_ROLE
SET CREAT_DT_TMP = CASE
                      WHEN REGEXP_LIKE(TRIM(EFF_START_DT_OLD), '^\d{2}-\d{2}-\d{4} \d{2}:\d{2}:\d{2}$')
                      THEN TO_TIMESTAMP(EFF_START_DT_OLD, 'DD-MM-YYYY HH24:MI:SS')
                      WHEN REGEXP_LIKE(TRIM(EFF_START_DT_OLD), '^\d{2}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$')
                      THEN TO_TIMESTAMP(EFF_START_DT_OLD, 'DD-MM-RR HH24:MI:SS')
                      ELSE NULL
                  END,
    UPDT_DT_TMP = CASE
                      WHEN EFF_END_DT_OLD IS NULL THEN NULL
                      WHEN REGEXP_LIKE(TRIM(EFF_END_DT_OLD), '^\d{2}-\d{2}-\d{4} \d{2}:\d{2}:\d{2}$')
                      THEN TO_TIMESTAMP(EFF_END_DT_OLD, 'DD-MM-YYYY HH24:MI:SS')
                      WHEN REGEXP_LIKE(TRIM(EFF_END_DT_OLD), '^\d{2}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$')
                      THEN TO_TIMESTAMP(EFF_END_DT_OLD, 'DD-MM-RR HH24:MI:SS')
                      ELSE NULL
                  END
WHERE EFF_START_DT_OLD IS NOT NULL OR EFF_END_DT_OLD IS NOT NULL;
