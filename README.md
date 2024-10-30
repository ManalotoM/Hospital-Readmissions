# Hospital Insights - Readmission and Performance Analysis
This project analyzes hospital readmissions data with the goal of identifying patterns and insights related to hospital performance. The project focuses on metrics like readmission rates, return days, and unplanned visits to evaluate and compare hospitals, aiming to provide actionable insights that could help healthcare institutions improve patient outcomes.

testing
###Place 1

Hello, this is some text to fill in this, [here]([place2](https://stackoverflow.com/questions/27981247/github-markdown-same-page-link)), is a link to the second place.


# Dataset Summary
This dataset, "Unplanned Hospital Visits: Provider Data," is released by Medicare to analyze provider performance on three primary measures:
1. Excess Days in Acute Care (EDAC), or return days,
2. Unplanned Readmissions following inpatient admissions, and
3. Unplanned Visits after outpatient procedures.
These measures provide insight into hospital quality and patient outcomes without requiring manual reporting from hospitals. Instead, they are calculated using Medicare claims and eligibility data, with data for some conditions (such as COPD, heart attack, heart failure, pneumonia, hip/knee replacement, and others) also sourced from VHA data. This claims-based approach offers comparable accuracy to chart reviews when calculating readmission and hospital visit rates.

Note: Data from the first and second quarters of 2020 is excluded due to the COVID-19 pandemic's impact on hospital services.

**Score Definition and Adjustment**
Each hospital’s Score represents the number of observed events—readmissions, return days, or unplanned visits—attributed to its performance. This score is risk-adjusted to account for patient characteristics such as age, medical history, and comorbidities that may increase readmission likelihood, allowing for fairer comparisons between hospitals.

For each measure:
- Readmission and hospital visit rates are compared to a national benchmark. Hospitals fall into categories based on whether their interval estimate (a 95% confidence interval) is above, below, or within the national average.
- Return days are benchmarked against zero, with hospitals categorized based on whether their result lies above, below, or includes zero.
Hospitals with too few cases for reliable estimates are marked accordingly. This classification framework ensures that results account for variability and are representative of each hospital’s relative performance.


# Data Cleaning







# Data Source
For more information on the dataset, please refer to the CMS dataset documentation.

