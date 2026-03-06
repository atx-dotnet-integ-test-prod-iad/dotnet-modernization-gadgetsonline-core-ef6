-- ============================================================================
-- CONVERTED SQL STATEMENTS CATALOG
-- Source: MS SQL Server (from extracted_statements.sql)
-- Target: PostgreSQL (converted via manual conversion after DMS failures)
-- Total Statements: 16
-- DMS Conversion Status: ALL 16 FAILED - Manual conversion applied
-- DMS Error: Metadata model creation failed: The selected objects were not found.
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Run Timestamp: 2026-03-06T00:39:28 through 2026-03-06T00:44:17
-- ============================================================================

-- ============================================================================
-- SOURCE FILE: Services/Inventory.cs
-- ============================================================================

-- Statement 1
-- Method: GetBestSellers(int count)
-- DMS Status: FAILED - Metadata model creation failed: The selected objects were not found.
-- DMS Timestamp: 2026-03-06T00:39:28.141995
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original: SELECT TOP(@p0) * FROM [dbo].[Products]
-- Converted:
SELECT * FROM gadgetsonline_dbo.products LIMIT @p0

-- Statement 2
-- Method: GetAllCategories()
-- DMS Status: FAILED - Metadata model creation failed: The selected objects were not found.
-- DMS Timestamp: 2026-03-06T00:39:43.752379
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original: SELECT * FROM [dbo].[Categories]
-- Converted:
SELECT * FROM gadgetsonline_dbo.categories

-- Statement 3
-- Method: GetAllProductsInCategory(string category)
-- DMS Status: FAILED - Metadata model creation failed: The selected objects were not found.
-- DMS Timestamp: 2026-03-06T00:39:59.160397
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original: SELECT * FROM [dbo].[Products] p INNER JOIN [dbo].[Categories] c ON p.CategoryId = c.CategoryId WHERE c.Name = @p0
-- Converted:
SELECT * FROM gadgetsonline_dbo.products p INNER JOIN gadgetsonline_dbo.categories c ON p.categoryid = c.categoryid WHERE c.name = @p0

-- Statement 4
-- Method: GetProductById(int id)
-- DMS Status: FAILED - Metadata model creation failed: The selected objects were not found.
-- DMS Timestamp: 2026-03-06T00:40:14.591545
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original: SELECT TOP(1) * FROM [dbo].[Products] WHERE ProductId = @p0
-- Converted:
SELECT * FROM gadgetsonline_dbo.products WHERE productid = @p0 LIMIT 1

-- Statement 5
-- Method: GetProductNameById(int id)
-- DMS Status: FAILED - Metadata model creation failed: The selected objects were not found.
-- DMS Timestamp: 2026-03-06T00:40:43.144264
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original: SELECT TOP(1) * FROM [dbo].[Products] WHERE ProductId = @p0
-- Converted:
SELECT * FROM gadgetsonline_dbo.products WHERE productid = @p0 LIMIT 1

-- ============================================================================
-- SOURCE FILE: Services/ShoppingCart.cs
-- ============================================================================

-- Statement 6
-- Method: GetCartItems()
-- DMS Status: FAILED - Metadata model creation failed: The selected objects were not found.
-- DMS Timestamp: 2026-03-06T00:40:58.688714
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original: SELECT * FROM [dbo].[Carts] WHERE CartId = @p0
-- Converted:
SELECT * FROM gadgetsonline_dbo.carts WHERE cartid = @p0

-- Statement 7
-- Method: GetCount()
-- DMS Status: FAILED - Metadata model creation failed: The selected objects were not found.
-- DMS Timestamp: 2026-03-06T00:41:14.376139
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original: SELECT SUM(Count) FROM [dbo].[Carts] WHERE CartId = @p0
-- Converted:
SELECT SUM(count) FROM gadgetsonline_dbo.carts WHERE cartid = @p0

-- Statement 8
-- Method: GetTotal()
-- DMS Status: FAILED - Metadata model creation failed: The selected objects were not found.
-- DMS Timestamp: 2026-03-06T00:41:29.724851
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original: SELECT SUM(c.Count * p.Price) FROM [dbo].[Carts] c INNER JOIN [dbo].[Products] p ON c.ProductId = p.ProductId WHERE c.CartId = @p0
-- Converted:
SELECT SUM(c.count * p.price) FROM gadgetsonline_dbo.carts c INNER JOIN gadgetsonline_dbo.products p ON c.productid = p.productid WHERE c.cartid = @p0

-- Statement 9
-- Method: AddToCart(int id) - SELECT part
-- DMS Status: FAILED - Metadata model creation failed: The selected objects were not found.
-- DMS Timestamp: 2026-03-06T00:41:58.653369
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original: SELECT * FROM [dbo].[Carts] WHERE CartId = @p0 AND ProductId = @p1
-- Converted:
SELECT * FROM gadgetsonline_dbo.carts WHERE cartid = @p0 AND productid = @p1

-- Statement 10
-- Method: AddToCart(int id) - INSERT part
-- DMS Status: FAILED - Metadata model creation failed: The selected objects were not found.
-- DMS Timestamp: 2026-03-06T00:42:14.008948
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original: INSERT INTO [dbo].[Carts] (CartId, ProductId, Count, DateCreated) VALUES (@p0, @p1, @p2, @p3)
-- Converted:
INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated) VALUES (@p0, @p1, @p2, @p3)

-- Statement 11
-- Method: RemoveFromCart(int id)
-- DMS Status: FAILED - Metadata model creation failed: The selected objects were not found.
-- DMS Timestamp: 2026-03-06T00:42:29.592956
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original: DELETE FROM [dbo].[Carts] WHERE RecordId = @p0
-- Converted:
DELETE FROM gadgetsonline_dbo.carts WHERE recordid = @p0

-- Statement 12
-- Method: EmptyCart()
-- DMS Status: FAILED - Metadata model creation failed: The selected objects were not found.
-- DMS Timestamp: 2026-03-06T00:42:45.216582
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original: DELETE FROM [dbo].[Carts] WHERE CartId = @p0
-- Converted:
DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @p0

-- Statement 13
-- Method: CreateOrder(Order order) - INSERT OrderDetails
-- DMS Status: FAILED - Metadata model creation failed: The selected objects were not found.
-- DMS Timestamp: 2026-03-06T00:43:16.438043
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original: INSERT INTO [dbo].[OrderDetails] (ProductId, OrderId, UnitPrice, Quantity) VALUES (@p0, @p1, @p2, @p3)
-- Converted:
INSERT INTO gadgetsonline_dbo.orderdetails (productid, orderid, unitprice, quantity) VALUES (@p0, @p1, @p2, @p3)

-- ============================================================================
-- SOURCE FILE: Services/OrderProcessing.cs
-- ============================================================================

-- Statement 14
-- Method: ProcessOrder(Order order, HttpContext httpContext)
-- DMS Status: FAILED - Metadata model creation failed: The selected objects were not found.
-- DMS Timestamp: 2026-03-06T00:43:31.928285
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original: INSERT INTO [dbo].[Orders] (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@p0, @p1, @p2, @p3, @p4, @p5, @p6, @p7, @p8, @p9, @p10, @p11)
-- Converted:
INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@p0, @p1, @p2, @p3, @p4, @p5, @p6, @p7, @p8, @p9, @p10, @p11)

-- ============================================================================
-- SOURCE FILE: Models/GadgetsOnlineInitializer.cs
-- ============================================================================

-- Statement 15
-- Method: Seed(GadgetsOnlineEntities context) - Categories
-- DMS Status: FAILED - Metadata model creation failed: The selected objects were not found.
-- DMS Timestamp: 2026-03-06T00:43:47.521513
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original: INSERT INTO [dbo].[Categories] (CategoryId, Name, Description) VALUES (@p0, @p1, @p2)
-- Converted:
INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description) VALUES (@p0, @p1, @p2)

-- Statement 16
-- Method: Seed(GadgetsOnlineEntities context) - Products
-- DMS Status: FAILED - Metadata model creation failed: The selected objects were not found.
-- DMS Timestamp: 2026-03-06T00:44:02.956528
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original: INSERT INTO [dbo].[Products] (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (@p0, @p1, @p2, @p3, @p4)
-- Converted:
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (@p0, @p1, @p2, @p3, @p4)

-- ============================================================================
-- END OF CONVERTED STATEMENTS CATALOG
-- Total: 16 statements converted
-- DMS Success: 0/16
-- Manual Conversion: 16/16 (DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA)
-- ============================================================================
