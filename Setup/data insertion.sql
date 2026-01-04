USE operations_quality_db;
GO

/* Clear existing data (safe to rerun) */
DELETE FROM fact_quality;
DELETE FROM fact_downtime;
DELETE FROM fact_production;
DELETE FROM dim_shift;
DELETE FROM dim_machine;
DELETE FROM dim_product;
DELETE FROM dim_date;
GO

/* ============================
   DIMENSIONS
   ============================ */

INSERT INTO dim_shift (shift_id, shift_name, start_time, end_time) VALUES
(1, 'Shift A', '06:00', '14:00'),
(2, 'Shift B', '14:00', '22:00'),
(3, 'Shift C', '22:00', '06:00');

INSERT INTO dim_machine (machine_id, machine_name, line_name) VALUES
(1, 'Machine-01', 'Line-1'),
(2, 'Machine-02', 'Line-1'),
(3, 'Machine-03', 'Line-2');

INSERT INTO dim_product (product_id, product_name, product_line) VALUES
(1, 'Widget A', 'Line-A'),
(2, 'Widget B', 'Line-A'),
(3, 'Widget C', 'Line-B');

INSERT INTO dim_date (date_id, full_date, year, month, month_name, week) VALUES
(20240101, '2024-01-01', 2024, 1, 'January', 1),
(20240102, '2024-01-02', 2024, 1, 'January', 1),
(20240103, '2024-01-03', 2024, 1, 'January', 1),
(20240104, '2024-01-04', 2024, 1, 'January', 1),
(20240105, '2024-01-05', 2024, 1, 'January', 1),
(20240106, '2024-01-06', 2024, 1, 'January', 1),
(20240107, '2024-01-07', 2024, 1, 'January', 1);
GO

/* ============================
   FACT: PRODUCTION
   ============================ */

INSERT INTO fact_production (date_id, product_id, machine_id, shift_id, planned_units, produced_units, runtime_minutes) VALUES
(20240101, 1, 1, 1, 1000,  940, 450),
(20240101, 2, 2, 1,  900,  880, 460),
(20240101, 3, 3, 2, 1100, 1040, 440),

(20240102, 1, 1, 1, 1000,  910, 430),
(20240102, 2, 2, 2,  950,  860, 410),
(20240102, 3, 3, 2, 1100,  980, 420),

(20240103, 1, 1, 1, 1000,  970, 470),
(20240103, 2, 2, 2,  950,  900, 455),
(20240103, 3, 3, 3, 1100, 1000, 430),

(20240104, 1, 1, 2, 1000,  890, 400),
(20240104, 2, 2, 2,  950,  920, 470),
(20240104, 3, 3, 3, 1100,  940, 410),

(20240105, 1, 1, 3, 1000,  850, 390),
(20240105, 2, 2, 1,  950,  930, 475),
(20240105, 3, 3, 1, 1100, 1080, 480);
GO

/* ============================
   FACT: DOWNTIME
   ============================ */

INSERT INTO fact_downtime (date_id, machine_id, shift_id, downtime_reason, downtime_minutes) VALUES
(20240101, 1, 1, 'Material shortage', 25),
(20240101, 1, 1, 'Changeover', 15),
(20240101, 2, 1, 'Maintenance', 20),
(20240101, 3, 2, 'Quality hold', 10),

(20240102, 1, 1, 'Material shortage', 30),
(20240102, 2, 2, 'Breakdown', 35),
(20240102, 3, 2, 'Changeover', 20),

(20240103, 1, 1, 'Maintenance', 15),
(20240103, 2, 2, 'Material shortage', 10),
(20240103, 3, 3, 'Breakdown', 25),

(20240104, 1, 2, 'Breakdown', 40),
(20240104, 2, 2, 'Changeover', 20),
(20240104, 3, 3, 'Quality hold', 15),

(20240105, 1, 3, 'Material shortage', 35),
(20240105, 2, 1, 'Maintenance', 10),
(20240105, 3, 1, 'Changeover', 20);
GO

/* ============================
   FACT: QUALITY
   ============================ */

INSERT INTO fact_quality (date_id, product_id, machine_id, defect_type, defect_units, scrap_units) VALUES
(20240101, 1, 1, 'Scratch', 12, 5),
(20240101, 2, 2, 'Dimensional', 9, 3),
(20240101, 3, 3, 'Crack', 15, 7),

(20240102, 1, 1, 'Scratch', 18, 8),
(20240102, 2, 2, 'Dimensional', 14, 6),
(20240102, 3, 3, 'Crack', 20, 10),

(20240103, 1, 1, 'Scratch', 10, 4),
(20240103, 2, 2, 'Dimensional', 11, 5),
(20240103, 3, 3, 'Crack', 17, 8),

(20240104, 1, 1, 'Scratch', 22, 11),
(20240104, 2, 2, 'Dimensional', 8, 2),
(20240104, 3, 3, 'Crack', 16, 7),

(20240105, 1, 1, 'Scratch', 25, 12),
(20240105, 2, 2, 'Dimensional', 7, 2),
(20240105, 3, 3, 'Crack', 10, 4);
GO

SELECT COUNT(*) AS dim_date_rows FROM dim_date;
SELECT COUNT(*) AS fact_production_rows FROM fact_production;
SELECT COUNT(*) AS fact_downtime_rows FROM fact_downtime;
SELECT COUNT(*) AS fact_quality_rows FROM fact_quality;