-- main table
CREATE TABLE dbo.orders (
    OrderID INT PRIMARY KEY,
    CustomerID NVARCHAR(50),
    OrderDate DATETIME,
    UpdatedDate DATETIME,
    Amount FLOAT
);

-- staging table
CREATE TABLE dbo.temp_orders (
    OrderID INT ,
    CustomerID NVARCHAR(50),
    OrderDate DATETIME,
    UpdatedDate DATETIME,
    Amount FLOAT
);


-- stored procedure for incremental data
CREATE PROCEDURE sp_upsert_orderss
AS
BEGIN
    SET NOCOUNT ON;

    MERGE dbo.orders AS Target
    USING dbo.temp_orders AS Source
    ON Target.OrderID = Source.OrderID
    WHEN MATCHED AND Source.UpdatedDate > Target.UpdatedDate THEN
        UPDATE SET
            Target.CustomerID = Source.CustomerID,
            Target.OrderDate = Source.OrderDate,
            Target.UpdatedDate = Source.UpdatedDate,
            Target.Amount = Source.Amount
    WHEN NOT MATCHED BY TARGET THEN
        INSERT (OrderID, CustomerID, OrderDate, UpdatedDate, Amount)
        VALUES (Source.OrderID, Source.CustomerID, Source.OrderDate, Source.UpdatedDate, Source.Amount);
END

-- check for incremental data updated or not
select * from dbo.temp_orders
    
select * from dbo.orders
