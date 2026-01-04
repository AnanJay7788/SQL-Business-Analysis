USE operations_quality_db;
GO

SELECT
    m.machine_name,
    SUM(q.defect_units) AS total_defects,
    SUM(p.produced_units) AS total_units_produced,
    CAST(
        1000.0 * SUM(q.defect_units) / NULLIF(SUM(p.produced_units), 0)
        AS DECIMAL(8,2)
    ) AS defects_per_1000_units
FROM fact_quality q
JOIN fact_production p
  ON q.date_id = p.date_id
 AND q.product_id = p.product_id
 AND q.machine_id = p.machine_id
JOIN dim_machine m ON m.machine_id = q.machine_id
GROUP BY m.machine_name
ORDER BY defects_per_1000_units DESC;
