# Data-Analytics-Portfolio
Collection of data analytics portfolio projects showcasing SQL, Tableau/Power BI, and Python skills.

# COVID-19 SQL Data Exploration 

## Overview
This project explores global COVID-19 datasets, focusing on deaths, infection rates, and vaccination trends across countries and continents. The goal is to uncover insights using SQL and prepare the data for further visualization.

## Dataset
- **CovidDeaths** – daily COVID-19 death counts by country  
- **CovidVaccinations** – daily vaccination numbers by country  
- Sources: Public COVID-19 datasets (e.g., Our World in Data)

## Analysis Performed
The SQL exploration covered:

1. **Data Overview:** Selected and reviewed all columns from both datasets to understand structure.  
2. **Country-Specific Analysis:**  
   - Death percentage in India (`total_deaths / total_cases`)  
   - Population infection percentage in India (`total_cases / population`)  
3. **Global Rankings:**  
   - Countries with the **highest infection rate relative to population**  
   - Countries and continents with **highest total deaths**  
4. **Global Aggregates:**  
   - Total cases, deaths, and overall death percentage globally  
5. **Vaccination Analysis:**  
   - Joined `CovidDeaths` and `CovidVaccinations`  
   - Calculated **rolling sum of vaccinations per country**  
   - Converted to **percentage of population vaccinated**  
6. **Reusable View:** Created a SQL **view (`PerPopVac`)** for future analyses and dashboard building

## Tools & Skills
- **SQL Server / SSMS**  
- **Skills sharpened:**  
  - SQL joins and aggregations  
  - Window functions (`SUM() OVER`)  
  - Common Table Expressions (CTEs)  
  - Views for reusable analysis  
  - Exploratory data analysis and data interpretation  

## Key Insights
- Infection and death percentages vary significantly by country  
- Rolling vaccination trends highlight countries with fast vs slow vaccine rollouts  
- Preparing this data with views and CTEs enables smooth dashboard integration in the next phase

## How to Run
1. Import the CSVs into SQL Server tables (`CovidDeaths`, `CovidVaccinations`)  
2. Open `covid_sql_exploration.sql` and run the queries  
3. Review results in SSMS or export for visualization in Tableau/Power BI
