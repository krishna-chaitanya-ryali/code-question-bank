SELECT d.metricDetailId,
       d.masterMetricId,
       p.rapMetrixMappingId,
       p.metricsDisp,
       r.riskTypeId
FROM   RAP_METRICS_DETAILS d
       JOIN RAP p ON d.rap_id = p.rap_id
       JOIN RAP_RISK_TYPE r ON r.risk_type_id = p.risk_type_id
WHERE  NOT EXISTS (
          SELECT 1
          FROM   RAP_MASTER_METRIC_DETAILS m
          WHERE  m.master_metric_id = d.masterMetricId
       );


SELECT d.metricDetailId,
       d.masterMetricId,
       m.master_metric_name,
       p.metricsDisp,
       p.rapMetrixMappingId,
       r.riskTypeId
FROM   RAP_METRICS_DETAILS d
       JOIN RAP p ON d.rap_id = p.rap_id
       JOIN RAP_RISK_TYPE r ON r.risk_type_id = p.risk_type_id
       JOIN RAP_MASTER_METRIC_DETAILS m
            ON m.master_metric_id = d.masterMetricId
WHERE  m.master_metric_name <> p.metricsDisp;


SELECT d.metricDetailId,
       d.masterMetricId,
       m.master_metric_name,
       p.metricsDisp,
       m.risk_type_id AS masterRiskTypeId,
       r.risk_type_id AS rapRiskTypeId,
       p.rapMetrixMappingId
FROM   RAP_METRICS_DETAILS d
       JOIN RAP p ON d.rap_id = p.rap_id
       JOIN RAP_RISK_TYPE r ON r.risk_type_id = p.risk_type_id
       JOIN RAP_MASTER_METRIC_DETAILS m
            ON m.master_metric_id = d.masterMetricId
WHERE  m.risk_type_id <> r.risk_type_id;

