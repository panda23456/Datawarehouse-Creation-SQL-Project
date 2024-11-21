select * from customer_dimension
select * from employee_dimension

select * from dataset_dimension
select * from modeltype_dimension
select * from model_dimension

--Tables below not created and data not inserted yet
select * from time_dimension
select * from order_dimension

select * from time_dimension
select * from fact_table


-- Enable explicit values for the identity column
SET IDENTITY_INSERT SPAIDW2A0306.dbo.customer_dimension ON;

-- Insert data with explicit CustomerID
INSERT INTO SPAIDW2A0306.dbo.customer_dimension (CustomerID, FirstName, LastName, CompanyName, Contact)
SELECT CustomerID, FirstName, LastName, CompanyName, Contact
FROM SPAI2A0306.dbo.Customer;

-- Insert data with explicit EmployeeID
INSERT INTO SPAIDW2A0306.dbo.employee_dimension (EmployeeID, FirstName, LastName, Contact, Gender)
SELECT EmployeeID, FirstName, LastName, Contact, Gender
FROM SPAI2A0306.dbo.Employee;

-- Insert data with explicit DatasetID
INSERT INTO SPAIDW2A0306.dbo.dataset_dimension (DatasetID, DatasetName)
SELECT DatasetID, DatasetName 
FROM SPAI2A0306.dbo.Dataset;

-- Insert data with explicit ModelCode
INSERT INTO SPAIDW2A0306.dbo.modeltype_dimension (ModelCode, ModelType)
SELECT ModelCode, ModelType 
FROM SPAI2A0306.dbo.ModelType;

-- Insert data with explicit ModelID
INSERT INTO SPAIDW2A0306.dbo.model_dimension (ModelID, ModelCode, TrainingDate, Accuracy, DatasetID)
SELECT ModelID, ModelCode, TrainingDate, Accuracy, DatasetID
FROM SPAI2A0306.dbo.Model;

-- Insert data with explicit OrderID
INSERT INTO SPAIDW2A0306.dbo.order_dimension (OrderID, OrderDate)
SELECT OrderID, OrderDate
FROM SPAI2A0306.dbo.Orders;

-- Insert data from SPAI2A0306.dbo.Orders into SPAIDW2A0306.dbo.time_dimension
-- Insert unique rows into time_dimension
INSERT INTO SPAIDW2A0306.dbo.time_dimension ([Year], [Date], [Quarter], [Month])
SELECT 
    CAST(YEAR(CompletionDate) AS CHAR(4)) AS [Year],  -- Extract year and cast to CHAR(4)
    CompletionDate AS [Date],                        -- Use the actual date for the Date column
    CAST(DATEPART(QUARTER, CompletionDate) AS CHAR(1)) AS [Quarter], -- Extract quarter and cast to CHAR(1)
    RIGHT('0' + CAST(MONTH(CompletionDate) AS VARCHAR(2)), 2) AS [Month] -- Extract month and pad with zero if needed
FROM 
    SPAI2A0306.dbo.Orders
WHERE 
    CompletionDate IS NOT NULL 
    AND NOT EXISTS ( -- Ensure the date doesn't already exist in the time_dimension table
        SELECT 1
        FROM SPAIDW2A0306.dbo.time_dimension td
        WHERE td.[Date] = SPAI2A0306.dbo.Orders.CompletionDate
    );

-- Ensure there are no duplicates in time_dimension
WITH CTE AS (
    SELECT 
        [Year],
        [Date],
        [Quarter],
        [Month],
        ROW_NUMBER() OVER (PARTITION BY [Date] ORDER BY [Date]) AS rn
    FROM 
        SPAIDW2A0306.dbo.time_dimension
)
DELETE FROM CTE
WHERE rn > 1;

-- Disable explicit values for the identity column
SET IDENTITY_INSERT SPAIDW2A0306.dbo.customer_dimension OFF;

-- Insert data into fact_table
INSERT INTO fact_table (CustomerSK, EmployeeSK, ModelSK, OrderSK, TimeSK, Price, RequiredAcc)
SELECT
    cd.CustomerSK,
    ed.EmployeeSK,
    md.ModelSK,
    od.OrderSK,
    td.TimeSK,
    o.Price,
    o.RequiredAcc
FROM 
    SPAI2A0306.dbo.Orders o -- Reference to the Orders table in the OLTP system
JOIN 
    SPAIDW2A0306.dbo.customer_dimension cd ON o.CustomerID = cd.CustomerID
JOIN 
    SPAIDW2A0306.dbo.employee_dimension ed ON o.EmployeeID = ed.EmployeeID
JOIN 
    SPAIDW2A0306.dbo.model_dimension md ON o.ModelID = md.ModelID
inner JOIN 
    SPAIDW2A0306.dbo.order_dimension od ON o.OrderID = od.OrderID
Inner JOIN 
    SPAIDW2A0306.dbo.time_dimension td ON YEAR(o.CompletionDate) = td.[Year] AND MONTH(o.CompletionDate) = td.[Month] AND o.CompletionDate = td.[Date];



