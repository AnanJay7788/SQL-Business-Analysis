USE operations_quality_db;
GO

DECLARE @scrap_cost_per_unit DECIMAL(12,2) =
(
    SELECT value
    FROM dbo.cost_assumptions
    WHERE assumption_name = 'scrap_cost_per_unit'
);

SELECT
    defect_type,
    SUM(scrap_units) AS total_scrap_units,
    CAST(SUM(scrap_units) * @scrap_cost_per_unit AS DECIMAL(12,2)) AS estimated_scrap_cost_gbp
FROM fact_quality
GROUP BY defect_type
ORDER BY estimated_scrap_cost_gbp DESC;
