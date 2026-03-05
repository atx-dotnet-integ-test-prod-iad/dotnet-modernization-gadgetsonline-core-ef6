-- ============================================================================
-- Extracted SQL Statements Catalog
-- Source: GadgetsOnline .NET Application (EF6 LINQ-to-Entities)
-- Original Database: Microsoft SQL Server with dbo schema (PascalCase)
-- Date: 2026-03-05
-- ============================================================================
-- NOTE: This application uses Entity Framework 6 with LINQ-to-Entities for ALL
-- database access. There are no raw/inline SQL statements in the codebase.
-- The following SQL statements are reconstructed equivalents of what EF6
-- would generate internally for each LINQ query.
-- ============================================================================

-- Statement 1: Inventory.GetBestSellers (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Products.Take(count).ToList()
SELECT TOP(@count) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products;

-- Statement 2: Inventory.GetAllCategories (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Categories.ToList()
SELECT CategoryId, Name, Description FROM dbo.Categories;

-- Statement 3: Inventory.GetAllProductsInCategory (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()
SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl FROM dbo.Products p INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @category;

-- Statement 4: Inventory.GetProductById (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()
SELECT TOP 1 ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products WHERE ProductId = @id;

-- Statement 5: Inventory.GetProductNameById (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name
SELECT TOP 1 Name FROM dbo.Products WHERE ProductId = @id;

-- Statement 6: ShoppingCart.GetCartItems (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId).ToList()
SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId;

-- Statement 7: ShoppingCart.GetCount (ShoppingCart.cs)
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count).Sum()
SELECT COALESCE(SUM(Count), 0) FROM dbo.Carts WHERE CartId = @cartId;

-- Statement 8: ShoppingCart.GetTotal (ShoppingCart.cs)
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count * cartItems.Product.Price).Sum()
SELECT COALESCE(SUM(c.Count * p.Price), 0) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.ProductId = p.ProductId WHERE c.CartId = @cartId;

-- Statement 9: ShoppingCart.AddToCart - SELECT (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.SingleOrDefault(c => c.CartId == ShoppingCartId && c.ProductId == id)
SELECT TOP 1 RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @productId;

-- Statement 10: ShoppingCart.AddToCart - INSERT (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.Add(cartItem) when item doesn't exist
INSERT INTO dbo.Carts (CartId, ProductId, Count, DateCreated) VALUES (@cartId, @productId, 1, GETDATE());

-- Statement 11: ShoppingCart.AddToCart - UPDATE (ShoppingCart.cs)
-- LINQ: cartItem.Count++ when item already exists
UPDATE dbo.Carts SET Count = Count + 1 WHERE CartId = @cartId AND ProductId = @productId;

-- Statement 12: ShoppingCart.RemoveFromCart - SELECT+UPDATE (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.Single(cart => cart.CartId == ShoppingCartId && cart.ProductId == id)
SELECT TOP 1 RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @id;

-- Statement 13: ShoppingCart.RemoveFromCart - UPDATE (count > 1) (ShoppingCart.cs)
-- LINQ: cartItem.Count-- via EF6 change tracking
UPDATE dbo.Carts SET Count = Count - 1 WHERE CartId = @cartId AND ProductId = @id;

-- Statement 14: ShoppingCart.RemoveFromCart - DELETE (count <= 1) (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.Remove(cartItem)
DELETE FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @id;

-- Statement 15: ShoppingCart.EmptyCart - DELETE (ShoppingCart.cs)
-- LINQ: foreach (var cartItem in cartItems) { _gadgetsOnlineEntities.Carts.Remove(cartItem); }
DELETE FROM dbo.Carts WHERE CartId = @cartId;

-- Statement 16: ShoppingCart.CreateOrder - INSERT OrderDetails (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.OrderDetails.Add(orderDetail) in foreach loop
INSERT INTO dbo.OrderDetails (OrderId, ProductId, Quantity, UnitPrice) VALUES (@orderId, @productId, @quantity, @unitPrice);

-- Statement 17: OrderProcessing.ProcessOrder - INSERT Orders (OrderProcessing.cs)
-- LINQ: _gadgetsOnlineEntities.Orders.Add(order)
INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);
