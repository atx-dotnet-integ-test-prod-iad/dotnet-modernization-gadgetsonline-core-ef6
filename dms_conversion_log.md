# DMS Conversion Log

## Migration Project
- **DMS ARN**: arn:aws:dms:us-east-1:789616364195:migration-project:73N4TGCKEFESJJWR43O334CC7U
- **Source Database**: GadgetsOnline (SQL Server 2019)
- **Target Database**: PostgreSQL 13
- **Date**: 2026-03-27

## Summary
- **Total Statements Attempted**: 5
- **DMS Successful Conversions**: 0
- **DMS Failed Conversions**: 5
- **Manual Conversions Applied**: 5

## DMS Conversion Attempts

### Statement 1: CREATE TABLE dbo.Products
- **Status**: FAILED
- **DMS Conversion Timestamp**: 2026-03-27T03:57:13.038374
- **DMS Error Timestamp**: 2026-03-27T03:57:27.808888
- **DMS Error**: `Metadata model creation failed: No objects were found according to the specified selection rules. Please review your selection rules and try again.`
- **Manual Conversion Applied**: Yes
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Original Statement**:
```sql
CREATE TABLE dbo.Products (
    ProductId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    CategoryId INT NOT NULL,
    Name NVARCHAR(255) NOT NULL,
    Price DECIMAL(18,2) NOT NULL,
    ProductArtUrl NVARCHAR(1024) NULL,
    CONSTRAINT FK_Products_Categories FOREIGN KEY (CategoryId) REFERENCES dbo.Categories(CategoryId)
);
```
- **Converted Statement**:
```sql
CREATE TABLE gadgetsonline_dbo.products (
    productid SERIAL PRIMARY KEY,
    categoryid INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL,
    price NUMERIC(18,2) NOT NULL,
    productarturl VARCHAR(1024) NULL,
    CONSTRAINT fk_products_categories FOREIGN KEY (categoryid) REFERENCES gadgetsonline_dbo.categories(categoryid)
);
```

### Statement 2: CREATE TABLE dbo.Categories
- **Status**: FAILED
- **DMS Conversion Timestamp**: 2026-03-27T03:57:35.872094
- **DMS Error Timestamp**: 2026-03-27T03:57:50.642958
- **DMS Error**: `Metadata model creation failed: No objects were found according to the specified selection rules. Please review your selection rules and try again.`
- **Manual Conversion Applied**: Yes
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Original Statement**:
```sql
CREATE TABLE dbo.Categories (
    CategoryId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Name NVARCHAR(MAX) NULL,
    Description NVARCHAR(MAX) NULL
);
```
- **Converted Statement**:
```sql
CREATE TABLE gadgetsonline_dbo.categories (
    categoryid SERIAL PRIMARY KEY,
    name TEXT NULL,
    description TEXT NULL
);
```

### Statement 3: CREATE TABLE dbo.Carts
- **Status**: FAILED
- **DMS Conversion Timestamp**: 2026-03-27T03:58:00.589787
- **DMS Error Timestamp**: 2026-03-27T03:58:15.268165
- **DMS Error**: `Metadata model creation failed: No objects were found according to the specified selection rules. Please review your selection rules and try again.`
- **Manual Conversion Applied**: Yes
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Original Statement**:
```sql
CREATE TABLE dbo.Carts (
    RecordId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    CartId NVARCHAR(MAX) NULL,
    ProductId INT NOT NULL,
    Count INT NOT NULL,
    DateCreated DATETIME NOT NULL,
    CONSTRAINT FK_Carts_Products FOREIGN KEY (ProductId) REFERENCES dbo.Products(ProductId)
);
```
- **Converted Statement**:
```sql
CREATE TABLE gadgetsonline_dbo.carts (
    recordid SERIAL PRIMARY KEY,
    cartid TEXT NULL,
    productid INTEGER NOT NULL,
    count INTEGER NOT NULL,
    datecreated TIMESTAMP NOT NULL,
    CONSTRAINT fk_carts_products FOREIGN KEY (productid) REFERENCES gadgetsonline_dbo.products(productid)
);
```

### Statement 4: CREATE TABLE dbo.Orders
- **Status**: FAILED
- **DMS Conversion Timestamp**: 2026-03-27T03:58:25.487330
- **DMS Error Timestamp**: 2026-03-27T03:58:40.279250
- **DMS Error**: `Metadata model creation failed: No objects were found according to the specified selection rules. Please review your selection rules and try again.`
- **Manual Conversion Applied**: Yes
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Original Statement**:
```sql
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
```
- **Converted Statement**:
```sql
CREATE TABLE gadgetsonline_dbo.orders (
    orderid SERIAL PRIMARY KEY,
    orderdate TIMESTAMP NOT NULL,
    username TEXT NULL,
    firstname VARCHAR(160) NOT NULL,
    lastname VARCHAR(160) NOT NULL,
    address VARCHAR(70) NOT NULL,
    city VARCHAR(40) NOT NULL,
    state VARCHAR(40) NOT NULL,
    postalcode VARCHAR(10) NOT NULL,
    country VARCHAR(40) NOT NULL,
    phone VARCHAR(24) NOT NULL,
    email TEXT NOT NULL,
    total NUMERIC(18,2) NOT NULL
);
```

### Statement 5: CREATE TABLE dbo.OrderDetails
- **Status**: FAILED
- **DMS Conversion Timestamp**: 2026-03-27T03:58:48.627260
- **DMS Error Timestamp**: 2026-03-27T03:59:03.292316
- **DMS Error**: `Metadata model creation failed: No objects were found according to the specified selection rules. Please review your selection rules and try again.`
- **Manual Conversion Applied**: Yes
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Original Statement**:
```sql
CREATE TABLE dbo.OrderDetails (
    OrderDetailId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    OrderId INT NOT NULL,
    ProductId INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(18,2) NOT NULL,
    CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (OrderId) REFERENCES dbo.Orders(OrderId),
    CONSTRAINT FK_OrderDetails_Products FOREIGN KEY (ProductId) REFERENCES dbo.Products(ProductId)
);
```
- **Converted Statement**:
```sql
CREATE TABLE gadgetsonline_dbo.orderdetails (
    orderdetailid SERIAL PRIMARY KEY,
    orderid INTEGER NOT NULL,
    productid INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    unitprice NUMERIC(18,2) NOT NULL,
    CONSTRAINT fk_orderdetails_orders FOREIGN KEY (orderid) REFERENCES gadgetsonline_dbo.orders(orderid),
    CONSTRAINT fk_orderdetails_products FOREIGN KEY (productid) REFERENCES gadgetsonline_dbo.products(productid)
);
```

## Manual Conversion Rules Applied
Since DMS failed for all statements, the following manual conversion rules were applied:
1. Schema mapping: `dbo` → `gadgetsonline_dbo` (matching existing EF6 entity configurations)
2. All table and column names converted to lowercase
3. `INT IDENTITY(1,1)` → `SERIAL`
4. `NVARCHAR(n)` → `VARCHAR(n)`
5. `NVARCHAR(MAX)` → `TEXT`
6. `DECIMAL(p,s)` → `NUMERIC(p,s)`
7. `DATETIME` → `TIMESTAMP`
8. Constraint names converted to lowercase
