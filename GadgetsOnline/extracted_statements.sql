-- =====================================================
-- Extracted SQL Statements Catalog
-- Source: GadgetsOnline .NET Application (Entity Framework LINQ)
-- Date: 2026-03-26
-- Note: This application uses Entity Framework 6 with LINQ exclusively.
--       No raw inline SQL strings exist in the codebase.
--       These are representative SQL statements that EF would generate at runtime.
-- Total Statements: 20
-- =====================================================

-- Statement 1: INSERT Category (from GadgetsOnlineInitializer.cs Seed method)
-- Source: Models/GadgetsOnlineInitializer.cs - context.Categories.Add()
-- LINQ: categories.ForEach(c => context.Categories.Add(c))
INSERT INTO Categories (CategoryId, Name, Description) VALUES (1, 'Mobile Phones', 'Latest collection of Mobile Phones');

-- Statement 2: INSERT Product (from GadgetsOnlineInitializer.cs Seed method)
-- Source: Models/GadgetsOnlineInitializer.cs - context.Products.Add()
-- LINQ: products.ForEach(p => context.Products.Add(p))
INSERT INTO Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (1, 1, 'Phone 12', 699.00, '/Content/Images/Mobile/1.jpg');

-- Statement 3: SELECT Products with TOP (from Inventory.GetBestSellers)
-- Source: Services/Inventory.cs - _gadgetsOnlineEntities.Products.Take(count).ToList()
-- LINQ: _gadgetsOnlineEntities.Products.Take(count).ToList()
SELECT TOP(@p0) ProductId, CategoryId, Name, Price, ProductArtUrl FROM Products;

-- Statement 4: SELECT All Categories (from Inventory.GetAllCategories)
-- Source: Services/Inventory.cs - _gadgetsOnlineEntities.Categories.ToList()
-- LINQ: _gadgetsOnlineEntities.Categories.ToList()
SELECT CategoryId, Name, Description FROM Categories;

-- Statement 5: SELECT Products by Category Name (from Inventory.GetAllProductsInCategory)
-- Source: Services/Inventory.cs - _gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()
SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl FROM Products p INNER JOIN Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @p0;

-- Statement 6: SELECT Product by Id (from Inventory.GetProductById)
-- Source: Services/Inventory.cs - _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()
SELECT TOP(1) ProductId, CategoryId, Name, Price, ProductArtUrl FROM Products WHERE ProductId = @p0;

-- Statement 7: SELECT Product Name by Id (from Inventory.GetProductNameById)
-- Source: Services/Inventory.cs - _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name
SELECT TOP(1) Name FROM Products WHERE ProductId = @p0;

-- Statement 8: SELECT Cart Items by CartId (from ShoppingCart.GetCartItems)
-- Source: Services/ShoppingCart.cs - _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId)
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId).ToList()
SELECT RecordId, CartId, ProductId, Count, DateCreated FROM Carts WHERE CartId = @p0;

-- Statement 9: SELECT Single Cart Item (from ShoppingCart.AddToCart - SingleOrDefault)
-- Source: Services/ShoppingCart.cs - _gadgetsOnlineEntities.Carts.SingleOrDefault(c => c.CartId == ShoppingCartId && c.ProductId == id)
-- LINQ: _gadgetsOnlineEntities.Carts.SingleOrDefault(c => c.CartId == ShoppingCartId && c.ProductId == id)
SELECT TOP(1) RecordId, CartId, ProductId, Count, DateCreated FROM Carts WHERE CartId = @p0 AND ProductId = @p1;

-- Statement 10: INSERT Cart Item (from ShoppingCart.AddToCart)
-- Source: Services/ShoppingCart.cs - _gadgetsOnlineEntities.Carts.Add(cartItem)
-- LINQ: _gadgetsOnlineEntities.Carts.Add(cartItem)
INSERT INTO Carts (CartId, ProductId, Count, DateCreated) VALUES (@p0, @p1, @p2, @p3);

-- Statement 11: UPDATE Cart Item Count (from ShoppingCart.AddToCart - cartItem.Count++)
-- Source: Services/ShoppingCart.cs - cartItem.Count++; _gadgetsOnlineEntities.SaveChanges()
-- LINQ: cartItem.Count++; _gadgetsOnlineEntities.SaveChanges()
UPDATE Carts SET Count = @p0 WHERE RecordId = @p1;

-- Statement 12: SELECT SUM of Cart Count (from ShoppingCart.GetCount)
-- Source: Services/ShoppingCart.cs - select (int?)cartItems.Count).Sum()
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count).Sum()
SELECT SUM(Count) FROM Carts WHERE CartId = @p0;

-- Statement 13: SELECT SUM of Cart Total (from ShoppingCart.GetTotal)
-- Source: Services/ShoppingCart.cs - select (int?)cartItems.Count * cartItems.Product.Price).Sum()
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count * cartItems.Product.Price).Sum()
SELECT SUM(c.Count * p.Price) FROM Carts c INNER JOIN Products p ON c.ProductId = p.ProductId WHERE c.CartId = @p0;

-- Statement 14: DELETE Cart Items by CartId (from ShoppingCart.EmptyCart)
-- Source: Services/ShoppingCart.cs - _gadgetsOnlineEntities.Carts.Remove(cartItem) in loop
-- LINQ: foreach (var cartItem in cartItems) { _gadgetsOnlineEntities.Carts.Remove(cartItem); }
DELETE FROM Carts WHERE CartId = @p0;

-- Statement 15: SELECT Cart Item for Remove (from ShoppingCart.RemoveFromCart - Single)
-- Source: Services/ShoppingCart.cs - _gadgetsOnlineEntities.Carts.Single(cart => cart.CartId == ShoppingCartId && cart.ProductId == id)
-- LINQ: _gadgetsOnlineEntities.Carts.Single(cart => cart.CartId == ShoppingCartId && cart.ProductId == id)
SELECT TOP(1) RecordId, CartId, ProductId, Count, DateCreated FROM Carts WHERE CartId = @p0 AND ProductId = @p1 ORDER BY RecordId;

-- Statement 16: DELETE Single Cart Item (from ShoppingCart.RemoveFromCart)
-- Source: Services/ShoppingCart.cs - _gadgetsOnlineEntities.Carts.Remove(cartItem)
-- LINQ: _gadgetsOnlineEntities.Carts.Remove(cartItem)
DELETE FROM Carts WHERE RecordId = @p0;

-- Statement 17: INSERT Order Detail (from ShoppingCart.CreateOrder)
-- Source: Services/ShoppingCart.cs - _gadgetsOnlineEntities.OrderDetails.Add(orderDetail)
-- LINQ: _gadgetsOnlineEntities.OrderDetails.Add(orderDetail)
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice) VALUES (@p0, @p1, @p2, @p3);

-- Statement 18: UPDATE Order Total (from ShoppingCart.CreateOrder)
-- Source: Services/ShoppingCart.cs - order.Total = orderTotal; _gadgetsOnlineEntities.SaveChanges()
-- LINQ: order.Total = orderTotal; _gadgetsOnlineEntities.SaveChanges()
UPDATE Orders SET Total = @p0 WHERE OrderId = @p1;

-- Statement 19: INSERT Order (from OrderProcessing.ProcessOrder)
-- Source: Services/OrderProcessing.cs - _gadgetsOnlineEntities.Orders.Add(order)
-- LINQ: _gadgetsOnlineEntities.Orders.Add(order)
INSERT INTO Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@p0, @p1, @p2, @p3, @p4, @p5, @p6, @p7, @p8, @p9, @p10, @p11);

-- Statement 20: SELECT Order Details by OrderId (from EF navigation property loading)
-- Source: Models/Order.cs - OrderDetails navigation property (lazy loading)
-- LINQ: EF lazy loading of Order.OrderDetails navigation property
SELECT OrderDetailId, OrderId, ProductId, Quantity, UnitPrice FROM OrderDetails WHERE OrderId = @p0;
