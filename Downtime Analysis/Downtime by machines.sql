USE operations_quality_db;
GO

SELECT
    m.machine_name,
    SUM(d.downtime_minutes) AS total_downtime_minutes
FROM fact_downtime d
JOIN dim_machine m ON m.machine_id = d.machine_id
GROUP BY m.machine_name
ORDER BY total_downtime_minutes DESC;
