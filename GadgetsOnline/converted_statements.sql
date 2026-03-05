-- ============================================================================
-- Converted SQL Statements Catalog (PostgreSQL)
-- Target Database: PostgreSQL with gadgetsonline_dbo schema (lowercase)
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Date: 2026-03-05
-- ============================================================================
-- NOTE: ALL statements were attempted through the DMS MCP tool first.
-- ALL DMS conversion attempts failed with error:
--   "Metadata model creation failed: The selected objects were not found."
-- Manual conversion was applied with lowercase schema mapping per transformation rules.
-- ============================================================================

-- Statement 1: Inventory.GetBestSellers (Inventory.cs)
-- Original: SELECT TOP(@count) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products LIMIT @count;

-- Statement 2: Inventory.GetAllCategories (Inventory.cs)
-- Original: SELECT CategoryId, Name, Description FROM dbo.Categories
SELECT categoryid, name, description FROM gadgetsonline_dbo.categories;

-- Statement 3: Inventory.GetAllProductsInCategory (Inventory.cs)
-- Original: SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl FROM dbo.Products p INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @category
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products p INNER JOIN gadgetsonline_dbo.categories c ON p.categoryid = c.categoryid WHERE c.name = @category;

-- Statement 4: Inventory.GetProductById (Inventory.cs)
-- Original: SELECT TOP 1 ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products WHERE ProductId = @id
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;

-- Statement 5: Inventory.GetProductNameById (Inventory.cs)
-- Original: SELECT TOP 1 Name FROM dbo.Products WHERE ProductId = @id
SELECT name FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;

-- Statement 6: ShoppingCart.GetCartItems (ShoppingCart.cs)
-- Original: SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;

-- Statement 7: ShoppingCart.GetCount (ShoppingCart.cs)
-- Original: SELECT COALESCE(SUM(Count), 0) FROM dbo.Carts WHERE CartId = @cartId
SELECT COALESCE(SUM(count), 0) FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;

-- Statement 8: ShoppingCart.GetTotal (ShoppingCart.cs)
-- Original: SELECT COALESCE(SUM(c.Count * p.Price), 0) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.ProductId = p.ProductId WHERE c.CartId = @cartId
SELECT COALESCE(SUM(c.count * p.price), 0) FROM gadgetsonline_dbo.carts c INNER JOIN gadgetsonline_dbo.products p ON c.productid = p.productid WHERE c.cartid = @cartId;

-- Statement 9: ShoppingCart.AddToCart - SELECT (ShoppingCart.cs)
-- Original: SELECT TOP 1 RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @productId
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @cartId AND productid = @productId LIMIT 1;

-- Statement 10: ShoppingCart.AddToCart - INSERT (ShoppingCart.cs)
-- Original: INSERT INTO dbo.Carts (CartId, ProductId, Count, DateCreated) VALUES (@cartId, @productId, 1, GETDATE())
INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated) VALUES (@cartId, @productId, 1, NOW());

-- Statement 11: ShoppingCart.AddToCart - UPDATE (ShoppingCart.cs)
-- Original: UPDATE dbo.Carts SET Count = Count + 1 WHERE CartId = @cartId AND ProductId = @productId
UPDATE gadgetsonline_dbo.carts SET count = count + 1 WHERE cartid = @cartId AND productid = @productId;

-- Statement 12: ShoppingCart.RemoveFromCart - SELECT (ShoppingCart.cs)
-- Original: SELECT TOP 1 RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @id
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @cartId AND productid = @id LIMIT 1;

-- Statement 13: ShoppingCart.RemoveFromCart - UPDATE (count > 1) (ShoppingCart.cs)
-- Original: UPDATE dbo.Carts SET Count = Count - 1 WHERE CartId = @cartId AND ProductId = @id
UPDATE gadgetsonline_dbo.carts SET count = count - 1 WHERE cartid = @cartId AND productid = @id;

-- Statement 14: ShoppingCart.RemoveFromCart - DELETE (count <= 1) (ShoppingCart.cs)
-- Original: DELETE FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @id
DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @cartId AND productid = @id;

-- Statement 15: ShoppingCart.EmptyCart - DELETE (ShoppingCart.cs)
-- Original: DELETE FROM dbo.Carts WHERE CartId = @cartId
DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;

-- Statement 16: ShoppingCart.CreateOrder - INSERT OrderDetails (ShoppingCart.cs)
-- Original: INSERT INTO dbo.OrderDetails (OrderId, ProductId, Quantity, UnitPrice) VALUES (@orderId, @productId, @quantity, @unitPrice)
INSERT INTO gadgetsonline_dbo.orderdetails (orderid, productid, quantity, unitprice) VALUES (@orderId, @productId, @quantity, @unitPrice);

-- Statement 17: OrderProcessing.ProcessOrder - INSERT Orders (OrderProcessing.cs)
-- Original: INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total)
INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);
