-- ============================================================================
-- CONVERTED SQL STATEMENTS CATALOG
-- Application: GadgetsOnline (.NET EF6 Application)
-- Source Database: Microsoft SQL Server (dbo schema)
-- Target Database: PostgreSQL (gadgetsonline_dbo schema)
-- Conversion Date: 2026-03-21
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA (all 21)
-- DMS Failure Reason: Metadata model creation failed - No objects found
-- DMS Submission Note: All 21 statements submitted to DMS MCP tool
--   (dms-mcp___statement_conversion_tool) with parameters:
--     database_name: GadgetsOnline
--     schema_name: dbo
--     migration_project_identifier: arn:aws:dms:us-east-1:789616364195:migration-project:73N4TGCKEFESJJWR43O334CC7U
--   DMS submission timestamps (attempt 1): 2026-03-21T17:40:14 through 2026-03-21T17:46:43
--   DMS submission timestamps (attempt 2): 2026-03-21T18:17:21 through 2026-03-21T18:26:25
--   Both attempts: All 21 returned identical error: "Metadata model creation failed:
--     No objects were found according to the specified selection rules.
--     Please review your selection rules and try again."
--   Attempt 2 also tried with server_name parameter - returned "Incorrect format of selection rules"
--   Manual conversion with lowercase schema applied per transformation rules.
-- ============================================================================

-- ============================================================================
-- SOURCE FILE: Services/Inventory.cs
-- ============================================================================

-- Statement 1: GetBestSellers
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- ORIGINAL (MS SQL):
-- SELECT TOP(@count) [ProductId], [CategoryId], [Name], [Price], [ProductArtUrl] FROM [dbo].[Products];
-- CONVERTED (PostgreSQL):
SELECT productid, categoryid, name, price, productarturl
FROM gadgetsonline_dbo.products LIMIT @count;

-- Statement 2: GetAllCategories
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- ORIGINAL (MS SQL):
-- SELECT [CategoryId], [Name], [Description] FROM [dbo].[Categories];
-- CONVERTED (PostgreSQL):
SELECT categoryid, name, description
FROM gadgetsonline_dbo.categories;

-- Statement 3: GetAllProductsInCategory
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- ORIGINAL (MS SQL):
-- SELECT p.[ProductId], p.[CategoryId], p.[Name], p.[Price], p.[ProductArtUrl] FROM [dbo].[Products] AS p INNER JOIN [dbo].[Categories] AS c ON p.[CategoryId] = c.[CategoryId] WHERE c.[Name] = @category;
-- CONVERTED (PostgreSQL):
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl
FROM gadgetsonline_dbo.products AS p
INNER JOIN gadgetsonline_dbo.categories AS c ON p.categoryid = c.categoryid
WHERE c.name = @category;

-- Statement 4: GetProductById
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- ORIGINAL (MS SQL):
-- SELECT TOP(1) [ProductId], [CategoryId], [Name], [Price], [ProductArtUrl] FROM [dbo].[Products] WHERE [ProductId] = @id;
-- CONVERTED (PostgreSQL):
SELECT productid, categoryid, name, price, productarturl
FROM gadgetsonline_dbo.products
WHERE productid = @id LIMIT 1;

-- Statement 5: GetProductNameById
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- ORIGINAL (MS SQL):
-- SELECT TOP(1) [Name] FROM [dbo].[Products] WHERE [ProductId] = @id;
-- CONVERTED (PostgreSQL):
SELECT name
FROM gadgetsonline_dbo.products
WHERE productid = @id LIMIT 1;

-- ============================================================================
-- SOURCE FILE: Services/ShoppingCart.cs
-- ============================================================================

-- Statement 6: GetCartItems
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- ORIGINAL (MS SQL):
-- SELECT [RecordId], [CartId], [ProductId], [Count], [DateCreated] FROM [dbo].[Carts] WHERE [CartId] = @ShoppingCartId;
-- CONVERTED (PostgreSQL):
SELECT recordid, cartid, productid, count, datecreated
FROM gadgetsonline_dbo.carts
WHERE cartid = @ShoppingCartId;

-- Statement 7: GetCount
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- ORIGINAL (MS SQL):
-- SELECT SUM([Count]) FROM [dbo].[Carts] WHERE [CartId] = @ShoppingCartId;
-- CONVERTED (PostgreSQL):
SELECT SUM(count)
FROM gadgetsonline_dbo.carts
WHERE cartid = @ShoppingCartId;

-- Statement 8: GetTotal
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- ORIGINAL (MS SQL):
-- SELECT SUM(CAST(c.[Count] AS INT) * p.[Price]) FROM [dbo].[Carts] AS c INNER JOIN [dbo].[Products] AS p ON c.[ProductId] = p.[ProductId] WHERE c.[CartId] = @ShoppingCartId;
-- CONVERTED (PostgreSQL):
SELECT SUM(CAST(c.count AS INT) * p.price)
FROM gadgetsonline_dbo.carts AS c
INNER JOIN gadgetsonline_dbo.products AS p ON c.productid = p.productid
WHERE c.cartid = @ShoppingCartId;

-- Statement 9: AddToCart - SELECT
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- ORIGINAL (MS SQL):
-- SELECT TOP(1) [RecordId], [CartId], [ProductId], [Count], [DateCreated] FROM [dbo].[Carts] WHERE [CartId] = @ShoppingCartId AND [ProductId] = @id;
-- CONVERTED (PostgreSQL):
SELECT recordid, cartid, productid, count, datecreated
FROM gadgetsonline_dbo.carts
WHERE cartid = @ShoppingCartId AND productid = @id LIMIT 1;

-- Statement 10: AddToCart - INSERT
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- ORIGINAL (MS SQL):
-- INSERT INTO [dbo].[Carts] ([CartId], [ProductId], [Count], [DateCreated]) VALUES (@CartId, @ProductId, 1, @DateCreated);
-- CONVERTED (PostgreSQL):
INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated)
VALUES (@CartId, @ProductId, 1, @DateCreated);

-- Statement 11: AddToCart - UPDATE
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- ORIGINAL (MS SQL):
-- UPDATE [dbo].[Carts] SET [Count] = [Count] + 1 WHERE [RecordId] = @RecordId;
-- CONVERTED (PostgreSQL):
UPDATE gadgetsonline_dbo.carts
SET count = count + 1
WHERE recordid = @RecordId;

-- Statement 12: RemoveFromCart - SELECT
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- ORIGINAL (MS SQL):
-- SELECT TOP(1) [RecordId], [CartId], [ProductId], [Count], [DateCreated] FROM [dbo].[Carts] WHERE [CartId] = @ShoppingCartId AND [ProductId] = @id;
-- CONVERTED (PostgreSQL):
SELECT recordid, cartid, productid, count, datecreated
FROM gadgetsonline_dbo.carts
WHERE cartid = @ShoppingCartId AND productid = @id LIMIT 1;

-- Statement 13: RemoveFromCart - UPDATE
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- ORIGINAL (MS SQL):
-- UPDATE [dbo].[Carts] SET [Count] = [Count] - 1 WHERE [RecordId] = @RecordId;
-- CONVERTED (PostgreSQL):
UPDATE gadgetsonline_dbo.carts
SET count = count - 1
WHERE recordid = @RecordId;

-- Statement 14: RemoveFromCart - DELETE
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- ORIGINAL (MS SQL):
-- DELETE FROM [dbo].[Carts] WHERE [RecordId] = @RecordId;
-- CONVERTED (PostgreSQL):
DELETE FROM gadgetsonline_dbo.carts
WHERE recordid = @RecordId;

-- Statement 15: EmptyCart - SELECT
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- ORIGINAL (MS SQL):
-- SELECT [RecordId], [CartId], [ProductId], [Count], [DateCreated] FROM [dbo].[Carts] WHERE [CartId] = @ShoppingCartId;
-- CONVERTED (PostgreSQL):
SELECT recordid, cartid, productid, count, datecreated
FROM gadgetsonline_dbo.carts
WHERE cartid = @ShoppingCartId;

-- Statement 16: EmptyCart - DELETE
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- ORIGINAL (MS SQL):
-- DELETE FROM [dbo].[Carts] WHERE [CartId] = @ShoppingCartId;
-- CONVERTED (PostgreSQL):
DELETE FROM gadgetsonline_dbo.carts
WHERE cartid = @ShoppingCartId;

-- Statement 17: CreateOrder - INSERT OrderDetail
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- ORIGINAL (MS SQL):
-- INSERT INTO [dbo].[OrderDetails] ([ProductId], [OrderId], [UnitPrice], [Quantity]) VALUES (@ProductId, @OrderId, @UnitPrice, @Quantity);
-- CONVERTED (PostgreSQL):
INSERT INTO gadgetsonline_dbo.orderdetails (productid, orderid, unitprice, quantity)
VALUES (@ProductId, @OrderId, @UnitPrice, @Quantity);

-- Statement 18: CreateOrder - UPDATE Order Total
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- ORIGINAL (MS SQL):
-- UPDATE [dbo].[Orders] SET [Total] = @Total WHERE [OrderId] = @OrderId;
-- CONVERTED (PostgreSQL):
UPDATE gadgetsonline_dbo.orders
SET total = @Total
WHERE orderid = @OrderId;

-- ============================================================================
-- SOURCE FILE: Services/OrderProcessing.cs
-- ============================================================================

-- Statement 19: ProcessOrder - INSERT Order
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- ORIGINAL (MS SQL):
-- INSERT INTO [dbo].[Orders] ([OrderDate], [Username], [FirstName], [LastName], [Address], [City], [State], [PostalCode], [Country], [Phone], [Email], [Total]) VALUES (@OrderDate, @Username, @FirstName, @LastName, @Address, @City, @State, @PostalCode, @Country, @Phone, @Email, @Total);
-- CONVERTED (PostgreSQL):
INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total)
VALUES (@OrderDate, @Username, @FirstName, @LastName, @Address, @City, @State, @PostalCode, @Country, @Phone, @Email, @Total);

-- ============================================================================
-- SOURCE FILE: Models/GadgetsOnlineInitializer.cs
-- ============================================================================

-- Statement 20: Seed Categories
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- ORIGINAL (MS SQL):
-- INSERT INTO [dbo].[Categories] ([CategoryId], [Name], [Description]) VALUES (1, 'Mobile Phones', 'Latest collection of Mobile Phones'), (2, 'Laptops', 'Latest Laptops in 2022'), (3, 'Desktops', 'Latest Desktops in 2022'), (4, 'Audio', 'Latest audio devices'), (5, 'Accessories', 'USB Cables, Mobile chargers and Keyboards etc');
-- CONVERTED (PostgreSQL):
INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description)
VALUES (1, 'Mobile Phones', 'Latest collection of Mobile Phones'),
       (2, 'Laptops', 'Latest Laptops in 2022'),
       (3, 'Desktops', 'Latest Desktops in 2022'),
       (4, 'Audio', 'Latest audio devices'),
       (5, 'Accessories', 'USB Cables, Mobile chargers and Keyboards etc');

-- Statement 21: Seed Products
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- ORIGINAL (MS SQL):
-- INSERT INTO [dbo].[Products] ([ProductId], [CategoryId], [Name], [Price], [ProductArtUrl]) VALUES (1, 1, 'Phone 12', 699.00, '/Content/Images/Mobile/1.jpg'), ...
-- CONVERTED (PostgreSQL):
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl)
VALUES (1, 1, 'Phone 12', 699.00, '/Content/Images/Mobile/1.jpg'),
       (2, 1, 'Phone 13 Pro', 999.00, '/Content/Images/Mobile/2.jpg'),
       (3, 1, 'Phone 13 Pro Max', 1199.00, '/Content/Images/Mobile/3.jpg'),
       (4, 2, 'XTS 13''', 899.00, '/Content/Images/Laptop/1.jpg'),
       (5, 2, 'PC 15.5''', 479.00, '/Content/Images/Laptop/2.jpg'),
       (6, 2, 'Notebook 14', 169.00, '/Content/Images/Laptop/3.jpg'),
       (7, 3, 'The IdeaCenter', 539.00, '/Content/Images/placeholder.gif'),
       (8, 3, 'COMP 22-df003w', 389.00, '/Content/Images/placeholder.gif'),
       (9, 4, 'Bluetooth Headphones Over Ear', 28.00, '/Content/Images/Headphones/1.png'),
       (10, 4, 'ZX Series ', 10.00, '/Content/Images/Headphones/2.png'),
       (11, 5, 'Wireless charger', 9.99, '/Content/Images/placeholder.gif'),
       (12, 5, 'Mousepad', 2.99, '/Content/Images/placeholder.gif'),
       (13, 5, 'Keyboard', 9.99, '/Content/Images/placeholder.gif');

-- ============================================================================
-- TOTAL STATEMENTS CONVERTED: 21
-- CONVERSION METHOD: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA (all 21)
-- DMS FAILURE REASON: Metadata model creation failed for all statements
-- Manual Conversion Rules Applied:
--   [dbo].[TableName] -> gadgetsonline_dbo.tablename
--   [ColumnName] -> columnname
--   SELECT TOP(N) -> LIMIT N
--   SELECT TOP(@param) -> LIMIT @param
--   CAST(x AS INT) preserved (valid in PostgreSQL)
-- ============================================================================
