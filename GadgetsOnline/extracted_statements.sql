-- ============================================================================
-- Extracted SQL Statements Catalog
-- Application: GadgetsOnline (ASP.NET Core 8.0 with EF6)
-- Source Database: Microsoft SQL Server 2019
-- Extraction Method: Logical SQL representations from EF6 LINQ operations
-- Total Statements: 13
-- ============================================================================

-- ============================================================================
-- Source: Services/Inventory.cs
-- ============================================================================

-- Statement 1: GetBestSellers(int count)
-- LINQ: _gadgetsOnlineEntities.Products.Take(count).ToList()
SELECT TOP(@count) productid, categoryid, name, price, productarturl FROM dbo.Products;

-- Statement 2: GetAllCategories()
-- LINQ: _gadgetsOnlineEntities.Categories.ToList()
SELECT categoryid, name, description FROM dbo.Categories;

-- Statement 3: GetAllProductsInCategory(string category)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM dbo.Products p INNER JOIN dbo.Categories c ON p.categoryid = c.categoryid WHERE c.name = @category;

-- Statement 4: GetProductById(int id)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()
SELECT TOP 1 productid, categoryid, name, price, productarturl FROM dbo.Products WHERE productid = @id;

-- Statement 5: GetProductNameById(int id)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name
SELECT TOP 1 name FROM dbo.Products WHERE productid = @id;

-- ============================================================================
-- Source: Services/ShoppingCart.cs
-- ============================================================================

-- Statement 6: AddToCart(int id) - lookup existing cart item
-- LINQ: _gadgetsOnlineEntities.Carts.SingleOrDefault(c => c.CartId == ShoppingCartId && c.ProductId == id)
SELECT TOP 1 recordid, cartid, productid, count, datecreated FROM dbo.Carts WHERE cartid = @cartid AND productid = @productid;

-- Statement 7: AddToCart(int id) - insert new cart item
-- LINQ: _gadgetsOnlineEntities.Carts.Add(cartItem)
INSERT INTO dbo.Carts (cartid, productid, count, datecreated) VALUES (@cartid, @productid, @count, @datecreated);

-- Statement 8: GetCount() - sum of cart item counts
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count).Sum()
SELECT SUM(count) FROM dbo.Carts WHERE cartid = @cartid;

-- Statement 9: RemoveFromCart/EmptyCart - delete cart item
-- LINQ: _gadgetsOnlineEntities.Carts.Remove(cartItem)
DELETE FROM dbo.Carts WHERE recordid = @recordid;

-- Statement 10: GetCartItems/EmptyCart - select cart items
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId)
SELECT recordid, cartid, productid, count, datecreated FROM dbo.Carts WHERE cartid = @cartid;

-- Statement 11: GetTotal() - sum of cart totals with product price
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count * cartItems.Product.Price).Sum()
SELECT SUM(c.count * p.price) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.productid = p.productid WHERE c.cartid = @cartid;

-- Statement 12: CreateOrder - insert order detail
-- LINQ: _gadgetsOnlineEntities.OrderDetails.Add(orderDetail)
INSERT INTO dbo.OrderDetails (productid, orderid, unitprice, quantity) VALUES (@productid, @orderid, @unitprice, @quantity);

-- ============================================================================
-- Source: Services/OrderProcessing.cs
-- ============================================================================

-- Statement 13: ProcessOrder - insert order
-- LINQ: _gadgetsOnlineEntities.Orders.Add(order)
INSERT INTO dbo.Orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@orderdate, @username, @firstname, @lastname, @address, @city, @state, @postalcode, @country, @phone, @email, @total);
