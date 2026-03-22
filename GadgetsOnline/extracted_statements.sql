-- ============================================================================
-- Extracted SQL Statements - MS SQL Server Equivalents of LINQ-to-Entities Queries
-- Application: GadgetsOnline
-- Source Database: SQL Server with dbo schema
-- Total Statements: 19
-- ============================================================================

-- ============================================================================
-- SOURCE FILE: Services/Inventory.cs (5 statements)
-- ============================================================================

-- Statement 1: Inventory.GetBestSellers(int count)
-- LINQ: _gadgetsOnlineEntities.Products.Take(count).ToList()
-- Retrieves top N products as best sellers
SELECT TOP(@count) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products;

-- Statement 2: Inventory.GetAllCategories()
-- LINQ: _gadgetsOnlineEntities.Categories.ToList()
-- Retrieves all categories
SELECT CategoryId, Name, Description FROM dbo.Categories;

-- Statement 3: Inventory.GetAllProductsInCategory(string category)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()
-- Retrieves all products in a specific category by joining with Categories
SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl FROM dbo.Products p INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @category;

-- Statement 4: Inventory.GetProductById(int id)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()
-- Retrieves a single product by its ID
SELECT TOP 1 ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products WHERE ProductId = @id;

-- Statement 5: Inventory.GetProductNameById(int id)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name
-- Retrieves only the name of a product by its ID
SELECT TOP 1 Name FROM dbo.Products WHERE ProductId = @id;

-- ============================================================================
-- SOURCE FILE: Services/ShoppingCart.cs (12 statements)
-- ============================================================================

-- Statement 6: ShoppingCart.GetCartItems()
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId).ToList()
-- Retrieves all cart items for a specific shopping cart
SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @ShoppingCartId;

-- Statement 7: ShoppingCart.GetCount()
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count).Sum()
-- Gets the total count of items in the cart
SELECT SUM(Count) FROM dbo.Carts WHERE CartId = @ShoppingCartId;

-- Statement 8: ShoppingCart.GetTotal()
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count * cartItems.Product.Price).Sum()
-- Gets the total price of all items in the cart
SELECT SUM(c.Count * p.Price) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.ProductId = p.ProductId WHERE c.CartId = @ShoppingCartId;

-- Statement 9: ShoppingCart.AddToCart - Select existing cart item
-- LINQ: _gadgetsOnlineEntities.Carts.SingleOrDefault(c => c.CartId == ShoppingCartId && c.ProductId == id)
-- Checks if a product already exists in the cart
SELECT TOP 1 RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @ShoppingCartId AND ProductId = @ProductId;

-- Statement 10: ShoppingCart.AddToCart - Insert new cart item
-- EF: _gadgetsOnlineEntities.Carts.Add(cartItem)
-- Inserts a new item into the cart
INSERT INTO dbo.Carts (CartId, ProductId, Count, DateCreated) VALUES (@CartId, @ProductId, @Count, @DateCreated);

-- Statement 11: ShoppingCart.RemoveFromCart - Select cart item
-- LINQ: _gadgetsOnlineEntities.Carts.Single(cart => cart.CartId == ShoppingCartId && cart.ProductId == id)
-- Gets a specific cart item for removal
SELECT TOP 1 RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @ShoppingCartId AND ProductId = @ProductId;

-- Statement 12: ShoppingCart.RemoveFromCart - Delete cart item (when count = 1)
-- EF: _gadgetsOnlineEntities.Carts.Remove(cartItem)
-- Removes a cart item when count reaches zero
DELETE FROM dbo.Carts WHERE RecordId = @RecordId;

-- Statement 13: ShoppingCart.RemoveFromCart - Update cart item (when count > 1)
-- EF: cartItem.Count-- then SaveChanges()
-- Decrements the count of a cart item
UPDATE dbo.Carts SET Count = Count - 1 WHERE RecordId = @RecordId;

-- Statement 14: ShoppingCart.EmptyCart - Select all cart items
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId)
-- Gets all items in the cart for emptying
SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @ShoppingCartId;

-- Statement 15: ShoppingCart.EmptyCart - Delete all cart items
-- EF: _gadgetsOnlineEntities.Carts.Remove(cartItem) in loop
-- Deletes all items from the cart
DELETE FROM dbo.Carts WHERE CartId = @ShoppingCartId;

-- Statement 16: ShoppingCart.CreateOrder - Insert order detail
-- EF: _gadgetsOnlineEntities.OrderDetails.Add(orderDetail)
-- Inserts a new order detail record
INSERT INTO dbo.OrderDetails (ProductId, OrderId, UnitPrice, Quantity) VALUES (@ProductId, @OrderId, @UnitPrice, @Quantity);

-- ============================================================================
-- SOURCE FILE: Services/OrderProcessing.cs (1 statement)
-- ============================================================================

-- Statement 17: OrderProcessing.ProcessOrder - Insert order
-- EF: _gadgetsOnlineEntities.Orders.Add(order)
-- Inserts a new order record
INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@OrderDate, @Username, @FirstName, @LastName, @Address, @City, @State, @PostalCode, @Country, @Phone, @Email, @Total);

-- ============================================================================
-- SOURCE FILE: Models/GadgetsOnlineInitializer.cs (2 statements)
-- ============================================================================

-- Statement 18: GadgetsOnlineInitializer.Seed - Insert Categories
-- EF: context.Categories.Add(c) in loop
-- Seeds initial category data
INSERT INTO dbo.Categories (CategoryId, Name, Description) VALUES (@CategoryId, @Name, @Description);

-- Statement 19: GadgetsOnlineInitializer.Seed - Insert Products
-- EF: context.Products.Add(p) in loop
-- Seeds initial product data
INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (@ProductId, @CategoryId, @Name, @Price, @ProductArtUrl);
