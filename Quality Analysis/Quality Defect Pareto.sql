USE operations_quality_db;
GO

WITH defects AS (
    SELECT
        defect_type,
        SUM(defect_units) AS total_defects
    FROM fact_quality
    GROUP BY defect_type
),
ranked AS (
    SELECT
        defect_type,
        total_defects,
        SUM(total_defects) OVER () AS grand_total,
        SUM(total_defects) OVER (
            ORDER BY total_defects DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS running_total
    FROM defects
)
SELECT
    defect_type,
    total_defects,
    CAST(100.0 * total_defects / grand_total AS DECIMAL(6,2)) AS percentage_of_total,
    CAST(100.0 * running_total / grand_total AS DECIMAL(6,2)) AS cumulative_percentage
FROM ranked
ORDER BY total_defects DESC;
