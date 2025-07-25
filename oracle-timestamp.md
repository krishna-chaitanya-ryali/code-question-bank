BEGIN
  FOR rec IN (
    SELECT ROWID AS rid, UPDT_DT FROM MEET_INSTC
    WHERE UPDT_DT IS NOT NULL
  ) LOOP
    BEGIN
      UPDATE MEET_INSTC
      SET UPDT_DT_TMP = 
        TO_TIMESTAMP(rec.UPDT_DT, 'DD-MM-YYYY HH24:MI:SS')
      WHERE ROWID = rec.rid;
    EXCEPTION
      WHEN OTHERS THEN
        BEGIN
          UPDATE MEET_INSTC
          SET UPDT_DT_TMP = 
            TO_TIMESTAMP(rec.UPDT_DT, 'DD-MM-RR HH24:MI:SS')
          WHERE ROWID = rec.rid;
        EXCEPTION
          WHEN OTHERS THEN
            BEGIN
              UPDATE MEET_INSTC
              SET UPDT_DT_TMP = 
                TO_TIMESTAMP(rec.UPDT_DT, 'DD-MON-RR')
              WHERE ROWID = rec.rid;
            EXCEPTION
              WHEN OTHERS THEN
                BEGIN
                  UPDATE MEET_INSTC
                  SET UPDT_DT_TMP = 
                    TO_TIMESTAMP(rec.UPDT_DT, 'MM-DD-YYYY HH24:MI:SS')
                  WHERE ROWID = rec.rid;
                EXCEPTION
                  WHEN OTHERS THEN
                    NULL; -- skip if all formats fail
                END;
            END;
        END;
    END;
  END LOOP;
END;

