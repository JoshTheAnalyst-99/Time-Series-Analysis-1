SELECT * FROM Retail_Data

ALTER TABLE Retail_Data
ALTER COLUMN UnitPrice DECIMAL (10,2)

ALTER TABLE Retail_Data
ALTER COLUMN Revenue DECIMAL (10,2)

ALTER TABLE Retail_Data
ALTER COLUMN Cost DECIMAL (10,2)

ALTER TABLE Retail_Data
ALTER COLUMN Profit DECIMAL (10,2)

-- 1. What is the total revenue generated in each year?
SELECT
	[Year],
	SUM(Revenue)	AS Revenue
FROM Retail_Data
GROUP BY [Year]
ORDER BY [Year] ASC

-- Alternative
SELECT
	YEAR(OrderDate) [Year],
	SUM(Revenue)	Revenue
FROM Retail_Data
GROUP BY YEAR(OrderDate)
ORDER BY YEAR(OrderDate) ASC

-- 2. Which month recorded the highest revenue across all three years?
WITH DateCalc AS (
SELECT
	MONTH(OrderDate)							AS  MonthNo,
	DATENAME("M", OrderDate)					AS	Month_Name, 
	SUM(Revenue)								AS	Total_Revenue,
	RANK() OVER (ORDER BY SUM(Revenue) DESC)	AS	Rnk
FROM Retail_Data
GROUP BY MONTH(OrderDate),DATENAME("M", OrderDate)
)
SELECT
	Month_Name,
	Total_Revenue,
	Rnk
FROM DateCalc
WHERE Rnk = 1

-- 3. What is the total profit earned in each quarter

SELECT
	DATEPART("Q",ORDERDATE)		AS [Quarter],
	SUM(Profit)					AS Total_Profit
FROM Retail_Data
GROUP BY DATEPART("Q",ORDERDATE)
ORDER BY DATEPART("Q",OrderDate) ASC

-- 4. DATENAME("Q",OrderDate)
SELECT
	MONTH(OrderDate)	AS [Month],
	SUM(UnitsSold)		AS Units_Sold
FROM Retail_Data
GROUP BY MONTH(OrderDate)
ORDER BY [Month] ASC

-- 5. Which weekday generates the highest average revenue
SELECT
	TOP 1
	DATEPART(WEEKDAY,OrderDate)			AS Week_Day,
	CAST(AVG(Revenue) AS DECIMAL(10,2)) AS Average_Revenue
FROM Retail_Data
GROUP BY DATEPART(WEEKDAY,OrderDate)
ORDER BY Average_Revenue DESC

-- 7. Compare revenue between Q1 and Q4 for each year
WITH DateCalc AS (
SELECT
	DATEPART(YEAR, OrderDate)	 AS [Year],
	DATEPART(QUARTER, OrderDate) AS [Quarter],
	SUM(Revenue)				 AS Total_Revenue
FROM Retail_Data
GROUP BY DATEPART(YEAR, OrderDate), DATEPART(QUARTER, OrderDate)
)
SELECT
	[Year],
	[Quarter],
	Total_Revenue
FROM DateCalc
WHERE [Quarter] IN (1,4)
ORDER BY [Year] ASC, [Quarter] ASC

-- Alternatively
WITH QuarterlyRevenue AS (
    SELECT
        YEAR(OrderDate) AS [Year],
        DATEPART(QUARTER, OrderDate) AS [Quarter],
        SUM(Revenue) AS Total_Revenue
    FROM Retail_Data
    GROUP BY
        YEAR(OrderDate),
        DATEPART(QUARTER, OrderDate)
)
SELECT
    [Year],
    MAX(CASE WHEN [Quarter] = 1 THEN Total_Revenue END) AS Q1_Revenue,
    MAX(CASE WHEN [Quarter] = 4 THEN Total_Revenue END) AS Q4_Revenue,
    MAX(CASE WHEN [Quarter] = 4 THEN Total_Revenue END)
      - MAX(CASE WHEN [Quarter] = 1 THEN Total_Revenue END) AS Q4_vs_Q1
FROM QuarterlyRevenue
GROUP BY [Year]
ORDER BY [Year];


-- 8. Which region generated the highest revenue in 2024?
SELECT TOP 1
	Region,
	SUM(Revenue)				AS Total_Revenue,
	DATEPART(YEAR, OrderDate)	AS [Year]
FROM Retail_Data
GROUP BY Region, DATEPART(YEAR, OrderDate)
HAVING DATEPART(YEAR, OrderDate) = 2024
ORDER BY Total_Revenue DESC

-- 9. Which sales channel generated the highest profit overall?
SELECT TOP 1
	SalesChannel,
	SUM(Profit)		AS Total_Revenue
FROM RETAIL_DATA
GROUP BY SalesChannel
ORDER BY Total_Revenue DESC


-- 10. What is the Month-over-Month (MoM) revenue growth for every month?
WITH DatedCalc AS (
SELECT
	MONTH(OrderDATE)				AS Month_No,
	YEAR(OrderDate)					AS [Year],
	DATENAME(MONTH, OrderDate)		AS [Month],
	SUM(Revenue)					AS Total_Revenue
FROM Retail_Data
GROUP BY MONTH(OrderDATE), YEAR(OrderDate),	DATENAME(MONTH, OrderDate)
)
SELECT
	[Year],
	[Month],
	Total_Revenue,
	CAST((100.0 * (Total_Revenue - LAG(Total_Revenue) OVER (ORDER BY [Year] ASC, Month_No ASC))) / NULLIF(LAG(Total_Revenue) OVER (ORDER BY [Year] ASC, Month_No ASC),0) AS DECIMAL(10,2))
FROM DatedCalc

-- Which quarter has the strongest profit growth compared to the same quarter last year?
WITH DateCalc AS (
    SELECT
        DATEPART(YEAR, OrderDate) AS [Year],
        DATEPART(QUARTER, OrderDate) AS [Quarter],
        SUM(Profit) AS Total_Profit
    FROM Retail_Data
    GROUP BY
        DATEPART(YEAR, OrderDate),
        DATEPART(QUARTER, OrderDate)
),
ProfitGrowth AS (
    SELECT
        [Year],
        [Quarter],
        Total_Profit,
        LAG(Total_Profit, 1) OVER (
            PARTITION BY [Quarter]
            ORDER BY [Year]
        ) AS Previous_Year_Profit
    FROM DateCalc
)
SELECT TOP 1
    [Year],
    [Quarter],
    Total_Profit,
    Previous_Year_Profit,
    Total_Profit - Previous_Year_Profit AS Profit_Growth,
    (Total_Profit - Previous_Year_Profit) * 100.0
        / NULLIF(Previous_Year_Profit, 0) AS Growth_Percentage
FROM ProfitGrowth
WHERE Previous_Year_Profit IS NOT NULL
ORDER BY Growth_Percentage DESC;



