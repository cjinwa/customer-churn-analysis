-- Data Overview
-- Check for missing values and understand data distribution
SELECT 
    COLUMN_NAME, 
    SUM(CASE WHEN COLUMN_NAME IS NULL THEN 1 ELSE 0 END) AS MissingCount
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'CreditcardData'
GROUP BY COLUMN_NAME;

-- Basic statistics for numerical columns
SELECT 
    MIN(Customer_Age) AS MinAge, MAX(Customer_Age) AS MaxAge, AVG(Customer_Age) AS AvgAge,
    MIN(Credit_Limit) AS MinCreditLimit, MAX(Credit_Limit) AS MaxCreditLimit, AVG(Credit_Limit) AS AvgCreditLimit
FROM CreditcardData;

-- Churn Distribution
-- Analyze the churn rate
SELECT 
    Attrition_Flag, 
    COUNT(*) AS CustomerCount,
    COUNT(*) * 1.0 / SUM(COUNT(*)) OVER () AS ChurnRate
FROM CreditcardData
GROUP BY Attrition_Flag;

-- Demographic Trends
-- Explore gender and marital status differences
SELECT 
    Attrition_Flag,
    Gender,
    Marital_Status,
    COUNT(*) AS Count
FROM CreditcardData
GROUP BY Attrition_Flag, Gender, Marital_Status;

-- Financial Behavior
-- Evaluate credit limits, revolving balances, and income levels
SELECT 
    Attrition_Flag,
    AVG(Credit_Limit) AS AvgCreditLimit,
    AVG(Total_Revolving_Bal) AS AvgRevolvingBal,
    MAX(Income_Category) AS CommonIncomeCategory
FROM CreditcardData
GROUP BY Attrition_Flag;

-- Transaction Patterns
-- Identify trends in transaction amounts and counts
SELECT 
    Attrition_Flag,
    AVG(Total_Trans_Amt_last_12_months) AS AvgTransactionAmt,
    AVG(Total_Trans_Ct_last_12_months) AS AvgTransactionCt
FROM CreditcardData
GROUP BY Attrition_Flag;

-- Age Analysis
-- Understand the role of age in churn
SELECT 
    Attrition_Flag,
    MIN(Customer_Age) AS MinAge,
    MAX(Customer_Age) AS MaxAge,
    AVG(Customer_Age) AS AvgAge
FROM CreditcardData
GROUP BY Attrition_Flag;

-- Retention Insights
-- Identify characteristics of high-risk churn customers
SELECT 
    CLIENTNUM,
    Attrition_Flag,
    Customer_Age,
    Credit_Limit,
    Total_Trans_Amt_last_12_months,
    Total_Trans_Ct_last_12_months
FROM CreditcardData
WHERE Attrition_Flag = 'Attrited Customer'
ORDER BY Total_Trans_Ct_last_12_months ASC, Total_Trans_Amt_last_12_months ASC;
