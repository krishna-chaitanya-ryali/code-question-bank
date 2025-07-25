SELECT DISTINCT CREAT_DT
FROM MEET_INSTC
WHERE NOT REGEXP_LIKE(TRIM(CREAT_DT), '^\d{2}-\d{2}-\d{4}(\s\d{2}:\d{2}:\d{2})?$');


UPDATE MEET_INSTC
SET CREAT_DT_TMP =
  CASE
    -- Format: DD/MM/YYYY HH24:MI:SS → convert
    WHEN REGEXP_LIKE(TRIM(CREAT_DT), '^\d{2}/\d{2}/\d{4} \d{2}:\d{2}:\d{2}$') THEN
      TO_TIMESTAMP(REPLACE(TRIM(CREAT_DT), '/', '-'), 'DD-MM-YYYY HH24:MI:SS')

    -- Format: DD/MM/YYYY only → convert
    WHEN REGEXP_LIKE(TRIM(CREAT_DT), '^\d{2}/\d{2}/\d{4}$') THEN
      TO_TIMESTAMP(REPLACE(TRIM(CREAT_DT), '/', '-'), 'DD-MM-YYYY')

    -- Format: D-M-YYYY or similar → pad manually
    WHEN REGEXP_LIKE(TRIM(CREAT_DT), '^\d{1,2}-\d{1,2}-\d{4}$') THEN
      TO_TIMESTAMP(
        LPAD(REGEXP_SUBSTR(CREAT_DT, '^\d{1,2}'), 2, '0') || '-' ||
        LPAD(REGEXP_SUBSTR(CREAT_DT, '\d{1,2}', 1, 2), 2, '0') || '-' ||
        REGEXP_SUBSTR(CREAT_DT, '\d{4}$'),
        'DD-MM-YYYY'
      )

    -- Format: D-M-YYYY HH24:MI:SS → pad and convert
    WHEN REGEXP_LIKE(TRIM(CREAT_DT), '^\d{1,2}-\d{1,2}-\d{4} \d{2}:\d{2}:\d{2}$') THEN
      TO_TIMESTAMP(
        LPAD(REGEXP_SUBSTR(CREAT_DT, '^\d{1,2}'), 2, '0') || '-' ||
        LPAD(REGEXP_SUBSTR(CREAT_DT, '\d{1,2}', 1, 2), 2, '0') || '-' ||
        REGEXP_SUBSTR(CREAT_DT, '\d{4}') || ' ' ||
        REGEXP_SUBSTR(CREAT_DT, '\d{2}:\d{2}:\d{2}$'),
        'DD-MM-YYYY HH24:MI:SS'
      )

    -- Already valid format → convert directly
    WHEN REGEXP_LIKE(TRIM(CREAT_DT), '^\d{2}-\d{2}-\d{4}$') THEN
      TO_TIMESTAMP(TRIM(CREAT_DT), 'DD-MM-YYYY')

SELECT CREAT_DT
FROM MEET_INSTC
WHERE CREAT_DT_TMP IS NULL AND CREAT_DT IS NOT NULL;

    WHEN REGEXP_LIKE(TRIM(CREAT_DT), '^\d{2}-\d{2}-\d{4} \d{2}:\d{2}:\d{2}$') THEN
      TO_TIMESTAMP(TRIM(CREAT_DT), 'DD-MM-YYYY HH24:MI:SS')

    ELSE NULL
  END
WHERE CREAT_DT IS NOT NULL;
