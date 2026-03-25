-- =====================================================================
-- Converted SQL Statements for GadgetsOnline Application
-- Target: PostgreSQL (gadgetsonline_dbo schema, lowercase column names)
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error (Retry Attempt 3 - 2026-03-25): Metadata model creation
--   failed: No objects were found according to the specified selection
--   rules. All 21 DMS calls retried and all failed with same error.
-- DMS Parameters Used:
--   migration_project_identifier: arn:aws:dms:us-east-1:789616364195:migration-project:73N4TGCKEFESJJWR43O334CC7U
--   database_name: GadgetsOnline
--   schema_name: dbo
--   region: us-east-1
-- DMS Attempt 3 Timestamps: Stmt1=22:13:53, Stmt2=22:14:20, Stmt3=22:14:47,
--   Stmt4=22:15:12, Stmt5=22:15:40, Stmt6=22:16:06, Stmt7=22:16:30,
--   Stmt8=22:16:55, Stmt9=22:17:18, Stmt10=22:17:42, Stmt11=22:18:07,
--   Stmt12=22:18:31, Stmt13=22:18:56, Stmt14=22:19:21, Stmt15=22:19:48,
--   Stmt16=22:20:17, Stmt17=22:20:40, Stmt18=22:21:04, Stmt19=22:21:30,
--   Stmt20=22:21:54, Stmt21=22:22:22
-- =====================================================================

-- =====================================================================
-- SOURCE FILE: Services/Inventory.cs
-- =====================================================================

-- Statement 1: GetBestSellers(int count)
-- Original: SELECT TOP (@p__linq__0) [Extent1].[ProductId] AS [ProductId], [Extent1].[CategoryId] AS [CategoryId], [Extent1].[Name] AS [Name], [Extent1].[Price] AS [Price], [Extent1].[ProductArtUrl] AS [ProductArtUrl] FROM [dbo].[Products] AS [Extent1];
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT Extent1.productid AS productid, Extent1.categoryid AS categoryid, Extent1.name AS name, Extent1.price AS price, Extent1.productarturl AS productarturl FROM gadgetsonline_dbo.products AS Extent1 LIMIT @p__linq__0;

-- Statement 2: GetAllCategories()
-- Original: SELECT [Extent1].[CategoryId] AS [CategoryId], [Extent1].[Name] AS [Name], [Extent1].[Description] AS [Description] FROM [dbo].[Categories] AS [Extent1];
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT Extent1.categoryid AS categoryid, Extent1.name AS name, Extent1.description AS description FROM gadgetsonline_dbo.categories AS Extent1;

-- Statement 3: GetAllProductsInCategory(string category)
-- Original: SELECT [Extent1].[ProductId] AS [ProductId], [Extent1].[CategoryId] AS [CategoryId], [Extent1].[Name] AS [Name], [Extent1].[Price] AS [Price], [Extent1].[ProductArtUrl] AS [ProductArtUrl] FROM [dbo].[Products] AS [Extent1] INNER JOIN [dbo].[Categories] AS [Extent2] ON [Extent1].[CategoryId] = [Extent2].[CategoryId] WHERE [Extent2].[Name] = @p__linq__0;
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT Extent1.productid AS productid, Extent1.categoryid AS categoryid, Extent1.name AS name, Extent1.price AS price, Extent1.productarturl AS productarturl FROM gadgetsonline_dbo.products AS Extent1 INNER JOIN gadgetsonline_dbo.categories AS Extent2 ON Extent1.categoryid = Extent2.categoryid WHERE Extent2.name = @p__linq__0;

-- Statement 4: GetProductById(int id)
-- Original: SELECT TOP (1) [Extent1].[ProductId] AS [ProductId], [Extent1].[CategoryId] AS [CategoryId], [Extent1].[Name] AS [Name], [Extent1].[Price] AS [Price], [Extent1].[ProductArtUrl] AS [ProductArtUrl] FROM [dbo].[Products] AS [Extent1] WHERE [Extent1].[ProductId] = @p__linq__0;
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT Extent1.productid AS productid, Extent1.categoryid AS categoryid, Extent1.name AS name, Extent1.price AS price, Extent1.productarturl AS productarturl FROM gadgetsonline_dbo.products AS Extent1 WHERE Extent1.productid = @p__linq__0 LIMIT 1;

-- Statement 5: GetProductNameById(int id)
-- Original: SELECT TOP (1) [Extent1].[Name] AS [Name] FROM [dbo].[Products] AS [Extent1] WHERE [Extent1].[ProductId] = @p__linq__0;
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT Extent1.name AS name FROM gadgetsonline_dbo.products AS Extent1 WHERE Extent1.productid = @p__linq__0 LIMIT 1;

-- =====================================================================
-- SOURCE FILE: Services/ShoppingCart.cs
-- =====================================================================

-- Statement 6: GetCartItems()
-- Original: SELECT [Extent1].[RecordId] AS [RecordId], [Extent1].[CartId] AS [CartId], [Extent1].[ProductId] AS [ProductId], [Extent1].[Count] AS [Count], [Extent1].[DateCreated] AS [DateCreated] FROM [dbo].[Carts] AS [Extent1] WHERE [Extent1].[CartId] = @p__linq__0;
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT Extent1.recordid AS recordid, Extent1.cartid AS cartid, Extent1.productid AS productid, Extent1.count AS count, Extent1.datecreated AS datecreated FROM gadgetsonline_dbo.carts AS Extent1 WHERE Extent1.cartid = @p__linq__0;

-- Statement 7: AddToCart - SELECT existing cart item
-- Original: SELECT TOP (2) [Extent1].[RecordId] AS [RecordId], [Extent1].[CartId] AS [CartId], [Extent1].[ProductId] AS [ProductId], [Extent1].[Count] AS [Count], [Extent1].[DateCreated] AS [DateCreated] FROM [dbo].[Carts] AS [Extent1] WHERE [Extent1].[CartId] = @p__linq__0 AND [Extent1].[ProductId] = @p__linq__1;
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT Extent1.recordid AS recordid, Extent1.cartid AS cartid, Extent1.productid AS productid, Extent1.count AS count, Extent1.datecreated AS datecreated FROM gadgetsonline_dbo.carts AS Extent1 WHERE Extent1.cartid = @p__linq__0 AND Extent1.productid = @p__linq__1 LIMIT 2;

-- Statement 8: AddToCart - INSERT new cart item
-- Original: INSERT INTO [dbo].[Carts] ([CartId], [ProductId], [Count], [DateCreated]) VALUES (@p0, @p1, @p2, @p3);
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated) VALUES (@p0, @p1, @p2, @p3);

-- Statement 9: AddToCart - UPDATE existing cart item count
-- Original: UPDATE [dbo].[Carts] SET [Count] = @p0 WHERE [RecordId] = @p1;
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
UPDATE gadgetsonline_dbo.carts SET count = @p0 WHERE recordid = @p1;

-- Statement 10: GetCount()
-- Original: SELECT SUM([Extent1].[Count]) AS [A1] FROM [dbo].[Carts] AS [Extent1] WHERE [Extent1].[CartId] = @p__linq__0;
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT SUM(Extent1.count) AS a1 FROM gadgetsonline_dbo.carts AS Extent1 WHERE Extent1.cartid = @p__linq__0;

-- Statement 11: RemoveFromCart - SELECT cart item
-- Original: SELECT TOP (2) [Extent1].[RecordId] AS [RecordId], [Extent1].[CartId] AS [CartId], [Extent1].[ProductId] AS [ProductId], [Extent1].[Count] AS [Count], [Extent1].[DateCreated] AS [DateCreated] FROM [dbo].[Carts] AS [Extent1] WHERE [Extent1].[CartId] = @p__linq__0 AND [Extent1].[ProductId] = @p__linq__1;
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT Extent1.recordid AS recordid, Extent1.cartid AS cartid, Extent1.productid AS productid, Extent1.count AS count, Extent1.datecreated AS datecreated FROM gadgetsonline_dbo.carts AS Extent1 WHERE Extent1.cartid = @p__linq__0 AND Extent1.productid = @p__linq__1 LIMIT 2;

-- Statement 12: RemoveFromCart - UPDATE cart item (decrement count)
-- Original: UPDATE [dbo].[Carts] SET [Count] = @p0 WHERE [RecordId] = @p1;
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
UPDATE gadgetsonline_dbo.carts SET count = @p0 WHERE recordid = @p1;

-- Statement 13: RemoveFromCart - DELETE cart item
-- Original: DELETE FROM [dbo].[Carts] WHERE [RecordId] = @p0;
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
DELETE FROM gadgetsonline_dbo.carts WHERE recordid = @p0;

-- Statement 14: EmptyCart - SELECT cart items for deletion
-- Original: SELECT [Extent1].[RecordId] AS [RecordId], [Extent1].[CartId] AS [CartId], [Extent1].[ProductId] AS [ProductId], [Extent1].[Count] AS [Count], [Extent1].[DateCreated] AS [DateCreated] FROM [dbo].[Carts] AS [Extent1] WHERE [Extent1].[CartId] = @p__linq__0;
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT Extent1.recordid AS recordid, Extent1.cartid AS cartid, Extent1.productid AS productid, Extent1.count AS count, Extent1.datecreated AS datecreated FROM gadgetsonline_dbo.carts AS Extent1 WHERE Extent1.cartid = @p__linq__0;

-- Statement 15: EmptyCart - DELETE each cart item
-- Original: DELETE FROM [dbo].[Carts] WHERE [RecordId] = @p0;
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
DELETE FROM gadgetsonline_dbo.carts WHERE recordid = @p0;

-- Statement 16: GetTotal()
-- Original: SELECT SUM(CAST([Extent1].[Count] AS decimal(19,0)) * [Extent2].[Price]) AS [A1] FROM [dbo].[Carts] AS [Extent1] INNER JOIN [dbo].[Products] AS [Extent2] ON [Extent1].[ProductId] = [Extent2].[ProductId] WHERE [Extent1].[CartId] = @p__linq__0;
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT SUM(CAST(Extent1.count AS decimal(19,0)) * Extent2.price) AS a1 FROM gadgetsonline_dbo.carts AS Extent1 INNER JOIN gadgetsonline_dbo.products AS Extent2 ON Extent1.productid = Extent2.productid WHERE Extent1.cartid = @p__linq__0;

-- Statement 17: CreateOrder - INSERT order detail
-- Original: INSERT INTO [dbo].[OrderDetails] ([OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (@p0, @p1, @p2, @p3);
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
INSERT INTO gadgetsonline_dbo.orderdetails (orderid, productid, quantity, unitprice) VALUES (@p0, @p1, @p2, @p3);

-- Statement 18: CreateOrder - UPDATE order total
-- Original: UPDATE [dbo].[Orders] SET [Total] = @p0 WHERE [OrderId] = @p1;
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
UPDATE gadgetsonline_dbo.orders SET total = @p0 WHERE orderid = @p1;

-- =====================================================================
-- SOURCE FILE: Services/OrderProcessing.cs
-- =====================================================================

-- Statement 19: ProcessOrder - INSERT order
-- Original: INSERT INTO [dbo].[Orders] ([OrderDate], [Username], [FirstName], [LastName], [Address], [City], [State], [PostalCode], [Country], [Phone], [Email], [Total]) VALUES (@p0, @p1, @p2, @p3, @p4, @p5, @p6, @p7, @p8, @p9, @p10, @p11);
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@p0, @p1, @p2, @p3, @p4, @p5, @p6, @p7, @p8, @p9, @p10, @p11);

-- =====================================================================
-- SOURCE FILE: Models/GadgetsOnlineInitializer.cs
-- =====================================================================

-- Statement 20: Seed - INSERT category
-- Original: INSERT INTO [dbo].[Categories] ([CategoryId], [Name], [Description]) VALUES (@p0, @p1, @p2);
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description) VALUES (@p0, @p1, @p2);

-- Statement 21: Seed - INSERT product
-- Original: INSERT INTO [dbo].[Products] ([ProductId], [CategoryId], [Name], [Price], [ProductArtUrl]) VALUES (@p0, @p1, @p2, @p3, @p4);
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (@p0, @p1, @p2, @p3, @p4);
