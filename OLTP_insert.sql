-- creating tables

create table Customer (
CustomerID varchar(10) primary key,
FirstName varchar(20) not null,
LastName varchar(20) not null,
CompanyName varchar(50) not null,
Contact varchar(10)
);
create table Employee (
EmployeeID varchar(10) primary key,
FirstName varchar(20) not null,
LastName varchar(20) not null,
Contact varchar(10),
Gender char(1) not null
);
create table Dataset(
DatasetID varchar(10) primary key,
DatasetName varchar(50) not null
);
create table ModelType(
ModelCode varchar(10) primary key,
ModelType varchar(50) not null
);
create table Model(
ModelID varchar(10) primary key,
ModelCode varchar(10) not null,
TrainingDate date not null,
Accuracy decimal(6,2) not null,
DatasetID varchar(10),
foreign key(ModelCode) references ModelType(ModelCode),
foreign key(DatasetID) references Dataset(DatasetID)
);
create table Orders(
OrderID varchar(10) primary key,
CustomerID varchar(10) not null,
EmployeeID varchar(10) not null,
ModelCode varchar(10) not null,
RequiredAcc decimal(6,2) not null,
OrderDate Date not null,
CompletionDate Date,
ModelID varchar(10),
Price int not null,
foreign key (EmployeeID) references Employee(EmployeeID),
foreign key (CustomerID) references Customer(CustomerID),
foreign key (ModelCode) references ModelType(ModelCode),
foreign key (ModelID) references Model(ModelID)
)

SELECT * FROM Customer
SELECT * FROM Employee
SELECT * FROM Dataset
SELECT * FROM ModelType
SELECT * FROM Model
SELECT * FROM Orders

BULK INSERT Customer
FROM 'C:\Users\lhchu\OneDrive\Desktop\DAAA (SP)2A03\DENG\CA2\Data Text Files\customer.txt'
WITH (
    FIELDTERMINATOR = '\t',  -- Specifies the field delimiter (tab)
    ROWTERMINATOR = '\n',    -- Specifies the row delimiter (new line)
    FIRSTROW = 2             -- Skip the header row
);

BULK INSERT Employee
FROM 'C:\Users\lhchu\OneDrive\Desktop\DAAA (SP)2A03\DENG\CA2\Data Text Files\employee.txt'
WITH (
    FIELDTERMINATOR = '\t',  -- Specifies the field delimiter (tab)
    ROWTERMINATOR = '\n',    -- Specifies the row delimiter (new line)
    FIRSTROW = 2             -- Skip the header row
);

BULK INSERT Dataset
FROM 'C:\Users\lhchu\OneDrive\Desktop\DAAA (SP)2A03\DENG\CA2\Data Text Files\export_dataset.txt'
WITH (
    FIELDTERMINATOR = '\t',  -- Specifies the field delimiter (tab)
    ROWTERMINATOR = '\n',    -- Specifies the row delimiter (new line)
    FIRSTROW = 2             -- Skip the header row
);

BULK INSERT ModelType
FROM 'C:\Users\lhchu\OneDrive\Desktop\DAAA (SP)2A03\DENG\CA2\Data Text Files\export_modeltype.txt'
WITH (
    FIELDTERMINATOR = '\t',  -- Specifies the field delimiter (tab)
    ROWTERMINATOR = '\n',    -- Specifies the row delimiter (new line)
    FIRSTROW = 2             -- Skip the header row
);

BULK INSERT Model
FROM 'C:\Users\lhchu\OneDrive\Desktop\DAAA (SP)2A03\DENG\CA2\Data Text Files\export_model.txt'
WITH (
    FIELDTERMINATOR = '\t',  -- Specifies the field delimiter (tab)
    ROWTERMINATOR = '\n',    -- Specifies the row delimiter (new line)
    FIRSTROW = 2             -- Skip the header row
);

BULK INSERT Orders
FROM 'C:\Users\lhchu\OneDrive\Desktop\DAAA (SP)2A03\DENG\CA2\Data Text Files\orders.txt'
WITH (
    FIELDTERMINATOR = '\t',  -- Specifies the field delimiter (tab)
    ROWTERMINATOR = '\n',    -- Specifies the row delimiter (new line)
    FIRSTROW = 2             -- Skip the header row
);








