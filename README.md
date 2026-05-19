\# E-commerce Analytics Warehouse



A production-style analytics engineering project using dbt Core, DuckDB, and SQL to transform raw e-commerce data into trusted analytics models for revenue, customers, products, and payments.



\## Project Goal



The goal of this project is to practice building an analytics warehouse the way an analytics engineer would structure one in a real business environment.



This project will eventually include:



\- Staging models that clean and standardize raw source data

\- Intermediate models that prepare reusable business logic

\- Mart models for finance, customers, and products

\- Fact and dimension tables

\- dbt tests for data quality

\- dbt documentation for model transparency

\- Git-based development workflow



\## Tech Stack



\- dbt Core

\- DuckDB

\- SQL

\- Python virtual environment

\- Git and GitHub

\- Local-first development



\## Project Structure



```text

ecommerce-analytics-warehouse/

├── README.md

└── ecommerce\_analytics/

&#x20;   ├── dbt\_project.yml

&#x20;   ├── models/

&#x20;   │   ├── staging/

&#x20;   │   ├── intermediate/

&#x20;   │   └── marts/

&#x20;   ├── seeds/

&#x20;   ├── macros/

&#x20;   ├── tests/

&#x20;   └── snapshots/



