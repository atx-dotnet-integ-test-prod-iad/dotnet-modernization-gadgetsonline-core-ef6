# GadgetsOnline - SQL Server to PostgreSQL Migration Report

## 1. Application Overview

| Property | Value |
|----------|-------|
| Application | GadgetsOnline |
| Framework | .NET 8.0 |
| ORM | Entity Framework 6 (EF6) |
| Database Access | LINQ exclusively (no raw SQL) |
| Source Database | Microsoft SQL Server 2019 |
| Target Database | PostgreSQL 13 (Amazon RDS) |
| Migration Date | 2026-03-26 |

## 2. DMS MCP Tool Conversion Results

| Metric | Count |
|--------|-------|
| Total SQL Statements | 20 |
| DMS Successful Conversions | 0 |
| DMS Failed Conversions | 20 |
| Manual Conversions (DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA) | 20 |

**DMS Configuration Used:**
- Migration Project ARN: `arn:aws:dms:us-east-1:789616364195:migration-project:73N4TGCKEFESJJWR43O334CC7U`
- Database Name: `GadgetsOnline`
- Schema Name: `dbo`
- Server Name: `172.31.82.226`
- Region: `us-east-1`

**DMS Error**: All 20 statements failed with: `Metadata model creation failed: No objects were found according to the specified selection rules. Please review your selection rules and try again.`

**Manual Conversion Rules Applied (DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA):**
- Table/column names converted to lowercase
- Schema mapped from `dbo` to `gadgetsonline_dbo`
- `TOP(N)` converted to `LIMIT N`
- `TOP(@param)` converted to `LIMIT @param`
- SQL logic and structure preserved

### Per-Statement DMS Results

| # | Source File | Operation | Original MS SQL | DMS Status | DMS Timestamp |
|---|------------|-----------|-----------------|------------|---------------|
| 1 | GadgetsOnlineInitializer.cs | INSERT Category | `INSERT INTO Categories (CategoryId, Name, Description) VALUES (...)` | FAILED | 2026-03-26T06:14:31 |
| 2 | GadgetsOnlineInitializer.cs | INSERT Product | `INSERT INTO Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (...)` | FAILED | 2026-03-26T06:14:55 |
| 3 | Inventory.cs | SELECT TOP Products | `SELECT TOP(@p0) ProductId, CategoryId, Name, Price, ProductArtUrl FROM Products` | FAILED | 2026-03-26T06:15:18 |
| 4 | Inventory.cs | SELECT All Categories | `SELECT CategoryId, Name, Description FROM Categories` | FAILED | 2026-03-26T06:15:39 |
| 5 | Inventory.cs | SELECT Products by Category | `SELECT p.ProductId, ... FROM Products p INNER JOIN Categories c ...` | FAILED | 2026-03-26T06:16:01 |
| 6 | Inventory.cs | SELECT Product by Id | `SELECT TOP(1) ProductId, ... FROM Products WHERE ProductId = @p0` | FAILED | 2026-03-26T06:16:26 |
| 7 | Inventory.cs | SELECT Product Name by Id | `SELECT TOP(1) Name FROM Products WHERE ProductId = @p0` | FAILED | 2026-03-26T06:16:53 |
| 8 | ShoppingCart.cs | SELECT Cart Items | `SELECT RecordId, CartId, ProductId, Count, DateCreated FROM Carts WHERE CartId = @p0` | FAILED | 2026-03-26T06:17:17 |
| 9 | ShoppingCart.cs | SELECT Single Cart Item | `SELECT TOP(1) RecordId, ... FROM Carts WHERE CartId = @p0 AND ProductId = @p1` | FAILED | 2026-03-26T06:17:40 |
| 10 | ShoppingCart.cs | INSERT Cart Item | `INSERT INTO Carts (CartId, ProductId, Count, DateCreated) VALUES (...)` | FAILED | 2026-03-26T06:18:01 |
| 11 | ShoppingCart.cs | UPDATE Cart Count | `UPDATE Carts SET Count = @p0 WHERE RecordId = @p1` | FAILED | 2026-03-26T06:18:24 |
| 12 | ShoppingCart.cs | SELECT SUM Cart Count | `SELECT SUM(Count) FROM Carts WHERE CartId = @p0` | FAILED | 2026-03-26T06:18:47 |
| 13 | ShoppingCart.cs | SELECT SUM Cart Total | `SELECT SUM(c.Count * p.Price) FROM Carts c INNER JOIN Products p ...` | FAILED | 2026-03-26T06:19:11 |
| 14 | ShoppingCart.cs | DELETE Cart Items | `DELETE FROM Carts WHERE CartId = @p0` | FAILED | 2026-03-26T06:19:33 |
| 15 | ShoppingCart.cs | SELECT Cart for Remove | `SELECT TOP(1) RecordId, ... FROM Carts WHERE ... ORDER BY RecordId` | FAILED | 2026-03-26T06:19:56 |
| 16 | ShoppingCart.cs | DELETE Single Cart Item | `DELETE FROM Carts WHERE RecordId = @p0` | FAILED | 2026-03-26T06:20:17 |
| 17 | ShoppingCart.cs | INSERT Order Detail | `INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice) VALUES (...)` | FAILED | 2026-03-26T06:20:40 |
| 18 | ShoppingCart.cs | UPDATE Order Total | `UPDATE Orders SET Total = @p0 WHERE OrderId = @p1` | FAILED | 2026-03-26T06:21:02 |
| 19 | OrderProcessing.cs | INSERT Order | `INSERT INTO Orders (OrderDate, Username, ...) VALUES (...)` | FAILED | 2026-03-26T06:21:25 |
| 20 | Order.cs | SELECT Order Details (lazy) | `SELECT OrderDetailId, OrderId, ProductId, Quantity, UnitPrice FROM OrderDetails WHERE OrderId = @p0` | FAILED | 2026-03-26T06:21:48 |

## 3. SQL Equivalency Validation Results

| Metric | Count |
|--------|-------|
| Total Statement Pairs Validated | 20 |
| Equivalent | 0 |
| Non-Equivalent | 0 |
| Error | 20 |

**Equivalency Error**: All 20 validations returned ERROR with `'uniqueID'` error from the SQL Equivalency tool.

**Note**: All equivalency statuses were determined solely by the SQL Equivalency tool output (sql-equivalency___validate_sql_equivalence). No agent judgment was used to determine equivalency status. Each pair was individually submitted to the tool regardless of the consistent error pattern.

### Per-Statement Equivalency Results

| # | Operation | Conversion Method | Equivalency Status | Equivalency Timestamp |
|---|-----------|-------------------|-------------------|-----------------------|
| 1 | INSERT Category | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR | 2026-03-26T06:24:36 |
| 2 | INSERT Product | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR | 2026-03-26T06:24:47 |
| 3 | SELECT TOP Products | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR | 2026-03-26T06:24:57 |
| 4 | SELECT All Categories | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR | 2026-03-26T06:25:07 |
| 5 | SELECT Products by Category | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR | 2026-03-26T06:25:18 |
| 6 | SELECT Product by Id | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR | 2026-03-26T06:25:28 |
| 7 | SELECT Product Name by Id | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR | 2026-03-26T06:25:38 |
| 8 | SELECT Cart Items | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR | 2026-03-26T06:25:48 |
| 9 | SELECT Single Cart Item | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR | 2026-03-26T06:25:59 |
| 10 | INSERT Cart Item | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR | 2026-03-26T06:26:09 |
| 11 | UPDATE Cart Count | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR | 2026-03-26T06:26:22 |
| 12 | SELECT SUM Cart Count | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR | 2026-03-26T06:26:32 |
| 13 | SELECT SUM Cart Total | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR | 2026-03-26T06:26:44 |
| 14 | DELETE Cart Items | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR | 2026-03-26T06:26:54 |
| 15 | SELECT Cart for Remove | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR | 2026-03-26T06:27:04 |
| 16 | DELETE Single Cart Item | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR | 2026-03-26T06:27:15 |
| 17 | INSERT Order Detail | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR | 2026-03-26T06:27:25 |
| 18 | UPDATE Order Total | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR | 2026-03-26T06:27:35 |
| 19 | INSERT Order | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR | 2026-03-26T06:27:48 |
| 20 | SELECT Order Details (lazy) | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR | 2026-03-26T06:28:01 |

## 4. Complete SQL Statement Listing

| # | Source File | Operation | DMS Status | Conversion Method | Equivalency Status |
|---|------------|-----------|------------|-------------------|-------------------|
| 1 | GadgetsOnlineInitializer.cs | INSERT Category | FAILED | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR |
| 2 | GadgetsOnlineInitializer.cs | INSERT Product | FAILED | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR |
| 3 | Inventory.cs | SELECT TOP Products | FAILED | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR |
| 4 | Inventory.cs | SELECT All Categories | FAILED | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR |
| 5 | Inventory.cs | SELECT Products by Category | FAILED | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR |
| 6 | Inventory.cs | SELECT Product by Id | FAILED | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR |
| 7 | Inventory.cs | SELECT Product Name by Id | FAILED | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR |
| 8 | ShoppingCart.cs | SELECT Cart Items | FAILED | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR |
| 9 | ShoppingCart.cs | SELECT Single Cart Item | FAILED | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR |
| 10 | ShoppingCart.cs | INSERT Cart Item | FAILED | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR |
| 11 | ShoppingCart.cs | UPDATE Cart Count | FAILED | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR |
| 12 | ShoppingCart.cs | SELECT SUM Cart Count | FAILED | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR |
| 13 | ShoppingCart.cs | SELECT SUM Cart Total | FAILED | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR |
| 14 | ShoppingCart.cs | DELETE Cart Items | FAILED | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR |
| 15 | ShoppingCart.cs | SELECT Cart for Remove | FAILED | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR |
| 16 | ShoppingCart.cs | DELETE Single Cart Item | FAILED | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR |
| 17 | ShoppingCart.cs | INSERT Order Detail | FAILED | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR |
| 18 | ShoppingCart.cs | UPDATE Order Total | FAILED | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR |
| 19 | OrderProcessing.cs | INSERT Order | FAILED | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR |
| 20 | Order.cs | SELECT Order Details (lazy) | FAILED | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA | ERROR |

## 5. Package Dependency Changes

| Original Package | Version | Replacement Package | Version |
|-----------------|---------|-------------------|---------| 
| Microsoft.Data.SqlClient | N/A (not used) | N/A | N/A |
| System.Data.SqlClient | N/A (not used) | N/A | N/A |
| EntityFramework | 6.5.1 | EntityFramework | 6.5.1 (unchanged) |
| N/A | N/A | EntityFramework6.Npgsql | 6.4.3 (added) |

**Note**: This application uses EF6 LINQ exclusively and never had direct ADO.NET SQL Server dependencies in the .csproj.

## 6. Connection String Changes

| Parameter | SQL Server (Original) | PostgreSQL (Current) |
|-----------|----------------------|---------------------|
| Host/Server | Server=... | Host=gadgetsonline-postgres.c6nek0euoyl0.us-east-1.rds.amazonaws.com |
| Database | Database=GadgetsOnline | Database=postgres |
| Authentication | Integrated Security=true | Username=${DB_USER};Password=${DB_PASSWORD} |

## 7. ADO.NET Class Replacement Status

| SQL Server Class | Npgsql Replacement | Status |
|-----------------|-------------------|--------|
| SqlConnection | NpgsqlConnection | N/A - EF6 LINQ only, no direct ADO.NET usage |
| SqlCommand | NpgsqlCommand | N/A - EF6 LINQ only, no direct ADO.NET usage |
| SqlDataReader | NpgsqlDataReader | N/A - EF6 LINQ only, no direct ADO.NET usage |
| SqlParameter | NpgsqlParameter | N/A - EF6 LINQ only, no direct ADO.NET usage |

## 8. EF Configuration Changes

| Configuration | Before | After |
|--------------|--------|-------|
| DbConfiguration | SqlServer provider | GadgetsOnlineEntitiesPostgreSqlConfiguration with NpgsqlServices |
| Connection Factory | SqlConnectionFactory | NpgsqlConnectionFactory |
| Provider | System.Data.SqlClient | Npgsql |
| DbConfigurationType | Not set | [DbConfigurationType(typeof(GadgetsOnlineEntitiesPostgreSqlConfiguration))] |
| DateTime Handling | Default | FixDateTimeKinds (UTC conversion for PostgreSQL TIMESTAMP compatibility) |
| Lazy Loading | Default | Explicitly enabled (LazyLoadingEnabled = true, ProxyCreationEnabled = true) |

## 9. Schema Mapping (dbo → gadgetsonline_dbo)

| SQL Server (dbo) | PostgreSQL (gadgetsonline_dbo) |
|------------------|-------------------------------|
| dbo.Categories | gadgetsonline_dbo.categories |
| dbo.Products | gadgetsonline_dbo.products |
| dbo.Carts | gadgetsonline_dbo.carts |
| dbo.Orders | gadgetsonline_dbo.orders |
| dbo.OrderDetails | gadgetsonline_dbo.orderdetails |

All column names are lowercase in PostgreSQL (e.g., CategoryId → categoryid, ProductArtUrl → productarturl).

### Column Mapping Details

**Categories**: CategoryId → categoryid, Name → name, Description → description

**Products**: ProductId → productid, CategoryId → categoryid, Name → name, Price → price, ProductArtUrl → productarturl

**Carts**: RecordId → recordid, CartId → cartid, ProductId → productid, Count → count, DateCreated → datecreated

**Orders**: OrderId → orderid, OrderDate → orderdate, Username → username, FirstName → firstname, LastName → lastname, Address → address, City → city, State → state, PostalCode → postalcode, Country → country, Phone → phone, Email → email, Total → total

**OrderDetails**: OrderDetailId → orderdetailid, OrderId → orderid, ProductId → productid, Quantity → quantity, UnitPrice → unitprice

## 10. Build Verification Results

| Check | Result |
|-------|--------|
| dotnet build GadgetsOnline.sln | **Build succeeded** |
| Warnings | 0 |
| Errors | 0 |
| Target Framework | net8.0 |

## 11. Validation Checklist

- [x] All 20 SQL statements have been processed through DMS MCP tool (all 20 submitted, all 20 failed)
- [x] All 20 statement pairs have been validated through SQL Equivalency tool (all 20 returned ERROR)
- [x] No SqlConnection/SqlCommand/SqlDataReader/SqlParameter in codebase
- [x] No Microsoft.Data.SqlClient/System.Data.SqlClient package references
- [x] Connection string uses PostgreSQL format (Host=..., Database=..., Username=..., Password=...)
- [x] EF configuration targets PostgreSQL with Npgsql provider
- [x] All table/column names are lowercase in EF model mappings
- [x] All model classes have [Table] and [Column] attributes with lowercase names and gadgetsonline_dbo schema
- [x] app.config has Npgsql provider and NpgsqlConnectionFactory
- [x] Application compiles with 0 errors and 0 warnings
- [x] All 5 migration artifacts are present and complete
- [x] sql_equivalency_validation_report.json totals are consistent (0 + 0 + 20 = 20)

## 12. Items Requiring Manual Testing

1. **SQL Equivalency Validation**: All 20 statement pairs returned ERROR from the SQL Equivalency tool due to 'uniqueID' error. Manual review of converted SQL statements is recommended to verify correctness.
2. **Database Connectivity**: Verify the application can connect to the target PostgreSQL RDS instance.
3. **CRUD Operations**: Test all database operations (SELECT, INSERT, UPDATE, DELETE) against the PostgreSQL database.
4. **Transaction Handling**: Verify transaction blocks maintain atomicity with PostgreSQL.
5. **Seed Data**: Verify the GadgetsOnlineInitializer seed method correctly populates the PostgreSQL database.
6. **Lazy Loading**: Verify EF6 lazy loading of navigation properties works correctly with Npgsql provider.
7. **DateTime Handling**: Verify UTC conversion in FixDateTimeKinds works correctly with PostgreSQL TIMESTAMP columns.

## 13. Migration Artifacts

| Artifact | Location | Status |
|----------|----------|--------|
| extracted_statements.sql | GadgetsOnline/extracted_statements.sql | Complete (20 statements) |
| converted_statements.sql | GadgetsOnline/converted_statements.sql | Complete (20 statements) |
| dms_conversion_log.md | GadgetsOnline/dms_conversion_log.md | Complete (20 entries) |
| sql_equivalency_validation_report.json | GadgetsOnline/sql_equivalency_validation_report.json | Complete (20 entries) |
| migration_report.md | GadgetsOnline/migration_report.md | This file |
