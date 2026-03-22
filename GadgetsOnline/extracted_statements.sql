-- ============================================================================
-- Extracted SQL Statements from GadgetsOnline EF6 LINQ Queries
-- Source: Entity Framework 6 LINQ-to-SQL generated equivalents
-- Database: Microsoft SQL Server (original)
-- Schema: dbo (SQL Server default)
-- Tables: Products, Categories, Carts, Orders, OrderDetails
-- ============================================================================

-- ---------------------------------------------------------------------------
-- Statement 1: Inventory.cs - GetBestSellers(int count)
-- LINQ: _gadgetsOnlineEntities.Products.Take(count).ToList()
-- Source File: Services/Inventory.cs, Method: GetBestSellers
-- ---------------------------------------------------------------------------
SELECT TOP(@count) [p].[ProductId], [p].[CategoryId], [p].[Name], [p].[Price], [p].[ProductArtUrl]
FROM [dbo].[Products] AS [p];

-- ---------------------------------------------------------------------------
-- Statement 2: Inventory.cs - GetAllCategories()
-- LINQ: _gadgetsOnlineEntities.Categories.ToList()
-- Source File: Services/Inventory.cs, Method: GetAllCategories
-- ---------------------------------------------------------------------------
SELECT [c].[CategoryId], [c].[Name], [c].[Description]
FROM [dbo].[Categories] AS [c];

-- ---------------------------------------------------------------------------
-- Statement 3: Inventory.cs - GetAllProductsInCategory(string category)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()
-- Source File: Services/Inventory.cs, Method: GetAllProductsInCategory
-- ---------------------------------------------------------------------------
SELECT [p].[ProductId], [p].[CategoryId], [p].[Name], [p].[Price], [p].[ProductArtUrl]
FROM [dbo].[Products] AS [p]
INNER JOIN [dbo].[Categories] AS [c] ON [p].[CategoryId] = [c].[CategoryId]
WHERE [c].[Name] = @category;

-- ---------------------------------------------------------------------------
-- Statement 4: Inventory.cs - GetProductById(int id)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()
-- Source File: Services/Inventory.cs, Method: GetProductById
-- ---------------------------------------------------------------------------
SELECT TOP(1) [p].[ProductId], [p].[CategoryId], [p].[Name], [p].[Price], [p].[ProductArtUrl]
FROM [dbo].[Products] AS [p]
WHERE [p].[ProductId] = @id;

-- ---------------------------------------------------------------------------
-- Statement 5: Inventory.cs - GetProductNameById(int id)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name
-- Source File: Services/Inventory.cs, Method: GetProductNameById
-- ---------------------------------------------------------------------------
SELECT TOP(1) [p].[Name]
FROM [dbo].[Products] AS [p]
WHERE [p].[ProductId] = @id;

-- ---------------------------------------------------------------------------
-- Statement 6: ShoppingCart.cs - GetCartItems()
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId).ToList()
-- Source File: Services/ShoppingCart.cs, Method: GetCartItems
-- ---------------------------------------------------------------------------
SELECT [c].[RecordId], [c].[CartId], [c].[ProductId], [c].[Count], [c].[DateCreated]
FROM [dbo].[Carts] AS [c]
WHERE [c].[CartId] = @cartId;

-- ---------------------------------------------------------------------------
-- Statement 7: ShoppingCart.cs - AddToCart (select existing cart item)
-- LINQ: _gadgetsOnlineEntities.Carts.SingleOrDefault(c => c.CartId == ShoppingCartId && c.ProductId == id)
-- Source File: Services/ShoppingCart.cs, Method: AddToCart
-- ---------------------------------------------------------------------------
SELECT TOP(2) [c].[RecordId], [c].[CartId], [c].[ProductId], [c].[Count], [c].[DateCreated]
FROM [dbo].[Carts] AS [c]
WHERE [c].[CartId] = @cartId AND [c].[ProductId] = @id;

-- ---------------------------------------------------------------------------
-- Statement 8: ShoppingCart.cs - AddToCart (insert new cart item)
-- LINQ: _gadgetsOnlineEntities.Carts.Add(cartItem) + SaveChanges()
-- Source File: Services/ShoppingCart.cs, Method: AddToCart
-- ---------------------------------------------------------------------------
INSERT INTO [dbo].[Carts] ([CartId], [ProductId], [Count], [DateCreated])
VALUES (@cartId, @productId, @count, @dateCreated);

-- ---------------------------------------------------------------------------
-- Statement 9: ShoppingCart.cs - GetCount()
-- LINQ: (from cartItems in Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count).Sum()
-- Source File: Services/ShoppingCart.cs, Method: GetCount
-- ---------------------------------------------------------------------------
SELECT SUM(CAST([c].[Count] AS INT))
FROM [dbo].[Carts] AS [c]
WHERE [c].[CartId] = @cartId;

-- ---------------------------------------------------------------------------
-- Statement 10: ShoppingCart.cs - GetTotal()
-- LINQ: (from cartItems in Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count * cartItems.Product.Price).Sum()
-- Source File: Services/ShoppingCart.cs, Method: GetTotal
-- ---------------------------------------------------------------------------
SELECT SUM(CAST([c].[Count] AS INT) * [p].[Price])
FROM [dbo].[Carts] AS [c]
INNER JOIN [dbo].[Products] AS [p] ON [c].[ProductId] = [p].[ProductId]
WHERE [c].[CartId] = @cartId;

-- ---------------------------------------------------------------------------
-- Statement 11: ShoppingCart.cs - RemoveFromCart (select cart item)
-- LINQ: _gadgetsOnlineEntities.Carts.Single(cart => cart.CartId == ShoppingCartId && cart.ProductId == id)
-- Source File: Services/ShoppingCart.cs, Method: RemoveFromCart
-- ---------------------------------------------------------------------------
SELECT TOP(2) [c].[RecordId], [c].[CartId], [c].[ProductId], [c].[Count], [c].[DateCreated]
FROM [dbo].[Carts] AS [c]
WHERE [c].[CartId] = @cartId AND [c].[ProductId] = @id;

-- ---------------------------------------------------------------------------
-- Statement 12: ShoppingCart.cs - EmptyCart (delete)
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId) + Remove each + SaveChanges
-- Source File: Services/ShoppingCart.cs, Method: EmptyCart
-- ---------------------------------------------------------------------------
DELETE FROM [dbo].[Carts]
WHERE [CartId] = @cartId;

-- ---------------------------------------------------------------------------
-- Statement 13: ShoppingCart.cs - CreateOrder (insert order details)
-- LINQ: _gadgetsOnlineEntities.OrderDetails.Add(orderDetail) + SaveChanges()
-- Source File: Services/ShoppingCart.cs, Method: CreateOrder
-- ---------------------------------------------------------------------------
INSERT INTO [dbo].[OrderDetails] ([OrderId], [ProductId], [Quantity], [UnitPrice])
VALUES (@orderId, @productId, @quantity, @unitPrice);

-- ---------------------------------------------------------------------------
-- Statement 14: OrderProcessing.cs - ProcessOrder (insert order)
-- LINQ: _gadgetsOnlineEntities.Orders.Add(order) + SaveChanges()
-- Source File: Services/OrderProcessing.cs, Method: ProcessOrder
-- ---------------------------------------------------------------------------
INSERT INTO [dbo].[Orders] ([OrderDate], [Username], [FirstName], [LastName], [Address], [City], [State], [PostalCode], [Country], [Phone], [Email], [Total])
VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);

-- ---------------------------------------------------------------------------
-- Statement 15: ShoppingCart.cs - SaveChanges (update count decrement)
-- LINQ: cartItem.Count-- + SaveChanges() (within RemoveFromCart)
-- Source File: Services/ShoppingCart.cs, Method: RemoveFromCart (update path)
-- ---------------------------------------------------------------------------
UPDATE [dbo].[Carts]
SET [Count] = [Count] - 1
WHERE [RecordId] = @recordId;
