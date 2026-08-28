# SQL Server Time Intelligence Analysis

## 📌 Project Overview

This project demonstrates how **time intelligence analysis can be performed using SQL Server** to uncover trends and patterns in business performance over time.

The analysis uses sales data to answer practical business questions involving **yearly, monthly, quarterly, MoM (Month-over-Month), and YoY (Year-over-Year) performance**.

Rather than focusing only on writing SQL queries, this project focuses on using SQL to answer meaningful **business and analytical questions**.

---

## 🎯 Project Objectives

The main objectives of this project are to:

* Analyze revenue and profit performance over time
* Compare business performance across years, months, and quarters
* Identify periods with the highest revenue or profit
* Calculate Month-over-Month (MoM) revenue growth
* Calculate Year-over-Year (YoY) profit growth
* Compare quarterly performance across different years
* Identify high-performing regions and sales channels
* Practice SQL Server date and window functions for time-based analysis

---

## 🛠️ Tools & Technologies

* **SQL Server**
* **SQL**
* Common Table Expressions (CTEs)
* Aggregate Functions
* Date Functions
* Window Functions

### SQL Techniques Used

Some of the key SQL functions and techniques used include:

```sql
YEAR()
MONTH()
DATEPART()
DATENAME()
SUM()
AVG()
RANK()
LAG()
PARTITION BY
GROUP BY
ORDER BY
CTEs
```

---

## 📊 Business Questions

The project answers questions such as:

1. What was the total revenue generated in each year?
2. Which month recorded the highest revenue across all years?
3. What was the total profit earned in each quarter?
4. How many units were sold in each month?
5. Which weekday generated the highest average revenue?
6. How did revenue compare between Q1 and Q4 for each year?
7. Which region generated the highest revenue in 2024?
8. Which sales channel generated the highest profit overall?
9. What was the Month-over-Month (MoM) revenue growth for each month?
10. Which quarter had the strongest profit growth compared with the same quarter in the previous year?

---

## 🔍 Key SQL Concepts

### 1. Date-Based Aggregation

The project uses SQL Server date functions to group transactions by:

* Year
* Month
* Quarter
* Weekday

Example:

```sql
SELECT
    YEAR(OrderDate) AS [Year],
    SUM(Revenue) AS Total_Revenue
FROM Retail_Data
GROUP BY YEAR(OrderDate)
ORDER BY [Year];
```

---

### 2. Month-over-Month Growth

`LAG()` is used to retrieve the previous month's revenue and calculate the percentage change.

Conceptually:

**MoM Growth = (Current Month Revenue − Previous Month Revenue) ÷ Previous Month Revenue × 100**

This makes it possible to identify periods of revenue growth and decline.

---

### 3. Year-over-Year Growth

The project also uses:

```sql
LAG() OVER (
    PARTITION BY [Quarter]
    ORDER BY [Year]
)
```

This allows the same quarter to be compared across different years.

For example:

**Q1 2024 → Q1 2023**

**Q2 2024 → Q2 2023**

**Q3 2024 → Q3 2023**

**Q4 2024 → Q4 2023**

---

## 📈 Analytical Focus

The main focus of this project is understanding how **time affects business performance**.

The analysis looks beyond individual transactions and examines broader patterns such as:

* Revenue trends
* Profit trends
* Seasonal performance
* Monthly growth
* Quarterly performance
* Yearly changes
* Regional performance
* Sales channel performance

---

## 💡 Key Learning

One of the main lessons from this project is that **writing SQL that runs successfully is not the same as writing SQL that correctly answers a business question.**

Time-based analysis requires careful consideration of:

* What time period is being compared?
* What metric is being measured?
* What is the appropriate aggregation?
* Should the comparison be MoM or YoY?
* Are we comparing revenue, profit, units, or averages?

This project helped strengthen both my **SQL skills and analytical thinking**.

---

## 📂 Project Structure

```text
SQL-Time-Intelligence/
│
├── README.md
├── Retail_Data.csv
└── Time_Intelligence_Analysis.sql
```

---

## 🚀 Conclusion

This project demonstrates how **SQL Server can be used for time intelligence analysis** without relying on a BI tool.

By combining SQL aggregation, date functions, CTEs, and window functions, it is possible to perform meaningful time-based analysis and generate insights that can support business decision-making.

**Tools:** SQL Server | SQL | Data Analytics

**Focus:** Time Intelligence | Business Analysis | Revenue & Profit Analysis
