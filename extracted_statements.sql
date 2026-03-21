-- =====================================================
-- Extracted SQL Statements from GadgetsOnline Application
-- Source: EF6 LINQ-to-Entities equivalent MS SQL Server statements
-- Total Statements: 17
--   Inventory.cs: 5 statements (Statements 1-5)
--   ShoppingCart.cs: 9 statements (Statements 6-14)
--   OrderProcessing.cs: 1 statement (Statement 15)
--   GadgetsOnlineInitializer.cs: 2 statements (Statements 16-17)
-- Date: 2026-03-21
-- =====================================================

-- =====================================================
-- Statement 1: GetBestSellers (Inventory.cs)
-- Source File: Services/Inventory.cs
-- Method: GetBestSellers(int count)
-- LINQ: _gadgetsOnlineEntities.Products.Take(count).ToList()
-- =====================================================
SELECT TOP (@count) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products;

-- =====================================================
-- Statement 2: GetAllCategories (Inventory.cs)
-- Source File: Services/Inventory.cs
-- Method: GetAllCategories()
-- LINQ: _gadgetsOnlineEntities.Categories.ToList()
-- =====================================================
SELECT CategoryId, Name, Description FROM dbo.Categories;

-- =====================================================
-- Statement 3: GetAllProductsInCategory (Inventory.cs)
-- Source File: Services/Inventory.cs
-- Method: GetAllProductsInCategory(string category)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()
-- =====================================================
SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl FROM dbo.Products p INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @categoryName;

-- =====================================================
-- Statement 4: GetProductById (Inventory.cs)
-- Source File: Services/Inventory.cs
-- Method: GetProductById(int id)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()
-- =====================================================
SELECT TOP 1 ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products WHERE ProductId = @id;

-- =====================================================
-- Statement 5: GetProductNameById (Inventory.cs)
-- Source File: Services/Inventory.cs
-- Method: GetProductNameById(int id)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name
-- =====================================================
SELECT TOP 1 Name FROM dbo.Products WHERE ProductId = @id;

-- =====================================================
-- Statement 6: GetCartItems (ShoppingCart.cs)
-- Source File: Services/ShoppingCart.cs
-- Method: GetCartItems()
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId).ToList()
-- =====================================================
SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId;

-- =====================================================
-- Statement 7: GetCount (ShoppingCart.cs)
-- Source File: Services/ShoppingCart.cs
-- Method: GetCount()
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count).Sum()
-- =====================================================
SELECT COALESCE(SUM(Count), 0) FROM dbo.Carts WHERE CartId = @cartId;

-- =====================================================
-- Statement 8: GetTotal (ShoppingCart.cs)
-- Source File: Services/ShoppingCart.cs
-- Method: GetTotal()
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count * cartItems.Product.Price).Sum()
-- =====================================================
SELECT COALESCE(SUM(c.Count * p.Price), 0) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.ProductId = p.ProductId WHERE c.CartId = @cartId;

-- =====================================================
-- Statement 9: AddToCart - Insert new item (ShoppingCart.cs)
-- Source File: Services/ShoppingCart.cs
-- Method: AddToCart(int id) - when item doesn't exist in cart
-- LINQ: _gadgetsOnlineEntities.Carts.Add(new Cart { ProductId = id, CartId = ShoppingCartId, Count = 1, DateCreated = DateTime.Now })
-- =====================================================
INSERT INTO dbo.Carts (CartId, ProductId, Count, DateCreated) VALUES (@cartId, @productId, 1, GETDATE());

-- =====================================================
-- Statement 10: AddToCart - Update existing item (ShoppingCart.cs)
-- Source File: Services/ShoppingCart.cs
-- Method: AddToCart(int id) - when item already exists in cart
-- LINQ: cartItem.Count++ then _gadgetsOnlineEntities.SaveChanges()
-- =====================================================
UPDATE dbo.Carts SET Count = Count + 1 WHERE CartId = @cartId AND ProductId = @productId;

-- =====================================================
-- Statement 11: RemoveFromCart - Delete item (ShoppingCart.cs)
-- Source File: Services/ShoppingCart.cs
-- Method: RemoveFromCart(int id) - when Count <= 1
-- LINQ: _gadgetsOnlineEntities.Carts.Remove(cartItem)
-- =====================================================
DELETE FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @productId;

-- =====================================================
-- Statement 12: RemoveFromCart - Decrement count (ShoppingCart.cs)
-- Source File: Services/ShoppingCart.cs
-- Method: RemoveFromCart(int id) - when Count > 1
-- LINQ: cartItem.Count-- then _gadgetsOnlineEntities.SaveChanges()
-- =====================================================
UPDATE dbo.Carts SET Count = Count - 1 WHERE CartId = @cartId AND ProductId = @productId;

-- =====================================================
-- Statement 13: EmptyCart (ShoppingCart.cs)
-- Source File: Services/ShoppingCart.cs
-- Method: EmptyCart()
-- LINQ: _gadgetsOnlineEntities.Carts.Remove(cartItem) for each cart item where CartId matches
-- =====================================================
DELETE FROM dbo.Carts WHERE CartId = @cartId;

-- =====================================================
-- Statement 14: CreateOrder - Insert order details (ShoppingCart.cs)
-- Source File: Services/ShoppingCart.cs
-- Method: CreateOrder(Order order)
-- LINQ: _gadgetsOnlineEntities.OrderDetails.Add(new OrderDetail { ProductId, OrderId, UnitPrice, Quantity })
-- =====================================================
INSERT INTO dbo.OrderDetails (OrderId, ProductId, Quantity, UnitPrice) VALUES (@orderId, @productId, @quantity, @unitPrice);

-- =====================================================
-- Statement 15: ProcessOrder - Insert order (OrderProcessing.cs)
-- Source File: Services/OrderProcessing.cs
-- Method: ProcessOrder(Order order, HttpContext httpContext)
-- LINQ: _gadgetsOnlineEntities.Orders.Add(order)
-- =====================================================
INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);

-- =====================================================
-- Statement 16: Seed Categories (GadgetsOnlineInitializer.cs)
-- Source File: Models/GadgetsOnlineInitializer.cs
-- Method: Seed(GadgetsOnlineEntities context)
-- LINQ: context.Categories.Add(c) for each category
-- =====================================================
INSERT INTO dbo.Categories (CategoryId, Name, Description) VALUES (@categoryId, @name, @description);

-- =====================================================
-- Statement 17: Seed Products (GadgetsOnlineInitializer.cs)
-- Source File: Models/GadgetsOnlineInitializer.cs
-- Method: Seed(GadgetsOnlineEntities context)
-- LINQ: context.Products.Add(p) for each product
-- =====================================================
INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (@productId, @categoryId, @name, @price, @productArtUrl);
