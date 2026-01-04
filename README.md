# SQL & Power BI Operations Analysis Portfolio

## Overview
This project demonstrates end-to-end SQL and Power BI analysis focused on manufacturing-style operations data, including production output, downtime events, and quality defects.

The objective is to show how raw operational data can be modelled, analysed, and converted into business-ready insights using industry-standard tools.

## Dataset Note
The dataset used in this project is synthetic (simulated) and designed to reflect realistic operational scenarios while avoiding the use of confidential company data.

## Data Model
A star schema was designed in SQL Server:
- Dimension tables: Date, Product, Machine, Shift
- Fact tables: Production, Downtime, Quality

A reporting view was created to combine these tables into a single BI-ready dataset.

## Key Analyses
- Output vs Plan (daily and shift-level attainment)
- Downtime Pareto and machine-level impact
- Defect trends and defect Pareto analysis
- Cost impact estimation for downtime and scrap

## Tools & Skills
- SQL Server (T-SQL)
- CTEs and window functions
- KPI and Pareto analysis
- Power BI (data modelling and dashboards)
- Business-focused insight generation

## How to Run
1. Execute scripts in `setup/` to create tables, load data, and create views
2. Run analysis queries from the respective folders
3. Load `vw_daily_operations_summary` into Power BI for reporting
