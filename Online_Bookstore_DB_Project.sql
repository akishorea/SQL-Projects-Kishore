
-- Online Bookstore Database Schema

-- 1. Create Tables
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    City VARCHAR(50)
);

CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Price DECIMAL(10,2),
    Stock INT
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    BookID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

-- 2. Sample Stored Procedure: Get Orders by Customer
CREATE PROCEDURE usp_GetCustomerOrders
    @CustomerID INT
AS
BEGIN
    SELECT o.OrderID, o.OrderDate, b.Title, od.Quantity, b.Price
    FROM Orders o
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    JOIN Books b ON od.BookID = b.BookID
    WHERE o.CustomerID = @CustomerID;
END;

-- 3. Sample Stored Procedure: Get Top Selling Books
CREATE PROCEDURE usp_TopSellingBooks
AS
BEGIN
    SELECT b.Title, SUM(od.Quantity) AS TotalSold
    FROM OrderDetails od
    JOIN Books b ON od.BookID = b.BookID
    GROUP BY b.Title
    ORDER BY TotalSold DESC;
END;
