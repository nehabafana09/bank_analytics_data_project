USE BANK_ANALYTICS;
SELECT *FROM BANKING_DATA;

--- KPI 1 (TOTAL FUNDED AMOUNT) ---
SELECT SUM(`Funded Amount`) AS Total_Loan_Amount_Funded
FROM banking_data;


--- KPI 2 (TOTAL LOANS) ---
SELECT COUNT(*) AS Total_Loans
FROM banking_data;


--- KPI 3 (TOTAL COLLECTION) ---
SELECT SUM(`Total Payment`) AS Total_Collection
FROM banking_data;

--- KPI 4 (TOTAL INTEREST) ---
SELECT SUM(`Total Recovered int`) AS Total_Interest
FROM banking_data;


--- KPI 5 (BRANCH WISE LOAN) ---
SELECT 
  `Branch Name`,
  ROUND(SUM(`Total Recovered int` + `Total Fees` + `Recoveries`) / 1000000, 2) AS Total_Revenue_Millions
FROM banking_data
GROUP BY `Branch Name`
ORDER BY Total_Revenue_Millions DESC
Limit 10;


--- KPI 6 (STATE WISE LOAN) ---
SELECT 
  `State Name`,
  ROUND(SUM(`Funded Amount`) / 1000000, 2) AS Total_Loan_Amount_Millions
FROM banking_data
GROUP BY `State Name`
ORDER BY Total_Loan_Amount_Millions DESC
Limit 10;


--- KPI 7 (RELIGION WISE LOAN) ---
SELECT 
  Religion,
  ROUND(SUM(`Funded Amount`) / 1000000, 2) AS Total_Loans_Millions
FROM banking_data
GROUP BY Religion
ORDER BY Total_Loans_Millions DESC;


--- KPI 8 (PRODUCT_GROUP WISE LOAN) ---
SELECT 
  `Product Code`,
  ROUND(SUM(`Funded Amount`) / 1000000, 2) AS Total_Loans_Millions
FROM banking_data
GROUP BY `Product Code`
ORDER BY Total_Loans_Millions DESC;


--- KPI 9 (DISBURESEMENT TREND) ---
SELECT 
  t1.Year,
  ROUND(t1.Total_Disbursement / 10000000, 2) AS Total_Disbursement_Crores,
  ROUND(
    ((t1.Total_Disbursement - t2.Total_Disbursement) / t2.Total_Disbursement) * 100,
    2
  ) AS YoY_Growth_Percentage
FROM (
  SELECT 
    YEAR(STR_TO_DATE(`Disbursement Date`, '%d-%m-%Y')) AS Year,
    SUM(`Funded Amount`) AS Total_Disbursement
  FROM banking_data
  GROUP BY Year
) AS t1
LEFT JOIN (
  SELECT 
    YEAR(STR_TO_DATE(`Disbursement Date`, '%d-%m-%Y')) AS Year,
    SUM(`Funded Amount`) AS Total_Disbursement
  FROM banking_data
  GROUP BY Year
) AS t2
ON t1.Year = t2.Year + 1
ORDER BY t1.Year;


--- KPI 10 (GRADE WISE LOAN) ---
SELECT 
  Grade,
  ROUND(SUM(`Funded Amount`) / 1000000, 2) AS Total_Loans_Millions
FROM banking_data
GROUP BY Grade
ORDER BY Total_Loans_Millions DESC;


--- KPI 11 (DEFAULT_LAON COUNT) ---
SELECT 
  `State Name`,
  COUNT(*) AS Default_Loan_Count
FROM banking_data
WHERE TRIM(UPPER(`Is Default Loan`)) = 'Y'
GROUP BY `State Name`
ORDER BY Default_Loan_Count DESC;


--- KPI 12 (DELINQUENT LOAN COUNT) ---
SELECT 
  `State Name`,
  COUNT(DISTINCT CASE WHEN TRIM(UPPER(`Is Delinquent Loan`)) = 'Y' THEN `Client id` END) AS Delinquent_Client_Count
FROM banking_data
GROUP BY `State Name`
HAVING Delinquent_Client_Count > 0
ORDER BY Delinquent_Client_Count DESC;


--- KPI 13 (DELINQUENT LOAN RATE) ---
SELECT 
  ROUND(
    (SUM(CASE WHEN TRIM(UPPER(`Is Delinquent Loan`)) = 'Y' THEN 1 ELSE 0 END) / COUNT(*)) * 100,
    2
  ) AS Delinquent_Loan_Rate_Percent
FROM banking_data;


--- KPI 14 (DEFAULT_LOAN RATE) ---
SELECT 
  ROUND(
    (SUM(CASE WHEN TRIM(UPPER(`Is Default Loan`)) = 'Y' THEN 1 ELSE 0 END) / COUNT(*)) * 100,
    2
  ) AS Default_Loan_Rate_Percent
FROM banking_data;


--- KPI 15 (LOAN_STATUS WISE LOAN) ---
SELECT 
  `Loan Status`,
  ROUND(SUM(`Funded Amount`) / 1000000, 2) AS Total_Loans_in_Millions
FROM banking_data
GROUP BY `Loan Status`
ORDER BY Total_Loans_in_Millions DESC;


--- KPI 16 (AGE_GROUP WISE LOAN) ---
SELECT 
  CASE
    WHEN CAST(`Age` AS UNSIGNED) < 25 THEN 'Below 25'
    WHEN CAST(`Age` AS UNSIGNED) BETWEEN 25 AND 35 THEN '25-35'
    WHEN CAST(`Age` AS UNSIGNED) BETWEEN 36 AND 45 THEN '36-45'
    WHEN CAST(`Age` AS UNSIGNED) BETWEEN 46 AND 60 THEN '46-60'
    ELSE '60+'
  END AS Age_Group,
  ROUND(SUM(`Funded Amount`) / 1000000, 2) AS Total_Loans_in_Millions
FROM banking_data
GROUP BY Age_Group
ORDER BY Total_Loans_in_Millions DESC;

--- KPI 17 (LOAN MATURITY) ---
SELECT 
  YEAR(
    DATE_ADD(
      STR_TO_DATE(`Disbursement Date`, '%d-%m-%Y'),
      INTERVAL CAST(TRIM(`Term`) AS UNSIGNED) MONTH
    )
  ) AS Maturity_Year,
  COUNT(*) AS Total_Loans,
  ROUND(SUM(`Funded Amount`) / 1000000, 2) AS Total_Funded_in_Millions
FROM banking_data
WHERE `Disbursement Date` IS NOT NULL AND `Term` <> ''
GROUP BY Maturity_Year
ORDER BY Maturity_Year;

--- KPI 18 (NO_VERIFIED LOAN) ---
SELECT COUNT(*) AS No_Verified_Loans
FROM banking_data
WHERE `Verification Status` IS NULL OR `Verification Status` IN ('Not Verified', '');