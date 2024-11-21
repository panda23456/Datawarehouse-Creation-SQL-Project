-- Customer Dimension
CREATE TABLE customer_dimension (
	CustomerSK int identity not null primary key,
    CustomerID varchar(10),
	FirstName varchar(20) not null,
	LastName varchar(20) not null,
	CompanyName varchar(50) not null,
	Contact varchar(10)
);

-- Employee Dimension
CREATE TABLE employee_dimension (
	EmployeeSK int identity not null primary key,
    EmployeeID varchar(10),
	FirstName varchar(20) not null,
	LastName varchar(20) not null,
	Contact varchar(10),
	Gender char(1) not null
);

-- Dataset Dimension
CREATE TABLE dataset_dimension (
    DatasetID varchar(10) primary key,
	DatasetName varchar(50) not null
);

-- Model Type Dimension
CREATE TABLE modeltype_dimension (
    ModelCode varchar(10) primary key,
	ModelType varchar(50) not null
);

-- Model Dimension
CREATE TABLE model_dimension (
	ModelSK int identity not null primary key,
    ModelID varchar(10),
	ModelCode varchar(10) not null,
	TrainingDate date not null,
	Accuracy decimal(6,2) not null,
	DatasetID varchar(10),
	foreign key(DatasetID) references dataset_dimension(DatasetID),
	foreign key(ModelCode) references modeltype_dimension(ModelCode)
);

-- Order Dimension
CREATE TABLE order_dimension (
	OrderSK int identity not null primary key,
	OrderID varchar(10),
	OrderDate Date not null
);

-- Time Dimension
CREATE TABLE time_dimension (
	TimeSK int identity not null primary key,
    [Year] CHAR(4),-- Year value of Date stored in Row
	[Date] DATETIME,
	[Quarter] CHAR(1),
	[Month] VARCHAR(2), --Number of the Month 1 to 12
);

--Unsure of what data types for fact_table
-- Fact Table
CREATE TABLE fact_table (
    FTSK int identity not null primary key,
	CustomerSK int not null,
	EmployeeSK int not null,
	ModelSK int not null,
	OrderSK int not null,
	TimeSK int not null,
    Price int not null,
	RequiredAcc decimal(6,2) not null,
    FOREIGN KEY (CustomerSK) REFERENCES customer_dimension(CustomerSK),
    FOREIGN KEY (EmployeeSK) REFERENCES employee_dimension(EmployeeSK),
    FOREIGN KEY (ModelSK) REFERENCES model_dimension(ModelSK),
    FOREIGN KEY (TimeSK) REFERENCES time_dimension(TimeSK),
	FOREIGN KEY (OrderSK) REFERENCES order_dimension(OrderSK)
);

/*drop table customer_dimension
drop table employee_dimension
drop table dataset_dimension
drop table modeltype_dimension
drop table model_dimension
drop table order_dimension
drop table time_dimension

drop table fact_table*/


select * from customer_dimension

select * from employee_dimension

select * from dataset_dimension
select * from modeltype_dimension
select * from model_dimension

select * from order_dimension
select * from time_dimension

select * from fact_table

