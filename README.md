# Project Background
This project analyzes hospital readmissions data with the goal of identifying patterns and insights related to hospital performance. The project aims to provide actionable insights that will help healthcare institutions improve patient outcomes, focusing on three primary measures:
1. Excess Days in Acute Care (EDAC), or return days,
2. Unplanned Readmissions following inpatient admissions, and
3. Unplanned Visits after outpatient procedures.
These measures provide insight into hospital quality and patient outcomes without requiring manual reporting from hospitals. Instead, they are calculated using Medicare claims and eligibility data, with data for some conditions (such as COPD, heart attack, heart failure, pneumonia, hip/knee replacement, and others) also sourced from VHA data. This claims-based approach offers comparable accuracy to chart reviews when calculating readmission and hospital visit rates.

An interactive Power BI dashboard can be downloaded [here](https://thetexthubllc-my.sharepoint.com/:u:/g/personal/mark_manaloto_thetexthub_com/EU89TJB1Ky5Nibv5BEbI5IoBwr63kmqy2LvV-8dNzh7FfQ?e=Uade9E).

The SQL queries utilized to clean, organize, and prepare data for the dashboard can be found [here](https://github.com/ManalotoM/Hospital-Readmissions/blob/main/Cleaning.sql).

The SQL queries regarding various business questions can be found [here](https://github.com/ManalotoM/Hospital-Readmissions/blob/main/Analysis.sql).

# Data Structure Overview

# Executive Summary

# Insights Deep Dive

# Recommmendations




Note: Data from the first and second quarters of 2020 is excluded due to the COVID-19 pandemic's impact on hospital services.

**Score Definition and Adjustment**
Each hospital’s Score represents the number of observed events—readmissions, return days, or unplanned visits—attributed to its performance. This score is risk-adjusted to account for patient characteristics such as age, medical history, and comorbidities that may increase readmission likelihood, allowing for fairer comparisons between hospitals.

For each measure:
- Readmission and hospital visit rates are compared to a national benchmark. Hospitals fall into categories based on whether their interval estimate (a 95% confidence interval) is above, below, or within the national average.
- Return days are benchmarked against zero, with hospitals categorized based on whether their result lies above, below, or includes zero.
Hospitals with too few cases for reliable estimates are marked accordingly. This classification framework ensures that results account for variability and are representative of each hospital’s relative performance.


# Data Import and Cleaning
created tables with defined data types
The raw dataset was imported into SQL Server, where initial cleaning steps were taken to ensure data quality. The steps involved:
- Identifying null values, "Not Applicable," and "Not Available" entries across key columns.
- Removing rows with null or unavailable values in critical fields like Denominator and Score.
- Dropping unnecessary columns, such as Footnote and Telephone_Number.

In Cleaning.sql, a custom table called MeasureMapping was created to map technical measure IDs to user-friendly names. Each measure, such as "Readmission Rate after Hip/Knee Replacement" or "Heart Failure 30-Day Readmission Rate," was given a readable name to improve the clarity of analysis and visualizations. Additionally, a MeasureGroup field was added to categorize measures into groups Readmissions, Return Days, and Unplanned Visits.

# Data Analysis in SQL
SQL scripts in Analysis.sql were used to perform calculations and aggregations to extract meaningful insights:
- Summary statistics (min, max, average) for numerical fields.
- Distribution of hospital performance against the national rate.
- Identification of top and bottom performing hospitals based on readmission rates.
- Average readmission rates by year and state.
- Analysis of readmission rates by specific conditions.

# Further Investigation topics
- hospital scores over time
- cost



# Data Source
For more information on the [dataset](https://data.cms.gov/provider-data/dataset/632h-zaca#data-table), please refer to the [CMS dataset documentation]([https://data.cms.gov/provider-data/dataset/632h-zaca#data-table](https://data.cms.gov/provider-data/topics/hospitals/unplanned-hospital-visits)).

