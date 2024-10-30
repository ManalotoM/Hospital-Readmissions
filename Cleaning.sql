--Hospital Readmissions Cleaning
USE HospitalReadmissions;

--Idenitify columns that contain null, Not Applicable, or Not Available datapoints
SELECT 
    COUNT(CASE WHEN Facility_Name IS NULL OR Facility_Name = 'Not Available' OR Facility_Name = 'Not Applicable' THEN 1 END) AS Facility_Name_Null,
	COUNT(CASE WHEN Address IS NULL OR Address = 'Not Available' OR Address = 'Not Applicable' THEN 1 END) AS Address_Null,
	COUNT(CASE WHEN State IS NULL OR State = 'Not Available' OR State = 'Not Applicable' THEN 1 END) AS State_Null,
    COUNT(CASE WHEN State IS NULL OR State = 'Not Available' OR State = 'Not Applicable' THEN 1 END) AS State_Null,
    COUNT(CASE WHEN ZIP_Code IS NULL THEN 1 END) AS ZIP_Code_Null,
	COUNT(CASE WHEN County_Parish IS NULL OR County_Parish = 'Not Available' OR County_Parish = 'Not Applicable' THEN 1 END) AS County_Parish_Null,
    COUNT(CASE WHEN Measure_ID IS NULL THEN 1 END) AS Measure_ID_Null,
    COUNT(CASE WHEN Measure_Name IS NULL OR Measure_Name = 'Not Available' OR Measure_Name = 'Not Applicable' THEN 1 END) AS Measure_Name_Null,
    COUNT(CASE WHEN Compared_to_National IS NULL OR Compared_to_National = 'Not Available' OR Compared_to_National = 'Not Applicable' THEN 1 END) AS Compared_to_National_Null,
    COUNT(CASE WHEN Denominator IS NULL THEN 1 END) AS Denominator_Null,
    COUNT(CASE WHEN Score IS NULL THEN 1 END) AS Score_Null,
    COUNT(CASE WHEN Lower_Estimate IS NULL THEN 1 END) AS Lower_Estimate_Null,
    COUNT(CASE WHEN Higher_Estimate IS NULL THEN 1 END) AS Higher_Estimate_Null,
    COUNT(CASE WHEN Number_of_Patients IS NULL THEN 1 END) AS Number_of_Patients_Null,
    COUNT(CASE WHEN Number_of_Patients_Returned IS NULL THEN 1 END) AS Number_of_Patients_Returned_Null,
    COUNT(CASE WHEN Start_Date IS NULL THEN 1 END) AS Start_Date_Null,
    COUNT(CASE WHEN End_Date IS NULL THEN 1 END) AS End_Date_Null
FROM HospitalData;

--Remove Footnote and Telephone_Number column
ALTER TABLE HospitalData
DROP COLUMN Footnote;

ALTER TABLE HospitalData
DROP COLUMN Telephone_Number;

--Remove all rows with data NULL or "Not Available" for Denominator, Score, Lower Estimate, and Higher Estimate
DELETE FROM HospitalData
WHERE TRY_CAST(Denominator AS VARCHAR) = 'Not Available';

DELETE FROM HospitalData
WHERE Denominator IS NULL;

-- Make Measure_Name more readable and easier to query
CREATE TABLE MeasureMapping (
	Measure_ID VARCHAR(50) PRIMARY KEY,
	Cleaned_Measure_ID VARCHAR(50),
	Cleaned_Measure_Name VARCHAR(255)
);

-- Insert cleaned up values
INSERT INTO MeasureMapping (Measure_ID, Cleaned_Measure_ID, Cleaned_Measure_Name)
VALUES 
('READM_30_HIP_KNEE', 'Hip_Knee_Readmission', 'Readmission Rate after Hip/Knee Replacement'),
('READM_30_HF', 'Heart_Failure_Readmission', 'Heart Failure 30-Day Readmission Rate'),
('READM_30_PN', 'Pneumonia_Readmission', 'Pneumonia 30-Day Readmission Rate'),
('EDAC_30_PN', 'Pneumonia_Return_Days', 'Hospital Return Days for Pneumonia Patients'),
('EDAC_30_AMI', 'Heart_Attack_Return_Days', 'Hospital Return Days for Heart Attack Patients'),
('READM_30_COPD', 'COPD_Readmission', 'Chronic Obstructive Pulmonary Disease Readmission Rate'),
('OP_32', 'Colonoscopy_Unplanned_Visits', 'Unplanned Hospital Visits after Colonoscopy'),
('OP_35_ED', 'ED_Visits_Outpatient_Chemo', 'Emergency Department Visits for Outpatient Chemotherapy'),
('EDAC_30_HF', 'Heart_Failure_Return_Days', 'Hospital Return Days for Heart Failure Patients'),
('READM_30_AMI', 'Heart_Attack_Readmission', 'Acute Myocardial Infarction (Heart Attack) Readmission Rate'),
('READM_30_HOSP_WIDE', 'Hospital_Wide_Readmission', 'Hospital-Wide Readmission Rate'),
('OP_35_ADM', 'Chemo_Inpatient_Admissions', 'Inpatient Admissions for Outpatient Chemotherapy'),
('OP_36', 'Outpatient_Surgery_Visits', 'Unplanned Hospital Visits after Outpatient Surgery'),
('READM_30_CABG', 'CABG_Readmission', 'Readmission Rate for CABG (Heart Bypass Surgery)');

-- Join HospitalData with MeasureMapping
SELECT hd.Facility_Name, mm.Cleaned_Measure_Name, hd.Score, hd.Denominator
FROM HospitalData hd
JOIN MeasureMapping mm ON hd.Measure_ID = mm.Measure_ID
WHERE mm.Cleaned_Measure_ID = 'Heart_Failure_Readmission';

-- Update Measure_Name to be readable in dashboard
ALTER TABLE MeasureMapping
ADD ShortenedName VARCHAR(100);

--UPDATE MeasureMapping
SET ShortenedName = CASE
	WHEN Measure_ID = 'EDAC_30_AMI' THEN 'Heart Attack'
	WHEN Measure_ID = 'EDAC_30_HF' THEN 'Heart Failure'
	WHEN Measure_ID = 'EDAC_30_PN' THEN 'Pneumonia'
	WHEN Measure_ID = 'OP_32' THEN 'Colonoscopy'
	WHEN Measure_ID = 'OP_35_ADM' THEN 'Outpatient Chemo'
	WHEN Measure_ID = 'OP_35_ED' THEN 'ED Outpatient Chemo'
	WHEN Measure_ID = 'OP_36' THEN 'Outpatient Surgery'
	WHEN Measure_ID = 'READM_30_AMI' THEN 'Heart Attack'
	WHEN Measure_ID = 'READM_30_CABG' THEN 'CABG'
	WHEN Measure_ID = 'READM_30_COPD' THEN 'COPD'
	WHEN Measure_ID = 'READM_30_HF' THEN 'Heart Failure'
	WHEN Measure_ID = 'READM_30_HIP_KNEE' THEN 'Hip/Knee'
	WHEN Measure_ID = 'READM_30_PN' THEN 'Pneumonia'
	WHEN Measure_ID = 'READM_30_HOSP_WIDE' THEN 'Hospital-Wide Readmission Rate'
END

-- Add column to label types of Measure_ID
ALTER TABLE MeasureMapping
ADD MeasureGroup VARCHAR(50);

UPDATE MeasureMapping
SET MeasureGroup =
	CASE
		WHEN Measure_ID IN ('EDAC_30_AMI', 'EDAC_30_HF', 'EDAC_30_PN') THEN 'Return Days'
		WHEN Measure_ID IN ('OP_32', 'OP_35_ADM', 'OP_35_ED', 'OP_36') THEN 'Unplanned Visits'
		WHEN Measure_ID IN ('READM_30_AMI', 'READM_30_CABG', 'READM_30_COPD', 'READM_30_HF', 'READM_30_HIP_KNEE', 'READM_30_HOSP_WIDE', 'READM_30_PN') THEN 'Readmissions'
	END;
		
SELECT TOP (1000) [Measure_ID]
      ,[Cleaned_Measure_ID]
      ,[Cleaned_Measure_Name]
	  ,[ShortenedName]
	  ,[MeasureGroup]
  FROM [HospitalReadmissions].[dbo].[MeasureMapping]
