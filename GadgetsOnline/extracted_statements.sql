-- ============================================================================
-- EXTRACTED SQL STATEMENTS CATALOG
-- Source: GadgetsOnline .NET Application (EF6 LINQ Queries)
-- Target: DMS MCP Conversion Tool Processing
-- Total Statements: 16
-- ============================================================================

-- ============================================================================
-- SOURCE FILE: Services/Inventory.cs
-- ============================================================================

-- Statement 1
-- Method: GetBestSellers(int count)
-- LINQ: _gadgetsOnlineEntities.Products.Take(count).ToList()
-- Description: Retrieves top N products as best sellers
SELECT TOP(@p0) * FROM [dbo].[Products]

-- Statement 2
-- Method: GetAllCategories()
-- LINQ: _gadgetsOnlineEntities.Categories.ToList()
-- Description: Retrieves all categories
SELECT * FROM [dbo].[Categories]

-- Statement 3
-- Method: GetAllProductsInCategory(string category)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()
-- Description: Retrieves all products in a given category by joining Products and Categories
SELECT * FROM [dbo].[Products] p INNER JOIN [dbo].[Categories] c ON p.CategoryId = c.CategoryId WHERE c.Name = @p0

-- Statement 4
-- Method: GetProductById(int id)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()
-- Description: Retrieves a single product by its ID
SELECT TOP(1) * FROM [dbo].[Products] WHERE ProductId = @p0

-- Statement 5
-- Method: GetProductNameById(int id)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name
-- Description: Retrieves a product name by product ID (fetches product first, then accesses Name)
SELECT TOP(1) * FROM [dbo].[Products] WHERE ProductId = @p0

-- ============================================================================
-- SOURCE FILE: Services/ShoppingCart.cs
-- ============================================================================

-- Statement 6
-- Method: GetCartItems()
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId).ToList()
-- Description: Retrieves all cart items for a given shopping cart ID
SELECT * FROM [dbo].[Carts] WHERE CartId = @p0

-- Statement 7
-- Method: GetCount()
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count).Sum()
-- Description: Gets the total count of items in the shopping cart
SELECT SUM(Count) FROM [dbo].[Carts] WHERE CartId = @p0

-- Statement 8
-- Method: GetTotal()
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count * cartItems.Product.Price).Sum()
-- Description: Gets the total price of items in the shopping cart by joining Carts and Products
SELECT SUM(c.Count * p.Price) FROM [dbo].[Carts] c INNER JOIN [dbo].[Products] p ON c.ProductId = p.ProductId WHERE c.CartId = @p0

-- Statement 9
-- Method: AddToCart(int id) - SELECT part
-- LINQ: _gadgetsOnlineEntities.Carts.SingleOrDefault(c => c.CartId == ShoppingCartId && c.ProductId == id)
-- Description: Checks if a cart item already exists for the given cart and product
SELECT * FROM [dbo].[Carts] WHERE CartId = @p0 AND ProductId = @p1

-- Statement 10
-- Method: AddToCart(int id) - INSERT part
-- Code: _gadgetsOnlineEntities.Carts.Add(cartItem) with new Cart { ProductId, CartId, Count, DateCreated }
-- Description: Inserts a new cart item when the product is not yet in the cart
INSERT INTO [dbo].[Carts] (CartId, ProductId, Count, DateCreated) VALUES (@p0, @p1, @p2, @p3)

-- Statement 11
-- Method: RemoveFromCart(int id)
-- Code: _gadgetsOnlineEntities.Carts.Remove(cartItem)
-- Description: Deletes a cart item when its count reaches zero
DELETE FROM [dbo].[Carts] WHERE RecordId = @p0

-- Statement 12
-- Method: EmptyCart()
-- Code: _gadgetsOnlineEntities.Carts.Remove(cartItem) in a loop
-- Description: Deletes all cart items for a given shopping cart ID
DELETE FROM [dbo].[Carts] WHERE CartId = @p0

-- Statement 13
-- Method: CreateOrder(Order order) - INSERT OrderDetails
-- Code: _gadgetsOnlineEntities.OrderDetails.Add(orderDetail)
-- Description: Inserts order details for each cart item during order creation
INSERT INTO [dbo].[OrderDetails] (ProductId, OrderId, UnitPrice, Quantity) VALUES (@p0, @p1, @p2, @p3)

-- ============================================================================
-- SOURCE FILE: Services/OrderProcessing.cs
-- ============================================================================

-- Statement 14
-- Method: ProcessOrder(Order order, HttpContext httpContext)
-- Code: _gadgetsOnlineEntities.Orders.Add(order)
-- Description: Inserts a new order during order processing
INSERT INTO [dbo].[Orders] (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@p0, @p1, @p2, @p3, @p4, @p5, @p6, @p7, @p8, @p9, @p10, @p11)

-- ============================================================================
-- SOURCE FILE: Models/GadgetsOnlineInitializer.cs
-- ============================================================================

-- Statement 15
-- Method: Seed(GadgetsOnlineEntities context) - Categories
-- Code: categories.ForEach(c => context.Categories.Add(c))
-- Description: Seeds initial category data during database initialization
INSERT INTO [dbo].[Categories] (CategoryId, Name, Description) VALUES (@p0, @p1, @p2)

-- Statement 16
-- Method: Seed(GadgetsOnlineEntities context) - Products
-- Code: products.ForEach(p => context.Products.Add(p))
-- Description: Seeds initial product data during database initialization
INSERT INTO [dbo].[Products] (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (@p0, @p1, @p2, @p3, @p4)

-- ============================================================================
-- END OF EXTRACTED STATEMENTS CATALOG
-- Total: 16 statements extracted
-- ============================================================================
