
-- Retail Sales Database Schema

-- 1. Create Tables
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE Stores (
    StoreID INT PRIMARY KEY,
    StoreName VARCHAR(100),
    Region VARCHAR(50)
);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    StoreID INT,
    Quantity INT,
    SaleDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (StoreID) REFERENCES Stores(StoreID)
);

-- 2. View: Monthly Sales by Region
CREATE VIEW vw_MonthlySalesByRegion AS
SELECT 
    s.Region,
    FORMAT(SaleDate, 'yyyy-MM') AS SaleMonth,
    SUM(p.Price * sa.Quantity) AS TotalSales
FROM Sales sa
JOIN Products p ON sa.ProductID = p.ProductID
JOIN Stores s ON sa.StoreID = s.StoreID
GROUP BY s.Region, FORMAT(SaleDate, 'yyyy-MM');

-- 3. View: Top Selling Products
CREATE VIEW vw_TopSellingProducts AS
SELECT 
    p.ProductName,
    SUM(sa.Quantity) AS TotalQuantitySold
FROM Sales sa
JOIN Products p ON sa.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY TotalQuantitySold DESC;
