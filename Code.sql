-- Data cleaning 
SELECT Sample_ID, COUNT(*) AS duplicate_count
FROM cinnamon_quality_classification.balanced_cinnamon_quality_dataset
GROUP BY Sample_ID
HAVING COUNT(*) > 1;

SELECT DISTINCT Quality_Label
FROM cinnamon_quality_classification.balanced_cinnamon_quality_dataset;

UPDATE cinnamon_quality_classification.balanced_cinnamon_quality_dataset
SET Quality_Label = INITCAP(TRIM(Quality_Label));

SELECT *,
  (Coumarin - stats.avg_val) / stats.std_val AS z_score
FROM cinnamon_quality_classification.balanced_cinnamon_quality_dataset,
(
  SELECT AVG(Coumarin) AS avg_val, STDDEV(Coumarin) AS std_val
  FROM cinnamon_quality_classification.balanced_cinnamon_quality_dataset
) AS stats
HAVING z_score > 2 OR z_score < -2;

SELECT *
FROM cinnamon_quality_classification.balanced_cinnamon_quality_dataset
WHERE Moisture < 9 OR Moisture > 15
   OR Ash < 5 OR Ash > 8
   OR Volatile_Oil < 0.5 OR Volatile_Oil > 1.6
   OR Acid_Insoluble_Ash > 0.8
   OR Chromium > 0.004
   OR Coumarin > 0.02;

SELECT 
  Quality_Label,
  ROUND(AVG(Moisture), 2) AS Avg_Moisture,
  ROUND(AVG(Ash), 2) AS Avg_Ash,
  ROUND(AVG(Volatile_Oil), 2) AS Avg_Volatile_Oil,
  ROUND(AVG(Acid_Insoluble_Ash), 2) AS Avg_AcidAsh,
  ROUND(AVG(Chromium), 6) AS Avg_Chromium,
  ROUND(AVG(Coumarin), 6) AS Avg_Coumarin
FROM cinnamon_quality_classification.balanced_cinnamon_quality_dataset
GROUP BY Quality_Label;

SELECT Sample_ID, Quality_Label,
  CASE WHEN Moisture BETWEEN 10 AND 12 THEN 1 ELSE 0 END +
  CASE WHEN Ash BETWEEN 5.5 AND 6.5 THEN 1 ELSE 0 END +
  CASE WHEN Volatile_Oil > 1.1 THEN 1 ELSE 0 END +
  CASE WHEN Acid_Insoluble_Ash < 0.4 THEN 1 ELSE 0 END +
  CASE WHEN Chromium < 0.002 THEN 1 ELSE 0 END +
  CASE WHEN Coumarin < 0.005 THEN 1 ELSE 0 END 
  AS quality_score_out_of_6
FROM cinnamon_quality_classification.balanced_cinnamon_quality_dataset
ORDER BY quality_score_out_of_6 DESC;

SELECT DISTINCT Quality_Label FROM balanced_cinnamon_quality_dataset;

SELECT 
  Quality_Label,
  ROUND(AVG(`Moisture (%)`), 2) AS Avg_Moisture,
  ROUND(AVG(`Ash (%)`), 2) AS Avg_Ash,
  ROUND(AVG(`Volatile_Oil (%)`), 2) AS Avg_Oil,
  ROUND(AVG(`Acid_Insoluble_Ash (%)`), 2) AS Avg_AcidAsh,
  ROUND(AVG(`Chromium (mg/kg)`), 6) AS Avg_Chromium,
  ROUND(AVG(`Coumarin (mg/kg)`), 6) AS Avg_Coumarin
FROM balanced_cinnamon_quality_dataset
GROUP BY Quality_Label;

SELECT Sample_ID, Quality_Label,
  CASE WHEN `Moisture (%)` BETWEEN 10 AND 12 THEN 1 ELSE 0 END +
  CASE WHEN `Ash (%)` BETWEEN 5.5 AND 6.5 THEN 1 ELSE 0 END +
  CASE WHEN `Volatile_Oil (%)` > 1.1 THEN 1 ELSE 0 END +
  CASE WHEN `Acid_Insoluble_Ash (%)` < 0.4 THEN 1 ELSE 0 END +
  CASE WHEN `Chromium (mg/kg)` < 0.002 THEN 1 ELSE 0 END +
  CASE WHEN `Coumarin (mg/kg)` < 0.005 THEN 1 ELSE 0 END AS quality_score_out_of_6
FROM balanced_cinnamon_quality_dataset
ORDER BY quality_score_out_of_6 DESC;

SELECT 
  Quality_Label,
  COUNT(*) AS Samples,
  ROUND(STDDEV(`Volatile_Oil (%)`), 3) AS Oil_Variability,
  ROUND(MAX(`Coumarin (mg/kg)`), 4) AS Max_Coumarin,
  ROUND(MIN(`Acid_Insoluble_Ash (%)`), 2) AS Min_Acid_Ash
FROM balanced_cinnamon_quality_dataset
GROUP BY Quality_Label;

SELECT 
  Quality_Label,
  COUNT(*) AS Samples,
  ROUND(STDDEV(`Volatile_Oil (%)`), 3) AS Oil_Variability,
  ROUND(MAX(`Coumarin (mg/kg)`), 4) AS Max_Coumarin,
  ROUND(MIN(`Acid_Insoluble_Ash (%)`), 2) AS Min_Acid_Ash
FROM balanced_cinnamon_quality_dataset
GROUP BY Quality_Label;

-- 1. Check unique labels (for quality check)
SELECT DISTINCT Quality_Label
FROM cinnamon_quality_classification.balanced_cinnamon_quality_dataset;

-- 2. Summary statistics by Quality_Label
SELECT 
  Quality_Label,
  ROUND(AVG(`Moisture (%)`), 2) AS Avg_Moisture,
  ROUND(STDDEV(`Moisture (%)`), 2) AS Std_Moisture,
  ROUND(AVG(`Ash (%)`), 2) AS Avg_Ash,
  ROUND(STDDEV(`Ash (%)`), 2) AS Std_Ash,
  ROUND(AVG(`Volatile_Oil (%)`), 2) AS Avg_Oil,
  ROUND(STDDEV(`Volatile_Oil (%)`), 2) AS Std_Oil,
  ROUND(AVG(`Acid_Insoluble_Ash (%)`), 2) AS Avg_AcidAsh,
  ROUND(STDDEV(`Acid_Insoluble_Ash (%)`), 2) AS Std_AcidAsh,
  ROUND(AVG(`Chromium (mg/kg)`), 4) AS Avg_Chromium,
  ROUND(STDDEV(`Chromium (mg/kg)`), 4) AS Std_Chromium,
  ROUND(AVG(`Coumarin (mg/kg)`), 4) AS Avg_Coumarin,
  ROUND(STDDEV(`Coumarin (mg/kg)`), 4) AS Std_Coumarin
FROM cinnamon_quality_classification.balanced_cinnamon_quality_dataset
GROUP BY Quality_Label;

-- 3. Rule-based Quality Scoring System (out of 6)
SELECT 
  Sample_ID,
  Quality_Label,
  CASE WHEN `Moisture (%)` BETWEEN 10 AND 12 THEN 1 ELSE 0 END +
  CASE WHEN `Ash (%)` BETWEEN 5.5 AND 6.5 THEN 1 ELSE 0 END +
  CASE WHEN `Volatile_Oil (%)` > 1.1 THEN 1 ELSE 0 END +
  CASE WHEN `Acid_Insoluble_Ash (%)` < 0.4 THEN 1 ELSE 0 END +
  CASE WHEN `Chromium (mg/kg)` < 0.002 THEN 1 ELSE 0 END +
  CASE WHEN `Coumarin (mg/kg)` < 0.005 THEN 1 ELSE 0 END 
  AS quality_score_out_of_6
FROM cinnamon_quality_classification.balanced_cinnamon_quality_dataset
ORDER BY quality_score_out_of_6 DESC;

-- 4. Optional index creation (for performance if working with larger datasets)
-- CREATE INDEX idx_quality_label ON cinnamon_quality_classification.balanced_cinnamon_quality_dataset(Quality_Label);

