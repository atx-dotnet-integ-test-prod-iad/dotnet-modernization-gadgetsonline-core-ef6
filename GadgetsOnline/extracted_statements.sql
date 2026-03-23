-- ============================================================================
-- EXTRACTED SQL STATEMENTS - GadgetsOnline Application
-- Source: Entity Framework 6 LINQ queries translated to equivalent MS SQL Server SQL
-- Date: 2026-03-23
-- ============================================================================

-- ============================================================================
-- SOURCE FILE: Services/Inventory.cs
-- ============================================================================

-- Statement 1: GetBestSellers(int count)
-- LINQ: _gadgetsOnlineEntities.Products.Take(count).ToList()
-- Retrieves top N products
SELECT TOP(@count) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products;

-- Statement 2: GetAllCategories()
-- LINQ: _gadgetsOnlineEntities.Categories.ToList()
-- Retrieves all categories
SELECT CategoryId, Name, Description FROM dbo.Categories;

-- Statement 3: GetAllProductsInCategory(string category)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()
-- Retrieves products filtered by category name via join
SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl FROM dbo.Products p INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @category;

-- Statement 4: GetProductById(int id)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()
-- Retrieves a single product by ID
SELECT TOP(1) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products WHERE ProductId = @id;

-- Statement 5: GetProductNameById(int id)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name
-- Retrieves product name by ID
SELECT TOP(1) Name FROM dbo.Products WHERE ProductId = @id;

-- ============================================================================
-- SOURCE FILE: Services/ShoppingCart.cs
-- ============================================================================

-- Statement 6: AddToCart - Select existing cart item
-- LINQ: _gadgetsOnlineEntities.Carts.SingleOrDefault(c => c.CartId == ShoppingCartId && c.ProductId == id)
-- Check if item exists in cart
SELECT TOP(1) RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @productId;

-- Statement 7: AddToCart - Insert new cart item
-- LINQ: _gadgetsOnlineEntities.Carts.Add(cartItem) followed by SaveChanges
-- Insert a new item into the cart
INSERT INTO dbo.Carts (CartId, ProductId, Count, DateCreated) VALUES (@cartId, @productId, 1, @dateCreated);

-- Statement 8: AddToCart - Update cart item count
-- LINQ: cartItem.Count++ followed by SaveChanges
-- Update count for existing cart item
UPDATE dbo.Carts SET Count = Count + 1 WHERE RecordId = @recordId;

-- Statement 9: GetCount()
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count).Sum()
-- Get total item count in cart
SELECT SUM(Count) FROM dbo.Carts WHERE CartId = @cartId;

-- Statement 10: RemoveFromCart - Get cart item
-- LINQ: _gadgetsOnlineEntities.Carts.Single(cart => cart.CartId == ShoppingCartId && cart.ProductId == id)
-- Get specific cart item for removal
SELECT TOP(1) RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @productId;

-- Statement 11: RemoveFromCart - Decrement count
-- LINQ: cartItem.Count-- followed by SaveChanges
-- Decrement cart item count
UPDATE dbo.Carts SET Count = Count - 1 WHERE RecordId = @recordId;

-- Statement 12: RemoveFromCart - Delete item
-- LINQ: _gadgetsOnlineEntities.Carts.Remove(cartItem) followed by SaveChanges
-- Remove cart item entirely
DELETE FROM dbo.Carts WHERE RecordId = @recordId;

-- Statement 13: GetCartItems()
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId).ToList()
-- Get all items in a cart
SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId;

-- Statement 14: GetTotal()
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count * cartItems.Product.Price).Sum()
-- Get total price of items in cart
SELECT SUM(c.Count * p.Price) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.ProductId = p.ProductId WHERE c.CartId = @cartId;

-- Statement 15: EmptyCart()
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId) then Remove each
-- Delete all items from a cart
DELETE FROM dbo.Carts WHERE CartId = @cartId;

-- Statement 16: CreateOrder - Insert order detail
-- LINQ: _gadgetsOnlineEntities.OrderDetails.Add(orderDetail) followed by SaveChanges
-- Insert order detail record
INSERT INTO dbo.OrderDetails (ProductId, OrderId, UnitPrice, Quantity) VALUES (@productId, @orderId, @unitPrice, @quantity);

-- ============================================================================
-- SOURCE FILE: Services/OrderProcessing.cs
-- ============================================================================

-- Statement 17: ProcessOrder - Insert order
-- LINQ: _gadgetsOnlineEntities.Orders.Add(order) followed by SaveChanges
-- Insert a new order
INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);

-- ============================================================================
-- SOURCE FILE: Models/GadgetsOnlineInitializer.cs
-- ============================================================================

-- Statement 18: Seed - Insert categories
-- LINQ: context.Categories.Add(c) for each category followed by SaveChanges
-- Insert seed categories
INSERT INTO dbo.Categories (CategoryId, Name, Description) VALUES (@categoryId, @name, @description);

-- Statement 19: Seed - Insert products
-- LINQ: context.Products.Add(p) for each product followed by SaveChanges
-- Insert seed products
INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (@productId, @categoryId, @name, @price, @productArtUrl);
