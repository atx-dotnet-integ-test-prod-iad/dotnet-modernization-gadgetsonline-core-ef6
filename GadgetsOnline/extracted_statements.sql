-- ============================================================================
-- EXTRACTED SQL STATEMENTS CATALOG
-- Application: GadgetsOnline (.NET EF6 Application)
-- Source Database: Microsoft SQL Server (dbo schema)
-- Extraction Date: 2026-03-21
-- 
-- This file catalogs all SQL statements that the Entity Framework 6 LINQ
-- queries in the application would generate against the original SQL Server
-- database (using dbo schema, PascalCase naming conventions).
-- Total Statements: 21
-- ============================================================================

-- ============================================================================
-- SOURCE FILE: Services/Inventory.cs
-- ============================================================================

-- Statement 1: GetBestSellers (line ~24)
-- LINQ: _gadgetsOnlineEntities.Products.Take(count).ToList()
-- Retrieves top N products as best sellers
SELECT TOP(@count) [ProductId], [CategoryId], [Name], [Price], [ProductArtUrl]
FROM [dbo].[Products];

-- Statement 2: GetAllCategories (line ~30)
-- LINQ: _gadgetsOnlineEntities.Categories.ToList()
-- Retrieves all categories
SELECT [CategoryId], [Name], [Description]
FROM [dbo].[Categories];

-- Statement 3: GetAllProductsInCategory (line ~35)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()
-- Retrieves all products in a specific category by category name
SELECT p.[ProductId], p.[CategoryId], p.[Name], p.[Price], p.[ProductArtUrl]
FROM [dbo].[Products] AS p
INNER JOIN [dbo].[Categories] AS c ON p.[CategoryId] = c.[CategoryId]
WHERE c.[Name] = @category;

-- Statement 4: GetProductById (line ~41)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()
-- Retrieves a single product by its ID
SELECT TOP(1) [ProductId], [CategoryId], [Name], [Price], [ProductArtUrl]
FROM [dbo].[Products]
WHERE [ProductId] = @id;

-- Statement 5: GetProductNameById (line ~48)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name
-- Retrieves the name of a product by its ID
SELECT TOP(1) [Name]
FROM [dbo].[Products]
WHERE [ProductId] = @id;

-- ============================================================================
-- SOURCE FILE: Services/ShoppingCart.cs
-- ============================================================================

-- Statement 6: GetCartItems (line ~128)
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId).ToList()
-- Retrieves all cart items for the current shopping cart
SELECT [RecordId], [CartId], [ProductId], [Count], [DateCreated]
FROM [dbo].[Carts]
WHERE [CartId] = @ShoppingCartId;

-- Statement 7: GetCount (line ~117)
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count).Sum()
-- Gets the total count of items in the shopping cart
SELECT SUM([Count])
FROM [dbo].[Carts]
WHERE [CartId] = @ShoppingCartId;

-- Statement 8: GetTotal (line ~133)
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count * cartItems.Product.Price).Sum()
-- Gets the total price of all items in the cart
SELECT SUM(CAST(c.[Count] AS INT) * p.[Price])
FROM [dbo].[Carts] AS c
INNER JOIN [dbo].[Products] AS p ON c.[ProductId] = p.[ProductId]
WHERE c.[CartId] = @ShoppingCartId;

-- Statement 9: AddToCart - SELECT (line ~93)
-- LINQ: _gadgetsOnlineEntities.Carts.SingleOrDefault(c => c.CartId == ShoppingCartId && c.ProductId == id)
-- Checks if a product already exists in the cart
SELECT TOP(1) [RecordId], [CartId], [ProductId], [Count], [DateCreated]
FROM [dbo].[Carts]
WHERE [CartId] = @ShoppingCartId AND [ProductId] = @id;

-- Statement 10: AddToCart - INSERT (line ~98)
-- Creates a new cart item when product is not in cart
INSERT INTO [dbo].[Carts] ([CartId], [ProductId], [Count], [DateCreated])
VALUES (@CartId, @ProductId, 1, @DateCreated);

-- Statement 11: AddToCart - UPDATE (line ~103)
-- Updates cart item count when product is already in cart
UPDATE [dbo].[Carts]
SET [Count] = [Count] + 1
WHERE [RecordId] = @RecordId;

-- Statement 12: RemoveFromCart - SELECT (line ~110)
-- LINQ: _gadgetsOnlineEntities.Carts.Single(cart => cart.CartId == ShoppingCartId && cart.ProductId == id)
-- Gets the cart item to remove
SELECT TOP(1) [RecordId], [CartId], [ProductId], [Count], [DateCreated]
FROM [dbo].[Carts]
WHERE [CartId] = @ShoppingCartId AND [ProductId] = @id;

-- Statement 13: RemoveFromCart - UPDATE (line ~117)
-- Decrements cart item count
UPDATE [dbo].[Carts]
SET [Count] = [Count] - 1
WHERE [RecordId] = @RecordId;

-- Statement 14: RemoveFromCart - DELETE (line ~122)
-- Removes cart item when count reaches zero
DELETE FROM [dbo].[Carts]
WHERE [RecordId] = @RecordId;

-- Statement 15: EmptyCart - SELECT (line ~62)
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId)
-- Gets all cart items for deletion
SELECT [RecordId], [CartId], [ProductId], [Count], [DateCreated]
FROM [dbo].[Carts]
WHERE [CartId] = @ShoppingCartId;

-- Statement 16: EmptyCart - DELETE (line ~65)
-- Deletes all items from the cart
DELETE FROM [dbo].[Carts]
WHERE [CartId] = @ShoppingCartId;

-- Statement 17: CreateOrder - INSERT OrderDetail (line ~48)
-- Inserts order detail for each cart item
INSERT INTO [dbo].[OrderDetails] ([ProductId], [OrderId], [UnitPrice], [Quantity])
VALUES (@ProductId, @OrderId, @UnitPrice, @Quantity);

-- Statement 18: CreateOrder - UPDATE Order Total (line ~53)
-- Updates the order total
UPDATE [dbo].[Orders]
SET [Total] = @Total
WHERE [OrderId] = @OrderId;

-- ============================================================================
-- SOURCE FILE: Services/OrderProcessing.cs
-- ============================================================================

-- Statement 19: ProcessOrder - INSERT Order (line ~22)
-- LINQ: _gadgetsOnlineEntities.Orders.Add(order)
-- Inserts a new order
INSERT INTO [dbo].[Orders] ([OrderDate], [Username], [FirstName], [LastName], [Address], [City], [State], [PostalCode], [Country], [Phone], [Email], [Total])
VALUES (@OrderDate, @Username, @FirstName, @LastName, @Address, @City, @State, @PostalCode, @Country, @Phone, @Email, @Total);

-- ============================================================================
-- SOURCE FILE: Models/GadgetsOnlineInitializer.cs
-- ============================================================================

-- Statement 20: Seed Categories (line ~12)
-- Inserts seed data for categories
INSERT INTO [dbo].[Categories] ([CategoryId], [Name], [Description])
VALUES (1, 'Mobile Phones', 'Latest collection of Mobile Phones'),
       (2, 'Laptops', 'Latest Laptops in 2022'),
       (3, 'Desktops', 'Latest Desktops in 2022'),
       (4, 'Audio', 'Latest audio devices'),
       (5, 'Accessories', 'USB Cables, Mobile chargers and Keyboards etc');

-- Statement 21: Seed Products (line ~22)
-- Inserts seed data for products
INSERT INTO [dbo].[Products] ([ProductId], [CategoryId], [Name], [Price], [ProductArtUrl])
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
-- TOTAL STATEMENTS EXTRACTED: 21
-- Coverage:
--   Services/Inventory.cs: 5 statements (1-5)
--   Services/ShoppingCart.cs: 13 statements (6-18)
--   Services/OrderProcessing.cs: 1 statement (19)
--   Models/GadgetsOnlineInitializer.cs: 2 statements (20-21)
-- ============================================================================
