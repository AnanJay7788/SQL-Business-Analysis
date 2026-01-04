
/* Defect Trend per 1,000 Units */ 
USE operations_quality_db;
GO

SELECT
    d.full_date,
    SUM(q.defect_units) AS total_defects,
    SUM(q.scrap_units) AS total_scrap,
    CAST(1000.0 * SUM(q.defect_units) / NULLIF(SUM(p.produced_units), 0) AS DECIMAL(10,2)) AS defects_per_1000_units
FROM fact_quality q
JOIN dim_date d ON q.date_id = d.date_id
JOIN fact_production p
    ON p.date_id = q.date_id
   AND p.machine_id = q.machine_id
   AND p.product_id = q.product_id
GROUP BY d.full_date
ORDER BY d.full_date;
