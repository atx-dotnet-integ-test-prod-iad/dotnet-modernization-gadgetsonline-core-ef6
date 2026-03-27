# GadgetsOnline - SQL Server to PostgreSQL Migration Report

## Executive Summary

| Metric | Count |
|--------|-------|
| Total SQL Statements Processed | 16 |
| DMS Successful Conversions | 0 |
| DMS Failed / Manual Conversions | 16 |
| Equivalency: EQUIVALENT | 0 |
| Equivalency: NOT_EQUIVALENT | 0 |
| Equivalency: ERROR | 16 |
| Build Status | ✅ Success (0 errors, 0 warnings) |

## Application Overview

| Property | Value |
|----------|-------|
| Application | GadgetsOnline |
| Framework | .NET 8.0 |
| ORM | Entity Framework 6 (EF6) |
| Source Database | Microsoft SQL Server 2019 |
| Target Database | PostgreSQL 13 |
| Query Type | EF6 LINQ Queries (no raw SQL) |
| Source Schema | dbo (PascalCase) |
| Target Schema | gadgetsonline_dbo (lowercase) |

## Migration Components Status

### 1. Package Dependencies (GadgetsOnline.csproj)
| Package | Status |
|---------|--------|
| EntityFramework6.Npgsql (6.4.3) | ✅ Present |
| EntityFramework (6.5.1) | ✅ Present |
| Microsoft.Data.SqlClient | ✅ Not present (removed) |
| System.Data.SqlClient | ✅ Not present (removed) |

### 2. Connection String (appsettings.json)
- **Format**: PostgreSQL `Host=` format ✅
- **Value**: `Host=gadgetsonline-postgresql.c6nek0euoyl0.us-east-1.rds.amazonaws.com;Database=postgres;Username=${DB_USER};Password=${DB_PASSWORD};`
- **Credentials**: Using environment variables (no hardcoded secrets) ✅

### 3. Provider Configuration (app.config)
| Component | Status |
|-----------|--------|
| Npgsql provider services | ✅ Configured |
| NpgsqlConnectionFactory | ✅ Set as default |
| NpgsqlFactory DbProviderFactory | ✅ Registered |

### 4. DbContext Configuration (GadgetsOnlineEntities.cs)
| Component | Status |
|-----------|--------|
| GadgetsOnlineEntitiesPostgreSqlConfiguration | ✅ Present |
| NpgsqlServices.Instance | ✅ Set as provider |
| NpgsqlConnectionFactory | ✅ Set as default |
| `using Npgsql` import | ✅ Present |
| OnModelCreating - gadgetsonline_dbo schema | ✅ All tables mapped |
| OnModelCreating - lowercase column names | ✅ All columns mapped |
| FixDateTimeKinds for PostgreSQL | ✅ Present |

### 5. Model Annotations
| Model | Table | Schema | Columns Lowercase |
|-------|-------|--------|-------------------|
| Product.cs | products | gadgetsonline_dbo | ✅ All lowercase |
| Category.cs | categories | gadgetsonline_dbo | ✅ All lowercase |
| Cart.cs | carts | gadgetsonline_dbo | ✅ All lowercase |
| Order.cs | orders | gadgetsonline_dbo | ✅ All lowercase |
| OrderDetail.cs | orderdetails | gadgetsonline_dbo | ✅ All lowercase |

### 6. Source Code Verification
| Check | Status |
|-------|--------|
| No SqlConnection references | ✅ Verified |
| No SqlCommand references | ✅ Verified |
| No SqlDataReader references | ✅ Verified |
| No SqlParameter references | ✅ Verified |
| No Microsoft.Data.SqlClient using | ✅ Verified |
| No System.Data.SqlClient using | ✅ Verified |

## DMS Tool Results

All 16 SQL statements were passed through the DMS MCP tool (`dms-mcp___statement_conversion_tool`) with migration project ARN `arn:aws:dms:us-east-1:789616364195:migration-project:73N4TGCKEFESJJWR43O334CC7U`.

**DMS Error (all 16 statements)**: `Metadata model creation failed: No objects were found according to the specified selection rules.`

**Fallback**: All 16 statements were manually converted using `DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA` rules:
- Schema: `dbo.TableName` → `gadgetsonline_dbo.tablename`
- Columns: PascalCase → lowercase
- SQL Server `TOP(@n)` → PostgreSQL `LIMIT @n`

| # | Statement | DMS Status | Conversion Method |
|---|-----------|------------|-------------------|
| 1 | GetBestSellers | ❌ Failed | Manual (lowercase) |
| 2 | GetAllCategories | ❌ Failed | Manual (lowercase) |
| 3 | GetAllProductsInCategory | ❌ Failed | Manual (lowercase) |
| 4 | GetProductById | ❌ Failed | Manual (lowercase) |
| 5 | GetProductNameById | ❌ Failed | Manual (lowercase) |
| 6 | GetCartItems | ❌ Failed | Manual (lowercase) |
| 7 | GetCount | ❌ Failed | Manual (lowercase) |
| 8 | GetTotal | ❌ Failed | Manual (lowercase) |
| 9 | AddToCart Select | ❌ Failed | Manual (lowercase) |
| 10 | AddToCart Insert | ❌ Failed | Manual (lowercase) |
| 11 | RemoveFromCart Delete | ❌ Failed | Manual (lowercase) |
| 12 | EmptyCart Delete | ❌ Failed | Manual (lowercase) |
| 13 | CreateOrder Insert | ❌ Failed | Manual (lowercase) |
| 14 | ProcessOrder Insert | ❌ Failed | Manual (lowercase) |
| 15 | Seed Categories | ❌ Failed | Manual (lowercase) |
| 16 | Seed Products | ❌ Failed | Manual (lowercase) |

## SQL Equivalency Results

All 16 statement pairs were validated using the SQL Equivalency MCP tool (`sql-equivalency___validate_sql_equivalence`).

**Tool Error (all 16 pairs)**: `'uniqueID'`

| # | Statement | Equivalency Status | Tool Output |
|---|-----------|-------------------|-------------|
| 1 | GetBestSellers | ERROR | `'uniqueID'` |
| 2 | GetAllCategories | ERROR | `'uniqueID'` |
| 3 | GetAllProductsInCategory | ERROR | `'uniqueID'` |
| 4 | GetProductById | ERROR | `'uniqueID'` |
| 5 | GetProductNameById | ERROR | `'uniqueID'` |
| 6 | GetCartItems | ERROR | `'uniqueID'` |
| 7 | GetCount | ERROR | `'uniqueID'` |
| 8 | GetTotal | ERROR | `'uniqueID'` |
| 9 | AddToCart Select | ERROR | `'uniqueID'` |
| 10 | AddToCart Insert | ERROR | `'uniqueID'` |
| 11 | RemoveFromCart Delete | ERROR | `'uniqueID'` |
| 12 | EmptyCart Delete | ERROR | `'uniqueID'` |
| 13 | CreateOrder Insert | ERROR | `'uniqueID'` |
| 14 | ProcessOrder Insert | ERROR | `'uniqueID'` |
| 15 | Seed Categories | ERROR | `'uniqueID'` |
| 16 | Seed Products | ERROR | `'uniqueID'` |

## Detailed Statement Conversions

### Statement 1: GetBestSellers (Inventory.cs)
- **Original**: `SELECT TOP(@count) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products;`
- **Converted**: `SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products LIMIT @count;`

### Statement 2: GetAllCategories (Inventory.cs)
- **Original**: `SELECT CategoryId, Name, Description FROM dbo.Categories;`
- **Converted**: `SELECT categoryid, name, description FROM gadgetsonline_dbo.categories;`

### Statement 3: GetAllProductsInCategory (Inventory.cs)
- **Original**: `SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl FROM dbo.Products p INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @category;`
- **Converted**: `SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products p INNER JOIN gadgetsonline_dbo.categories c ON p.categoryid = c.categoryid WHERE c.name = @category;`

### Statement 4: GetProductById (Inventory.cs)
- **Original**: `SELECT TOP(1) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products WHERE ProductId = @id;`
- **Converted**: `SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;`

### Statement 5: GetProductNameById (Inventory.cs)
- **Original**: `SELECT TOP(1) Name FROM dbo.Products WHERE ProductId = @id;`
- **Converted**: `SELECT name FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;`

### Statement 6: GetCartItems (ShoppingCart.cs)
- **Original**: `SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @ShoppingCartId;`
- **Converted**: `SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @ShoppingCartId;`

### Statement 7: GetCount (ShoppingCart.cs)
- **Original**: `SELECT SUM(Count) FROM dbo.Carts WHERE CartId = @ShoppingCartId;`
- **Converted**: `SELECT SUM(count) FROM gadgetsonline_dbo.carts WHERE cartid = @ShoppingCartId;`

### Statement 8: GetTotal (ShoppingCart.cs)
- **Original**: `SELECT SUM(c.Count * p.Price) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.ProductId = p.ProductId WHERE c.CartId = @ShoppingCartId;`
- **Converted**: `SELECT SUM(c.count * p.price) FROM gadgetsonline_dbo.carts c INNER JOIN gadgetsonline_dbo.products p ON c.productid = p.productid WHERE c.cartid = @ShoppingCartId;`

### Statement 9: AddToCart Select (ShoppingCart.cs)
- **Original**: `SELECT TOP(1) RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @ShoppingCartId AND ProductId = @id;`
- **Converted**: `SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @ShoppingCartId AND productid = @id LIMIT 1;`

### Statement 10: AddToCart Insert (ShoppingCart.cs)
- **Original**: `INSERT INTO dbo.Carts (CartId, ProductId, Count, DateCreated) VALUES (@CartId, @ProductId, @Count, @DateCreated);`
- **Converted**: `INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated) VALUES (@CartId, @ProductId, @Count, @DateCreated);`

### Statement 11: RemoveFromCart Delete (ShoppingCart.cs)
- **Original**: `DELETE FROM dbo.Carts WHERE RecordId = @RecordId;`
- **Converted**: `DELETE FROM gadgetsonline_dbo.carts WHERE recordid = @RecordId;`

### Statement 12: EmptyCart Delete (ShoppingCart.cs)
- **Original**: `DELETE FROM dbo.Carts WHERE CartId = @ShoppingCartId;`
- **Converted**: `DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @ShoppingCartId;`

### Statement 13: CreateOrder Insert (ShoppingCart.cs)
- **Original**: `INSERT INTO dbo.OrderDetails (OrderId, ProductId, Quantity, UnitPrice) VALUES (@OrderId, @ProductId, @Quantity, @UnitPrice);`
- **Converted**: `INSERT INTO gadgetsonline_dbo.orderdetails (orderid, productid, quantity, unitprice) VALUES (@OrderId, @ProductId, @Quantity, @UnitPrice);`

### Statement 14: ProcessOrder Insert (OrderProcessing.cs)
- **Original**: `INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@OrderDate, @Username, @FirstName, @LastName, @Address, @City, @State, @PostalCode, @Country, @Phone, @Email, @Total);`
- **Converted**: `INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@OrderDate, @Username, @FirstName, @LastName, @Address, @City, @State, @PostalCode, @Country, @Phone, @Email, @Total);`

### Statement 15: Seed Categories (GadgetsOnlineInitializer.cs)
- **Original**: `INSERT INTO dbo.Categories (CategoryId, Name, Description) VALUES (@CategoryId, @Name, @Description);`
- **Converted**: `INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description) VALUES (@CategoryId, @Name, @Description);`

### Statement 16: Seed Products (GadgetsOnlineInitializer.cs)
- **Original**: `INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (@ProductId, @CategoryId, @Name, @Price, @ProductArtUrl);`
- **Converted**: `INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (@ProductId, @CategoryId, @Name, @Price, @ProductArtUrl);`

## Build Status

```
Build succeeded.
    0 Warning(s)
    0 Error(s)

Time Elapsed 00:00:07.22
```

## Transformation Artifacts Checklist

| Artifact | Status | Description |
|----------|--------|-------------|
| extracted_statements.sql | ✅ Complete | 16 original MS SQL Server statements |
| converted_statements.sql | ✅ Complete | 16 converted PostgreSQL statements |
| sql_equivalency_validation_report.json | ✅ Complete | 16 equivalency validation entries |
| migration_report.md | ✅ Complete | This report |

## Notes

1. **EF6 LINQ Queries**: This application uses Entity Framework 6 with LINQ queries rather than raw SQL. The SQL statements were extracted as the SQL equivalents of LINQ operations for conversion tracking purposes. The actual SQL generation is handled by EF6 based on model mappings and DbContext configuration.

2. **DMS Tool Failures**: All 16 DMS conversion attempts failed with "Metadata model creation failed: No objects were found according to the specified selection rules." This is likely due to the source database schema not being available in the DMS migration project metadata. Manual conversions were applied following the `DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA` protocol.

3. **SQL Equivalency Tool Errors**: All 16 equivalency validations returned ERROR with `'uniqueID'`. This appears to be a tool-side issue. Per the transformation protocol, all results are recorded as ERROR since the tool's output is the sole authority for equivalency determination.

4. **Re-integration**: Since this is an EF6 application, the re-integration of converted SQL is implicit through the model annotations (`[Table]`, `[Column]` attributes) and `OnModelCreating` configuration. The EF6 provider (EntityFramework6.Npgsql) generates the correct PostgreSQL SQL based on these mappings.
