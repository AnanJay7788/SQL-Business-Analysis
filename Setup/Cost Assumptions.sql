USE operations_quality_db;
GO

IF OBJECT_ID('dbo.cost_assumptions', 'U') IS NOT NULL
    DROP TABLE dbo.cost_assumptions;
GO

CREATE TABLE dbo.cost_assumptions (
    assumption_name VARCHAR(50) PRIMARY KEY,
    value DECIMAL(12,2) NOT NULL,
    unit VARCHAR(30) NULL
);

INSERT INTO dbo.cost_assumptions (assumption_name, value, unit) VALUES
('downtime_cost_per_min', 5.00, 'GBP/min'),
('scrap_cost_per_unit',   2.50, 'GBP/unit');
GO
