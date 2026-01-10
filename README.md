
 # 🚗 VEHICLE DATABASE – SQL ANALYTICS PROJECT

PROJECT OVERVIEW
----------------
This project is a comprehensive SQL analytics case study built
on a relational vehicle database. It focuses on extracting
business insights from large-scale automotive data using
pure SQL without relying on BI tools.

The project demonstrates strong analytical thinking, advanced
query writing, and real-world data analysis skills using
Microsoft SQL Server.

============================================================

DATABASE DESCRIPTION
--------------------
The database contains detailed information about vehicles and
their related dimensions:

- VehicleDetails   : Core vehicle attributes
- Makes            : Vehicle manufacturers
- MakeModels       : Models per manufacturer
- SubModels        : Sub-model classifications
- Bodies           : Vehicle body types
- DriveTypes       : Drive system types
- FuelTypes        : Fuel classifications

All tables are connected using relational keys, enabling
complex multi-table analysis.

============================================================

TECHNOLOGIES USED
-----------------
- Microsoft SQL Server
- T-SQL

============================================================

SQL SKILLS DEMONSTRATED
----------------------
- INNER JOIN across multiple tables
- GROUP BY with HAVING
- Subqueries and derived tables
- Aggregate functions (COUNT, SUM, AVG, MIN, MAX)
- Conditional logic using CASE WHEN
- Filtering using BETWEEN, IN, LIKE
- Handling NULL values
- Calculated columns (percentages, age, tax)
- Ranking and sorting using ORDER BY and TOP
- Randomized result ordering using NEWID()

============================================================

KEY ANALYSIS AREAS
-----------------

1) PRODUCTION ANALYSIS
---------------------
- Total number of vehicles per manufacturer
- Vehicles manufactured between 1950 and 2000
- Top manufacturers by production volume
- Manufacturers producing more than 20,000 vehicles

------------------------------------------------------------

2) ENGINE & PERFORMANCE ANALYSIS
--------------------------------
- Minimum, maximum, and average engine capacity
- Vehicles above and below average engine size
- Top 3 highest engine capacities
- Manufacturers producing high-capacity engines
- Engine-based tax calculation using business rules

------------------------------------------------------------

3) FUEL & DRIVE TYPE ANALYSIS
-----------------------------
- Vehicles running on GAS fuel
- Total makes supporting GAS fuel
- Vehicle count per fuel type per manufacturer
- Drive type analysis (FWD, RWD, AWD) per make

------------------------------------------------------------

4) VEHICLE STRUCTURE ANALYSIS
-----------------------------
- Body types analysis (Sedan, Coupe, Hatchback, SUV)
- Door count distribution
- Missing door data percentage
- Vehicles with specific configurations
  (e.g. 2 doors, large engines)

------------------------------------------------------------

5) TIME-BASED INSIGHTS
----------------------
- Vehicle age calculation
- Vehicles filtered by age range
- Vehicles manufactured in specific years

============================================================

BUSINESS INSIGHTS
-----------------
- Identified manufacturers with highest production volume
- Highlighted manufacturers with the largest model diversity
- Analyzed data quality through missing attributes
- Applied rule-based logic for engine taxation
- Provided insights suitable for automotive market analysis

============================================================

PROJECT STRUCTURE
-----------------
Vehicle-SQL-Analytics/
|
|-- SQL_Scripts.sql
|-- README.md

============================================================

USE CASES
---------
- SQL Portfolio Project
- Data Analyst Interview Preparation
- Advanced SQL Practice
- Relational Database Analysis Demonstration

============================================================

AUTHOR
------
Shady Mahmoud
SQL & Data Analytics Enthusiast

============================================================

FINAL NOTE
----------
This project showcases the ability to transform raw relational
data into actionable insights using SQL and reflects real-world
data analysis scenarios.

============================================================
