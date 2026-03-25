-- =====================================================================
-- Extracted SQL Statements from GadgetsOnline Application
-- Source: Entity Framework LINQ Queries (EF6 generating SQL Server syntax)
-- Original Database: SQL Server (dbo schema, PascalCase column names)
-- =====================================================================

-- =====================================================================
-- SOURCE FILE: Services/Inventory.cs
-- =====================================================================

-- Statement 1: GetBestSellers(int count)
-- LINQ: _gadgetsOnlineEntities.Products.Take(count).ToList()
-- Method: Inventory.GetBestSellers
SELECT TOP (@p__linq__0) [Extent1].[ProductId] AS [ProductId], [Extent1].[CategoryId] AS [CategoryId], [Extent1].[Name] AS [Name], [Extent1].[Price] AS [Price], [Extent1].[ProductArtUrl] AS [ProductArtUrl] FROM [dbo].[Products] AS [Extent1];

-- Statement 2: GetAllCategories()
-- LINQ: _gadgetsOnlineEntities.Categories.ToList()
-- Method: Inventory.GetAllCategories
SELECT [Extent1].[CategoryId] AS [CategoryId], [Extent1].[Name] AS [Name], [Extent1].[Description] AS [Description] FROM [dbo].[Categories] AS [Extent1];

-- Statement 3: GetAllProductsInCategory(string category)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()
-- Method: Inventory.GetAllProductsInCategory
SELECT [Extent1].[ProductId] AS [ProductId], [Extent1].[CategoryId] AS [CategoryId], [Extent1].[Name] AS [Name], [Extent1].[Price] AS [Price], [Extent1].[ProductArtUrl] AS [ProductArtUrl] FROM [dbo].[Products] AS [Extent1] INNER JOIN [dbo].[Categories] AS [Extent2] ON [Extent1].[CategoryId] = [Extent2].[CategoryId] WHERE [Extent2].[Name] = @p__linq__0;

-- Statement 4: GetProductById(int id)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()
-- Method: Inventory.GetProductById
SELECT TOP (1) [Extent1].[ProductId] AS [ProductId], [Extent1].[CategoryId] AS [CategoryId], [Extent1].[Name] AS [Name], [Extent1].[Price] AS [Price], [Extent1].[ProductArtUrl] AS [ProductArtUrl] FROM [dbo].[Products] AS [Extent1] WHERE [Extent1].[ProductId] = @p__linq__0;

-- Statement 5: GetProductNameById(int id)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name
-- Method: Inventory.GetProductNameById
SELECT TOP (1) [Extent1].[Name] AS [Name] FROM [dbo].[Products] AS [Extent1] WHERE [Extent1].[ProductId] = @p__linq__0;

-- =====================================================================
-- SOURCE FILE: Services/ShoppingCart.cs
-- =====================================================================

-- Statement 6: GetCartItems()
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId).ToList()
-- Method: ShoppingCart.GetCartItems
SELECT [Extent1].[RecordId] AS [RecordId], [Extent1].[CartId] AS [CartId], [Extent1].[ProductId] AS [ProductId], [Extent1].[Count] AS [Count], [Extent1].[DateCreated] AS [DateCreated] FROM [dbo].[Carts] AS [Extent1] WHERE [Extent1].[CartId] = @p__linq__0;

-- Statement 7: AddToCart - SELECT existing cart item
-- LINQ: _gadgetsOnlineEntities.Carts.SingleOrDefault(c => c.CartId == ShoppingCartId && c.ProductId == id)
-- Method: ShoppingCart.AddToCart
SELECT TOP (2) [Extent1].[RecordId] AS [RecordId], [Extent1].[CartId] AS [CartId], [Extent1].[ProductId] AS [ProductId], [Extent1].[Count] AS [Count], [Extent1].[DateCreated] AS [DateCreated] FROM [dbo].[Carts] AS [Extent1] WHERE [Extent1].[CartId] = @p__linq__0 AND [Extent1].[ProductId] = @p__linq__1;

-- Statement 8: AddToCart - INSERT new cart item (when item not in cart)
-- LINQ: _gadgetsOnlineEntities.Carts.Add(cartItem) + SaveChanges()
-- Method: ShoppingCart.AddToCart
INSERT INTO [dbo].[Carts] ([CartId], [ProductId], [Count], [DateCreated]) VALUES (@p0, @p1, @p2, @p3);

-- Statement 9: AddToCart - UPDATE existing cart item count (when item already in cart)
-- LINQ: cartItem.Count++ + SaveChanges()
-- Method: ShoppingCart.AddToCart
UPDATE [dbo].[Carts] SET [Count] = @p0 WHERE [RecordId] = @p1;

-- Statement 10: GetCount()
-- LINQ: (from cartItems in Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count).Sum()
-- Method: ShoppingCart.GetCount
SELECT SUM([Extent1].[Count]) AS [A1] FROM [dbo].[Carts] AS [Extent1] WHERE [Extent1].[CartId] = @p__linq__0;

-- Statement 11: RemoveFromCart - SELECT cart item
-- LINQ: _gadgetsOnlineEntities.Carts.Single(cart => cart.CartId == ShoppingCartId && cart.ProductId == id)
-- Method: ShoppingCart.RemoveFromCart
SELECT TOP (2) [Extent1].[RecordId] AS [RecordId], [Extent1].[CartId] AS [CartId], [Extent1].[ProductId] AS [ProductId], [Extent1].[Count] AS [Count], [Extent1].[DateCreated] AS [DateCreated] FROM [dbo].[Carts] AS [Extent1] WHERE [Extent1].[CartId] = @p__linq__0 AND [Extent1].[ProductId] = @p__linq__1;

-- Statement 12: RemoveFromCart - UPDATE cart item (decrement count)
-- LINQ: cartItem.Count-- + SaveChanges()
-- Method: ShoppingCart.RemoveFromCart
UPDATE [dbo].[Carts] SET [Count] = @p0 WHERE [RecordId] = @p1;

-- Statement 13: RemoveFromCart - DELETE cart item (when count reaches 0)
-- LINQ: _gadgetsOnlineEntities.Carts.Remove(cartItem) + SaveChanges()
-- Method: ShoppingCart.RemoveFromCart
DELETE FROM [dbo].[Carts] WHERE [RecordId] = @p0;

-- Statement 14: EmptyCart - SELECT cart items for deletion
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId)
-- Method: ShoppingCart.EmptyCart
SELECT [Extent1].[RecordId] AS [RecordId], [Extent1].[CartId] AS [CartId], [Extent1].[ProductId] AS [ProductId], [Extent1].[Count] AS [Count], [Extent1].[DateCreated] AS [DateCreated] FROM [dbo].[Carts] AS [Extent1] WHERE [Extent1].[CartId] = @p__linq__0;

-- Statement 15: EmptyCart - DELETE each cart item
-- LINQ: _gadgetsOnlineEntities.Carts.Remove(cartItem) + SaveChanges()
-- Method: ShoppingCart.EmptyCart
DELETE FROM [dbo].[Carts] WHERE [RecordId] = @p0;

-- Statement 16: GetTotal()
-- LINQ: (from cartItems in Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count * cartItems.Product.Price).Sum()
-- Method: ShoppingCart.GetTotal
SELECT SUM(CAST([Extent1].[Count] AS decimal(19,0)) * [Extent2].[Price]) AS [A1] FROM [dbo].[Carts] AS [Extent1] INNER JOIN [dbo].[Products] AS [Extent2] ON [Extent1].[ProductId] = [Extent2].[ProductId] WHERE [Extent1].[CartId] = @p__linq__0;

-- Statement 17: CreateOrder - INSERT order detail
-- LINQ: _gadgetsOnlineEntities.OrderDetails.Add(orderDetail) + SaveChanges()
-- Method: ShoppingCart.CreateOrder
INSERT INTO [dbo].[OrderDetails] ([OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (@p0, @p1, @p2, @p3);

-- Statement 18: CreateOrder - UPDATE order total
-- LINQ: order.Total = orderTotal + SaveChanges()
-- Method: ShoppingCart.CreateOrder
UPDATE [dbo].[Orders] SET [Total] = @p0 WHERE [OrderId] = @p1;

-- =====================================================================
-- SOURCE FILE: Services/OrderProcessing.cs
-- =====================================================================

-- Statement 19: ProcessOrder - INSERT order
-- LINQ: _gadgetsOnlineEntities.Orders.Add(order) + SaveChanges()
-- Method: OrderProcessing.ProcessOrder
INSERT INTO [dbo].[Orders] ([OrderDate], [Username], [FirstName], [LastName], [Address], [City], [State], [PostalCode], [Country], [Phone], [Email], [Total]) VALUES (@p0, @p1, @p2, @p3, @p4, @p5, @p6, @p7, @p8, @p9, @p10, @p11);

-- =====================================================================
-- SOURCE FILE: Models/GadgetsOnlineInitializer.cs
-- =====================================================================

-- Statement 20: Seed - INSERT category
-- LINQ: context.Categories.Add(c) + SaveChanges()
-- Method: GadgetsOnlineInitializer.Seed
INSERT INTO [dbo].[Categories] ([CategoryId], [Name], [Description]) VALUES (@p0, @p1, @p2);

-- Statement 21: Seed - INSERT product
-- LINQ: context.Products.Add(p) + SaveChanges()
-- Method: GadgetsOnlineInitializer.Seed
INSERT INTO [dbo].[Products] ([ProductId], [CategoryId], [Name], [Price], [ProductArtUrl]) VALUES (@p0, @p1, @p2, @p3, @p4);
