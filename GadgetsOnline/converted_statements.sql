-- =====================================================
-- Converted SQL Statements Catalog (PostgreSQL)
-- Source: GadgetsOnline .NET Application (Entity Framework LINQ)
-- Date: 2026-03-26
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed - No objects were found according to the specified selection rules
-- Rules Applied:
--   - Table/column names converted to lowercase
--   - Schema mapped from dbo to gadgetsonline_dbo
--   - TOP(N) converted to LIMIT N
--   - SQL logic and structure preserved
-- Total Statements: 20
-- =====================================================

-- Statement 1: INSERT Category (from GadgetsOnlineInitializer.cs Seed method)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description) VALUES (1, 'Mobile Phones', 'Latest collection of Mobile Phones');

-- Statement 2: INSERT Product (from GadgetsOnlineInitializer.cs Seed method)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (1, 1, 'Phone 12', 699.00, '/Content/Images/Mobile/1.jpg');

-- Statement 3: SELECT Products with LIMIT (from Inventory.GetBestSellers)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA (TOP(@p0) -> LIMIT @p0)
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products LIMIT @p0;

-- Statement 4: SELECT All Categories (from Inventory.GetAllCategories)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT categoryid, name, description FROM gadgetsonline_dbo.categories;

-- Statement 5: SELECT Products by Category Name (from Inventory.GetAllProductsInCategory)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products p INNER JOIN gadgetsonline_dbo.categories c ON p.categoryid = c.categoryid WHERE c.name = @p0;

-- Statement 6: SELECT Product by Id (from Inventory.GetProductById)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA (TOP(1) -> LIMIT 1)
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products WHERE productid = @p0 LIMIT 1;

-- Statement 7: SELECT Product Name by Id (from Inventory.GetProductNameById)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA (TOP(1) -> LIMIT 1)
SELECT name FROM gadgetsonline_dbo.products WHERE productid = @p0 LIMIT 1;

-- Statement 8: SELECT Cart Items by CartId (from ShoppingCart.GetCartItems)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @p0;

-- Statement 9: SELECT Single Cart Item (from ShoppingCart.AddToCart - SingleOrDefault)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA (TOP(1) -> LIMIT 1)
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @p0 AND productid = @p1 LIMIT 1;

-- Statement 10: INSERT Cart Item (from ShoppingCart.AddToCart)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated) VALUES (@p0, @p1, @p2, @p3);

-- Statement 11: UPDATE Cart Item Count (from ShoppingCart.AddToCart - cartItem.Count++)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
UPDATE gadgetsonline_dbo.carts SET count = @p0 WHERE recordid = @p1;

-- Statement 12: SELECT SUM of Cart Count (from ShoppingCart.GetCount)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT SUM(count) FROM gadgetsonline_dbo.carts WHERE cartid = @p0;

-- Statement 13: SELECT SUM of Cart Total (from ShoppingCart.GetTotal)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT SUM(c.count * p.price) FROM gadgetsonline_dbo.carts c INNER JOIN gadgetsonline_dbo.products p ON c.productid = p.productid WHERE c.cartid = @p0;

-- Statement 14: DELETE Cart Items by CartId (from ShoppingCart.EmptyCart)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @p0;

-- Statement 15: SELECT Cart Item for Remove (from ShoppingCart.RemoveFromCart - Single)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA (TOP(1) -> LIMIT 1)
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @p0 AND productid = @p1 ORDER BY recordid LIMIT 1;

-- Statement 16: DELETE Single Cart Item (from ShoppingCart.RemoveFromCart)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
DELETE FROM gadgetsonline_dbo.carts WHERE recordid = @p0;

-- Statement 17: INSERT Order Detail (from ShoppingCart.CreateOrder)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
INSERT INTO gadgetsonline_dbo.orderdetails (orderid, productid, quantity, unitprice) VALUES (@p0, @p1, @p2, @p3);

-- Statement 18: UPDATE Order Total (from ShoppingCart.CreateOrder)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
UPDATE gadgetsonline_dbo.orders SET total = @p0 WHERE orderid = @p1;

-- Statement 19: INSERT Order (from OrderProcessing.ProcessOrder)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@p0, @p1, @p2, @p3, @p4, @p5, @p6, @p7, @p8, @p9, @p10, @p11);

-- Statement 20: SELECT Order Details by OrderId (from EF navigation property loading)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT orderdetailid, orderid, productid, quantity, unitprice FROM gadgetsonline_dbo.orderdetails WHERE orderid = @p0;
