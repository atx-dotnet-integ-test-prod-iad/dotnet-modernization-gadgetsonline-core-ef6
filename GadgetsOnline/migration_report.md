================================================================================
FINAL MIGRATION REPORT
================================================================================
Project: GadgetsOnline
Migration: Microsoft SQL Server to PostgreSQL
Framework: .NET 8.0 with Entity Framework 6 (LINQ-to-Entities)
Date: 2026-03-05
================================================================================

================================================================================
1. EXECUTIVE SUMMARY
================================================================================

The GadgetsOnline application has been successfully migrated from Microsoft SQL
Server to PostgreSQL. The application uses Entity Framework 6 with LINQ-to-Entities
for ALL database access — there are no raw/inline SQL statements, no
SqlConnection/SqlCommand usage, and no string-concatenated SQL in the codebase.

The migration involved:
- Replacing SQL Server packages with Npgsql equivalents
- Configuring EF6 with Npgsql provider
- Mapping all entity models to PostgreSQL schema (gadgetsonline_dbo) with lowercase
  table and column names
- Updating connection strings to PostgreSQL format
- Adding DateTime UTC fix for Npgsql compatibility

================================================================================
2. SQL STATEMENT PROCESSING SUMMARY
================================================================================

Total SQL Statements Processed:                    17
Statements Successfully Converted by DMS Tool:      0
Statements Requiring Manual Intervention:           17
Statements Validated as Equivalent (SQL Equiv.):     0
Statements Validated as Non-Equivalent:              0
Statements with Equivalency Validation Errors:      17

DMS Tool Status:
- ALL 17 statements were submitted to the DMS MCP tool (dms-mcp___statement_conversion_tool)
- ALL conversions failed with: "Metadata model creation failed: The selected objects were not found."
- Manual conversion was applied using lowercase schema mapping per transformation rules
  (conversion_method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA)

SQL Equivalency Tool Status:
- ALL 17 statement pairs were submitted to the SQL Equivalency tool
  (sql-equivalency___validate_sql_equivalence)
- ALL validations returned ERROR with 'uniqueID' error
- Per transformation rules, all are marked as ERROR (tool output only, no agent judgment)

NOTE: This application uses EF6 LINQ-to-Entities for all database access. The SQL
statements were reconstructed from LINQ queries for the purpose of DMS conversion
and equivalency validation. The actual SQL is generated internally by EF6 at runtime.

================================================================================
3. STATEMENT DETAILS
================================================================================

Stmt 1: Inventory.GetBestSellers (Services/Inventory.cs)
  MS SQL:  SELECT TOP(@count) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products
  PgSQL:   SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products LIMIT @count
  DMS:     FAILED | Manual:  YES | Equivalency: ERROR

Stmt 2: Inventory.GetAllCategories (Services/Inventory.cs)
  MS SQL:  SELECT CategoryId, Name, Description FROM dbo.Categories
  PgSQL:   SELECT categoryid, name, description FROM gadgetsonline_dbo.categories
  DMS:     FAILED | Manual:  YES | Equivalency: ERROR

Stmt 3: Inventory.GetAllProductsInCategory (Services/Inventory.cs)
  MS SQL:  SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl FROM dbo.Products p INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @category
  PgSQL:   SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products p INNER JOIN gadgetsonline_dbo.categories c ON p.categoryid = c.categoryid WHERE c.name = @category
  DMS:     FAILED | Manual:  YES | Equivalency: ERROR

Stmt 4: Inventory.GetProductById (Services/Inventory.cs)
  MS SQL:  SELECT TOP 1 ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products WHERE ProductId = @id
  PgSQL:   SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1
  DMS:     FAILED | Manual:  YES | Equivalency: ERROR

Stmt 5: Inventory.GetProductNameById (Services/Inventory.cs)
  MS SQL:  SELECT TOP 1 Name FROM dbo.Products WHERE ProductId = @id
  PgSQL:   SELECT name FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1
  DMS:     FAILED | Manual:  YES | Equivalency: ERROR

Stmt 6: ShoppingCart.GetCartItems (Services/ShoppingCart.cs)
  MS SQL:  SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId
  PgSQL:   SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @cartId
  DMS:     FAILED | Manual:  YES | Equivalency: ERROR

Stmt 7: ShoppingCart.GetCount (Services/ShoppingCart.cs)
  MS SQL:  SELECT COALESCE(SUM(Count), 0) FROM dbo.Carts WHERE CartId = @cartId
  PgSQL:   SELECT COALESCE(SUM(count), 0) FROM gadgetsonline_dbo.carts WHERE cartid = @cartId
  DMS:     FAILED | Manual:  YES | Equivalency: ERROR

Stmt 8: ShoppingCart.GetTotal (Services/ShoppingCart.cs)
  MS SQL:  SELECT COALESCE(SUM(c.Count * p.Price), 0) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.ProductId = p.ProductId WHERE c.CartId = @cartId
  PgSQL:   SELECT COALESCE(SUM(c.count * p.price), 0) FROM gadgetsonline_dbo.carts c INNER JOIN gadgetsonline_dbo.products p ON c.productid = p.productid WHERE c.cartid = @cartId
  DMS:     FAILED | Manual:  YES | Equivalency: ERROR

Stmt 9: ShoppingCart.AddToCart - SELECT (Services/ShoppingCart.cs)
  MS SQL:  SELECT TOP 1 RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @productId
  PgSQL:   SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @cartId AND productid = @productId LIMIT 1
  DMS:     FAILED | Manual:  YES | Equivalency: ERROR

Stmt 10: ShoppingCart.AddToCart - INSERT (Services/ShoppingCart.cs)
  MS SQL:  INSERT INTO dbo.Carts (CartId, ProductId, Count, DateCreated) VALUES (@cartId, @productId, 1, GETDATE())
  PgSQL:   INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated) VALUES (@cartId, @productId, 1, NOW())
  DMS:     FAILED | Manual:  YES | Equivalency: ERROR

Stmt 11: ShoppingCart.AddToCart - UPDATE (Services/ShoppingCart.cs)
  MS SQL:  UPDATE dbo.Carts SET Count = Count + 1 WHERE CartId = @cartId AND ProductId = @productId
  PgSQL:   UPDATE gadgetsonline_dbo.carts SET count = count + 1 WHERE cartid = @cartId AND productid = @productId
  DMS:     FAILED | Manual:  YES | Equivalency: ERROR

Stmt 12: ShoppingCart.RemoveFromCart - SELECT (Services/ShoppingCart.cs)
  MS SQL:  SELECT TOP 1 RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @id
  PgSQL:   SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @cartId AND productid = @id LIMIT 1
  DMS:     FAILED | Manual:  YES | Equivalency: ERROR

Stmt 13: ShoppingCart.RemoveFromCart - UPDATE (Services/ShoppingCart.cs)
  MS SQL:  UPDATE dbo.Carts SET Count = Count - 1 WHERE CartId = @cartId AND ProductId = @id
  PgSQL:   UPDATE gadgetsonline_dbo.carts SET count = count - 1 WHERE cartid = @cartId AND productid = @id
  DMS:     FAILED | Manual:  YES | Equivalency: ERROR

Stmt 14: ShoppingCart.RemoveFromCart - DELETE (Services/ShoppingCart.cs)
  MS SQL:  DELETE FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @id
  PgSQL:   DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @cartId AND productid = @id
  DMS:     FAILED | Manual:  YES | Equivalency: ERROR

Stmt 15: ShoppingCart.EmptyCart (Services/ShoppingCart.cs)
  MS SQL:  DELETE FROM dbo.Carts WHERE CartId = @cartId
  PgSQL:   DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @cartId
  DMS:     FAILED | Manual:  YES | Equivalency: ERROR

Stmt 16: ShoppingCart.CreateOrder - INSERT OrderDetails (Services/ShoppingCart.cs)
  MS SQL:  INSERT INTO dbo.OrderDetails (OrderId, ProductId, Quantity, UnitPrice) VALUES (@orderId, @productId, @quantity, @unitPrice)
  PgSQL:   INSERT INTO gadgetsonline_dbo.orderdetails (orderid, productid, quantity, unitprice) VALUES (@orderId, @productId, @quantity, @unitPrice)
  DMS:     FAILED | Manual:  YES | Equivalency: ERROR

Stmt 17: OrderProcessing.ProcessOrder - INSERT Orders (Services/OrderProcessing.cs)
  MS SQL:  INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (...)
  PgSQL:   INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (...)
  DMS:     FAILED | Manual:  YES | Equivalency: ERROR

================================================================================
4. PACKAGE DEPENDENCY CHANGES
================================================================================

REMOVED (from original SQL Server configuration):
- Microsoft.Data.SqlClient (no direct reference existed)
- System.Data.SqlClient (no direct reference existed)

ADDED/PRESENT (for PostgreSQL):
- Npgsql 5.0.18 (NuGet Gallery)
- EntityFramework6.Npgsql 6.4.3 (NuGet Gallery)

TRANSITIVE DEPENDENCY NOTE:
- System.Data.SqlClient 4.8.0 appears as a transitive dependency in
  project.assets.json from the EntityFramework package.
- This is a KNOWN EF6 dependency that CANNOT be removed without breaking EF6.
- It does not affect PostgreSQL functionality since EF6 is configured to use
  Npgsql as the provider.

================================================================================
5. CONNECTION STRING CHANGES
================================================================================

BEFORE (SQL Server format):
  Server=<server>;Database=GadgetsOnline;Integrated Security=true

AFTER (PostgreSQL format):
  Host=gadgetsonline-sqlserver.c6nek0euoyl0.us-east-1.rds.amazonaws.com;
  Database=postgres;Username=${DB_USER};Password=${DB_PASSWORD}

Changes Applied:
- Server= replaced with Host=
- Integrated Security removed
- Username/Password parameters added (using environment variables)
- Database name updated to match PostgreSQL instance

================================================================================
6. DATABASE ACCESS CODE CHANGES
================================================================================

This application uses Entity Framework 6 with LINQ-to-Entities. No raw SQL
statements, SqlConnection, SqlCommand, SqlDataReader, or SqlParameter classes
were found in the codebase.

EF6 Configuration Changes:
- Added GadgetsOnlineEntitiesPostgreSqlConfiguration class (Npgsql provider)
- Added [DbConfigurationType] attribute to GadgetsOnlineEntities
- Configured default schema: gadgetsonline_dbo
- Added Fluent API mappings for all entities with lowercase table/column names
- Added DateTime UTC fix for Npgsql compatibility (SaveChanges/SaveChangesAsync)

Model Mapping Changes (via Data Annotations and Fluent API):
- Products → gadgetsonline_dbo.products (all column names lowercased)
- Categories → gadgetsonline_dbo.categories (all column names lowercased)
- Carts → gadgetsonline_dbo.carts (all column names lowercased)
- Orders → gadgetsonline_dbo.orders (all column names lowercased)
- OrderDetails → gadgetsonline_dbo.orderdetails (all column names lowercased)

app.config Changes:
- EF6 provider: Npgsql (NpgsqlServices, EntityFramework6.Npgsql)
- Default connection factory: NpgsqlConnectionFactory
- DbProviderFactories: NpgsqlFactory registered

================================================================================
7. BUILD STATUS
================================================================================

Final Build: SUCCESS
  - 0 Warnings
  - 0 Errors
  - Target: net8.0
  - Output: GadgetsOnline.dll

================================================================================
8. TRANSFORMATION ARTIFACTS
================================================================================

1. extracted_statements.sql
   - Complete catalog of all 17 original MS SQL Server statements
   - Location: sourceCode/GadgetsOnline/extracted_statements.sql

2. converted_statements.sql
   - Complete catalog of all 17 converted PostgreSQL statements
   - Location: sourceCode/GadgetsOnline/converted_statements.sql

3. sql_equivalency_validation_report.json
   - Comprehensive equivalency validation report in required JSON format
   - Contains: number_of_statements_processed, number_of_statements_equivalent,
     number_of_statements_non_equivalent, number_of_statements_with_equivalency_error,
     statement_details array with all 17 entries
   - Each entry includes: original_statement, converted_statement, conversion_method,
     equivalency_status, equivalency_tool_output, dms_failure_reason
   - Location: sourceCode/GadgetsOnline/sql_equivalency_validation_report.json

4. migration_report.md (this file)
   - Comprehensive final migration report
   - Location: sourceCode/GadgetsOnline/migration_report.md

================================================================================
9. STATEMENTS REQUIRING MANUAL REVIEW
================================================================================

ALL 17 statements require manual review because:
1. DMS MCP tool failed for all conversions (metadata model creation error)
2. SQL Equivalency tool returned ERROR for all validations ('uniqueID' error)

Manual conversions applied consistent transformation rules:
- Schema: dbo → gadgetsonline_dbo
- Table names: PascalCase → lowercase (Products → products, etc.)
- Column names: PascalCase → lowercase (ProductId → productid, etc.)
- SQL syntax: TOP N → LIMIT N, GETDATE() → NOW()

These conversions align with the EF6 model mappings already configured in the
codebase, ensuring runtime consistency.

================================================================================
END OF REPORT
================================================================================
