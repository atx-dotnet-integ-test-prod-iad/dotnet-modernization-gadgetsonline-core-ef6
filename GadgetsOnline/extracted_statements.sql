-- ============================================================
-- Extracted SQL Statements - GadgetsOnline Migration
-- Source: Microsoft SQL Server (dbo schema)
-- Extracted from EF6 model mappings and LINQ-generated queries
-- Total: 18 statements (5 DDL + 13 DML)
-- ============================================================

-- ============================================================
-- DDL Statements (CREATE TABLE)
-- ============================================================

-- Statement 1: CREATE TABLE Categories
CREATE TABLE dbo.Categories (
    CategoryId INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(MAX) NULL,
    Description NVARCHAR(MAX) NULL
);

-- Statement 2: CREATE TABLE Products
CREATE TABLE dbo.Products (
    ProductId INT IDENTITY(1,1) PRIMARY KEY,
    CategoryId INT NOT NULL,
    Name NVARCHAR(255) NOT NULL,
    Price DECIMAL(18,2) NOT NULL,
    ProductArtUrl NVARCHAR(1024) NULL,
    CONSTRAINT FK_Products_Categories FOREIGN KEY (CategoryId) REFERENCES dbo.Categories(CategoryId)
);

-- Statement 3: CREATE TABLE Carts
CREATE TABLE dbo.Carts (
    RecordId INT IDENTITY(1,1) PRIMARY KEY,
    CartId NVARCHAR(MAX) NULL,
    ProductId INT NOT NULL,
    Count INT NOT NULL,
    DateCreated DATETIME NOT NULL,
    CONSTRAINT FK_Carts_Products FOREIGN KEY (ProductId) REFERENCES dbo.Products(ProductId)
);

-- Statement 4: CREATE TABLE Orders
CREATE TABLE dbo.Orders (
    OrderId INT IDENTITY(1,1) PRIMARY KEY,
    OrderDate DATETIME NOT NULL,
    Username NVARCHAR(MAX) NULL,
    FirstName NVARCHAR(160) NOT NULL,
    LastName NVARCHAR(160) NOT NULL,
    Address NVARCHAR(70) NOT NULL,
    City NVARCHAR(40) NOT NULL,
    State NVARCHAR(40) NOT NULL,
    PostalCode NVARCHAR(10) NOT NULL,
    Country NVARCHAR(40) NOT NULL,
    Phone NVARCHAR(24) NOT NULL,
    Email NVARCHAR(MAX) NOT NULL,
    Total DECIMAL(18,2) NOT NULL
);

-- Statement 5: CREATE TABLE OrderDetails
CREATE TABLE dbo.OrderDetails (
    OrderDetailId INT IDENTITY(1,1) PRIMARY KEY,
    OrderId INT NOT NULL,
    ProductId INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(18,2) NOT NULL,
    CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (OrderId) REFERENCES dbo.Orders(OrderId),
    CONSTRAINT FK_OrderDetails_Products FOREIGN KEY (ProductId) REFERENCES dbo.Products(ProductId)
);

-- ============================================================
-- DML Statements - SELECT (from Inventory service)
-- ============================================================

-- Statement 6: GetBestSellers (Inventory.cs)
SELECT TOP(@count) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products;

-- Statement 7: GetAllCategories (Inventory.cs)
SELECT CategoryId, Name, Description FROM dbo.Categories;

-- Statement 8: GetAllProductsInCategory (Inventory.cs)
SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl
FROM dbo.Products p INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId
WHERE c.Name = @categoryName;

-- Statement 9: GetProductById (Inventory.cs)
SELECT ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products WHERE ProductId = @id;

-- Statement 10: GetProductNameById (Inventory.cs)
SELECT Name FROM dbo.Products WHERE ProductId = @id;

-- ============================================================
-- DML Statements - SELECT (from ShoppingCart service)
-- ============================================================

-- Statement 11: AddToCart - lookup (ShoppingCart.cs)
SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @productId;

-- Statement 12: GetCartItems (ShoppingCart.cs)
SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId;

-- Statement 13: GetCount (ShoppingCart.cs)
SELECT SUM(Count) FROM dbo.Carts WHERE CartId = @cartId;

-- Statement 14: GetTotal (ShoppingCart.cs)
SELECT SUM(c.Count * p.Price) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.ProductId = p.ProductId WHERE c.CartId = @cartId;

-- ============================================================
-- DML Statements - INSERT/UPDATE/DELETE
-- ============================================================

-- Statement 15: AddToCart - insert (ShoppingCart.cs)
INSERT INTO dbo.Carts (CartId, ProductId, Count, DateCreated) VALUES (@cartId, @productId, @count, @dateCreated);

-- Statement 16: EmptyCart (ShoppingCart.cs)
DELETE FROM dbo.Carts WHERE CartId = @cartId;

-- Statement 17: ProcessOrder - insert order (OrderProcessing.cs)
INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total)
VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);

-- Statement 18: CreateOrder - insert order detail (ShoppingCart.cs)
INSERT INTO dbo.OrderDetails (OrderId, ProductId, Quantity, UnitPrice) VALUES (@orderId, @productId, @quantity, @unitPrice);
