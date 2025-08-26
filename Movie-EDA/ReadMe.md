#Movie Dataset Exploratory Data Analysis (EDA)  
*Alex The Analyst: Portfolio Project 4*  

This repository contains an **exploratory data analysis (EDA)** of a movie dataset.  
The project uncovers **patterns and relationships between various movie attributes**, focusing on factors that influence **financial success** and **critical reception**.  

---

## Project Objective  
The goal of this project is to analyze the **`movies.csv`** dataset to understand the factors influencing movie success, with focus on:  
- **Financial performance** (gross earnings)  
- **Critical reception** (score/rating)  

---

## Data Source  
- Dataset: **`movies.csv`**  
- Downloaded from **Kaggle**  

---

## Analysis Steps  

1. **Data Loading & Initial Understanding**  
   - Loaded dataset, inspected data types, missing values, and summary statistics  

2. **Data Cleaning**  
   - Removed missing values in key columns  
   - Checked and removed duplicates  

3. **Data Type Conversion**  
   - Converted numerical columns to integers where needed  

4. **Year Consistency Check**  
   - Compared `year` and `released` columns, handled mismatches  

5. **Correlation Analysis**  
   - Scatter plots, regression plots, and correlation matrices  
   - Used Pearson, Kendall, and Spearman  

6. **Handling Categorical Data**  
   - Converted categorical features to numeric codes using `.cat.codes`  

7. **Expanded Correlation Analysis**  
   - Recomputed correlation matrix with numerized categorical features  

8. **Genre & Company Analysis**  
   - Visualized gross and scores by genre and production company  
   - Used box plots and median-value bar charts  

9. **Visualizing Distributions**  
   - Histograms and box plots for budget, gross, votes, etc.  

10. **Trend Analysis Over Time (Optional)**  
    - Median earnings and ratings across years  

11. **Interpretation & Narrative**  
    - Markdown notes for findings and storytelling  

---

## Key Findings  

-  **Budget strongly correlates with gross**  
-  **Votes correlate with gross**  
-  **Genres & large studios drive higher revenue**  
-  **Scores show weaker correlation with revenue**  

---

##  Skills Demonstrated  

- Data Loading & Inspection (**pandas**)  
- Data Cleaning & Handling Missing Values  
- Data Type Conversion  
- Exploratory Data Analysis (EDA)  
- Correlation Analysis (**Pearson, Kendall, Spearman**)  
- Data Visualization (**matplotlib, seaborn**)  
- Handling Categorical Data  
- Interpreting Statistical Measures  
- Data Grouping & Aggregation  

---

##  How to Run  

1. Clone this repository  
2. Install dependencies:  
   ```bash
   pip install pandas numpy matplotlib seaborn
