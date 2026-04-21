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

dbt Models (SQL Transformations)
1. stg_patient – Clean patient data
    select
      pin,
      firstname,
      lastname,
      birthdate,
      sex,
      civil
      from {{ source('raw', 'raw_patient') }}
   
2. stg_charges - clean charges data
    select
      chno,
      pin,
      date,
      amount
      from {{ source('raw', 'raw_charges') }}

3.  fct_patient_totals – Aggregate total charges per patient
    with charges_summary as (
    select
        pin,
        sum(amount) as total_charges,
        count(*) as claim_count
        from {{ ref('stg_charges') }}
        group by pin
        )
    select
        p.pin,
        p.firstname,
        p.lastname,
        p.sex,
        coalesce(c.total_charges, 0) as total_charges,
        coalesce(c.claim_count, 0) as claim_count
        from {{ ref('stg_patient') }} p
        left join charges_summary c on p.pin = c.pin

