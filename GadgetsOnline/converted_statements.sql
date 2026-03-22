-- ============================================================================
-- Converted SQL Statements for GadgetsOnline - PostgreSQL
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according
--            to the specified selection rules.
-- DMS Parameters Used:
--   migration_project_identifier: arn:aws:dms:us-east-1:789616364195:migration-project:73N4TGCKEFESJJWR43O334CC7U
--   database_name: GadgetsOnline
--   schema_name: dbo
--   region: us-east-1
-- DMS Attempt Timestamps (Run 1): 2026-03-22T04:46:57 - 2026-03-22T04:52:42
-- DMS Attempt Timestamps (Run 2): 2026-03-22T05:20:11 - 2026-03-22T05:24:36
-- All 15 statements were submitted to DMS MCP tool TWICE and all 15 failed both times.
-- Manual fallback conversion applied per transformation definition rules:
--   - [dbo].[TableName] -> gadgetsonline_dbo.tablename (lowercase)
--   - TOP(N) -> LIMIT N
--   - Square bracket notation removed
--   - All column names lowercased
--   - SQL logic and parameters preserved
-- Target Database: PostgreSQL
-- Target Schema: gadgetsonline_dbo (lowercase)
-- ============================================================================

-- ---------------------------------------------------------------------------
-- Statement 1: Inventory.cs - GetBestSellers(int count)
-- Original: SELECT TOP(@count) [p].[ProductId], [p].[CategoryId], [p].[Name], [p].[Price], [p].[ProductArtUrl] FROM [dbo].[Products] AS [p];
-- DMS Status: FAILED (Run 1: 2026-03-22T04:46:57, Run 2: 2026-03-22T05:20:11) - Metadata model creation failed: No objects found
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: TOP(@count) -> LIMIT @count, [dbo].[Products] -> gadgetsonline_dbo.products, lowercase columns
-- ---------------------------------------------------------------------------
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl
FROM gadgetsonline_dbo.products AS p
LIMIT @count;

-- ---------------------------------------------------------------------------
-- Statement 2: Inventory.cs - GetAllCategories()
-- Original: SELECT [c].[CategoryId], [c].[Name], [c].[Description] FROM [dbo].[Categories] AS [c];
-- DMS Status: FAILED (Run 1: 2026-03-22T04:47:20, Run 2: 2026-03-22T05:20:27) - Metadata model creation failed: No objects found
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: [dbo].[Categories] -> gadgetsonline_dbo.categories, lowercase columns
-- ---------------------------------------------------------------------------
SELECT c.categoryid, c.name, c.description
FROM gadgetsonline_dbo.categories AS c;

-- ---------------------------------------------------------------------------
-- Statement 3: Inventory.cs - GetAllProductsInCategory(string category)
-- Original: SELECT [p].[ProductId], [p].[CategoryId], [p].[Name], [p].[Price], [p].[ProductArtUrl] FROM [dbo].[Products] AS [p] INNER JOIN [dbo].[Categories] AS [c] ON [p].[CategoryId] = [c].[CategoryId] WHERE [c].[Name] = @category;
-- DMS Status: FAILED (Run 1: 2026-03-22T04:47:44, Run 2: 2026-03-22T05:20:42) - Metadata model creation failed: No objects found
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: lowercase schema/table/columns, removed brackets
-- ---------------------------------------------------------------------------
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl
FROM gadgetsonline_dbo.products AS p
INNER JOIN gadgetsonline_dbo.categories AS c ON p.categoryid = c.categoryid
WHERE c.name = @category;

-- ---------------------------------------------------------------------------
-- Statement 4: Inventory.cs - GetProductById(int id)
-- Original: SELECT TOP(1) [p].[ProductId], [p].[CategoryId], [p].[Name], [p].[Price], [p].[ProductArtUrl] FROM [dbo].[Products] AS [p] WHERE [p].[ProductId] = @id;
-- DMS Status: FAILED (Run 1: 2026-03-22T04:48:07, Run 2: 2026-03-22T05:20:58) - Metadata model creation failed: No objects found
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: TOP(1) -> LIMIT 1, lowercase schema/table/columns
-- ---------------------------------------------------------------------------
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl
FROM gadgetsonline_dbo.products AS p
WHERE p.productid = @id
LIMIT 1;

-- ---------------------------------------------------------------------------
-- Statement 5: Inventory.cs - GetProductNameById(int id)
-- Original: SELECT TOP(1) [p].[Name] FROM [dbo].[Products] AS [p] WHERE [p].[ProductId] = @id;
-- DMS Status: FAILED (Run 1: 2026-03-22T04:48:30, Run 2: 2026-03-22T05:21:13) - Metadata model creation failed: No objects found
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: TOP(1) -> LIMIT 1, lowercase schema/table/columns
-- ---------------------------------------------------------------------------
SELECT p.name
FROM gadgetsonline_dbo.products AS p
WHERE p.productid = @id
LIMIT 1;

-- ---------------------------------------------------------------------------
-- Statement 6: ShoppingCart.cs - GetCartItems()
-- Original: SELECT [c].[RecordId], [c].[CartId], [c].[ProductId], [c].[Count], [c].[DateCreated] FROM [dbo].[Carts] AS [c] WHERE [c].[CartId] = @cartId;
-- DMS Status: FAILED (Run 1: 2026-03-22T04:48:53, Run 2: 2026-03-22T05:21:47) - Metadata model creation failed: No objects found
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: lowercase schema/table/columns, removed brackets
-- ---------------------------------------------------------------------------
SELECT c.recordid, c.cartid, c.productid, c.count, c.datecreated
FROM gadgetsonline_dbo.carts AS c
WHERE c.cartid = @cartId;

-- ---------------------------------------------------------------------------
-- Statement 7: ShoppingCart.cs - AddToCart (select existing cart item)
-- Original: SELECT TOP(2) [c].[RecordId], [c].[CartId], [c].[ProductId], [c].[Count], [c].[DateCreated] FROM [dbo].[Carts] AS [c] WHERE [c].[CartId] = @cartId AND [c].[ProductId] = @id;
-- DMS Status: FAILED (Run 1: 2026-03-22T04:49:17, Run 2: 2026-03-22T05:22:02) - Metadata model creation failed: No objects found
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: TOP(2) -> LIMIT 2, lowercase schema/table/columns
-- ---------------------------------------------------------------------------
SELECT c.recordid, c.cartid, c.productid, c.count, c.datecreated
FROM gadgetsonline_dbo.carts AS c
WHERE c.cartid = @cartId AND c.productid = @id
LIMIT 2;

-- ---------------------------------------------------------------------------
-- Statement 8: ShoppingCart.cs - AddToCart (insert new cart item)
-- Original: INSERT INTO [dbo].[Carts] ([CartId], [ProductId], [Count], [DateCreated]) VALUES (@cartId, @productId, @count, @dateCreated);
-- DMS Status: FAILED (Run 1: 2026-03-22T04:49:41, Run 2: 2026-03-22T05:22:17) - Metadata model creation failed: No objects found
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: lowercase schema/table/columns, removed brackets
-- ---------------------------------------------------------------------------
INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated)
VALUES (@cartId, @productId, @count, @dateCreated);

-- ---------------------------------------------------------------------------
-- Statement 9: ShoppingCart.cs - GetCount()
-- Original: SELECT SUM(CAST([c].[Count] AS INT)) FROM [dbo].[Carts] AS [c] WHERE [c].[CartId] = @cartId;
-- DMS Status: FAILED (Run 1: 2026-03-22T04:50:04, Run 2: 2026-03-22T05:22:33) - Metadata model creation failed: No objects found
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: lowercase schema/table/columns, CAST preserved (valid in PostgreSQL)
-- ---------------------------------------------------------------------------
SELECT SUM(CAST(c.count AS INT))
FROM gadgetsonline_dbo.carts AS c
WHERE c.cartid = @cartId;

-- ---------------------------------------------------------------------------
-- Statement 10: ShoppingCart.cs - GetTotal()
-- Original: SELECT SUM(CAST([c].[Count] AS INT) * [p].[Price]) FROM [dbo].[Carts] AS [c] INNER JOIN [dbo].[Products] AS [p] ON [c].[ProductId] = [p].[ProductId] WHERE [c].[CartId] = @cartId;
-- DMS Status: FAILED (Run 1: 2026-03-22T04:50:27, Run 2: 2026-03-22T05:22:48) - Metadata model creation failed: No objects found
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: lowercase schema/table/columns, removed brackets
-- ---------------------------------------------------------------------------
SELECT SUM(CAST(c.count AS INT) * p.price)
FROM gadgetsonline_dbo.carts AS c
INNER JOIN gadgetsonline_dbo.products AS p ON c.productid = p.productid
WHERE c.cartid = @cartId;

-- ---------------------------------------------------------------------------
-- Statement 11: ShoppingCart.cs - RemoveFromCart (select cart item)
-- Original: SELECT TOP(2) [c].[RecordId], [c].[CartId], [c].[ProductId], [c].[Count], [c].[DateCreated] FROM [dbo].[Carts] AS [c] WHERE [c].[CartId] = @cartId AND [c].[ProductId] = @id;
-- DMS Status: FAILED (Run 1: 2026-03-22T04:50:55, Run 2: 2026-03-22T05:23:19) - Metadata model creation failed: No objects found
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: TOP(2) -> LIMIT 2, lowercase schema/table/columns
-- ---------------------------------------------------------------------------
SELECT c.recordid, c.cartid, c.productid, c.count, c.datecreated
FROM gadgetsonline_dbo.carts AS c
WHERE c.cartid = @cartId AND c.productid = @id
LIMIT 2;

-- ---------------------------------------------------------------------------
-- Statement 12: ShoppingCart.cs - EmptyCart (delete)
-- Original: DELETE FROM [dbo].[Carts] WHERE [CartId] = @cartId;
-- DMS Status: FAILED (Run 1: 2026-03-22T04:51:17, Run 2: 2026-03-22T05:23:34) - Metadata model creation failed: No objects found
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: lowercase schema/table/columns, removed brackets
-- ---------------------------------------------------------------------------
DELETE FROM gadgetsonline_dbo.carts
WHERE cartid = @cartId;

-- ---------------------------------------------------------------------------
-- Statement 13: ShoppingCart.cs - CreateOrder (insert order details)
-- Original: INSERT INTO [dbo].[OrderDetails] ([OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (@orderId, @productId, @quantity, @unitPrice);
-- DMS Status: FAILED (Run 1: 2026-03-22T04:51:40, Run 2: 2026-03-22T05:23:50) - Metadata model creation failed: No objects found
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: lowercase schema/table/columns, removed brackets
-- ---------------------------------------------------------------------------
INSERT INTO gadgetsonline_dbo.orderdetails (orderid, productid, quantity, unitprice)
VALUES (@orderId, @productId, @quantity, @unitPrice);

-- ---------------------------------------------------------------------------
-- Statement 14: OrderProcessing.cs - ProcessOrder (insert order)
-- Original: INSERT INTO [dbo].[Orders] ([OrderDate], [Username], [FirstName], [LastName], [Address], [City], [State], [PostalCode], [Country], [Phone], [Email], [Total]) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);
-- DMS Status: FAILED (Run 1: 2026-03-22T04:52:04, Run 2: 2026-03-22T05:24:05) - Metadata model creation failed: No objects found
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: lowercase schema/table/columns, removed brackets
-- ---------------------------------------------------------------------------
INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total)
VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);

-- ---------------------------------------------------------------------------
-- Statement 15: ShoppingCart.cs - RemoveFromCart (update count decrement)
-- Original: UPDATE [dbo].[Carts] SET [Count] = [Count] - 1 WHERE [RecordId] = @recordId;
-- DMS Status: FAILED (Run 1: 2026-03-22T04:52:27, Run 2: 2026-03-22T05:24:21) - Metadata model creation failed: No objects found
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: lowercase schema/table/columns, removed brackets
-- ---------------------------------------------------------------------------
UPDATE gadgetsonline_dbo.carts
SET count = count - 1
WHERE recordid = @recordId;
