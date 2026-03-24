-- ============================================================================
-- Converted SQL Statements Catalog (PostgreSQL)
-- Application: GadgetsOnline (ASP.NET Core 8.0 with EF6)
-- Target Database: PostgreSQL 13
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Failure Reason: Metadata model creation failed - No objects found
-- Total Statements: 13
-- ============================================================================

-- ============================================================================
-- Source: Services/Inventory.cs
-- ============================================================================

-- Statement 1: GetBestSellers(int count)
-- Original: SELECT TOP(@count) productid, categoryid, name, price, productarturl FROM dbo.Products
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products LIMIT @count;

-- Statement 2: GetAllCategories()
-- Original: SELECT categoryid, name, description FROM dbo.Categories
SELECT categoryid, name, description FROM gadgetsonline_dbo.categories;

-- Statement 3: GetAllProductsInCategory(string category)
-- Original: SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM dbo.Products p INNER JOIN dbo.Categories c ON p.categoryid = c.categoryid WHERE c.name = @category
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products p INNER JOIN gadgetsonline_dbo.categories c ON p.categoryid = c.categoryid WHERE c.name = @category;

-- Statement 4: GetProductById(int id)
-- Original: SELECT TOP 1 productid, categoryid, name, price, productarturl FROM dbo.Products WHERE productid = @id
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;

-- Statement 5: GetProductNameById(int id)
-- Original: SELECT TOP 1 name FROM dbo.Products WHERE productid = @id
SELECT name FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;

-- ============================================================================
-- Source: Services/ShoppingCart.cs
-- ============================================================================

-- Statement 6: AddToCart(int id) - lookup existing cart item
-- Original: SELECT TOP 1 recordid, cartid, productid, count, datecreated FROM dbo.Carts WHERE cartid = @cartid AND productid = @productid
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @cartid AND productid = @productid LIMIT 1;

-- Statement 7: AddToCart(int id) - insert new cart item
-- Original: INSERT INTO dbo.Carts (cartid, productid, count, datecreated) VALUES (@cartid, @productid, @count, @datecreated)
INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated) VALUES (@cartid, @productid, @count, @datecreated);

-- Statement 8: GetCount() - sum of cart item counts
-- Original: SELECT SUM(count) FROM dbo.Carts WHERE cartid = @cartid
SELECT SUM(count) FROM gadgetsonline_dbo.carts WHERE cartid = @cartid;

-- Statement 9: RemoveFromCart/EmptyCart - delete cart item
-- Original: DELETE FROM dbo.Carts WHERE recordid = @recordid
DELETE FROM gadgetsonline_dbo.carts WHERE recordid = @recordid;

-- Statement 10: GetCartItems/EmptyCart - select cart items
-- Original: SELECT recordid, cartid, productid, count, datecreated FROM dbo.Carts WHERE cartid = @cartid
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @cartid;

-- Statement 11: GetTotal() - sum of cart totals with product price
-- Original: SELECT SUM(c.count * p.price) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.productid = p.productid WHERE c.cartid = @cartid
SELECT SUM(c.count * p.price) FROM gadgetsonline_dbo.carts c INNER JOIN gadgetsonline_dbo.products p ON c.productid = p.productid WHERE c.cartid = @cartid;

-- Statement 12: CreateOrder - insert order detail
-- Original: INSERT INTO dbo.OrderDetails (productid, orderid, unitprice, quantity) VALUES (@productid, @orderid, @unitprice, @quantity)
INSERT INTO gadgetsonline_dbo.orderdetails (productid, orderid, unitprice, quantity) VALUES (@productid, @orderid, @unitprice, @quantity);

-- ============================================================================
-- Source: Services/OrderProcessing.cs
-- ============================================================================

-- Statement 13: ProcessOrder - insert order
-- Original: INSERT INTO dbo.Orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@orderdate, @username, @firstname, @lastname, @address, @city, @state, @postalcode, @country, @phone, @email, @total)
INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@orderdate, @username, @firstname, @lastname, @address, @city, @state, @postalcode, @country, @phone, @email, @total);
