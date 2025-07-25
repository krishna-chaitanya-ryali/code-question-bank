UPDATE MAP_RAP_USER_ROLE
SET CREAT_DT_TMP = CASE
                      WHEN REGEXP_LIKE(TRIM(EFF_START_DT), '^\d{1,2}/\d{1,2}/\d{4} \d{1,2}:\d{2}:\d{2} [AP]M$', 'i')
                      THEN TO_TIMESTAMP(EFF_START_DT, 'MM/DD/YYYY HH:MI:SS PM')
                      WHEN REGEXP_LIKE(TRIM(EFF_START_DT), '^\d{2}-\d{2}-\d{4} \d{2}:\d{2}:\d{2}$')
                      THEN TO_TIMESTAMP(EFF_START_DT, 'DD-MM-YYYY HH24:MI:SS')
                      WHEN REGEXP_LIKE(TRIM(EFF_START_DT), '^\d{2}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$')
                      THEN TO_TIMESTAMP(EFF_START_DT, 'DD-MM-RR HH24:MI:SS')
                      ELSE NULL
                  END,
    UPDT_DT_TMP = CASE
                      WHEN EFF_END_DT IS NULL OR TRIM(EFF_END_DT) = '0'
                      THEN SYSDATE
                      WHEN REGEXP_LIKE(TRIM(EFF_END_DT), '^\d{1,2}/\d{1,2}/\d{4} \d{1,2}:\d{2}:\d{2} [AP]M$', 'i')
                      THEN TO_TIMESTAMP(EFF_END_DT, 'MM/DD/YYYY HH:MI:SS PM')
                      WHEN REGEXP_LIKE(TRIM(EFF_END_DT), '^\d{2}-\d{2}-\d{4} \d{2}:\d{2}:\d{2}$')
                      THEN TO_TIMESTAMP(EFF_END_DT, 'DD-MM-YYYY HH24:MI:SS')
                      WHEN REGEXP_LIKE(TRIM(EFF_END_DT), '^\d{2}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$')
                      THEN TO_TIMESTAMP(EFF_END_DT, 'DD-MM-RR HH24:MI:SS')
                      ELSE SYSDATE
                  END
WHERE EFF_START_DT IS NOT NULL OR EFF_END_DT IS NOT NULL;
