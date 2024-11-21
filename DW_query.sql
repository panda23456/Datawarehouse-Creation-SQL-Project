/*Provide meaningful queries that can be supported by your data warehouse that can
draw insights regarding below questions. Submit your queries (in “DW_query.sql”),
results and your discussion. Some possible insights include trend over time or other
meaning dimension(s).
1. Demonstrate insights about profits.
2. Demonstrate insights on customer and orders.
3. Demonstrate insights about employees.
The queries should provide insightful findings to the owner of SPAI. You can submit up
to 2 queries for each of the questions above. Explain what insights are found from query
results.
*/

-- Qn 1 (Demonstrate insights about profits.)
-- Analysis is to understand the trends in profits and order volumes over time. (Query 1)

SELECT 
    t.[Year],
    t.[Quarter],
    SUM(f.Price) AS TotalProfit,
    COUNT(f.OrderSK) AS TotalOrders
FROM 
    SPAIDW2A0306.dbo.fact_table f
JOIN 
    SPAIDW2A0306.dbo.time_dimension t ON f.TimeSK = t.TimeSK
GROUP BY 
    t.[Year], t.[Quarter]
ORDER BY 
    t.[Year], t.[Quarter];

-- Identify the total profit generated and the average required accuracy for each model type (Query 2)
SELECT 
    mt.ModelType,
    SUM(f.Price) AS TotalProfit,
    AVG(f.RequiredAcc) AS AvgRequiredAccuracy
FROM 
    SPAIDW2A0306.dbo.fact_table f
JOIN 
    SPAIDW2A0306.dbo.model_dimension m ON f.ModelSK = m.ModelSK
JOIN 
    SPAIDW2A0306.dbo.modeltype_dimension mt ON m.ModelCode = mt.ModelCode
GROUP BY 
    mt.ModelType
ORDER BY 
    TotalProfit DESC;

--Qn 2 (Demonstrate insights on customer and orders.)
--Who the top customers are based on revenue that they  bring to the Company(Query 1)
SELECT 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    COUNT(f.OrderSK) AS TotalOrders,
	SUM(f.Price) AS TotalSales,
	SUM(f.Price) / COUNT(f.OrderSK) AS AverageRevenuePerOrder
FROM 
    fact_table f
JOIN 
    customer_dimension c ON f.CustomerSK = c.CustomerSK
GROUP BY 
    c.CustomerID, c.FirstName, c.LastName
ORDER BY 
    TotalSales DESC;

--When do the volume of orders increase, whether revenue generated is strongly correlated with order volume and how order numbers and revenue has changed over the years by quarter(Query 2)
SELECT 
    t.Year,
    t.Quarter,
    COUNT(f.OrderSK) AS TotalOrders,
    SUM(f.Price) AS TotalSales
FROM 
    fact_table f
JOIN 
    time_dimension t ON f.TimeSK = t.TimeSK
GROUP BY 
    t.Year, t.Quarter
ORDER BY 
    TotalOrders DESC;

--Qn3 (Demonstrate insights about employees.)
-- Employee Performance Analysis (total orders and total revenue generated) (Query 1)
SELECT e.employeesk, e.firstname, e.lastname,
       COUNT(f.ordersk) AS total_orders,
       SUM(f.price) AS total_revenue
FROM employee_dimension e
JOIN fact_table f ON e.employeesk = f.employeesk
GROUP BY e.employeesk, e.firstname, e.lastname
ORDER BY total_revenue DESC;

-- Revenue and Orders Distribution by Gender (Query 2)
SELECT e.gender,
       COUNT(f.ordersk) AS total_orders,
       SUM(f.price) AS total_revenue
FROM employee_dimension e
JOIN fact_table f ON e.employeesk = f.employeesk
GROUP BY e.gender;

