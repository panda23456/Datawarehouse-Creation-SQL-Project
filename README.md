# ST1501 CA2: Group Submission and Database Analysis

This project aims to design, implement, and analyze data within an OLTP system and a data warehouse, leveraging SQL for insights into operational data.

---

## Objectives
1. **OLTP Setup**: 
   - Insert data into relational tables using `OLTP_insert.sql`.
   - Address and resolve data quality issues from the provided datasets.
2. **Data Warehouse Design**:
   - Design a snowflake schema with fact and dimension tables to support analytical queries.
   - Populate the data warehouse from OLTP data using `DW_create.sql` and `DW_insert.sql`.
3. **Data Analysis**:
   - Write and execute SQL queries to derive actionable insights.

---

## Key Components

### 1. OLTP Insertions and Data Quality Fixes
   - **OLTP_insert.sql**: Contains SQL queries to populate OLTP tables.
   - **Data Issues and Resolutions**:
     | Issue No. | Description | Solution |
     |-----------|-------------|----------|
     | 1         | Irrelevant data in `great ideas` sheet of `modeling.xlsx`. | Excluded irrelevant sheet. |
     | 2         | Mismatch in `Model Code` columns: `LogR` vs `logR`. | Standardized to `logR`. |
     | 3         | Missing/invalid `CustomerID` in `Orders.csv`. | Removed invalid rows. |
     | 4 & 5     | Duplicate contact numbers in `Employee.docx` and `Customer.csv`. | Retained as-is due to lack of alternative data. |

### 2. Data Warehouse Design
   - **Schema**: Snowflake schema with a central fact table and dimensions (Employee, Time, Customer, Model, Dataset).
   - **Design Rationale**:
     - Chosen to reduce data redundancy.
     - Facilitates consistent, space-efficient storage.
   - **Validation**:
     - Matched OLTP and data warehouse dimensions for consistency.
     - Verified data correctness post-insertion.

### 3. Analytical Queries
   - **Q1**: Seasonal trends in profits and order volumes.
     - Query analyzed quarterly performance.
     - **Findings**:
       - Profits peak in Q4.
       - Strong correlation between orders and profits.
   - **Q2**: Financial performance by model type.
     - **Findings**:
       - Neural Networks are top performers.
       - Random Forest excels in accuracy.
   - **Q3**: Employee performance and revenue distribution by gender.
     - **Findings**:
       - Mia Lewis leads in revenue and orders.
       - Female employees handle higher workloads and revenue per order.

---

## Summary
This project successfully implemented OLTP and data warehouse systems, ensuring data quality and leveraging SQL for advanced data analytics. The findings support decision-making in operational efficiency and strategic planning.

