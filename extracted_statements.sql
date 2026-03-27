-- ============================================================================
-- Extracted SQL Statements from GadgetsOnline Application
-- Source: Entity Framework model configurations (implicit DDL)
-- Date: 2026-03-27
-- ============================================================================

-- Statement 1: Products table (from Product.cs model and GadgetsOnlineEntities.cs)
CREATE TABLE dbo.Products (
    ProductId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    CategoryId INT NOT NULL,
    Name NVARCHAR(255) NOT NULL,
    Price DECIMAL(18,2) NOT NULL,
    ProductArtUrl NVARCHAR(1024) NULL,
    CONSTRAINT FK_Products_Categories FOREIGN KEY (CategoryId) REFERENCES dbo.Categories(CategoryId)
);

-- Statement 2: Categories table (from Category.cs model and GadgetsOnlineEntities.cs)
CREATE TABLE dbo.Categories (
    CategoryId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Name NVARCHAR(MAX) NULL,
    Description NVARCHAR(MAX) NULL
);

-- Statement 3: Carts table (from Cart.cs model and GadgetsOnlineEntities.cs)
CREATE TABLE dbo.Carts (
    RecordId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    CartId NVARCHAR(MAX) NULL,
    ProductId INT NOT NULL,
    Count INT NOT NULL,
    DateCreated DATETIME NOT NULL,
    CONSTRAINT FK_Carts_Products FOREIGN KEY (ProductId) REFERENCES dbo.Products(ProductId)
);

-- Statement 4: Orders table (from Order.cs model and GadgetsOnlineEntities.cs)
CREATE TABLE dbo.Orders (
    OrderId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
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

-- Statement 5: OrderDetails table (from OrderDetail.cs model and GadgetsOnlineEntities.cs)
CREATE TABLE dbo.OrderDetails (
    OrderDetailId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    OrderId INT NOT NULL,
    ProductId INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(18,2) NOT NULL,
    CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (OrderId) REFERENCES dbo.Orders(OrderId),
    CONSTRAINT FK_OrderDetails_Products FOREIGN KEY (ProductId) REFERENCES dbo.Products(ProductId)
);
