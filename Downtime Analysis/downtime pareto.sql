
/* Downtime Pareto */ 
USE operations_quality_db;
GO

WITH downtime_by_reason AS (
    SELECT
        downtime_reason,
        SUM(downtime_minutes) AS total_minutes
    FROM fact_downtime
    GROUP BY downtime_reason
),
ranked AS (
    SELECT
        downtime_reason,
        total_minutes,
        SUM(total_minutes) OVER () AS grand_total_minutes,
        SUM(total_minutes) OVER (
            ORDER BY total_minutes DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS running_minutes
    FROM downtime_by_reason
)
SELECT
    downtime_reason,
    total_minutes,
    CAST(100.0 * total_minutes / NULLIF(grand_total_minutes, 0) AS DECIMAL(6,2)) AS pct_of_total,
    CAST(100.0 * running_minutes / NULLIF(grand_total_minutes, 0) AS DECIMAL(6,2)) AS running_pct
FROM ranked
ORDER BY total_minutes DESC;
