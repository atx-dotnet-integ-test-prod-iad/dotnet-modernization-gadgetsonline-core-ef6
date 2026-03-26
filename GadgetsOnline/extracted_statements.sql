-- ============================================================================
-- EXTRACTED SQL STATEMENTS CATALOG
-- GadgetsOnline - SQL Server to PostgreSQL Migration
-- ============================================================================
-- This application uses Entity Framework 6 with LINQ queries.
-- No raw SQL statements (inline SQL, string concatenation SQL, parameterized SQL,
-- StringBuilder-constructed SQL) were found in any .cs file.
-- No Microsoft.Data.SqlClient or System.Data.SqlClient references exist.
-- No SqlConnection, SqlCommand, SqlDataReader, SqlParameter references exist.
--
-- The following are the representative MS SQL Server statements that Entity Framework
-- would generate at runtime from the LINQ operations found in the codebase.
-- These are constructed to match the EF-generated SQL patterns for DMS conversion.
-- ============================================================================

-- ============================================================================
-- SOURCE: Services/Inventory.cs - GetBestSellers(int count)
-- LINQ: _gadgetsOnlineEntities.Products.Take(count).ToList()
-- ============================================================================
-- Statement 1: SELECT TOP Products
SELECT TOP(6) [p].[ProductId], [p].[CategoryId], [p].[Name], [p].[Price], [p].[ProductArtUrl] FROM [dbo].[Products] AS [p];

-- ============================================================================
-- SOURCE: Services/Inventory.cs - GetAllCategories()
-- LINQ: _gadgetsOnlineEntities.Categories.ToList()
-- ============================================================================
-- Statement 2: SELECT all Categories
SELECT [c].[CategoryId], [c].[Name], [c].[Description] FROM [dbo].[Categories] AS [c];

-- ============================================================================
-- SOURCE: Services/Inventory.cs - GetAllProductsInCategory(string category)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()
-- ============================================================================
-- Statement 3: SELECT Products by Category Name (with JOIN)
SELECT [p].[ProductId], [p].[CategoryId], [p].[Name], [p].[Price], [p].[ProductArtUrl] FROM [dbo].[Products] AS [p] INNER JOIN [dbo].[Categories] AS [c] ON [p].[CategoryId] = [c].[CategoryId] WHERE [c].[Name] = @category;

-- ============================================================================
-- SOURCE: Services/Inventory.cs - GetProductById(int id)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()
-- ============================================================================
-- Statement 4: SELECT Product by Id
SELECT TOP(1) [p].[ProductId], [p].[CategoryId], [p].[Name], [p].[Price], [p].[ProductArtUrl] FROM [dbo].[Products] AS [p] WHERE [p].[ProductId] = @id;

-- ============================================================================
-- SOURCE: Services/Inventory.cs - GetProductNameById(int id)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name
-- ============================================================================
-- Statement 5: SELECT Product Name by Id
SELECT TOP(1) [p].[ProductId], [p].[CategoryId], [p].[Name], [p].[Price], [p].[ProductArtUrl] FROM [dbo].[Products] AS [p] WHERE [p].[ProductId] = @id;

-- ============================================================================
-- SOURCE: Services/ShoppingCart.cs - AddToCart(int id) - check existing cart item
-- LINQ: _gadgetsOnlineEntities.Carts.SingleOrDefault(c => c.CartId == ShoppingCartId && c.ProductId == id)
-- ============================================================================
-- Statement 6: SELECT Cart item by CartId and ProductId
SELECT TOP(2) [c].[RecordId], [c].[CartId], [c].[ProductId], [c].[Count], [c].[DateCreated] FROM [dbo].[Carts] AS [c] WHERE [c].[CartId] = @cartId AND [c].[ProductId] = @productId;

-- ============================================================================
-- SOURCE: Services/ShoppingCart.cs - AddToCart(int id) - insert new cart item
-- LINQ: _gadgetsOnlineEntities.Carts.Add(cartItem)
-- ============================================================================
-- Statement 7: INSERT into Carts
INSERT INTO [dbo].[Carts] ([CartId], [ProductId], [Count], [DateCreated]) VALUES (@CartId, @ProductId, @Count, @DateCreated);

-- ============================================================================
-- SOURCE: Services/ShoppingCart.cs - AddToCart(int id) - update existing cart item count
-- LINQ: cartItem.Count++ then SaveChanges()
-- ============================================================================
-- Statement 8: UPDATE Cart item Count
UPDATE [dbo].[Carts] SET [Count] = @Count WHERE [RecordId] = @RecordId;

-- ============================================================================
-- SOURCE: Services/ShoppingCart.cs - GetCount()
-- LINQ: from cartItems in Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count).Sum()
-- ============================================================================
-- Statement 9: SELECT SUM of Cart Count
SELECT SUM([c].[Count]) FROM [dbo].[Carts] AS [c] WHERE [c].[CartId] = @cartId;

-- ============================================================================
-- SOURCE: Services/ShoppingCart.cs - RemoveFromCart(int id)
-- LINQ: _gadgetsOnlineEntities.Carts.Single(cart => cart.CartId == ShoppingCartId && cart.ProductId == id)
-- ============================================================================
-- Statement 10: SELECT single Cart item for removal
SELECT TOP(2) [c].[RecordId], [c].[CartId], [c].[ProductId], [c].[Count], [c].[DateCreated] FROM [dbo].[Carts] AS [c] WHERE [c].[CartId] = @cartId AND [c].[ProductId] = @productId;

-- ============================================================================
-- SOURCE: Services/ShoppingCart.cs - RemoveFromCart - decrement count
-- LINQ: cartItem.Count-- then SaveChanges()
-- ============================================================================
-- Statement 11: UPDATE Cart item Count (decrement)
UPDATE [dbo].[Carts] SET [Count] = @Count WHERE [RecordId] = @RecordId;

-- ============================================================================
-- SOURCE: Services/ShoppingCart.cs - RemoveFromCart - remove item
-- LINQ: _gadgetsOnlineEntities.Carts.Remove(cartItem) then SaveChanges()
-- ============================================================================
-- Statement 12: DELETE Cart item
DELETE FROM [dbo].[Carts] WHERE [RecordId] = @RecordId;

-- ============================================================================
-- SOURCE: Services/ShoppingCart.cs - GetCartItems()
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId).ToList()
-- ============================================================================
-- Statement 13: SELECT Cart items by CartId
SELECT [c].[RecordId], [c].[CartId], [c].[ProductId], [c].[Count], [c].[DateCreated] FROM [dbo].[Carts] AS [c] WHERE [c].[CartId] = @cartId;

-- ============================================================================
-- SOURCE: Services/ShoppingCart.cs - GetTotal()
-- LINQ: from cartItems in Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count * cartItems.Product.Price).Sum()
-- ============================================================================
-- Statement 14: SELECT Cart Total (Sum of Count * Price)
SELECT SUM(CAST([c].[Count] AS INT) * [p].[Price]) FROM [dbo].[Carts] AS [c] INNER JOIN [dbo].[Products] AS [p] ON [c].[ProductId] = [p].[ProductId] WHERE [c].[CartId] = @cartId;

-- ============================================================================
-- SOURCE: Services/ShoppingCart.cs - EmptyCart()
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId) then Remove each
-- ============================================================================
-- Statement 15: SELECT Cart items for emptying
SELECT [c].[RecordId], [c].[CartId], [c].[ProductId], [c].[Count], [c].[DateCreated] FROM [dbo].[Carts] AS [c] WHERE [c].[CartId] = @cartId;

-- ============================================================================
-- SOURCE: Services/ShoppingCart.cs - EmptyCart() - delete each item
-- LINQ: _gadgetsOnlineEntities.Carts.Remove(cartItem) for each in cartItems
-- ============================================================================
-- Statement 16: DELETE Cart items (empty cart)
DELETE FROM [dbo].[Carts] WHERE [RecordId] = @RecordId;

-- ============================================================================
-- SOURCE: Services/OrderProcessing.cs - ProcessOrder
-- LINQ: _gadgetsOnlineEntities.Orders.Add(order)
-- ============================================================================
-- Statement 17: INSERT into Orders
INSERT INTO [dbo].[Orders] ([OrderDate], [Username], [FirstName], [LastName], [Address], [City], [State], [PostalCode], [Country], [Phone], [Email], [Total]) VALUES (@OrderDate, @Username, @FirstName, @LastName, @Address, @City, @State, @PostalCode, @Country, @Phone, @Email, @Total);

-- ============================================================================
-- SOURCE: Services/ShoppingCart.cs - CreateOrder
-- LINQ: _gadgetsOnlineEntities.OrderDetails.Add(orderDetail)
-- ============================================================================
-- Statement 18: INSERT into OrderDetails
INSERT INTO [dbo].[OrderDetails] ([ProductId], [OrderId], [UnitPrice], [Quantity]) VALUES (@ProductId, @OrderId, @UnitPrice, @Quantity);

-- ============================================================================
-- SOURCE: Models/GadgetsOnlineInitializer.cs - Seed Categories
-- LINQ: context.Categories.Add(c) for each category
-- ============================================================================
-- Statement 19: INSERT seed Categories
INSERT INTO [dbo].[Categories] ([CategoryId], [Name], [Description]) VALUES (@CategoryId, @Name, @Description);

-- ============================================================================
-- SOURCE: Models/GadgetsOnlineInitializer.cs - Seed Products
-- LINQ: context.Products.Add(p) for each product
-- ============================================================================
-- Statement 20: INSERT seed Products
INSERT INTO [dbo].[Products] ([ProductId], [CategoryId], [Name], [Price], [ProductArtUrl]) VALUES (@ProductId, @CategoryId, @Name, @Price, @ProductArtUrl);

-- ============================================================================
-- END OF EXTRACTED STATEMENTS CATALOG
-- Total: 20 representative SQL statements from EF LINQ operations
-- Raw SQL found: 0 (all database access via Entity Framework LINQ)
-- SqlClient references found: 0 (using Npgsql provider)
-- ============================================================================
