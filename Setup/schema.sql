/* ============================
   DIMENSION TABLES
   ============================ */

CREATE TABLE dim_date (
    date_id INT PRIMARY KEY,
    full_date DATE,
    year INT,
    month INT,
    month_name VARCHAR(20),
    week INT
);

CREATE TABLE dim_product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    product_line VARCHAR(50)
);

CREATE TABLE dim_machine (
    machine_id INT PRIMARY KEY,
    machine_name VARCHAR(50),
    line_name VARCHAR(50)
);

CREATE TABLE dim_shift (
    shift_id INT PRIMARY KEY,
    shift_name VARCHAR(20),
    start_time TIME,
    end_time TIME
);

/* ============================
   FACT TABLES
   ============================ */

CREATE TABLE fact_production (
    production_id INT IDENTITY(1,1) PRIMARY KEY,
    date_id INT,
    product_id INT,
    machine_id INT,
    shift_id INT,
    planned_units INT,
    produced_units INT,
    runtime_minutes INT,
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id),
    FOREIGN KEY (machine_id) REFERENCES dim_machine(machine_id),
    FOREIGN KEY (shift_id) REFERENCES dim_shift(shift_id)
);

CREATE TABLE fact_downtime (
    downtime_id INT IDENTITY(1,1) PRIMARY KEY,
    date_id INT,
    machine_id INT,
    shift_id INT,
    downtime_reason VARCHAR(100),
    downtime_minutes INT,
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (machine_id) REFERENCES dim_machine(machine_id),
    FOREIGN KEY (shift_id) REFERENCES dim_shift(shift_id)
);

CREATE TABLE fact_quality (
    quality_id INT IDENTITY(1,1) PRIMARY KEY,
    date_id INT,
    product_id INT,
    machine_id INT,
    defect_type VARCHAR(100),
    defect_units INT,
    scrap_units INT,
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id),
    FOREIGN KEY (machine_id) REFERENCES dim_machine(machine_id)
);


SELECT *
FROM dim_date
