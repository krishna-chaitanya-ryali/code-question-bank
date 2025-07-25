BEGIN
  FOR rec IN (
    SELECT ROWID AS rid, CREAT_DT FROM MEET_INSTC
    WHERE CREAT_DT IS NOT NULL
  ) LOOP
    BEGIN
      UPDATE MEET_INSTC
      SET CREAT_DT_TMP = 
        TO_TIMESTAMP(rec.CREAT_DT, 'DD-MM-YYYY HH24:MI:SS')
      WHERE ROWID = rec.rid;
    EXCEPTION
      WHEN OTHERS THEN
        BEGIN
          UPDATE MEET_INSTC
          SET CREAT_DT_TMP = 
            TO_TIMESTAMP(rec.CREAT_DT, 'DD-MM-RR HH24:MI:SS')
          WHERE ROWID = rec.rid;
        EXCEPTION
          WHEN OTHERS THEN
            BEGIN
              UPDATE MEET_INSTC
              SET CREAT_DT_TMP = 
                TO_TIMESTAMP(rec.CREAT_DT, 'DD-MON-RR')
              WHERE ROWID = rec.rid;
            EXCEPTION
              WHEN OTHERS THEN
                NULL; -- skip if all formats fail
            END;
        END;
    END;
  END LOOP;
END;
/
