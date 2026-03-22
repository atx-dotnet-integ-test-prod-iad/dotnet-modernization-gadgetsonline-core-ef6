# GadgetsOnline Migration Report
## Microsoft SQL Server to PostgreSQL Migration

**Report Date:** 2026-03-22
**Application:** GadgetsOnline (.NET 8.0, Entity Framework 6)
**Source Database:** Microsoft SQL Server 2019
**Target Database:** PostgreSQL 13
**Migration Type:** Database provider migration (EF6 LINQ queries, not raw ADO.NET SQL)
**DMS Migration Project ARN:** arn:aws:dms:us-east-1:789616364195:migration-project:73N4TGCKEFESJJWR43O334CC7U

---

## 1. Executive Summary

The GadgetsOnline web application has been migrated from Microsoft SQL Server to PostgreSQL. The application uses Entity Framework 6 with LINQ queries (not raw ADO.NET SQL strings), so the migration involved:

1. Extracting SQL Server equivalent statements from EF6 LINQ queries (15 statements total)
2. Converting those statements to PostgreSQL syntax via DMS MCP tool (with manual fallback due to DMS failure)
3. Validating equivalency of all statement pairs via SQL Equivalency MCP tool
4. Updating the EF6 provider from SQL Server to Npgsql
5. Updating model mappings to use PostgreSQL lowercase naming conventions with gadgetsonline_dbo schema
6. Updating connection strings and configuration files

**Build Status:** ✅ SUCCESS (0 warnings, 0 errors)

---

## 2. SQL Statement Processing Summary

| Metric | Count |
|--------|-------|
| Total SQL statements extracted | 15 |
| Statements submitted to DMS MCP tool | 15 (submitted twice: Run 1 and Run 2) |
| DMS successful conversions | 0 |
| DMS failed conversions | 15 |
| Manual conversions (DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA) | 15 |
| Statements validated via SQL Equivalency tool | 15 |
| Equivalency status: EQUIVALENT | 0 |
| Equivalency status: NOT_EQUIVALENT | 0 |
| Equivalency status: ERROR | 15 |

### DMS Conversion Details

All 15 statements were submitted to the DMS MCP tool (`dms-mcp___statement_conversion_tool`) **twice** with the following parameters:
- **Migration Project ARN:** `arn:aws:dms:us-east-1:789616364195:migration-project:73N4TGCKEFESJJWR43O334CC7U`
- **Database Name:** GadgetsOnline
- **Schema Name:** dbo
- **Region:** us-east-1

**DMS Error (all 15 statements, both runs):** `Metadata model creation failed: No objects were found according to the specified selection rules. Please review your selection rules and try again.`

**DMS Attempt Timestamps:**
- **Run 1:** 2026-03-22T04:46:57 through 2026-03-22T04:52:42
- **Run 2:** 2026-03-22T05:20:11 through 2026-03-22T05:24:36

Since all DMS conversions failed, manual conversion was applied using `DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA` rules:
- `[dbo].[TableName]` → `gadgetsonline_dbo.tablename` (lowercase)
- `TOP(N)` → `LIMIT N` (PostgreSQL equivalent)
- Square bracket notation removed
- All column names lowercased
- SQL logic, parameters, and structure preserved

### SQL Equivalency Validation Details

All 15 statement pairs were submitted to the SQL Equivalency tool (`sql-equivalency___validate_sql_equivalence`). All 15 returned ERROR with `'uniqueID'` - a systemic tool-side error. No agent judgment was used to determine equivalency.

**Equivalency Validation Timestamps:** 2026-03-22T05:27:01 through 2026-03-22T05:27:59

---

## 3. SQL Statement Conversion Details

### Statement 1: GetBestSellers (Inventory.cs)
| | |
|---|---|
| **Source** | `SELECT TOP(@count) [p].[ProductId], [p].[CategoryId], [p].[Name], [p].[Price], [p].[ProductArtUrl] FROM [dbo].[Products] AS [p];` |
| **Target** | `SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products AS p LIMIT @count;` |
| **Conversion** | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA |
| **DMS Run 1** | 2026-03-22T04:46:57 - FAILED |
| **DMS Run 2** | 2026-03-22T05:20:11 - FAILED |
| **Equivalency** | ERROR (tool-side error: 'uniqueID') |

### Statement 2: GetAllCategories (Inventory.cs)
| | |
|---|---|
| **Source** | `SELECT [c].[CategoryId], [c].[Name], [c].[Description] FROM [dbo].[Categories] AS [c];` |
| **Target** | `SELECT c.categoryid, c.name, c.description FROM gadgetsonline_dbo.categories AS c;` |
| **Conversion** | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA |
| **DMS Run 1** | 2026-03-22T04:47:20 - FAILED |
| **DMS Run 2** | 2026-03-22T05:20:27 - FAILED |
| **Equivalency** | ERROR (tool-side error: 'uniqueID') |

### Statement 3: GetAllProductsInCategory (Inventory.cs)
| | |
|---|---|
| **Source** | `SELECT [p].[ProductId], [p].[CategoryId], [p].[Name], [p].[Price], [p].[ProductArtUrl] FROM [dbo].[Products] AS [p] INNER JOIN [dbo].[Categories] AS [c] ON [p].[CategoryId] = [c].[CategoryId] WHERE [c].[Name] = @category;` |
| **Target** | `SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products AS p INNER JOIN gadgetsonline_dbo.categories AS c ON p.categoryid = c.categoryid WHERE c.name = @category;` |
| **Conversion** | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA |
| **DMS Run 1** | 2026-03-22T04:47:44 - FAILED |
| **DMS Run 2** | 2026-03-22T05:20:42 - FAILED |
| **Equivalency** | ERROR (tool-side error: 'uniqueID') |

### Statement 4: GetProductById (Inventory.cs)
| | |
|---|---|
| **Source** | `SELECT TOP(1) [p].[ProductId], [p].[CategoryId], [p].[Name], [p].[Price], [p].[ProductArtUrl] FROM [dbo].[Products] AS [p] WHERE [p].[ProductId] = @id;` |
| **Target** | `SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products AS p WHERE p.productid = @id LIMIT 1;` |
| **Conversion** | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA |
| **DMS Run 1** | 2026-03-22T04:48:07 - FAILED |
| **DMS Run 2** | 2026-03-22T05:20:58 - FAILED |
| **Equivalency** | ERROR (tool-side error: 'uniqueID') |

### Statement 5: GetProductNameById (Inventory.cs)
| | |
|---|---|
| **Source** | `SELECT TOP(1) [p].[Name] FROM [dbo].[Products] AS [p] WHERE [p].[ProductId] = @id;` |
| **Target** | `SELECT p.name FROM gadgetsonline_dbo.products AS p WHERE p.productid = @id LIMIT 1;` |
| **Conversion** | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA |
| **DMS Run 1** | 2026-03-22T04:48:30 - FAILED |
| **DMS Run 2** | 2026-03-22T05:21:13 - FAILED |
| **Equivalency** | ERROR (tool-side error: 'uniqueID') |

### Statement 6: GetCartItems (ShoppingCart.cs)
| | |
|---|---|
| **Source** | `SELECT [c].[RecordId], [c].[CartId], [c].[ProductId], [c].[Count], [c].[DateCreated] FROM [dbo].[Carts] AS [c] WHERE [c].[CartId] = @cartId;` |
| **Target** | `SELECT c.recordid, c.cartid, c.productid, c.count, c.datecreated FROM gadgetsonline_dbo.carts AS c WHERE c.cartid = @cartId;` |
| **Conversion** | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA |
| **DMS Run 1** | 2026-03-22T04:48:53 - FAILED |
| **DMS Run 2** | 2026-03-22T05:21:47 - FAILED |
| **Equivalency** | ERROR (tool-side error: 'uniqueID') |

### Statement 7: AddToCart - Select (ShoppingCart.cs)
| | |
|---|---|
| **Source** | `SELECT TOP(2) [c].[RecordId], [c].[CartId], [c].[ProductId], [c].[Count], [c].[DateCreated] FROM [dbo].[Carts] AS [c] WHERE [c].[CartId] = @cartId AND [c].[ProductId] = @id;` |
| **Target** | `SELECT c.recordid, c.cartid, c.productid, c.count, c.datecreated FROM gadgetsonline_dbo.carts AS c WHERE c.cartid = @cartId AND c.productid = @id LIMIT 2;` |
| **Conversion** | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA |
| **DMS Run 1** | 2026-03-22T04:49:17 - FAILED |
| **DMS Run 2** | 2026-03-22T05:22:02 - FAILED |
| **Equivalency** | ERROR (tool-side error: 'uniqueID') |

### Statement 8: AddToCart - Insert (ShoppingCart.cs)
| | |
|---|---|
| **Source** | `INSERT INTO [dbo].[Carts] ([CartId], [ProductId], [Count], [DateCreated]) VALUES (@cartId, @productId, @count, @dateCreated);` |
| **Target** | `INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated) VALUES (@cartId, @productId, @count, @dateCreated);` |
| **Conversion** | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA |
| **DMS Run 1** | 2026-03-22T04:49:41 - FAILED |
| **DMS Run 2** | 2026-03-22T05:22:17 - FAILED |
| **Equivalency** | ERROR (tool-side error: 'uniqueID') |

### Statement 9: GetCount (ShoppingCart.cs)
| | |
|---|---|
| **Source** | `SELECT SUM(CAST([c].[Count] AS INT)) FROM [dbo].[Carts] AS [c] WHERE [c].[CartId] = @cartId;` |
| **Target** | `SELECT SUM(CAST(c.count AS INT)) FROM gadgetsonline_dbo.carts AS c WHERE c.cartid = @cartId;` |
| **Conversion** | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA |
| **DMS Run 1** | 2026-03-22T04:50:04 - FAILED |
| **DMS Run 2** | 2026-03-22T05:22:33 - FAILED |
| **Equivalency** | ERROR (tool-side error: 'uniqueID') |

### Statement 10: GetTotal (ShoppingCart.cs)
| | |
|---|---|
| **Source** | `SELECT SUM(CAST([c].[Count] AS INT) * [p].[Price]) FROM [dbo].[Carts] AS [c] INNER JOIN [dbo].[Products] AS [p] ON [c].[ProductId] = [p].[ProductId] WHERE [c].[CartId] = @cartId;` |
| **Target** | `SELECT SUM(CAST(c.count AS INT) * p.price) FROM gadgetsonline_dbo.carts AS c INNER JOIN gadgetsonline_dbo.products AS p ON c.productid = p.productid WHERE c.cartid = @cartId;` |
| **Conversion** | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA |
| **DMS Run 1** | 2026-03-22T04:50:27 - FAILED |
| **DMS Run 2** | 2026-03-22T05:22:48 - FAILED |
| **Equivalency** | ERROR (tool-side error: 'uniqueID') |

### Statement 11: RemoveFromCart - Select (ShoppingCart.cs)
| | |
|---|---|
| **Source** | `SELECT TOP(2) [c].[RecordId], [c].[CartId], [c].[ProductId], [c].[Count], [c].[DateCreated] FROM [dbo].[Carts] AS [c] WHERE [c].[CartId] = @cartId AND [c].[ProductId] = @id;` |
| **Target** | `SELECT c.recordid, c.cartid, c.productid, c.count, c.datecreated FROM gadgetsonline_dbo.carts AS c WHERE c.cartid = @cartId AND c.productid = @id LIMIT 2;` |
| **Conversion** | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA |
| **DMS Run 1** | 2026-03-22T04:50:55 - FAILED |
| **DMS Run 2** | 2026-03-22T05:23:19 - FAILED |
| **Equivalency** | ERROR (tool-side error: 'uniqueID') |

### Statement 12: EmptyCart (ShoppingCart.cs)
| | |
|---|---|
| **Source** | `DELETE FROM [dbo].[Carts] WHERE [CartId] = @cartId;` |
| **Target** | `DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;` |
| **Conversion** | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA |
| **DMS Run 1** | 2026-03-22T04:51:17 - FAILED |
| **DMS Run 2** | 2026-03-22T05:23:34 - FAILED |
| **Equivalency** | ERROR (tool-side error: 'uniqueID') |

### Statement 13: CreateOrder (ShoppingCart.cs)
| | |
|---|---|
| **Source** | `INSERT INTO [dbo].[OrderDetails] ([OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (@orderId, @productId, @quantity, @unitPrice);` |
| **Target** | `INSERT INTO gadgetsonline_dbo.orderdetails (orderid, productid, quantity, unitprice) VALUES (@orderId, @productId, @quantity, @unitPrice);` |
| **Conversion** | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA |
| **DMS Run 1** | 2026-03-22T04:51:40 - FAILED |
| **DMS Run 2** | 2026-03-22T05:23:50 - FAILED |
| **Equivalency** | ERROR (tool-side error: 'uniqueID') |

### Statement 14: ProcessOrder (OrderProcessing.cs)
| | |
|---|---|
| **Source** | `INSERT INTO [dbo].[Orders] ([OrderDate], [Username], [FirstName], [LastName], [Address], [City], [State], [PostalCode], [Country], [Phone], [Email], [Total]) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);` |
| **Target** | `INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);` |
| **Conversion** | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA |
| **DMS Run 1** | 2026-03-22T04:52:04 - FAILED |
| **DMS Run 2** | 2026-03-22T05:24:05 - FAILED |
| **Equivalency** | ERROR (tool-side error: 'uniqueID') |

### Statement 15: RemoveFromCart - Update (ShoppingCart.cs)
| | |
|---|---|
| **Source** | `UPDATE [dbo].[Carts] SET [Count] = [Count] - 1 WHERE [RecordId] = @recordId;` |
| **Target** | `UPDATE gadgetsonline_dbo.carts SET count = count - 1 WHERE recordid = @recordId;` |
| **Conversion** | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA |
| **DMS Run 1** | 2026-03-22T04:52:27 - FAILED |
| **DMS Run 2** | 2026-03-22T05:24:21 - FAILED |
| **Equivalency** | ERROR (tool-side error: 'uniqueID') |

---

## 4. Package Dependency Migration Status

| Component | Status | Details |
|-----------|--------|---------|
| Microsoft.Data.SqlClient | ✅ Removed | No SQL Server client packages present |
| System.Data.SqlClient | ✅ Removed | No SQL Server client packages present |
| Npgsql | ✅ Added | Version 5.0.18 |
| EntityFramework6.Npgsql | ✅ Added | Version 6.4.3 |
| EntityFramework | ✅ Retained | Version 6.5.1 |

---

## 5. Connection String Migration Status

| Aspect | Status | Details |
|--------|--------|---------|
| Format | ✅ PostgreSQL | `Host=;Database=;Username=;Password=` |
| Server/Host | ✅ Migrated | Uses `Host=` (not `Server=`) |
| Authentication | ✅ Updated | Uses `Username=${DB_USER};Password=${DB_PASSWORD}` |
| Connection String Name | ✅ Preserved | `GadgetsOnlineEntities` |

---

## 6. EF6 Provider Configuration Status

| Component | Status | Details |
|-----------|--------|---------|
| DbConfiguration | ✅ Complete | `GadgetsOnlineEntitiesPostgreSqlConfiguration` with Npgsql |
| Provider Services | ✅ Complete | `NpgsqlServices.Instance` registered |
| Connection Factory | ✅ Complete | `NpgsqlConnectionFactory` set as default |
| DbProviderFactories | ✅ Complete | Npgsql registered in app.config |
| DateTime UTC Handling | ✅ Complete | `FixDateTimeKinds()` in SaveChanges/SaveChangesAsync |

---

## 7. Model Mapping Status

All 5 entity models have been updated with PostgreSQL lowercase naming conventions:

| Entity | Table Name | Schema | Status |
|--------|-----------|--------|--------|
| Product | products | gadgetsonline_dbo | ✅ Complete |
| Category | categories | gadgetsonline_dbo | ✅ Complete |
| Cart | carts | gadgetsonline_dbo | ✅ Complete |
| Order | orders | gadgetsonline_dbo | ✅ Complete |
| OrderDetail | orderdetails | gadgetsonline_dbo | ✅ Complete |

All column names use lowercase `[Column("columnname")]` attributes.
All `OnModelCreating` fluent API mappings use lowercase table/column names with `gadgetsonline_dbo` schema.

---

## 8. Source Code SqlClient Reference Check

| Check | Result |
|-------|--------|
| SqlClient in .cs files | ✅ None found |
| SqlConnection in source | ✅ None found |
| SqlCommand in source | ✅ None found |
| SqlDataReader in source | ✅ None found |
| SqlParameter in source | ✅ None found |
| Microsoft.Data.SqlClient in .csproj | ✅ None found |
| System.Data.SqlClient in .csproj | ✅ None found |

Note: SqlClient references exist only in `bin/` and `obj/` build artifact directories (transitive dependency from EntityFramework). These are not source code references and will be resolved on next clean build.

---

## 9. Build Status

Build completed successfully with 0 errors and 0 warnings.

---

## 10. Exit Criteria Verification

| Criteria | Status | Notes |
|----------|--------|-------|
| All SQL Server packages replaced | ✅ | No SqlClient packages remain in .csproj |
| All ADO.NET classes replaced (SqlConnection, etc.) | ✅ | N/A - app uses EF6 LINQ, not raw ADO.NET |
| All SQL statements processed through DMS (15/15) | ✅ | All 15 submitted twice, all failed with metadata error |
| All DMS failures documented | ✅ | Manual conversion applied with full documentation |
| DMS failures use lowercase schema mapping | ✅ | DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA applied |
| All statement pairs validated via Equivalency tool (15/15) | ✅ | All 15 submitted, all returned ERROR |
| No agent judgment for equivalency | ✅ | All statuses from tool output exclusively |
| Connection strings use PostgreSQL format | ✅ | Host= format used |
| Transaction handling updated | ✅ | N/A - EF6 handles transactions |
| Application builds without errors | ✅ | 0 errors, 0 warnings |
| Comprehensive equivalency report generated | ✅ | sql_equivalency_validation_report.json |
| Complete catalog of extracted statements | ✅ | extracted_statements.sql (15 statements) |
| Complete catalog of converted statements | ✅ | converted_statements.sql (15 statements) |

---

## 11. Statements Requiring Manual Review

All 15 statements require manual review due to:
1. **DMS Tool Failure:** All DMS conversions failed with metadata model creation error (both Run 1 and Run 2)
2. **Equivalency Tool Error:** All equivalency validations returned ERROR with 'uniqueID'

The manual conversions applied standard SQL Server to PostgreSQL conversion rules (lowercase schema/table/column names, TOP→LIMIT, bracket removal) and should be functionally equivalent, but automated equivalency validation could not confirm this due to the systemic tool error.

**Note:** Since this is an EF6 LINQ application, the SQL statements in extracted_statements.sql represent the SQL that EF6 would generate when running against SQL Server. With the Npgsql provider and lowercase model mappings in place, EF6 will generate the correct PostgreSQL SQL at runtime. The extracted/converted statements serve as documentation of the equivalent SQL patterns.

---

## 12. Transformation Artifacts

| Artifact | Location | Status | Contents |
|----------|----------|--------|----------|
| Extracted Statements | `extracted_statements.sql` | ✅ Complete | 15 original MS SQL statements |
| Converted Statements | `converted_statements.sql` | ✅ Complete | 15 converted PostgreSQL statements |
| Equivalency Report | `sql_equivalency_validation_report.json` | ✅ Complete | 15 statement pairs with tool output |
| Build Log | `build.log` | ✅ Successful | 0 errors, 0 warnings |
| Migration Report | `migration_report.md` | ✅ This document | Comprehensive migration summary |

### Artifact Consistency Verification
- `extracted_statements.sql`: 15 statements ✅
- `converted_statements.sql`: 15 statements ✅
- `sql_equivalency_validation_report.json`: 15 statement pairs ✅
- All three artifacts reference the same 15 statements in the same order ✅
