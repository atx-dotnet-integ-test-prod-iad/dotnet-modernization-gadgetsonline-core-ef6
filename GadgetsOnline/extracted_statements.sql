-- ============================================================================
-- EXTRACTED SQL STATEMENTS CATALOG
-- Application: GadgetsOnline
-- Source Database: Microsoft SQL Server 2019
-- Total Statements: 18
-- Description: SQL equivalents extracted from EF6 LINQ-to-Entities queries
-- ============================================================================

-- ============================================================================
-- SOURCE FILE: Services/Inventory.cs
-- ============================================================================

-- Statement 1: GetBestSellers
-- Source: Services/Inventory.cs :: GetBestSellers(int count)
-- LINQ: _gadgetsOnlineEntities.Products.Take(count).ToList()
SELECT TOP(@count) [ProductId], [CategoryId], [Name], [Price], [ProductArtUrl]
FROM [dbo].[Products];

-- Statement 2: GetAllCategories
-- Source: Services/Inventory.cs :: GetAllCategories()
-- LINQ: _gadgetsOnlineEntities.Categories.ToList()
SELECT [CategoryId], [Name], [Description]
FROM [dbo].[Categories];

-- Statement 3: GetAllProductsInCategory
-- Source: Services/Inventory.cs :: GetAllProductsInCategory(string category)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()
SELECT p.[ProductId], p.[CategoryId], p.[Name], p.[Price], p.[ProductArtUrl]
FROM [dbo].[Products] p
INNER JOIN [dbo].[Categories] c ON p.[CategoryId] = c.[CategoryId]
WHERE c.[Name] = @category;

-- Statement 4: GetProductById
-- Source: Services/Inventory.cs :: GetProductById(int id)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()
SELECT TOP 1 [ProductId], [CategoryId], [Name], [Price], [ProductArtUrl]
FROM [dbo].[Products]
WHERE [ProductId] = @id;

-- Statement 5: GetProductNameById
-- Source: Services/Inventory.cs :: GetProductNameById(int id)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name
SELECT TOP 1 [Name]
FROM [dbo].[Products]
WHERE [ProductId] = @id;

-- ============================================================================
-- SOURCE FILE: Services/ShoppingCart.cs
-- ============================================================================

-- Statement 6: GetCartItems
-- Source: Services/ShoppingCart.cs :: GetCartItems()
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId).ToList()
SELECT [RecordId], [CartId], [ProductId], [Count], [DateCreated]
FROM [dbo].[Carts]
WHERE [CartId] = @ShoppingCartId;

-- Statement 7: GetCount
-- Source: Services/ShoppingCart.cs :: GetCount()
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count).Sum()
SELECT SUM([Count])
FROM [dbo].[Carts]
WHERE [CartId] = @ShoppingCartId;

-- Statement 8: GetTotal
-- Source: Services/ShoppingCart.cs :: GetTotal()
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count * cartItems.Product.Price).Sum()
SELECT SUM(c.[Count] * p.[Price])
FROM [dbo].[Carts] c
INNER JOIN [dbo].[Products] p ON c.[ProductId] = p.[ProductId]
WHERE c.[CartId] = @ShoppingCartId;

-- Statement 9: AddToCart - SELECT (check existing)
-- Source: Services/ShoppingCart.cs :: AddToCart(int id)
-- LINQ: _gadgetsOnlineEntities.Carts.SingleOrDefault(c => c.CartId == ShoppingCartId && c.ProductId == id)
SELECT [RecordId], [CartId], [ProductId], [Count], [DateCreated]
FROM [dbo].[Carts]
WHERE [CartId] = @ShoppingCartId AND [ProductId] = @id;

-- Statement 10: AddToCart - INSERT (new cart item)
-- Source: Services/ShoppingCart.cs :: AddToCart(int id)
-- LINQ: _gadgetsOnlineEntities.Carts.Add(new Cart { ProductId = id, CartId = ShoppingCartId, Count = 1, DateCreated = DateTime.Now })
INSERT INTO [dbo].[Carts] ([CartId], [ProductId], [Count], [DateCreated])
VALUES (@ShoppingCartId, @ProductId, 1, GETDATE());

-- Statement 11: RemoveFromCart - SELECT (get cart item)
-- Source: Services/ShoppingCart.cs :: RemoveFromCart(int id)
-- LINQ: _gadgetsOnlineEntities.Carts.Single(cart => cart.CartId == ShoppingCartId && cart.ProductId == id)
SELECT [RecordId], [CartId], [ProductId], [Count], [DateCreated]
FROM [dbo].[Carts]
WHERE [CartId] = @ShoppingCartId AND [ProductId] = @id;

-- Statement 12: RemoveFromCart - DELETE (remove cart item)
-- Source: Services/ShoppingCart.cs :: RemoveFromCart(int id)
-- LINQ: _gadgetsOnlineEntities.Carts.Remove(cartItem)
DELETE FROM [dbo].[Carts]
WHERE [RecordId] = @RecordId;

-- Statement 13: EmptyCart - SELECT (get cart items for deletion)
-- Source: Services/ShoppingCart.cs :: EmptyCart()
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId)
SELECT [RecordId], [CartId], [ProductId], [Count], [DateCreated]
FROM [dbo].[Carts]
WHERE [CartId] = @ShoppingCartId;

-- Statement 14: EmptyCart - DELETE (remove all cart items)
-- Source: Services/ShoppingCart.cs :: EmptyCart()
-- LINQ: _gadgetsOnlineEntities.Carts.Remove(cartItem) [for each item in cart]
DELETE FROM [dbo].[Carts]
WHERE [CartId] = @ShoppingCartId;

-- Statement 15: CreateOrder - INSERT OrderDetails
-- Source: Services/ShoppingCart.cs :: CreateOrder(Order order)
-- LINQ: _gadgetsOnlineEntities.OrderDetails.Add(new OrderDetail { ProductId = item.ProductId, OrderId = order.OrderId, UnitPrice = item.Product.Price, Quantity = item.Count })
INSERT INTO [dbo].[OrderDetails] ([OrderId], [ProductId], [Quantity], [UnitPrice])
VALUES (@OrderId, @ProductId, @Quantity, @UnitPrice);

-- ============================================================================
-- SOURCE FILE: Services/OrderProcessing.cs
-- ============================================================================

-- Statement 16: ProcessOrder - INSERT Orders
-- Source: Services/OrderProcessing.cs :: ProcessOrder(Order order, HttpContext httpContext)
-- LINQ: _gadgetsOnlineEntities.Orders.Add(order)
INSERT INTO [dbo].[Orders] ([OrderDate], [Username], [FirstName], [LastName], [Address], [City], [State], [PostalCode], [Country], [Phone], [Email], [Total])
VALUES (@OrderDate, @Username, @FirstName, @LastName, @Address, @City, @State, @PostalCode, @Country, @Phone, @Email, @Total);

-- ============================================================================
-- SOURCE FILE: Models/GadgetsOnlineInitializer.cs
-- ============================================================================

-- Statement 17: Seed Categories - INSERT
-- Source: Models/GadgetsOnlineInitializer.cs :: Seed(GadgetsOnlineEntities context)
-- LINQ: categories.ForEach(c => context.Categories.Add(c))
INSERT INTO [dbo].[Categories] ([CategoryId], [Name], [Description])
VALUES
    (1, 'Mobile Phones', 'Latest collection of Mobile Phones'),
    (2, 'Laptops', 'Latest Laptops in 2022'),
    (3, 'Desktops', 'Latest Desktops in 2022'),
    (4, 'Audio', 'Latest audio devices'),
    (5, 'Accessories', 'USB Cables, Mobile chargers and Keyboards etc');

-- Statement 18: Seed Products - INSERT
-- Source: Models/GadgetsOnlineInitializer.cs :: Seed(GadgetsOnlineEntities context)
-- LINQ: products.ForEach(p => context.Products.Add(p))
INSERT INTO [dbo].[Products] ([ProductId], [CategoryId], [Name], [Price], [ProductArtUrl])
VALUES
    (1, 1, 'Phone 12', 699.00, '/Content/Images/Mobile/1.jpg'),
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
