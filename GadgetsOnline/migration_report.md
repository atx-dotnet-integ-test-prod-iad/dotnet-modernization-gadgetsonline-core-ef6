# GadgetsOnline - SQL Server to PostgreSQL Migration Report

## Migration Summary

| Metric | Count |
|--------|-------|
| **Total SQL Statements Processed** | 19 |
| **DMS Tool Conversion Attempts** | 19 |
| **Successfully Converted by DMS** | 0 |
| **Requiring Manual Intervention** | 19 |
| **Validated as Equivalent (SQL Equivalency Tool)** | 0 |
| **Validated as Non-Equivalent** | 0 |
| **Equivalency Validation Errors** | 19 |

## Tool Status

### DMS MCP Statement Conversion Tool
- **Status**: FAILED for all 19 statements
- **Error**: `Metadata model creation failed: No objects were found according to the specified selection rules. Please review your selection rules and try again.`
- **Migration Project ARN**: `arn:aws:dms:us-east-1:789616364195:migration-project:73N4TGCKEFESJJWR43O334CC7U`
- **Database**: GadgetsOnline
- **Schema**: dbo
- **Region**: us-east-1
- **Conversion Timestamps**: 2026-03-23T12:43:11 to 2026-03-23T12:50:11 UTC
- **Action Taken**: All 19 statements were manually converted using lowercase schema object naming convention (DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA)

### SQL Equivalency Validation Tool
- **Status**: ERROR for all 19 statement pairs
- **Error**: `'uniqueID'` - systemic tool error affecting all validations
- **Validation Timestamps**: 2026-03-23T12:52:44 to 2026-03-23T12:55:53 UTC
- **Action Taken**: All 19 pairs marked as ERROR per transformation definition requirements. Equivalency status comes exclusively from the tool output. No agent judgment was used.

## Build Status
- **Build Result**: ✅ **BUILD SUCCEEDED**
- **Warnings**: 0
- **Errors**: 0
- **Build Command**: `dotnet build GadgetsOnline.sln`
- **Target Framework**: .NET 8.0

## Manual Conversion Rules Applied

Since DMS failed for all statements, the following manual conversion rules were applied per the transformation definition:

1. **Schema mapping**: `dbo.TableName` → `gadgetsonline_dbo.tablename`
2. **Column names**: PascalCase → lowercase (e.g., `ProductId` → `productid`)
3. **SQL syntax**: `TOP(N)` → `LIMIT N` (PostgreSQL equivalent, moved to end of query)
4. **Table names**: PascalCase → lowercase (e.g., `Products` → `products`)
5. **Data types** (for DDL context): `NVARCHAR` → `VARCHAR`, `NVARCHAR(MAX)` → `TEXT`, `DATETIME` → `TIMESTAMP`, `INT IDENTITY(1,1)` → `SERIAL`

## Files Modified During Migration

### Model Classes (Schema Mappings)
| File | Table | Schema | Status |
|------|-------|--------|--------|
| `Models/Product.cs` | products | gadgetsonline_dbo | ✅ Correctly configured |
| `Models/Category.cs` | categories | gadgetsonline_dbo | ✅ Correctly configured |
| `Models/Cart.cs` | carts | gadgetsonline_dbo | ✅ Correctly configured |
| `Models/Order.cs` | orders | gadgetsonline_dbo | ✅ Correctly configured |
| `Models/OrderDetail.cs` | orderdetails | gadgetsonline_dbo | ✅ Correctly configured |
| `Models/GadgetsOnlineEntities.cs` | All tables | gadgetsonline_dbo | ✅ Correctly configured |

### Package Dependencies
| File | Status |
|------|--------|
| `GadgetsOnline.csproj` | ✅ Npgsql (5.0.18), EntityFramework6.Npgsql (6.4.3), EntityFramework (6.5.1) - No SqlClient |

### Configuration Files
| File | Status |
|------|--------|
| `appsettings.json` | ✅ PostgreSQL connection string (Host=, Database=, Username=, Password=) |
| `app.config` | ✅ Npgsql provider, NpgsqlConnectionFactory, Npgsql DbProviderFactory |

### Application Code
| File | Status |
|------|--------|
| `Startup.cs` | ✅ No SQL Server-specific code |
| `Program.cs` | ✅ Clean |
| `Services/Inventory.cs` | ✅ Uses EF6 LINQ (no inline SQL) |
| `Services/ShoppingCart.cs` | ✅ Uses EF6 LINQ (no inline SQL) |
| `Services/OrderProcessing.cs` | ✅ Uses EF6 LINQ (no inline SQL) |

## SQL Server Remnant Verification
- No `SqlConnection`, `SqlCommand`, `SqlDataReader`, `SqlParameter` usage found ✅
- No `using Microsoft.Data.SqlClient` or `using System.Data.SqlClient` imports found ✅
- No `BeginTransaction` SQL Server-specific patterns found ✅
- `using Npgsql` correctly present in GadgetsOnlineEntities.cs ✅

## Change Categories

### 1. Schema Mappings
All EF6 model mappings (Table attributes, Column attributes, and OnModelCreating Fluent API) use:
- Schema: `gadgetsonline_dbo`
- Table names: lowercase (`products`, `categories`, `carts`, `orders`, `orderdetails`)
- Column names: lowercase (e.g., `productid`, `categoryid`, `name`, `price`)

### 2. Package Dependencies
- **Npgsql** (5.0.18) - PostgreSQL ADO.NET data provider
- **EntityFramework6.Npgsql** (6.4.3) - EF6 PostgreSQL provider
- **EntityFramework** (6.5.1) - Entity Framework 6 core
- No Microsoft.Data.SqlClient or System.Data.SqlClient references

### 3. Configuration
- Connection string in `appsettings.json` uses PostgreSQL format
- `app.config` configures Npgsql as the EF6 provider
- DbConfiguration class (`GadgetsOnlineEntitiesPostgreSqlConfiguration`) configures NpgsqlServices and NpgsqlConnectionFactory
- DateTime UTC fix implemented in SaveChanges/SaveChangesAsync for PostgreSQL TIMESTAMP compatibility

### 4. Database Access Code
- All database operations use EF6 LINQ (no inline SQL to modify)
- No SqlConnection, SqlCommand, SqlDataReader, or SqlParameter usage
- No System.Data.SqlClient or Microsoft.Data.SqlClient imports

## SQL Statement Catalog

### Statements from Services/Inventory.cs (5 statements)
| # | Operation | MS SQL | PostgreSQL |
|---|-----------|--------|------------|
| 1 | GetBestSellers | `SELECT TOP(@count) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products;` | `SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products LIMIT @count;` |
| 2 | GetAllCategories | `SELECT CategoryId, Name, Description FROM dbo.Categories;` | `SELECT categoryid, name, description FROM gadgetsonline_dbo.categories;` |
| 3 | GetAllProductsInCategory | `SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl FROM dbo.Products p INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @category;` | `SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products p INNER JOIN gadgetsonline_dbo.categories c ON p.categoryid = c.categoryid WHERE c.name = @category;` |
| 4 | GetProductById | `SELECT TOP(1) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products WHERE ProductId = @id;` | `SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;` |
| 5 | GetProductNameById | `SELECT TOP(1) Name FROM dbo.Products WHERE ProductId = @id;` | `SELECT name FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;` |

### Statements from Services/ShoppingCart.cs (11 statements)
| # | Operation | MS SQL | PostgreSQL |
|---|-----------|--------|------------|
| 6 | AddToCart - Select | `SELECT TOP(1) RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @productId;` | `SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @cartId AND productid = @productId LIMIT 1;` |
| 7 | AddToCart - Insert | `INSERT INTO dbo.Carts (CartId, ProductId, Count, DateCreated) VALUES (@cartId, @productId, 1, @dateCreated);` | `INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated) VALUES (@cartId, @productId, 1, @dateCreated);` |
| 8 | AddToCart - Update | `UPDATE dbo.Carts SET Count = Count + 1 WHERE RecordId = @recordId;` | `UPDATE gadgetsonline_dbo.carts SET count = count + 1 WHERE recordid = @recordId;` |
| 9 | GetCount | `SELECT SUM(Count) FROM dbo.Carts WHERE CartId = @cartId;` | `SELECT SUM(count) FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;` |
| 10 | RemoveFromCart - Select | `SELECT TOP(1) RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @productId;` | `SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @cartId AND productid = @productId LIMIT 1;` |
| 11 | RemoveFromCart - Decrement | `UPDATE dbo.Carts SET Count = Count - 1 WHERE RecordId = @recordId;` | `UPDATE gadgetsonline_dbo.carts SET count = count - 1 WHERE recordid = @recordId;` |
| 12 | RemoveFromCart - Delete | `DELETE FROM dbo.Carts WHERE RecordId = @recordId;` | `DELETE FROM gadgetsonline_dbo.carts WHERE recordid = @recordId;` |
| 13 | GetCartItems | `SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId;` | `SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;` |
| 14 | GetTotal | `SELECT SUM(c.Count * p.Price) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.ProductId = p.ProductId WHERE c.CartId = @cartId;` | `SELECT SUM(c.count * p.price) FROM gadgetsonline_dbo.carts c INNER JOIN gadgetsonline_dbo.products p ON c.productid = p.productid WHERE c.cartid = @cartId;` |
| 15 | EmptyCart | `DELETE FROM dbo.Carts WHERE CartId = @cartId;` | `DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;` |
| 16 | CreateOrder - Insert | `INSERT INTO dbo.OrderDetails (ProductId, OrderId, UnitPrice, Quantity) VALUES (@productId, @orderId, @unitPrice, @quantity);` | `INSERT INTO gadgetsonline_dbo.orderdetails (productid, orderid, unitprice, quantity) VALUES (@productId, @orderId, @unitPrice, @quantity);` |

### Statements from Services/OrderProcessing.cs (1 statement)
| # | Operation | MS SQL | PostgreSQL |
|---|-----------|--------|------------|
| 17 | ProcessOrder | `INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);` | `INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);` |

### Statements from Models/GadgetsOnlineInitializer.cs (2 statements)
| # | Operation | MS SQL | PostgreSQL |
|---|-----------|--------|------------|
| 18 | Seed Categories | `INSERT INTO dbo.Categories (CategoryId, Name, Description) VALUES (@categoryId, @name, @description);` | `INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description) VALUES (@categoryId, @name, @description);` |
| 19 | Seed Products | `INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (@productId, @categoryId, @name, @price, @productArtUrl);` | `INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (@productId, @categoryId, @name, @price, @productArtUrl);` |

## Statements Requiring Manual Review

All 19 statements require manual review due to:
1. **DMS conversion failure** - All statements failed DMS conversion and were manually converted
2. **Equivalency validation error** - All statement pairs returned ERROR from the SQL Equivalency tool

**Note**: The manual conversions follow standard SQL Server → PostgreSQL conversion patterns (lowercase identifiers, TOP → LIMIT, schema mapping). The conversions are straightforward and should be functionally equivalent, but could not be automatically validated due to tool availability issues.

## Artifacts Generated

| Artifact | Location | Description | Statement Count | Status |
|----------|----------|-------------|-----------------|--------|
| `extracted_statements.sql` | Project root | 19 original MS SQL Server statements | 19 | ✅ Complete |
| `converted_statements.sql` | Project root | 19 converted PostgreSQL statements with DMS attempt timestamps | 19 | ✅ Complete |
| `sql_equivalency_validation_report.json` | Project root | Comprehensive validation report with all 19 statement pairs | 19 | ✅ Complete |
| `migration_report.md` | Project root | This report | N/A | ✅ Complete |

## Artifact Count Verification
- extracted_statements.sql: **19** statements ✅
- converted_statements.sql: **19** statements ✅
- sql_equivalency_validation_report.json: **19** statement pairs ✅
- All counts match ✅

## DMS Conversion Detail Log

All 19 DMS attempts used the following parameters:
- `migration_project_identifier`: `arn:aws:dms:us-east-1:789616364195:migration-project:73N4TGCKEFESJJWR43O334CC7U`
- `database_name`: `GadgetsOnline`
- `schema_name`: `dbo`
- `region`: `us-east-1`
- `server_name`: `172.31.82.226` (auto-detected)

| Stmt # | DMS Timestamp | DMS Status | Manual Conversion Applied |
|--------|---------------|------------|--------------------------|
| 1 | 2026-03-23T12:43:11 | ERROR | YES - TOP(@count) → LIMIT @count |
| 2 | 2026-03-23T12:43:38 | ERROR | YES - lowercase schema/columns |
| 3 | 2026-03-23T12:44:01 | ERROR | YES - lowercase schema/columns/aliases |
| 4 | 2026-03-23T12:44:25 | ERROR | YES - TOP(1) → LIMIT 1 |
| 5 | 2026-03-23T12:44:49 | ERROR | YES - TOP(1) → LIMIT 1 |
| 6 | 2026-03-23T12:45:14 | ERROR | YES - TOP(1) → LIMIT 1 |
| 7 | 2026-03-23T12:45:38 | ERROR | YES - lowercase schema/columns |
| 8 | 2026-03-23T12:46:02 | ERROR | YES - lowercase schema/columns |
| 9 | 2026-03-23T12:46:24 | ERROR | YES - lowercase schema/columns |
| 10 | 2026-03-23T12:45:14 | ERROR | YES - TOP(1) → LIMIT 1 |
| 11 | 2026-03-23T12:46:47 | ERROR | YES - lowercase schema/columns |
| 12 | 2026-03-23T12:47:10 | ERROR | YES - lowercase schema/columns |
| 13 | 2026-03-23T12:47:34 | ERROR | YES - lowercase schema/columns |
| 14 | 2026-03-23T12:47:59 | ERROR | YES - lowercase schema/columns/aliases |
| 15 | 2026-03-23T12:48:22 | ERROR | YES - lowercase schema/columns |
| 16 | 2026-03-23T12:48:46 | ERROR | YES - lowercase schema/columns |
| 17 | 2026-03-23T12:49:10 | ERROR | YES - lowercase schema/columns |
| 18 | 2026-03-23T12:49:33 | ERROR | YES - lowercase schema/columns |
| 19 | 2026-03-23T12:49:57 | ERROR | YES - lowercase schema/columns |

## SQL Equivalency Validation Detail Log

| Stmt # | Equivalency Timestamp | Status | Tool Output |
|--------|-----------------------|--------|-------------|
| 1 | 2026-03-23T12:52:44 | ERROR | `'uniqueID'` |
| 2 | 2026-03-23T12:52:53 | ERROR | `'uniqueID'` |
| 3 | 2026-03-23T12:53:04 | ERROR | `'uniqueID'` |
| 4 | 2026-03-23T12:53:13 | ERROR | `'uniqueID'` |
| 5 | 2026-03-23T12:53:24 | ERROR | `'uniqueID'` |
| 6 | 2026-03-23T12:53:36 | ERROR | `'uniqueID'` |
| 7 | 2026-03-23T12:53:46 | ERROR | `'uniqueID'` |
| 8 | 2026-03-23T12:53:56 | ERROR | `'uniqueID'` |
| 9 | 2026-03-23T12:54:06 | ERROR | `'uniqueID'` |
| 10 | 2026-03-23T12:54:16 | ERROR | `'uniqueID'` |
| 11 | 2026-03-23T12:54:25 | ERROR | `'uniqueID'` |
| 12 | 2026-03-23T12:54:36 | ERROR | `'uniqueID'` |
| 13 | 2026-03-23T12:54:46 | ERROR | `'uniqueID'` |
| 14 | 2026-03-23T12:54:58 | ERROR | `'uniqueID'` |
| 15 | 2026-03-23T12:55:07 | ERROR | `'uniqueID'` |
| 16 | 2026-03-23T12:55:19 | ERROR | `'uniqueID'` |
| 17 | 2026-03-23T12:55:31 | ERROR | `'uniqueID'` |
| 18 | 2026-03-23T12:55:43 | ERROR | `'uniqueID'` |
| 19 | 2026-03-23T12:55:53 | ERROR | `'uniqueID'` |

## Migration Date
2026-03-23
