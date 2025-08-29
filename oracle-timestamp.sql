SELECT
    ut.user_name                            AS user_name,
    mrur.emp_id                             AS emp_id,
    rrg.rmm_display_name                    AS rmm_name,
    rrt.risk_type                           AS risk_type,
    ur.role_name                            AS user_role,
    mrur.access_rational                    AS access_rational,
    CASE
        WHEN rmpm.metrics_display IS NULL
        THEN rmd.metrics_display
        ELSE rmpm.metrics_display
    END                                     AS metrics_name
FROM user_tab ut
JOIN map_rap_user_role mrur
      ON mrur.user_id = ut.user_id
     AND NVL(mrur.is_active, 1) = 1
JOIN user_role ur
      ON ur.user_role_id = mrur.user_role_id
JOIN metric_access ma
      ON ma.user_id = mrur.user_id
     AND ma.user_role_id = mrur.user_role_id
     AND NVL(ma.is_active, 1) = 1
JOIN rap_metrics_details rmd
      ON rmd.metric_detail_id = ma.metric_detail_id
JOIN rap_risk_type rrt
      ON rrt.risk_type_id = rmd.risk_type_id
JOIN rap_rmm_group rrg
      ON rrg.rmm_id = mrur.rmm_id
LEFT JOIN rap_metrics_mapping rmpm
      ON rmpm.metric_detail_id = rmd.metric_detail_id
     AND rmpm.rmm_id          = mrur.rmm_id
JOIN meet_instc mi
      ON mi.rmm_id = mrur.rmm_id
WHERE mi.dt_id = (
        SELECT MAX(mo.dt_id)
        FROM meet_instc mo
        WHERE mo.rmm_id = mrur.rmm_id
          AND mo.meet_stat_id IN (1, 2)
      )
-- If you have a flag on metrics to exclude, keep this:
--  AND rmd.metric_flag <> 'F'
ORDER BY rrg.rmm_display_name, ut.user_name, ur.role_name, metrics_name;
