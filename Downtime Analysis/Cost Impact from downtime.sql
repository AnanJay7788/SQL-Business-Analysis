USE operations_quality_db;
GO

DECLARE @downtime_cost_per_min DECIMAL(12,2) =
(
    SELECT value
    FROM dbo.cost_assumptions
    WHERE assumption_name = 'downtime_cost_per_min'
);

SELECT
    downtime_reason,
    SUM(downtime_minutes) AS total_downtime_minutes,
    CAST(SUM(downtime_minutes) * @downtime_cost_per_min AS DECIMAL(12,2)) AS estimated_cost_gbp
FROM fact_downtime
GROUP BY downtime_reason
ORDER BY estimated_cost_gbp DESC;
