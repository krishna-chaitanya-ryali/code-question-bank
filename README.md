SELECT
    10701 AS user_id,
    mrur.rap_user_role_id,
    rmd.metric_detail_id
FROM rapuser.map_rap_user_role mrur
JOIN rapuser.rap_rmm_group rrg
    ON rrg.rmm_id = mrur.rmm_id
JOIN rapuser.rap_metrics_details rmd
    ON rmd.metric_flag = 'insert'
WHERE mrur.user_id = 10701
  AND mrur.rmm_id = 14
  AND mrur.is_active = 1
  AND NOT EXISTS (
        SELECT 1
        FROM rapuser.metric_access ma
        WHERE ma.user_id = 10701
          AND ma.user_role_id = mrur.rap_user_role_id
          AND ma.metric_detail_id = rmd.metric_detail_id
  );



SELECT
    rmd.metric_detail_id,
    CASE
        WHEN ma.metric_access_id IS NULL THEN 'MISSING'
        ELSE 'PRESENT'
    END AS access_status
FROM rapuser.map_rap_user_role mrur
JOIN rapuser.rap_metrics_details rmd
    ON rmd.metric_flag = 'insert'
LEFT JOIN rapuser.metric_access ma
    ON ma.user_id = mrur.user_id
   AND ma.user_role_id = mrur.rap_user_role_id
   AND ma.metric_detail_id = rmd.metric_detail_id
WHERE mrur.user_id = 10701
  AND mrur.rmm_id = 14
  AND mrur.is_active = 1;
