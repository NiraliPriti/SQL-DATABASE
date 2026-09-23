# 📊 SQL Masterclass: Database Management & Advanced Data Analytics

Welcome to my SQL repository! This project contains hands-on SQL scripts, data analysis workflows, and schema design built while working through complete database fundamentals and real-world analytical tasks.

Reference Course: [SQL Full Course for Beginners by Data with Baraa](https://youtu.be/SSKVgrwhzus)

---

## 📌 Project Overview

This repository demonstrates end-to-end database management, from establishing raw tables and managing schemas to writing complex analytical queries, data transformations, and building business-ready reporting views.

### Key Highlights
* **Database Design & DDL:** Schema definition, table creation, constraints, and relationships.
* **Data Manipulation & DML:** Inserting, updating, deleting, and handling missing data safely.
* **Core & Intermediate Querying:** Joins, filtering, set operators, and row-level data transformations.
* **Data Analysis & Aggregations:** Grouping, window functions, and business metric calculations.
* **Advanced Analytics & Objects:** Common Table Expressions (CTEs), Subqueries, Views, and Optimization techniques.

---

## 🗂️ Database Setup

The scripts in this repository utilize standard relational database schemas (e.g., `SalesDB` / `AdventureWorks` models) with relational entities:

* `customers`: Customer profiles, demographics, and contact information.
* `orders`: Transaction records, purchase dates, and status logs.
* `products`: Catalog items, price tiers, and inventory dimensions.
* `employees`: Organizational staff structure and department roles.

---

## 🚀 Repository Contents & Topics Covered

### 1. Database Definition & Data Manipulation (DDL & DML)
* **Table Management:** `CREATE TABLE`, `ALTER TABLE`, `DROP TABLE`.
* **Data Modifications:** Safe `INSERT`, bulk `UPDATE`, and targeted `DELETE` operations.

### 2. Intermediate Querying & Filtering
* **Filtering & Pattern Matching:** Utilizing `WHERE`, `LIKE`, `IN`, `BETWEEN`, and logical operators.
* **Combining Datasets:**
  * **Joins:** `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, and `FULL OUTER JOIN`.
  * **Set Operators:** `UNION`, `UNION ALL`, `INTERSECT`, and `EXCEPT`.

### 3. Data Transformations & Functions
* **Row-Level Transformations:** String manipulation, numeric rounding, date/time formatting, and conditional handling (`CASE WHEN`).
* **Handling Nulls:** `COALESCE`, `ISNULL`, and default fallback strategies.

### 4. Advanced Analytics & Window Functions
* **Grouping & Aggregations:** `GROUP BY`, `HAVING`, `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`.
* **Window Functions:** `ROW_NUMBER()`, `RANK()`, `DENSE_RANK()`, `SUM() OVER()`, `LAG()`, `LEAD()`.

### 5. Advanced SQL Architecture & Views
* **Modular Code:** Multi-stage CTEs (`WITH` clauses) and nested subqueries.
* **Business Views & Reporting:** Reusable reporting views for tracking high-level product performance, customer metrics, and monthly revenue trends.

---

## 📂 Directory Structure

```text
├── 01_database_setup/       # DDL scripts for table creation and database initialization
├── 02_basic_queries/        # SELECT statements, filtering, and data manipulation
├── 03_joins_and_unions/     # Multi-table querying using Joins and Set Operators
├── 04_data_transformations/ # String, Date, and Case-When transformation queries
├── 05_advanced_analytics/   # Window functions, CTEs, and aggregation pipelines
└── 06_reporting_views/      # Business views for customer and product reporting
