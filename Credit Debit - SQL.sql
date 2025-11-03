USE BANK_ANALYTICS;
SELECT *FROM DEBIT_CREDIT;

-- 1. Total Credit Amount
SELECT 
  CONCAT(ROUND(SUM(CASE WHEN `Transaction Type` = 'Credit' THEN Amount ELSE 0 END)/1000000), ' M') AS Total_Credit_Amount
FROM debit_credit;


-- 2. Total Debit Amount
SELECT 
  CONCAT(ROUND(SUM(CASE WHEN `Transaction Type` = 'Debit' THEN Amount ELSE 0 END)/1000000), ' M') AS Total_Debit_Amount
FROM debit_credit;


-- 3. Credit to Debit Ratio
SELECT 
  CONCAT(
    ROUND(
      (SUM(CASE WHEN `Transaction Type` = 'Credit' THEN Amount ELSE 0 END) * 100.0 /
       SUM(CASE WHEN `Transaction Type` = 'Debit' THEN Amount ELSE 0 END))
    ),
    ' %'
  ) AS Credit_to_Debit_Ratio_Percentage
FROM debit_credit;


-- 4. Net Transaction Amount
SELECT 
  ROUND(
    SUM(CASE WHEN `Transaction Type` = 'Credit' THEN Amount ELSE 0 END) -
    SUM(CASE WHEN `Transaction Type` = 'Debit' THEN Amount ELSE 0 END)
  ) AS Net_Transaction_Amount
FROM debit_credit;


-- 5. Account Activity Ratio
SELECT 
  ROUND(
    (COUNT(*) * 1.0) / NULLIF(SUM(`Balance`),0) * 100,4
  ) AS Account_Activity_Ratio_Percent
FROM debit_credit;


-- 6. Transaction per Month/Day
SELECT Month, Transactions_Per_Month
FROM (
  SELECT 
    COALESCE(
      DATE_FORMAT(STR_TO_DATE(TRIM(`Transaction Date`), '%d-%m-%Y'), '%Y-%m'),
      DATE_FORMAT(STR_TO_DATE(TRIM(`Transaction Date`), '%Y-%m-%d'), '%Y-%m'),
      DATE_FORMAT(STR_TO_DATE(TRIM(`Transaction Date`), '%d/%m/%Y'), '%Y-%m')
    ) AS Month,
    COUNT(*) AS Transactions_Per_Month
  FROM debit_credit
  WHERE TRIM(`Transaction Date`) <> ''
  GROUP BY Month
) AS t
WHERE Month IS NOT NULL
ORDER BY Month;

SELECT Day, Transactions_Per_Day
FROM (
  SELECT 
    COALESCE(
      DATE_FORMAT(STR_TO_DATE(TRIM(`Transaction Date`), '%d-%m-%Y'), '%Y-%m'),
      DATE_FORMAT(STR_TO_DATE(TRIM(`Transaction Date`), '%Y-%m-%d'), '%Y-%m'),
      DATE_FORMAT(STR_TO_DATE(TRIM(`Transaction Date`), '%d/%m/%Y'), '%Y-%m')
    ) AS day,
    COUNT(*) AS Transactions_Per_Day
  FROM debit_credit
  WHERE TRIM(`Transaction Date`) <> ''
  GROUP BY day
) AS t
WHERE day IS NOT NULL
ORDER BY day;	


-- 7. Total transaction Amount by Branch
select branch, concat(round(sum(amount)/1000000,2)," M ") as Total_transaction_amount 
from debit_credit group by branch;