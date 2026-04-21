Project Overview

This project demonstrates a production‑ready ELT pipeline using dbt (data build tool) and Databricks.
It ingests raw CSV files (patient.csv, charges.csv), transforms them into clean staging models, and aggregates patient‑level charges. The pipeline includes data quality tests and is scheduled via Databricks Jobs.

Key skills showcased:
dbt (sources, models, ref, tests, documentation)
Databricks SQL Warehouse & Unity Catalog
Incremental modeling strategy
CI/CD with GitHub + Databricks Repos
Data testing (unique, not_null)

Source Data
File	Description	Key Columns
patient.csv	Patient demographics	id (unique), pin, firstname, lastname, sex
charges.csv	Medical charges per patient	pin (charge line), chno (charge number, can repeat), amount, service_date
Both files are uploaded to Databricks Unity Catalog under main.dbt_learn.


Execution and Orchestration

dbt run          # builds all models
dbt test         # runs data tests


Production scheduling on Databricks

The dbt project is synced to a Databricks Repo (GitHub integration).
A Databricks Job with a dbt task runs dbt run daily on a SQL Warehouse.
Separate environment (dev vs prod) using different schemas.


