-- Hospital Readmissions Analysis
USE HospitalReadmissions;

-- Min, Max, and Averages of Numeric Fields
SELECT
	MIN(CAST(Denominator AS INT)) AS Min_Denominator,
	MAX(CAST(Denominator AS INT)) AS Max_Denominator,
    AVG(CAST(Denominator AS FLOAT)) AS Avg_Denominator,
    MIN(CAST(Score AS FLOAT)) AS Min_Score,
    MAX(CAST(Score AS FLOAT)) AS Max_Score,
    AVG(CAST(Score AS FLOAT)) AS Avg_Score
FROM HospitalData;

-- Distribution of Performance Compared to National Rate
SELECT Compared_to_National, COUNT(*) AS Count
FROM HospitalData
GROUP BY Compared_to_National;

-- Best 10 Performing Hospitals
SELECT TOP 10 Facility_Name, Score, Compared_to_National
FROM HospitalData
WHERE CAST(Score AS FLOAT) < 0
ORDER BY Score ASC;

---- Worst 10 Performing Hospitals
SELECT TOP 10 Facility_Name, Score, Compared_to_National
FROM HospitalData
WHERE CAST(Score AS FLOAT) > 0
ORDER BY Score DESC;

-- Average Readmissions Per Year
SELECT YEAR(Start_Date) AS YEAR,
	AVG(CAST(Score AS FLOAT)) AS Avg_Score
FROM HospitalData
GROUP BY YEAR(Start_Date)
ORDER BY Year ASC;

-- Hospital Performance Analysis
-- Goal: Identify hospitals performing above or below national averages and compare their metrics.

-- Hospitals performing better than national average
SELECT Facility_Name, AVG(CAST(Score AS FLOAT)) AS Avg_Score
FROM HospitalData
WHERE Compared_to_National = 'Better Than the National Rate'
GROUP BY Facility_Name
ORDER BY Avg_Score ASC;

-- How many hospitals are performing better/worse than national average
-- better, worse, no different, too few cases
SELECT 
    COUNT(CASE WHEN LOWER(TRIM(Compared_to_National)) LIKE 'better%' THEN 1 END) AS Better,
	COUNT(CASE WHEN LOWER(TRIM(Compared_to_National)) LIKE 'worse%' THEN 1 END) AS Worse,
	COUNT(CASE WHEN LOWER(TRIM(Compared_to_National)) = 'no different than national' THEN 1 END) AS No_Difference,
    COUNT(CASE WHEN LOWER(TRIM(Compared_to_National)) = 'number of cases too small' THEN 1 END) AS Too_Few_Cases,
    COUNT(CASE WHEN LOWER(TRIM(Compared_to_National)) NOT IN ('better than national', 'better than expected', 'worse than national', 'no different than national', 'number of cases too small') THEN 1 END) AS Uncategorized
FROM HospitalData;

-- Which conditions have the most readmissions
SELECT mm.Cleaned_Measure_Name, SUM(hd.Score) AS Total_Readmissions
FROM dbo.HospitalData hd
JOIN dbo.MeasureMapping mm ON hd.Measure_ID = mm.Measure_ID
WHERE hd.Score IS NOT NULL
GROUP BY mm.Cleaned_Measure_Name
ORDER BY Total_Readmissions DESC;

 Readmission rates by state
SELECT State, AVG(Score) AS Avg_Readmission_rate
FROM HospitalData
GROUP BY State;