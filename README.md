# E-commerce Analytics Warehouse

A production-style analytics engineering project using dbt Core, DuckDB, and SQL to transform raw e-commerce data into trusted analytics models for revenue, customers, products, and payments.

## Project Goal

The goal of this project is to practice building an analytics warehouse the way an analytics engineer would structure one in a real business environment.

This project will eventually include:

- Staging models that clean and standardize raw source data
- Intermediate models that prepare reusable business logic
- Mart models for finance, customers, and products
- Fact and dimension tables
- dbt tests for data quality
- dbt documentation for model transparency
- Git-based development workflow

## Tech Stack

- dbt Core
- DuckDB
- SQL
- uv-managed Python environment
- Git and GitHub
- Local-first development

## Setup

Install and sync the project dependencies:

```powershell
uv sync
```

The project pins Python 3.13 in `.python-version`.

Run dbt commands through uv:

```powershell
uv run dbt debug --project-dir ecommerce_analytics
uv run dbt seed --project-dir ecommerce_analytics
uv run dbt run --project-dir ecommerce_analytics
uv run dbt test --project-dir ecommerce_analytics
```

You do not need to manually activate `.venv` for normal project work. `uv` creates and manages the project environment automatically.

## Project Structure

```text
ecommerce-analytics-warehouse/
|-- README.md
|-- .python-version
|-- pyproject.toml
|-- uv.lock
`-- ecommerce_analytics/
    |-- dbt_project.yml
    |-- models/
    |   |-- staging/
    |   |-- intermediate/
    |   `-- marts/
    |-- seeds/
    |-- macros/
    |-- tests/
    `-- snapshots/
```
