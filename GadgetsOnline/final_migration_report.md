# GadgetsOnline - SQL Server to PostgreSQL Migration Report

## Executive Summary

This report documents the comprehensive migration of the GadgetsOnline .NET application from Microsoft SQL Server to PostgreSQL. The application uses Entity Framework 6 with LINQ queries for all database operations — no raw SQL statements were found in the codebase. All database access is through the Npgsql provider for PostgreSQL.

**Migration Date:** 2026-03-26
**Source Database:** Microsoft SQL Server 2019
**Target Database:** PostgreSQL 13
**Application Framework:** .NET 8.0, Entity Framework 6, ASP.NET Core MVC
**DMS Migration Project:** arn:aws:dms:us-east-1:789616364195:migration-project:73N4TGCKEFESJJWR43O334CC7U

---

## 1. SQL Statement Processing Summary

| Metric | Count |
|--------|-------|
| Total SQL statements processed | 20 |
| Statements successfully converted by DMS MCP tool | 0 |
| Statements requiring manual intervention (DMS failure) | 20 |
| Statements validated as equivalent | 0 |
| Statements validated as non-equivalent | 0 |
| Statements with equivalency validation errors | 20 |

### DMS Tool Status
All 20 SQL statements were submitted to the DMS MCP Statement Conversion Tool (`dms-mcp___statement_conversion_tool`). All returned the same error:
```
Metadata model creation failed: {'error': "Metadata model creation failed: {'default_error_details': 
{'message': 'No objects were found according to the specified selection rules. Please review your 
selection rules and try again.'}}"}
```

**DMS Parameters Used:**
- `migration_project_identifier`: arn:aws:dms:us-east-1:789616364195:migration-project:73N4TGCKEFESJJWR43O334CC7U
- `database_name`: GadgetsOnline
- `schema_name`: dbo
- `region`: us-east-1

### SQL Equivalency Tool Status
All 20 statement pairs were submitted to the SQL Equivalency tool (`sql-equivalency___validate_sql_equivalence`). All returned ERROR with:
```
{ "equivalence_status": "ERROR", "error": "'uniqueID'" }
```
This appears to be a tool-level error rather than a statement-level equivalency issue, as even the simplest query (`SELECT 1`) returned the same error.

---

## 2. Conversion Method Applied

Since DMS failed for all statements, manual conversion was applied using the rule:
**DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA**

### Schema Mapping Rules Applied:
| SQL Server | PostgreSQL |
|-----------|-----------|
| `[dbo].[Products]` | `gadgetsonline_dbo.products` |
| `[dbo].[Categories]` | `gadgetsonline_dbo.categories` |
| `[dbo].[Carts]` | `gadgetsonline_dbo.carts` |
| `[dbo].[Orders]` | `gadgetsonline_dbo.orders` |
| `[dbo].[OrderDetails]` | `gadgetsonline_dbo.orderdetails` |

### SQL Syntax Conversions Applied:
| SQL Server Syntax | PostgreSQL Equivalent |
|------------------|---------------------|
| `SELECT TOP(n)` | `SELECT ... LIMIT n` |
| `CAST(x AS INT)` | `CAST(x AS INTEGER)` |
| `[column]` bracket notation | `column` (unquoted lowercase) |
| `NVARCHAR` | `VARCHAR` |
| `DATETIME` | `TIMESTAMP` |
| `IDENTITY` | `SERIAL` |

---

## 3. Detailed Statement Listing

### Statement 1: SELECT TOP Products
- **Source:** Services/Inventory.cs - GetBestSellers(int count)
- **LINQ:** `_gadgetsOnlineEntities.Products.Take(count).ToList()`
- **Original MS SQL:** `SELECT TOP(6) [p].[ProductId], [p].[CategoryId], [p].[Name], [p].[Price], [p].[ProductArtUrl] FROM [dbo].[Products] AS [p]`
- **Converted PostgreSQL:** `SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products AS p LIMIT 6`
- **Conversion Method:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Equivalency Status:** ERROR (tool error)

### Statement 2: SELECT all Categories
- **Source:** Services/Inventory.cs - GetAllCategories()
- **LINQ:** `_gadgetsOnlineEntities.Categories.ToList()`
- **Original MS SQL:** `SELECT [c].[CategoryId], [c].[Name], [c].[Description] FROM [dbo].[Categories] AS [c]`
- **Converted PostgreSQL:** `SELECT c.categoryid, c.name, c.description FROM gadgetsonline_dbo.categories AS c`
- **Conversion Method:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Equivalency Status:** ERROR (tool error)

### Statement 3: SELECT Products by Category Name (with JOIN)
- **Source:** Services/Inventory.cs - GetAllProductsInCategory(string category)
- **LINQ:** `_gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()`
- **Original MS SQL:** `SELECT [p].[ProductId], [p].[CategoryId], [p].[Name], [p].[Price], [p].[ProductArtUrl] FROM [dbo].[Products] AS [p] INNER JOIN [dbo].[Categories] AS [c] ON [p].[CategoryId] = [c].[CategoryId] WHERE [c].[Name] = @category`
- **Converted PostgreSQL:** `SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products AS p INNER JOIN gadgetsonline_dbo.categories AS c ON p.categoryid = c.categoryid WHERE c.name = @category`
- **Conversion Method:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Equivalency Status:** ERROR (tool error)

### Statement 4: SELECT Product by Id
- **Source:** Services/Inventory.cs - GetProductById(int id)
- **LINQ:** `_gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()`
- **Original MS SQL:** `SELECT TOP(1) [p].[ProductId], [p].[CategoryId], [p].[Name], [p].[Price], [p].[ProductArtUrl] FROM [dbo].[Products] AS [p] WHERE [p].[ProductId] = @id`
- **Converted PostgreSQL:** `SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products AS p WHERE p.productid = @id LIMIT 1`
- **Conversion Method:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Equivalency Status:** ERROR (tool error)

### Statement 5: SELECT Product Name by Id
- **Source:** Services/Inventory.cs - GetProductNameById(int id)
- **LINQ:** `_gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name`
- **Original MS SQL:** `SELECT TOP(1) [p].[ProductId], [p].[CategoryId], [p].[Name], [p].[Price], [p].[ProductArtUrl] FROM [dbo].[Products] AS [p] WHERE [p].[ProductId] = @id`
- **Converted PostgreSQL:** `SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products AS p WHERE p.productid = @id LIMIT 1`
- **Conversion Method:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Equivalency Status:** ERROR (tool error)

### Statement 6: SELECT Cart item by CartId and ProductId
- **Source:** Services/ShoppingCart.cs - AddToCart(int id) - check existing
- **LINQ:** `_gadgetsOnlineEntities.Carts.SingleOrDefault(c => c.CartId == ShoppingCartId && c.ProductId == id)`
- **Original MS SQL:** `SELECT TOP(2) [c].[RecordId], [c].[CartId], [c].[ProductId], [c].[Count], [c].[DateCreated] FROM [dbo].[Carts] AS [c] WHERE [c].[CartId] = @cartId AND [c].[ProductId] = @productId`
- **Converted PostgreSQL:** `SELECT c.recordid, c.cartid, c.productid, c.count, c.datecreated FROM gadgetsonline_dbo.carts AS c WHERE c.cartid = @cartId AND c.productid = @productId LIMIT 2`
- **Conversion Method:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Equivalency Status:** ERROR (tool error)

### Statement 7: INSERT into Carts
- **Source:** Services/ShoppingCart.cs - AddToCart(int id) - insert new
- **LINQ:** `_gadgetsOnlineEntities.Carts.Add(cartItem)`
- **Original MS SQL:** `INSERT INTO [dbo].[Carts] ([CartId], [ProductId], [Count], [DateCreated]) VALUES (@CartId, @ProductId, @Count, @DateCreated)`
- **Converted PostgreSQL:** `INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated) VALUES (@CartId, @ProductId, @Count, @DateCreated)`
- **Conversion Method:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Equivalency Status:** ERROR (tool error)

### Statement 8: UPDATE Cart item Count
- **Source:** Services/ShoppingCart.cs - AddToCart(int id) - update existing
- **LINQ:** `cartItem.Count++` then `SaveChanges()`
- **Original MS SQL:** `UPDATE [dbo].[Carts] SET [Count] = @Count WHERE [RecordId] = @RecordId`
- **Converted PostgreSQL:** `UPDATE gadgetsonline_dbo.carts SET count = @Count WHERE recordid = @RecordId`
- **Conversion Method:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Equivalency Status:** ERROR (tool error)

### Statement 9: SELECT SUM of Cart Count
- **Source:** Services/ShoppingCart.cs - GetCount()
- **LINQ:** `(from cartItems in Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count).Sum()`
- **Original MS SQL:** `SELECT SUM([c].[Count]) FROM [dbo].[Carts] AS [c] WHERE [c].[CartId] = @cartId`
- **Converted PostgreSQL:** `SELECT SUM(c.count) FROM gadgetsonline_dbo.carts AS c WHERE c.cartid = @cartId`
- **Conversion Method:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Equivalency Status:** ERROR (tool error)

### Statement 10: SELECT single Cart item for removal
- **Source:** Services/ShoppingCart.cs - RemoveFromCart(int id)
- **LINQ:** `_gadgetsOnlineEntities.Carts.Single(cart => cart.CartId == ShoppingCartId && cart.ProductId == id)`
- **Original MS SQL:** `SELECT TOP(2) [c].[RecordId], [c].[CartId], [c].[ProductId], [c].[Count], [c].[DateCreated] FROM [dbo].[Carts] AS [c] WHERE [c].[CartId] = @cartId AND [c].[ProductId] = @productId`
- **Converted PostgreSQL:** `SELECT c.recordid, c.cartid, c.productid, c.count, c.datecreated FROM gadgetsonline_dbo.carts AS c WHERE c.cartid = @cartId AND c.productid = @productId LIMIT 2`
- **Conversion Method:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Equivalency Status:** ERROR (tool error)

### Statement 11: UPDATE Cart item Count (decrement)
- **Source:** Services/ShoppingCart.cs - RemoveFromCart - decrement count
- **LINQ:** `cartItem.Count--` then `SaveChanges()`
- **Original MS SQL:** `UPDATE [dbo].[Carts] SET [Count] = @Count WHERE [RecordId] = @RecordId`
- **Converted PostgreSQL:** `UPDATE gadgetsonline_dbo.carts SET count = @Count WHERE recordid = @RecordId`
- **Conversion Method:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Equivalency Status:** ERROR (tool error)

### Statement 12: DELETE Cart item
- **Source:** Services/ShoppingCart.cs - RemoveFromCart - remove item
- **LINQ:** `_gadgetsOnlineEntities.Carts.Remove(cartItem)` then `SaveChanges()`
- **Original MS SQL:** `DELETE FROM [dbo].[Carts] WHERE [RecordId] = @RecordId`
- **Converted PostgreSQL:** `DELETE FROM gadgetsonline_dbo.carts WHERE recordid = @RecordId`
- **Conversion Method:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Equivalency Status:** ERROR (tool error)

### Statement 13: SELECT Cart items by CartId
- **Source:** Services/ShoppingCart.cs - GetCartItems()
- **LINQ:** `_gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId).ToList()`
- **Original MS SQL:** `SELECT [c].[RecordId], [c].[CartId], [c].[ProductId], [c].[Count], [c].[DateCreated] FROM [dbo].[Carts] AS [c] WHERE [c].[CartId] = @cartId`
- **Converted PostgreSQL:** `SELECT c.recordid, c.cartid, c.productid, c.count, c.datecreated FROM gadgetsonline_dbo.carts AS c WHERE c.cartid = @cartId`
- **Conversion Method:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Equivalency Status:** ERROR (tool error)

### Statement 14: SELECT Cart Total (Sum of Count * Price)
- **Source:** Services/ShoppingCart.cs - GetTotal()
- **LINQ:** `(from cartItems in Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count * cartItems.Product.Price).Sum()`
- **Original MS SQL:** `SELECT SUM(CAST([c].[Count] AS INT) * [p].[Price]) FROM [dbo].[Carts] AS [c] INNER JOIN [dbo].[Products] AS [p] ON [c].[ProductId] = [p].[ProductId] WHERE [c].[CartId] = @cartId`
- **Converted PostgreSQL:** `SELECT SUM(CAST(c.count AS INTEGER) * p.price) FROM gadgetsonline_dbo.carts AS c INNER JOIN gadgetsonline_dbo.products AS p ON c.productid = p.productid WHERE c.cartid = @cartId`
- **Conversion Method:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Equivalency Status:** ERROR (tool error)

### Statement 15: SELECT Cart items for emptying
- **Source:** Services/ShoppingCart.cs - EmptyCart()
- **LINQ:** `_gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId)` then Remove each
- **Original MS SQL:** `SELECT [c].[RecordId], [c].[CartId], [c].[ProductId], [c].[Count], [c].[DateCreated] FROM [dbo].[Carts] AS [c] WHERE [c].[CartId] = @cartId`
- **Converted PostgreSQL:** `SELECT c.recordid, c.cartid, c.productid, c.count, c.datecreated FROM gadgetsonline_dbo.carts AS c WHERE c.cartid = @cartId`
- **Conversion Method:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Equivalency Status:** ERROR (tool error)

### Statement 16: DELETE Cart items (empty cart)
- **Source:** Services/ShoppingCart.cs - EmptyCart() - delete each item
- **LINQ:** `_gadgetsOnlineEntities.Carts.Remove(cartItem)` for each
- **Original MS SQL:** `DELETE FROM [dbo].[Carts] WHERE [RecordId] = @RecordId`
- **Converted PostgreSQL:** `DELETE FROM gadgetsonline_dbo.carts WHERE recordid = @RecordId`
- **Conversion Method:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Equivalency Status:** ERROR (tool error)

### Statement 17: INSERT into Orders
- **Source:** Services/OrderProcessing.cs - ProcessOrder
- **LINQ:** `_gadgetsOnlineEntities.Orders.Add(order)`
- **Original MS SQL:** `INSERT INTO [dbo].[Orders] ([OrderDate], [Username], [FirstName], [LastName], [Address], [City], [State], [PostalCode], [Country], [Phone], [Email], [Total]) VALUES (@OrderDate, @Username, @FirstName, @LastName, @Address, @City, @State, @PostalCode, @Country, @Phone, @Email, @Total)`
- **Converted PostgreSQL:** `INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@OrderDate, @Username, @FirstName, @LastName, @Address, @City, @State, @PostalCode, @Country, @Phone, @Email, @Total)`
- **Conversion Method:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Equivalency Status:** ERROR (tool error)

### Statement 18: INSERT into OrderDetails
- **Source:** Services/ShoppingCart.cs - CreateOrder
- **LINQ:** `_gadgetsOnlineEntities.OrderDetails.Add(orderDetail)`
- **Original MS SQL:** `INSERT INTO [dbo].[OrderDetails] ([ProductId], [OrderId], [UnitPrice], [Quantity]) VALUES (@ProductId, @OrderId, @UnitPrice, @Quantity)`
- **Converted PostgreSQL:** `INSERT INTO gadgetsonline_dbo.orderdetails (productid, orderid, unitprice, quantity) VALUES (@ProductId, @OrderId, @UnitPrice, @Quantity)`
- **Conversion Method:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Equivalency Status:** ERROR (tool error)

### Statement 19: INSERT seed Categories
- **Source:** Models/GadgetsOnlineInitializer.cs - Seed
- **LINQ:** `context.Categories.Add(c)` for each category
- **Original MS SQL:** `INSERT INTO [dbo].[Categories] ([CategoryId], [Name], [Description]) VALUES (@CategoryId, @Name, @Description)`
- **Converted PostgreSQL:** `INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description) VALUES (@CategoryId, @Name, @Description)`
- **Conversion Method:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Equivalency Status:** ERROR (tool error)

### Statement 20: INSERT seed Products
- **Source:** Models/GadgetsOnlineInitializer.cs - Seed
- **LINQ:** `context.Products.Add(p)` for each product
- **Original MS SQL:** `INSERT INTO [dbo].[Products] ([ProductId], [CategoryId], [Name], [Price], [ProductArtUrl]) VALUES (@ProductId, @CategoryId, @Name, @Price, @ProductArtUrl)`
- **Converted PostgreSQL:** `INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (@ProductId, @CategoryId, @Name, @Price, @ProductArtUrl)`
- **Conversion Method:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Equivalency Status:** ERROR (tool error)

---

## 4. Package Dependency Changes

| Component | Before (SQL Server) | After (PostgreSQL) |
|-----------|-------------------|--------------------|
| Database Provider | Microsoft.Data.SqlClient | Npgsql 5.0.18 |
| EF Provider | EntityFramework (SQL Server) | EntityFramework6.Npgsql 6.4.3 |
| EF Core | EntityFramework 6.5.1 | EntityFramework 6.5.1 (unchanged) |
| Connection Factory | SqlConnectionFactory | NpgsqlConnectionFactory |
| Provider Services | SqlProviderServices | NpgsqlServices |

**Current .csproj packages (PostgreSQL):**
```xml
<PackageReference Include="EntityFramework6.Npgsql" Version="6.4.3" />
<PackageReference Include="Npgsql" Version="5.0.18" />
<PackageReference Include="EntityFramework" Version="6.5.1" />
```

---

## 5. Connection String Changes

| Parameter | SQL Server | PostgreSQL |
|-----------|-----------|-----------|
| Server/Host | `Server=...` | `Host=gadgetsonline-postgres.c6nek0euoyl0.us-east-1.rds.amazonaws.com` |
| Database | `Database=GadgetsOnline` | `Database=postgres` |
| Authentication | `Integrated Security=true` | `Username=${DB_USER};Password=${DB_PASSWORD}` |

**Current connection string (appsettings.json):**
```
Host=gadgetsonline-postgres.c6nek0euoyl0.us-east-1.rds.amazonaws.com;Database=postgres;Username=${DB_USER};Password=${DB_PASSWORD};
```

---

## 6. Entity Framework Configuration Changes

### DbConfiguration (GadgetsOnlineEntities.cs)
- **Provider:** `Npgsql.NpgsqlServices.Instance`
- **Connection Factory:** `Npgsql.NpgsqlConnectionFactory`
- **Configuration Class:** `GadgetsOnlineEntitiesPostgreSqlConfiguration`

### app.config
- **Provider:** `Npgsql.NpgsqlServices, EntityFramework6.Npgsql`
- **Connection Factory:** `Npgsql.NpgsqlConnectionFactory, EntityFramework6.Npgsql`
- **DbProviderFactory:** `Npgsql.NpgsqlFactory, Npgsql`

### Schema Mapping (OnModelCreating)
All 5 tables mapped to `gadgetsonline_dbo` schema with lowercase names:
- `Products` → `gadgetsonline_dbo.products`
- `Categories` → `gadgetsonline_dbo.categories`
- `Carts` → `gadgetsonline_dbo.carts`
- `Orders` → `gadgetsonline_dbo.orders`
- `OrderDetails` → `gadgetsonline_dbo.orderdetails`

All column names mapped to lowercase (e.g., `ProductId` → `productid`).

### DateTime Handling
Added `FixDateTimeKinds()` method to ensure all DateTime values are marked as UTC before saving (PostgreSQL requires UTC DateTimeKind).

---

## 7. Build Verification

```
Build succeeded.
    0 Warning(s)
    0 Error(s)
Time Elapsed 00:00:09.16
```

---

## 8. Statements Requiring Manual Review

All 20 statements require manual review because:
1. DMS MCP tool failed for all statements (metadata model creation error)
2. SQL Equivalency tool returned errors for all statement pairs (tool-level error)
3. Manual conversion was applied based on lowercase schema naming conventions

**Note:** Since this application uses Entity Framework 6 with LINQ, the actual SQL is generated at runtime by the ORM. The EF configuration (model mapping, schema mapping, column mapping) handles the translation automatically. The statements cataloged here represent what EF would generate and are documented for completeness.

---

## 9. Transformation Artifacts

| Artifact | Location | Description |
|----------|----------|-------------|
| extracted_statements.sql | sourceCode/GadgetsOnline/ | Catalog of 20 extracted representative MS SQL statements |
| converted_statements.sql | sourceCode/GadgetsOnline/ | Catalog of 20 original/converted statement pairs |
| sql_equivalency_validation_report.json | sourceCode/GadgetsOnline/ | Comprehensive equivalency validation report for all 20 pairs |
| final_migration_report.md | sourceCode/GadgetsOnline/ | This report |

---

## 10. Conclusion

The GadgetsOnline application has been successfully configured for PostgreSQL:
- All SQL Server package dependencies replaced with Npgsql equivalents
- Entity Framework configured with Npgsql provider and PostgreSQL schema mapping
- Connection string updated to PostgreSQL format
- All model classes mapped to lowercase PostgreSQL table/column names in `gadgetsonline_dbo` schema
- Application builds successfully with 0 warnings and 0 errors
- No residual SQL Server dependencies remain in the codebase
