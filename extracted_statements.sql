-- =====================================================================
-- EXTRACTED SQL STATEMENTS CATALOG
-- Source: GadgetsOnline EF6 LINQ Queries
-- Database: Microsoft SQL Server (dbo schema)
-- Total Statements: 16
-- =====================================================================

-- =====================================================================
-- FILE: GadgetsOnline/Services/Inventory.cs
-- =====================================================================

-- Statement 1: GetBestSellers
-- Method: GetBestSellers(int count)
-- LINQ: _gadgetsOnlineEntities.Products.Take(count).ToList()
-- Type: SELECT
SELECT TOP(@count) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products;

-- Statement 2: GetAllCategories
-- Method: GetAllCategories()
-- LINQ: _gadgetsOnlineEntities.Categories.ToList()
-- Type: SELECT
SELECT CategoryId, Name, Description FROM dbo.Categories;

-- Statement 3: GetAllProductsInCategory
-- Method: GetAllProductsInCategory(string category)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()
-- Type: SELECT
SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl FROM dbo.Products p INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @category;

-- Statement 4: GetProductById
-- Method: GetProductById(int id)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()
-- Type: SELECT
SELECT TOP(1) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products WHERE ProductId = @id;

-- Statement 5: GetProductNameById
-- Method: GetProductNameById(int id)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name
-- Type: SELECT
SELECT TOP(1) Name FROM dbo.Products WHERE ProductId = @id;

-- =====================================================================
-- FILE: GadgetsOnline/Services/ShoppingCart.cs
-- =====================================================================

-- Statement 6: GetCartItems
-- Method: GetCartItems()
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId).ToList()
-- Type: SELECT
SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @ShoppingCartId;

-- Statement 7: GetCount
-- Method: GetCount()
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count).Sum()
-- Type: SELECT
SELECT SUM(Count) FROM dbo.Carts WHERE CartId = @ShoppingCartId;

-- Statement 8: GetTotal
-- Method: GetTotal()
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count * cartItems.Product.Price).Sum()
-- Type: SELECT
SELECT SUM(c.Count * p.Price) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.ProductId = p.ProductId WHERE c.CartId = @ShoppingCartId;

-- Statement 9: AddToCart - Select existing cart item
-- Method: AddToCart(int id)
-- LINQ: _gadgetsOnlineEntities.Carts.SingleOrDefault(c => c.CartId == ShoppingCartId && c.ProductId == id)
-- Type: SELECT
SELECT TOP(1) RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @ShoppingCartId AND ProductId = @id;

-- Statement 10: AddToCart - Insert new cart item
-- Method: AddToCart(int id)
-- LINQ: _gadgetsOnlineEntities.Carts.Add(cartItem) where cartItem = new Cart { ProductId = id, CartId = ShoppingCartId, Count = 1, DateCreated = DateTime.Now }
-- Type: INSERT
INSERT INTO dbo.Carts (CartId, ProductId, Count, DateCreated) VALUES (@CartId, @ProductId, @Count, @DateCreated);

-- Statement 11: RemoveFromCart - Delete cart item
-- Method: RemoveFromCart(int id)
-- LINQ: _gadgetsOnlineEntities.Carts.Remove(cartItem)
-- Type: DELETE
DELETE FROM dbo.Carts WHERE RecordId = @RecordId;

-- Statement 12: EmptyCart - Delete all cart items for a cart
-- Method: EmptyCart()
-- LINQ: foreach (var cartItem in cartItems) { _gadgetsOnlineEntities.Carts.Remove(cartItem); }
-- Type: DELETE
DELETE FROM dbo.Carts WHERE CartId = @ShoppingCartId;

-- Statement 13: CreateOrder - Insert order detail
-- Method: CreateOrder(Order order)
-- LINQ: _gadgetsOnlineEntities.OrderDetails.Add(orderDetail) where orderDetail = new OrderDetail { ProductId, OrderId, UnitPrice, Quantity }
-- Type: INSERT
INSERT INTO dbo.OrderDetails (OrderId, ProductId, Quantity, UnitPrice) VALUES (@OrderId, @ProductId, @Quantity, @UnitPrice);

-- =====================================================================
-- FILE: GadgetsOnline/Services/OrderProcessing.cs
-- =====================================================================

-- Statement 14: ProcessOrder - Insert order
-- Method: ProcessOrder(Order order, HttpContext httpContext)
-- LINQ: _gadgetsOnlineEntities.Orders.Add(order)
-- Type: INSERT
INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@OrderDate, @Username, @FirstName, @LastName, @Address, @City, @State, @PostalCode, @Country, @Phone, @Email, @Total);

-- =====================================================================
-- FILE: GadgetsOnline/Models/GadgetsOnlineInitializer.cs
-- =====================================================================

-- Statement 15: Seed Categories
-- Method: Seed(GadgetsOnlineEntities context)
-- LINQ: categories.ForEach(c => context.Categories.Add(c))
-- Type: INSERT
INSERT INTO dbo.Categories (CategoryId, Name, Description) VALUES (@CategoryId, @Name, @Description);

-- Statement 16: Seed Products
-- Method: Seed(GadgetsOnlineEntities context)
-- LINQ: products.ForEach(p => context.Products.Add(p))
-- Type: INSERT
INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (@ProductId, @CategoryId, @Name, @Price, @ProductArtUrl);
