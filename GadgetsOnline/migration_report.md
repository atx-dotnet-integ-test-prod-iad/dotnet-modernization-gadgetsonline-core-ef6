# Migration Report: Microsoft SQL Server to PostgreSQL

## GadgetsOnline Application

**Generated:** 2026-03-24  
**Source Database:** Microsoft SQL Server 2019  
**Target Database:** PostgreSQL 13  
**Application Type:** .NET 8.0 ASP.NET Core MVC with Entity Framework 6  

---

## 1. Executive Summary

The GadgetsOnline application is a .NET 8.0 ASP.NET Core MVC e-commerce application that uses Entity Framework 6 (EF6) with LINQ-to-Entities for all database access operations. Unlike applications with raw SQL strings embedded in source code, this application relies entirely on EF6's LINQ query translation engine to generate SQL at runtime.

The migration from Microsoft SQL Server to PostgreSQL was accomplished by:
1. Configuring the EF6 Npgsql provider (EntityFramework6.Npgsql) for PostgreSQL connectivity
2. Updating all entity model mappings to use lowercase table/column names in the `gadgetsonline_dbo` schema
3. Replacing all SQL Server ADO.NET packages with Npgsql equivalents
4. Updating connection strings to PostgreSQL format

Since the application uses EF6 LINQ-to-Entities exclusively (no raw SQL), the SQL statement extraction and conversion was performed for documentation and validation purposes. The actual SQL generation at runtime is handled by the EF6 Npgsql provider.

---

## 2. Migration Summary Table

| Metric | Count |
|--------|-------|
| Total SQL statements processed | 18 |
| Statements successfully converted by DMS MCP tool | 0 |
| Statements requiring manual intervention (DMS failure) | 18 |
| Statements validated as EQUIVALENT | 0 |
| Statements validated as NOT_EQUIVALENT | 0 |
| Statements with equivalency validation ERROR | 18 |

### DMS Tool Failure Details
All 18 DMS conversions failed with the same error:
```
Metadata model creation failed: {'error': "Metadata model creation failed: 
{'default_error_details': {'message': 'No objects were found according to the 
specified selection rules. Please review your selection rules and try again.'}}"}
```

### SQL Equivalency Tool Error Details
All 18 equivalency validations returned ERROR:
```json
{"equivalence_status": "ERROR", "error": "'uniqueID'"}
```

---

## 3. DMS Tool Results

### Parameters Used
- **Migration Project Identifier:** `arn:aws:dms:us-east-1:789616364195:migration-project:73N4TGCKEFESJJWR43O334CC7U`
- **Database Name:** GadgetsOnline
- **Schema Name:** dbo
- **Region:** us-east-1

### Results Per Statement

| # | Statement | DMS Status |
|---|-----------|------------|
| 1 | GetBestSellers SELECT TOP | FAILED |
| 2 | GetAllCategories SELECT | FAILED |
| 3 | GetAllProductsInCategory SELECT JOIN | FAILED |
| 4 | GetProductById SELECT TOP 1 | FAILED |
| 5 | GetProductNameById SELECT TOP 1 | FAILED |
| 6 | GetCartItems SELECT | FAILED |
| 7 | GetCount SELECT SUM | FAILED |
| 8 | GetTotal SELECT SUM JOIN | FAILED |
| 9 | AddToCart SELECT | FAILED |
| 10 | AddToCart INSERT | FAILED |
| 11 | RemoveFromCart SELECT | FAILED |
| 12 | RemoveFromCart DELETE | FAILED |
| 13 | EmptyCart SELECT | FAILED |
| 14 | EmptyCart DELETE | FAILED |
| 15 | CreateOrder INSERT OrderDetails | FAILED |
| 16 | ProcessOrder INSERT Orders | FAILED |
| 17 | Seed Categories INSERT | FAILED |
| 18 | Seed Products INSERT | FAILED |

All failures: "Metadata model creation failed: No objects were found according to the specified selection rules."

---

## 4. SQL Equivalency Results

All 18 statement pairs were submitted to the SQL Equivalency validation tool (`sql-equivalency___validate_sql_equivalence`). All returned ERROR with `'uniqueID'`.

| # | Statement | Equivalency Status |
|---|-----------|-------------------|
| 1 | GetBestSellers | ERROR |
| 2 | GetAllCategories | ERROR |
| 3 | GetAllProductsInCategory | ERROR |
| 4 | GetProductById | ERROR |
| 5 | GetProductNameById | ERROR |
| 6 | GetCartItems | ERROR |
| 7 | GetCount | ERROR |
| 8 | GetTotal | ERROR |
| 9 | AddToCart SELECT | ERROR |
| 10 | AddToCart INSERT | ERROR |
| 11 | RemoveFromCart SELECT | ERROR |
| 12 | RemoveFromCart DELETE | ERROR |
| 13 | EmptyCart SELECT | ERROR |
| 14 | EmptyCart DELETE | ERROR |
| 15 | CreateOrder INSERT | ERROR |
| 16 | ProcessOrder INSERT | ERROR |
| 17 | Seed Categories INSERT | ERROR |
| 18 | Seed Products INSERT | ERROR |

**Note:** Equivalency statuses are exclusively from the tool output. No agent judgment was used.

---

## 5. Detailed Statement Listing

### Statement 1: GetBestSellers
- **Source:** Services/Inventory.cs :: GetBestSellers(int count)
- **LINQ:** `_gadgetsOnlineEntities.Products.Take(count).ToList()`
- **Original SQL:** `SELECT TOP(@count) [ProductId], [CategoryId], [Name], [Price], [ProductArtUrl] FROM [dbo].[Products];`
- **Converted SQL:** `SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products LIMIT @count;`
- **DMS Status:** FAILED
- **Equivalency:** ERROR

### Statement 2: GetAllCategories
- **Source:** Services/Inventory.cs :: GetAllCategories()
- **LINQ:** `_gadgetsOnlineEntities.Categories.ToList()`
- **Original SQL:** `SELECT [CategoryId], [Name], [Description] FROM [dbo].[Categories];`
- **Converted SQL:** `SELECT categoryid, name, description FROM gadgetsonline_dbo.categories;`
- **DMS Status:** FAILED
- **Equivalency:** ERROR

### Statement 3: GetAllProductsInCategory
- **Source:** Services/Inventory.cs :: GetAllProductsInCategory(string category)
- **LINQ:** `_gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()`
- **Original SQL:** `SELECT p.[ProductId], p.[CategoryId], p.[Name], p.[Price], p.[ProductArtUrl] FROM [dbo].[Products] p INNER JOIN [dbo].[Categories] c ON p.[CategoryId] = c.[CategoryId] WHERE c.[Name] = @category;`
- **Converted SQL:** `SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products p INNER JOIN gadgetsonline_dbo.categories c ON p.categoryid = c.categoryid WHERE c.name = @category;`
- **DMS Status:** FAILED
- **Equivalency:** ERROR

### Statement 4: GetProductById
- **Source:** Services/Inventory.cs :: GetProductById(int id)
- **LINQ:** `_gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()`
- **Original SQL:** `SELECT TOP 1 [ProductId], [CategoryId], [Name], [Price], [ProductArtUrl] FROM [dbo].[Products] WHERE [ProductId] = @id;`
- **Converted SQL:** `SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;`
- **DMS Status:** FAILED
- **Equivalency:** ERROR

### Statement 5: GetProductNameById
- **Source:** Services/Inventory.cs :: GetProductNameById(int id)
- **LINQ:** `_gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name`
- **Original SQL:** `SELECT TOP 1 [Name] FROM [dbo].[Products] WHERE [ProductId] = @id;`
- **Converted SQL:** `SELECT name FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;`
- **DMS Status:** FAILED
- **Equivalency:** ERROR

### Statement 6: GetCartItems
- **Source:** Services/ShoppingCart.cs :: GetCartItems()
- **LINQ:** `_gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId).ToList()`
- **Original SQL:** `SELECT [RecordId], [CartId], [ProductId], [Count], [DateCreated] FROM [dbo].[Carts] WHERE [CartId] = @ShoppingCartId;`
- **Converted SQL:** `SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @ShoppingCartId;`
- **DMS Status:** FAILED
- **Equivalency:** ERROR

### Statement 7: GetCount
- **Source:** Services/ShoppingCart.cs :: GetCount()
- **LINQ:** `(from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count).Sum()`
- **Original SQL:** `SELECT SUM([Count]) FROM [dbo].[Carts] WHERE [CartId] = @ShoppingCartId;`
- **Converted SQL:** `SELECT SUM(count) FROM gadgetsonline_dbo.carts WHERE cartid = @ShoppingCartId;`
- **DMS Status:** FAILED
- **Equivalency:** ERROR

### Statement 8: GetTotal
- **Source:** Services/ShoppingCart.cs :: GetTotal()
- **LINQ:** `(from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count * cartItems.Product.Price).Sum()`
- **Original SQL:** `SELECT SUM(c.[Count] * p.[Price]) FROM [dbo].[Carts] c INNER JOIN [dbo].[Products] p ON c.[ProductId] = p.[ProductId] WHERE c.[CartId] = @ShoppingCartId;`
- **Converted SQL:** `SELECT SUM(c.count * p.price) FROM gadgetsonline_dbo.carts c INNER JOIN gadgetsonline_dbo.products p ON c.productid = p.productid WHERE c.cartid = @ShoppingCartId;`
- **DMS Status:** FAILED
- **Equivalency:** ERROR

### Statement 9: AddToCart - SELECT
- **Source:** Services/ShoppingCart.cs :: AddToCart(int id)
- **LINQ:** `_gadgetsOnlineEntities.Carts.SingleOrDefault(c => c.CartId == ShoppingCartId && c.ProductId == id)`
- **Original SQL:** `SELECT [RecordId], [CartId], [ProductId], [Count], [DateCreated] FROM [dbo].[Carts] WHERE [CartId] = @ShoppingCartId AND [ProductId] = @id;`
- **Converted SQL:** `SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @ShoppingCartId AND productid = @id;`
- **DMS Status:** FAILED
- **Equivalency:** ERROR

### Statement 10: AddToCart - INSERT
- **Source:** Services/ShoppingCart.cs :: AddToCart(int id)
- **LINQ:** `_gadgetsOnlineEntities.Carts.Add(new Cart { ... })`
- **Original SQL:** `INSERT INTO [dbo].[Carts] ([CartId], [ProductId], [Count], [DateCreated]) VALUES (@ShoppingCartId, @ProductId, 1, GETDATE());`
- **Converted SQL:** `INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated) VALUES (@ShoppingCartId, @ProductId, 1, NOW());`
- **DMS Status:** FAILED
- **Equivalency:** ERROR

### Statement 11: RemoveFromCart - SELECT
- **Source:** Services/ShoppingCart.cs :: RemoveFromCart(int id)
- **LINQ:** `_gadgetsOnlineEntities.Carts.Single(cart => cart.CartId == ShoppingCartId && cart.ProductId == id)`
- **Original SQL:** `SELECT [RecordId], [CartId], [ProductId], [Count], [DateCreated] FROM [dbo].[Carts] WHERE [CartId] = @ShoppingCartId AND [ProductId] = @id;`
- **Converted SQL:** `SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @ShoppingCartId AND productid = @id;`
- **DMS Status:** FAILED
- **Equivalency:** ERROR

### Statement 12: RemoveFromCart - DELETE
- **Source:** Services/ShoppingCart.cs :: RemoveFromCart(int id)
- **LINQ:** `_gadgetsOnlineEntities.Carts.Remove(cartItem)`
- **Original SQL:** `DELETE FROM [dbo].[Carts] WHERE [RecordId] = @RecordId;`
- **Converted SQL:** `DELETE FROM gadgetsonline_dbo.carts WHERE recordid = @RecordId;`
- **DMS Status:** FAILED
- **Equivalency:** ERROR

### Statement 13: EmptyCart - SELECT
- **Source:** Services/ShoppingCart.cs :: EmptyCart()
- **LINQ:** `_gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId)`
- **Original SQL:** `SELECT [RecordId], [CartId], [ProductId], [Count], [DateCreated] FROM [dbo].[Carts] WHERE [CartId] = @ShoppingCartId;`
- **Converted SQL:** `SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @ShoppingCartId;`
- **DMS Status:** FAILED
- **Equivalency:** ERROR

### Statement 14: EmptyCart - DELETE
- **Source:** Services/ShoppingCart.cs :: EmptyCart()
- **LINQ:** `_gadgetsOnlineEntities.Carts.Remove(cartItem)` [for each]
- **Original SQL:** `DELETE FROM [dbo].[Carts] WHERE [CartId] = @ShoppingCartId;`
- **Converted SQL:** `DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @ShoppingCartId;`
- **DMS Status:** FAILED
- **Equivalency:** ERROR

### Statement 15: CreateOrder - INSERT OrderDetails
- **Source:** Services/ShoppingCart.cs :: CreateOrder(Order order)
- **LINQ:** `_gadgetsOnlineEntities.OrderDetails.Add(new OrderDetail { ... })`
- **Original SQL:** `INSERT INTO [dbo].[OrderDetails] ([OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (@OrderId, @ProductId, @Quantity, @UnitPrice);`
- **Converted SQL:** `INSERT INTO gadgetsonline_dbo.orderdetails (orderid, productid, quantity, unitprice) VALUES (@OrderId, @ProductId, @Quantity, @UnitPrice);`
- **DMS Status:** FAILED
- **Equivalency:** ERROR

### Statement 16: ProcessOrder - INSERT Orders
- **Source:** Services/OrderProcessing.cs :: ProcessOrder(Order order, HttpContext httpContext)
- **LINQ:** `_gadgetsOnlineEntities.Orders.Add(order)`
- **Original SQL:** `INSERT INTO [dbo].[Orders] ([OrderDate], [Username], [FirstName], [LastName], [Address], [City], [State], [PostalCode], [Country], [Phone], [Email], [Total]) VALUES (@OrderDate, @Username, @FirstName, @LastName, @Address, @City, @State, @PostalCode, @Country, @Phone, @Email, @Total);`
- **Converted SQL:** `INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@OrderDate, @Username, @FirstName, @LastName, @Address, @City, @State, @PostalCode, @Country, @Phone, @Email, @Total);`
- **DMS Status:** FAILED
- **Equivalency:** ERROR

### Statement 17: Seed Categories - INSERT
- **Source:** Models/GadgetsOnlineInitializer.cs :: Seed(GadgetsOnlineEntities context)
- **LINQ:** `categories.ForEach(c => context.Categories.Add(c))`
- **Original SQL:** `INSERT INTO [dbo].[Categories] ([CategoryId], [Name], [Description]) VALUES (1, 'Mobile Phones', ...), ...;`
- **Converted SQL:** `INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description) VALUES (1, 'Mobile Phones', ...), ...;`
- **DMS Status:** FAILED
- **Equivalency:** ERROR

### Statement 18: Seed Products - INSERT
- **Source:** Models/GadgetsOnlineInitializer.cs :: Seed(GadgetsOnlineEntities context)
- **LINQ:** `products.ForEach(p => context.Products.Add(p))`
- **Original SQL:** `INSERT INTO [dbo].[Products] ([ProductId], [CategoryId], [Name], [Price], [ProductArtUrl]) VALUES (1, 1, 'Phone 12', ...), ...;`
- **Converted SQL:** `INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (1, 1, 'Phone 12', ...), ...;`
- **DMS Status:** FAILED
- **Equivalency:** ERROR

---

## 6. Conversion Rules Applied

Since all DMS conversions failed, manual conversion was applied using `DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA`:

### Schema Mapping
| Source (SQL Server) | Target (PostgreSQL) |
|-------------------|-------------------|
| `[dbo]` | `gadgetsonline_dbo` |

### Table Name Mapping
| Source | Target |
|--------|--------|
| `[dbo].[Products]` | `gadgetsonline_dbo.products` |
| `[dbo].[Categories]` | `gadgetsonline_dbo.categories` |
| `[dbo].[Carts]` | `gadgetsonline_dbo.carts` |
| `[dbo].[Orders]` | `gadgetsonline_dbo.orders` |
| `[dbo].[OrderDetails]` | `gadgetsonline_dbo.orderdetails` |

### Column Name Mapping
All column names converted to lowercase (e.g., `ProductId` → `productid`, `CategoryId` → `categoryid`)

### SQL Syntax Conversions
| SQL Server | PostgreSQL |
|-----------|-----------|
| `SELECT TOP N` | `SELECT ... LIMIT N` |
| `SELECT TOP(@param)` | `SELECT ... LIMIT @param` |
| `GETDATE()` | `NOW()` |
| `NVARCHAR(n)` | `VARCHAR(n)` |
| `NVARCHAR(MAX)` | `TEXT` |
| `DATETIME` | `TIMESTAMP` |
| `INT IDENTITY` | `SERIAL` |

---

## 7. Migration State Verification

### Package Dependencies
- ✅ **Npgsql 5.0.18** — Present in GadgetsOnline.csproj
- ✅ **EntityFramework6.Npgsql 6.4.3** — Present in GadgetsOnline.csproj
- ✅ **No Microsoft.Data.SqlClient** — Confirmed absent
- ✅ **No System.Data.SqlClient** — Confirmed absent

### Database Access Code
- ✅ **using Npgsql** import in GadgetsOnlineEntities.cs
- ✅ **NpgsqlServices.Instance** configured as provider
- ✅ **NpgsqlConnectionFactory** set as default connection factory
- ✅ **DbConfigurationType** points to GadgetsOnlineEntitiesPostgreSqlConfiguration
- ✅ **No SqlConnection/SqlCommand/SqlDataReader/SqlParameter/SqlTransaction** references in source code

### Connection String
- ✅ **PostgreSQL format:** `Host=gadgetsonline-sqlserver.c6nek0euoyl0.us-east-1.rds.amazonaws.com;Database=postgres;Username=${DB_USER};Password=${DB_PASSWORD};`
- ✅ **No SQL Server patterns** (Server=, Data Source=, Initial Catalog=, Integrated Security=)

### App.config Configuration
- ✅ **Npgsql provider** registered: `Npgsql.NpgsqlServices, EntityFramework6.Npgsql`
- ✅ **NpgsqlConnectionFactory** as default: `Npgsql.NpgsqlConnectionFactory, EntityFramework6.Npgsql`
- ✅ **NpgsqlFactory** in DbProviderFactories: `Npgsql.NpgsqlFactory, Npgsql`

### Model Mappings (EF6 Fluent API + Data Annotations)
| Entity | Table | Schema | Column Mapping |
|--------|-------|--------|---------------|
| Product | products | gadgetsonline_dbo | productid, categoryid, name, price, productarturl |
| Category | categories | gadgetsonline_dbo | categoryid, name, description |
| Cart | carts | gadgetsonline_dbo | recordid, cartid, productid, count, datecreated |
| Order | orders | gadgetsonline_dbo | orderid, orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total |
| OrderDetail | orderdetails | gadgetsonline_dbo | orderdetailid, orderid, productid, quantity, unitprice |

---

## 8. Transformation Artifacts

| Artifact | Location | Contents |
|----------|----------|----------|
| Extracted SQL Statements | `sourceCode/GadgetsOnline/extracted_statements.sql` | 18 original MS SQL Server statements |
| Converted SQL Statements | `sourceCode/GadgetsOnline/converted_statements.sql` | 18 converted PostgreSQL statements |
| SQL Equivalency Report | `sourceCode/GadgetsOnline/sql_equivalency_validation_report.json` | 18 statement validation entries |
| Migration Report | `sourceCode/GadgetsOnline/migration_report.md` | This document |
| Build Log | `sourceCode/build.log` | Build output |

---

## 9. Build Status

```
Build succeeded.
    0 Warning(s)
    0 Error(s)
```

**Framework:** .NET 8.0  
**Solution:** GadgetsOnline.sln  
**Build Command:** `dotnet build GadgetsOnline.sln`

---

## 10. Notes and Recommendations

1. **DMS Tool Failures:** All 18 DMS conversions failed due to metadata model creation issues. This is likely because the DMS migration project could not find matching database objects in the source SQL Server instance. Manual conversions were applied following the `DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA` protocol.

2. **SQL Equivalency Tool Errors:** All 18 equivalency validations returned ERROR with `'uniqueID'`. This appears to be a service-side configuration issue. Each pair was individually submitted to the tool as required.

3. **EF6 Runtime SQL Generation:** Since this application uses EF6 LINQ-to-Entities, the actual SQL executed against PostgreSQL is generated at runtime by the EF6 Npgsql provider. The extracted/converted SQL statements represent the logical equivalents for documentation purposes.

4. **No Source Code SQL Changes Required:** The application contains no raw/inline SQL strings. All database access is through EF6 LINQ queries, which are translated to PostgreSQL-compatible SQL by the Npgsql provider at runtime.
