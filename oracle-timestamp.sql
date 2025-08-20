UPDATE RAP_METRICS_DETAILS d
SET (
      d.STATUS,
      d.MASTER_METRIC_ID,
      d.METRICS_DISP,
      d.RISK_TYPE_ID
    ) = (
      SELECT 
        m.STATUS,
        m.MASTER_METRIC_ID,
        m.MASTER_METRIC_NAME,
        m.RISK_TYPE_ID
      FROM RAP_MASTER_METRIC_DETAILS m
      WHERE m.MASTER_METRIC_ID = d.MASTER_METRIC_ID
    )
WHERE d.MASTER_METRIC_ID IS NOT NULL
  AND EXISTS (
        SELECT 1
        FROM RAP_MASTER_METRIC_DETAILS m
        WHERE m.MASTER_METRIC_ID = d.MASTER_METRIC_ID
          AND (
                 d.STATUS         <> m.STATUS
              OR d.METRICS_DISP   <> m.MASTER_METRIC_NAME
              OR NVL(d.RISK_TYPE_ID, -1) <> NVL(m.RISK_TYPE_ID, -1)
          )
      );


-- Just preview the rows that will be updated
SELECT d.metricDetailId, d.MASTER_METRIC_ID, d.STATUS AS detail_status,
       m.STATUS AS master_status,
       d.METRICS_DISP AS detail_name,
       m.MASTER_METRIC_NAME AS master_name,
       d.RISK_TYPE_ID AS detail_risk_type,
       m.RISK_TYPE_ID AS master_risk_type
FROM RAP_METRICS_DETAILS d
JOIN RAP_MASTER_METRIC_DETAILS m
  ON d.MASTER_METRIC_ID = m.MASTER_METRIC_ID
WHERE d.MASTER_METRIC_ID IS NOT NULL
  AND (
        d.STATUS <> m.STATUS
     OR d.METRICS_DISP <> m.MASTER_METRIC_NAME
     OR NVL(d.RISK_TYPE_ID, -1) <> NVL(m.RISK_TYPE_ID, -1)
  )
ORDER BY d.metricDetailId;
