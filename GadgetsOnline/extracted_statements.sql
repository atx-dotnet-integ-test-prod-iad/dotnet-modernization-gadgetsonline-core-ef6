-- ============================================================================
-- Extracted SQL Statements Catalog
-- Source: GadgetsOnline EF6 LINQ-to-SQL Operations
-- Database: GadgetsOnline (SQL Server - dbo schema)
-- Extracted: 2026-03-07
-- ============================================================================

-- Statement 1: GetBestSellers (Inventory.cs)
-- Source: _gadgetsOnlineEntities.Products.Take(count).ToList()
SELECT TOP(@count) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products;

-- Statement 2: GetAllCategories (Inventory.cs)
-- Source: _gadgetsOnlineEntities.Categories.ToList()
SELECT * FROM dbo.Categories;

-- Statement 3: GetAllProductsInCategory (Inventory.cs)
-- Source: _gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()
SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl FROM dbo.Products p INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @category;

-- Statement 4: GetProductById (Inventory.cs)
-- Source: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()
SELECT TOP 1 ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products WHERE ProductId = @id;

-- Statement 5: GetProductNameById (Inventory.cs)
-- Source: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name
SELECT TOP 1 Name FROM dbo.Products WHERE ProductId = @id;

-- Statement 6: CreateOrder - Insert OrderDetail (ShoppingCart.cs)
-- Source: _gadgetsOnlineEntities.OrderDetails.Add(orderDetail)
INSERT INTO dbo.OrderDetails (ProductId, OrderId, UnitPrice, Quantity) VALUES (@ProductId, @OrderId, @UnitPrice, @Quantity);

-- Statement 7: EmptyCart - Delete cart items (ShoppingCart.cs)
-- Source: _gadgetsOnlineEntities.Carts.Remove(cartItem) in loop where CartId matches
DELETE FROM dbo.Carts WHERE CartId = @CartId;

-- Statement 8: AddToCart - Find existing cart item (ShoppingCart.cs)
-- Source: _gadgetsOnlineEntities.Carts.SingleOrDefault(c => c.CartId == ShoppingCartId && c.ProductId == id)
SELECT TOP 1 * FROM dbo.Carts WHERE CartId = @CartId AND ProductId = @ProductId;

-- Statement 9: AddToCart - Insert new cart item (ShoppingCart.cs)
-- Source: _gadgetsOnlineEntities.Carts.Add(cartItem) when cartItem == null
INSERT INTO dbo.Carts (ProductId, CartId, Count, DateCreated) VALUES (@ProductId, @CartId, 1, @DateCreated);

-- Statement 10: AddToCart - Update cart item count (ShoppingCart.cs)
-- Source: cartItem.Count++ then SaveChanges()
UPDATE dbo.Carts SET Count = Count + 1 WHERE CartId = @CartId AND ProductId = @ProductId;

-- Statement 11: GetCount (ShoppingCart.cs)
-- Source: LINQ query summing Count where CartId matches
SELECT SUM(Count) FROM dbo.Carts WHERE CartId = @CartId;

-- Statement 12: RemoveFromCart - Find cart item (ShoppingCart.cs)
-- Source: _gadgetsOnlineEntities.Carts.Single(cart => cart.CartId == ShoppingCartId && cart.ProductId == id)
SELECT TOP 1 * FROM dbo.Carts WHERE CartId = @CartId AND ProductId = @ProductId;

-- Statement 13: RemoveFromCart - Decrement count (ShoppingCart.cs)
-- Source: cartItem.Count-- then SaveChanges()
UPDATE dbo.Carts SET Count = Count - 1 WHERE CartId = @CartId AND ProductId = @ProductId;

-- Statement 14: RemoveFromCart - Delete cart item (ShoppingCart.cs)
-- Source: _gadgetsOnlineEntities.Carts.Remove(cartItem) when Count <= 1
DELETE FROM dbo.Carts WHERE CartId = @CartId AND ProductId = @ProductId;

-- Statement 15: GetCartItems (ShoppingCart.cs)
-- Source: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId).ToList()
SELECT * FROM dbo.Carts WHERE CartId = @CartId;

-- Statement 16: GetTotal (ShoppingCart.cs)
-- Source: LINQ query joining Carts and Products, summing Count * Price
SELECT SUM(c.Count * p.Price) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.ProductId = p.ProductId WHERE c.CartId = @CartId;

-- Statement 17: ProcessOrder - Insert order (OrderProcessing.cs)
-- Source: _gadgetsOnlineEntities.Orders.Add(order)
INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@OrderDate, @Username, @FirstName, @LastName, @Address, @City, @State, @PostalCode, @Country, @Phone, @Email, @Total);

-- Statement 18: Seed - Insert categories (GadgetsOnlineInitializer.cs)
-- Source: context.Categories.Add(c) in loop
INSERT INTO dbo.Categories (CategoryId, Name, Description) VALUES (@CategoryId, @Name, @Description);

-- Statement 19: Seed - Insert products (GadgetsOnlineInitializer.cs)
-- Source: context.Products.Add(p) in loop
INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (@ProductId, @CategoryId, @Name, @Price, @ProductArtUrl);
