
/* Output vs Plan */
USE operations_quality_db;
GO

SELECT
    d.full_date,
    SUM(p.planned_units) AS planned_units,
    SUM(p.produced_units) AS produced_units,
    CAST(100.0 * SUM(p.produced_units) / NULLIF(SUM(p.planned_units), 0) AS DECIMAL(6,2)) AS attainment_pct
FROM fact_production p
JOIN dim_date d ON p.date_id = d.date_id
GROUP BY d.full_date
ORDER BY d.full_date;

