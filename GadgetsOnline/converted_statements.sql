-- ============================================================================
-- CONVERTED SQL STATEMENTS CATALOG
-- GadgetsOnline - SQL Server to PostgreSQL Migration
-- ============================================================================
-- ALL 20 statements were submitted to DMS MCP tool for conversion.
-- ALL 20 statements FAILED with error:
--   "Metadata model creation failed: No objects were found according to the
--    specified selection rules. Please review your selection rules and try again."
--
-- Manual conversion applied with reason: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Schema mapping: [dbo].[TableName] -> gadgetsonline_dbo.tablename
-- SQL Server TOP(n) -> PostgreSQL LIMIT n
-- SQL Server CAST(x AS INT) -> PostgreSQL CAST(x AS INTEGER)
-- Parameter syntax: @param preserved (compatible with Npgsql)
-- ============================================================================

-- ============================================================================
-- Statement 1: SELECT TOP Products
-- Source: Services/Inventory.cs - GetBestSellers(int count)
-- ============================================================================
-- Original MS SQL:
-- SELECT TOP(6) [p].[ProductId], [p].[CategoryId], [p].[Name], [p].[Price], [p].[ProductArtUrl] FROM [dbo].[Products] AS [p]
-- Converted PostgreSQL:
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products AS p LIMIT 6;

-- ============================================================================
-- Statement 2: SELECT all Categories
-- Source: Services/Inventory.cs - GetAllCategories()
-- ============================================================================
-- Original MS SQL:
-- SELECT [c].[CategoryId], [c].[Name], [c].[Description] FROM [dbo].[Categories] AS [c]
-- Converted PostgreSQL:
SELECT c.categoryid, c.name, c.description FROM gadgetsonline_dbo.categories AS c;

-- ============================================================================
-- Statement 3: SELECT Products by Category Name (with JOIN)
-- Source: Services/Inventory.cs - GetAllProductsInCategory(string category)
-- ============================================================================
-- Original MS SQL:
-- SELECT [p].[ProductId], [p].[CategoryId], [p].[Name], [p].[Price], [p].[ProductArtUrl] FROM [dbo].[Products] AS [p] INNER JOIN [dbo].[Categories] AS [c] ON [p].[CategoryId] = [c].[CategoryId] WHERE [c].[Name] = @category
-- Converted PostgreSQL:
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products AS p INNER JOIN gadgetsonline_dbo.categories AS c ON p.categoryid = c.categoryid WHERE c.name = @category;

-- ============================================================================
-- Statement 4: SELECT Product by Id
-- Source: Services/Inventory.cs - GetProductById(int id)
-- ============================================================================
-- Original MS SQL:
-- SELECT TOP(1) [p].[ProductId], [p].[CategoryId], [p].[Name], [p].[Price], [p].[ProductArtUrl] FROM [dbo].[Products] AS [p] WHERE [p].[ProductId] = @id
-- Converted PostgreSQL:
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products AS p WHERE p.productid = @id LIMIT 1;

-- ============================================================================
-- Statement 5: SELECT Product Name by Id
-- Source: Services/Inventory.cs - GetProductNameById(int id)
-- ============================================================================
-- Original MS SQL:
-- SELECT TOP(1) [p].[ProductId], [p].[CategoryId], [p].[Name], [p].[Price], [p].[ProductArtUrl] FROM [dbo].[Products] AS [p] WHERE [p].[ProductId] = @id
-- Converted PostgreSQL:
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products AS p WHERE p.productid = @id LIMIT 1;

-- ============================================================================
-- Statement 6: SELECT Cart item by CartId and ProductId
-- Source: Services/ShoppingCart.cs - AddToCart(int id) - check existing
-- ============================================================================
-- Original MS SQL:
-- SELECT TOP(2) [c].[RecordId], [c].[CartId], [c].[ProductId], [c].[Count], [c].[DateCreated] FROM [dbo].[Carts] AS [c] WHERE [c].[CartId] = @cartId AND [c].[ProductId] = @productId
-- Converted PostgreSQL:
SELECT c.recordid, c.cartid, c.productid, c.count, c.datecreated FROM gadgetsonline_dbo.carts AS c WHERE c.cartid = @cartId AND c.productid = @productId LIMIT 2;

-- ============================================================================
-- Statement 7: INSERT into Carts
-- Source: Services/ShoppingCart.cs - AddToCart(int id) - insert new
-- ============================================================================
-- Original MS SQL:
-- INSERT INTO [dbo].[Carts] ([CartId], [ProductId], [Count], [DateCreated]) VALUES (@CartId, @ProductId, @Count, @DateCreated)
-- Converted PostgreSQL:
INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated) VALUES (@CartId, @ProductId, @Count, @DateCreated);

-- ============================================================================
-- Statement 8: UPDATE Cart item Count
-- Source: Services/ShoppingCart.cs - AddToCart(int id) - update existing
-- ============================================================================
-- Original MS SQL:
-- UPDATE [dbo].[Carts] SET [Count] = @Count WHERE [RecordId] = @RecordId
-- Converted PostgreSQL:
UPDATE gadgetsonline_dbo.carts SET count = @Count WHERE recordid = @RecordId;

-- ============================================================================
-- Statement 9: SELECT SUM of Cart Count
-- Source: Services/ShoppingCart.cs - GetCount()
-- ============================================================================
-- Original MS SQL:
-- SELECT SUM([c].[Count]) FROM [dbo].[Carts] AS [c] WHERE [c].[CartId] = @cartId
-- Converted PostgreSQL:
SELECT SUM(c.count) FROM gadgetsonline_dbo.carts AS c WHERE c.cartid = @cartId;

-- ============================================================================
-- Statement 10: SELECT single Cart item for removal
-- Source: Services/ShoppingCart.cs - RemoveFromCart(int id)
-- ============================================================================
-- Original MS SQL:
-- SELECT TOP(2) [c].[RecordId], [c].[CartId], [c].[ProductId], [c].[Count], [c].[DateCreated] FROM [dbo].[Carts] AS [c] WHERE [c].[CartId] = @cartId AND [c].[ProductId] = @productId
-- Converted PostgreSQL:
SELECT c.recordid, c.cartid, c.productid, c.count, c.datecreated FROM gadgetsonline_dbo.carts AS c WHERE c.cartid = @cartId AND c.productid = @productId LIMIT 2;

-- ============================================================================
-- Statement 11: UPDATE Cart item Count (decrement)
-- Source: Services/ShoppingCart.cs - RemoveFromCart - decrement count
-- ============================================================================
-- Original MS SQL:
-- UPDATE [dbo].[Carts] SET [Count] = @Count WHERE [RecordId] = @RecordId
-- Converted PostgreSQL:
UPDATE gadgetsonline_dbo.carts SET count = @Count WHERE recordid = @RecordId;

-- ============================================================================
-- Statement 12: DELETE Cart item
-- Source: Services/ShoppingCart.cs - RemoveFromCart - remove item
-- ============================================================================
-- Original MS SQL:
-- DELETE FROM [dbo].[Carts] WHERE [RecordId] = @RecordId
-- Converted PostgreSQL:
DELETE FROM gadgetsonline_dbo.carts WHERE recordid = @RecordId;

-- ============================================================================
-- Statement 13: SELECT Cart items by CartId
-- Source: Services/ShoppingCart.cs - GetCartItems()
-- ============================================================================
-- Original MS SQL:
-- SELECT [c].[RecordId], [c].[CartId], [c].[ProductId], [c].[Count], [c].[DateCreated] FROM [dbo].[Carts] AS [c] WHERE [c].[CartId] = @cartId
-- Converted PostgreSQL:
SELECT c.recordid, c.cartid, c.productid, c.count, c.datecreated FROM gadgetsonline_dbo.carts AS c WHERE c.cartid = @cartId;

-- ============================================================================
-- Statement 14: SELECT Cart Total (Sum of Count * Price)
-- Source: Services/ShoppingCart.cs - GetTotal()
-- ============================================================================
-- Original MS SQL:
-- SELECT SUM(CAST([c].[Count] AS INT) * [p].[Price]) FROM [dbo].[Carts] AS [c] INNER JOIN [dbo].[Products] AS [p] ON [c].[ProductId] = [p].[ProductId] WHERE [c].[CartId] = @cartId
-- Converted PostgreSQL:
SELECT SUM(CAST(c.count AS INTEGER) * p.price) FROM gadgetsonline_dbo.carts AS c INNER JOIN gadgetsonline_dbo.products AS p ON c.productid = p.productid WHERE c.cartid = @cartId;

-- ============================================================================
-- Statement 15: SELECT Cart items for emptying
-- Source: Services/ShoppingCart.cs - EmptyCart()
-- ============================================================================
-- Original MS SQL:
-- SELECT [c].[RecordId], [c].[CartId], [c].[ProductId], [c].[Count], [c].[DateCreated] FROM [dbo].[Carts] AS [c] WHERE [c].[CartId] = @cartId
-- Converted PostgreSQL:
SELECT c.recordid, c.cartid, c.productid, c.count, c.datecreated FROM gadgetsonline_dbo.carts AS c WHERE c.cartid = @cartId;

-- ============================================================================
-- Statement 16: DELETE Cart items (empty cart)
-- Source: Services/ShoppingCart.cs - EmptyCart() - delete each item
-- ============================================================================
-- Original MS SQL:
-- DELETE FROM [dbo].[Carts] WHERE [RecordId] = @RecordId
-- Converted PostgreSQL:
DELETE FROM gadgetsonline_dbo.carts WHERE recordid = @RecordId;

-- ============================================================================
-- Statement 17: INSERT into Orders
-- Source: Services/OrderProcessing.cs - ProcessOrder
-- ============================================================================
-- Original MS SQL:
-- INSERT INTO [dbo].[Orders] ([OrderDate], [Username], [FirstName], [LastName], [Address], [City], [State], [PostalCode], [Country], [Phone], [Email], [Total]) VALUES (@OrderDate, @Username, @FirstName, @LastName, @Address, @City, @State, @PostalCode, @Country, @Phone, @Email, @Total)
-- Converted PostgreSQL:
INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@OrderDate, @Username, @FirstName, @LastName, @Address, @City, @State, @PostalCode, @Country, @Phone, @Email, @Total);

-- ============================================================================
-- Statement 18: INSERT into OrderDetails
-- Source: Services/ShoppingCart.cs - CreateOrder
-- ============================================================================
-- Original MS SQL:
-- INSERT INTO [dbo].[OrderDetails] ([ProductId], [OrderId], [UnitPrice], [Quantity]) VALUES (@ProductId, @OrderId, @UnitPrice, @Quantity)
-- Converted PostgreSQL:
INSERT INTO gadgetsonline_dbo.orderdetails (productid, orderid, unitprice, quantity) VALUES (@ProductId, @OrderId, @UnitPrice, @Quantity);

-- ============================================================================
-- Statement 19: INSERT seed Categories
-- Source: Models/GadgetsOnlineInitializer.cs - Seed Categories
-- ============================================================================
-- Original MS SQL:
-- INSERT INTO [dbo].[Categories] ([CategoryId], [Name], [Description]) VALUES (@CategoryId, @Name, @Description)
-- Converted PostgreSQL:
INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description) VALUES (@CategoryId, @Name, @Description);

-- ============================================================================
-- Statement 20: INSERT seed Products
-- Source: Models/GadgetsOnlineInitializer.cs - Seed Products
-- ============================================================================
-- Original MS SQL:
-- INSERT INTO [dbo].[Products] ([ProductId], [CategoryId], [Name], [Price], [ProductArtUrl]) VALUES (@ProductId, @CategoryId, @Name, @Price, @ProductArtUrl)
-- Converted PostgreSQL:
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (@ProductId, @CategoryId, @Name, @Price, @ProductArtUrl);

-- ============================================================================
-- END OF CONVERTED STATEMENTS CATALOG
-- Total: 20 statements processed
-- DMS MCP tool conversions: 0 (all failed with metadata model creation error)
-- Manual conversions: 20 (all using DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA)
-- DMS Error: "Metadata model creation failed: No objects were found according to
--            the specified selection rules."
-- ============================================================================
