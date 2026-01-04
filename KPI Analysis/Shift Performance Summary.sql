USE operations_quality_db;
GO

SELECT
    s.shift_name,
    SUM(p.planned_units) AS planned_units,
    SUM(p.produced_units) AS produced_units,
    CAST(
        100.0 * SUM(p.produced_units) / NULLIF(SUM(p.planned_units), 0)
        AS DECIMAL(6,2)
    ) AS attainment_percentage
FROM fact_production p
JOIN dim_shift s ON s.shift_id = p.shift_id
GROUP BY s.shift_name
ORDER BY attainment_percentage DESC;
