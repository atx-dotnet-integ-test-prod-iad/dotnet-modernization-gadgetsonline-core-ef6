-- =====================================================
-- Converted SQL Statements for PostgreSQL - GadgetsOnline Application
-- Total Statements: 17
-- DMS Tool Status: ALL 17 statements attempted through DMS - ALL FAILED
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Manual Conversion Rules Applied:
--   1. Schema mapping: dbo.* -> gadgetsonline_dbo.*
--   2. All table names converted to lowercase
--   3. All column names converted to lowercase
--   4. SQL Server TOP N -> PostgreSQL LIMIT N
--   5. SQL Server GETDATE() -> PostgreSQL NOW()
-- Target Schema: gadgetsonline_dbo (PostgreSQL)
-- Date: 2026-03-21
-- DMS Attempt Timestamp: 2026-03-21T05:08-05:15
-- =====================================================

-- =====================================================
-- Statement 1: GetBestSellers (Inventory.cs)
-- Source File: Services/Inventory.cs
-- Method: GetBestSellers(int count)
-- Original MS SQL: SELECT TOP (@count) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products;
-- DMS Status: FAILED - Metadata model creation failed: No objects were found according to the specified selection rules
-- DMS Timestamp: 2026-03-21T05:08:31.189750
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- =====================================================
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products LIMIT @count;

-- =====================================================
-- Statement 2: GetAllCategories (Inventory.cs)
-- Source File: Services/Inventory.cs
-- Method: GetAllCategories()
-- Original MS SQL: SELECT CategoryId, Name, Description FROM dbo.Categories;
-- DMS Status: FAILED - Metadata model creation failed: No objects were found according to the specified selection rules
-- DMS Timestamp: 2026-03-21T05:08:54.777788
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- =====================================================
SELECT categoryid, name, description FROM gadgetsonline_dbo.categories;

-- =====================================================
-- Statement 3: GetAllProductsInCategory (Inventory.cs)
-- Source File: Services/Inventory.cs
-- Method: GetAllProductsInCategory(string category)
-- Original MS SQL: SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl FROM dbo.Products p INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @categoryName;
-- DMS Status: FAILED - Metadata model creation failed: No objects were found according to the specified selection rules
-- DMS Timestamp: 2026-03-21T05:09:17.542587
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- =====================================================
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products p INNER JOIN gadgetsonline_dbo.categories c ON p.categoryid = c.categoryid WHERE c.name = @categoryName;

-- =====================================================
-- Statement 4: GetProductById (Inventory.cs)
-- Source File: Services/Inventory.cs
-- Method: GetProductById(int id)
-- Original MS SQL: SELECT TOP 1 ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products WHERE ProductId = @id;
-- DMS Status: FAILED - Metadata model creation failed: No objects were found according to the specified selection rules
-- DMS Timestamp: 2026-03-21T05:09:40.325323
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- =====================================================
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;

-- =====================================================
-- Statement 5: GetProductNameById (Inventory.cs)
-- Source File: Services/Inventory.cs
-- Method: GetProductNameById(int id)
-- Original MS SQL: SELECT TOP 1 Name FROM dbo.Products WHERE ProductId = @id;
-- DMS Status: FAILED - Metadata model creation failed: No objects were found according to the specified selection rules
-- DMS Timestamp: 2026-03-21T05:10:02.833061
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- =====================================================
SELECT name FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;

-- =====================================================
-- Statement 6: GetCartItems (ShoppingCart.cs)
-- Source File: Services/ShoppingCart.cs
-- Method: GetCartItems()
-- Original MS SQL: SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId;
-- DMS Status: FAILED - Metadata model creation failed: No objects were found according to the specified selection rules
-- DMS Timestamp: 2026-03-21T05:10:26.142108
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- =====================================================
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;

-- =====================================================
-- Statement 7: GetCount (ShoppingCart.cs)
-- Source File: Services/ShoppingCart.cs
-- Method: GetCount()
-- Original MS SQL: SELECT COALESCE(SUM(Count), 0) FROM dbo.Carts WHERE CartId = @cartId;
-- DMS Status: FAILED - Metadata model creation failed: No objects were found according to the specified selection rules
-- DMS Timestamp: 2026-03-21T05:10:50.184743
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- =====================================================
SELECT COALESCE(SUM(count), 0) FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;

-- =====================================================
-- Statement 8: GetTotal (ShoppingCart.cs)
-- Source File: Services/ShoppingCart.cs
-- Method: GetTotal()
-- Original MS SQL: SELECT COALESCE(SUM(c.Count * p.Price), 0) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.ProductId = p.ProductId WHERE c.CartId = @cartId;
-- DMS Status: FAILED - Metadata model creation failed: No objects were found according to the specified selection rules
-- DMS Timestamp: 2026-03-21T05:11:13.558055
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- =====================================================
SELECT COALESCE(SUM(c.count * p.price), 0) FROM gadgetsonline_dbo.carts c INNER JOIN gadgetsonline_dbo.products p ON c.productid = p.productid WHERE c.cartid = @cartId;

-- =====================================================
-- Statement 9: AddToCart - Insert new item (ShoppingCart.cs)
-- Source File: Services/ShoppingCart.cs
-- Method: AddToCart(int id) - when item doesn't exist in cart
-- Original MS SQL: INSERT INTO dbo.Carts (CartId, ProductId, Count, DateCreated) VALUES (@cartId, @productId, 1, GETDATE());
-- DMS Status: FAILED - Metadata model creation failed: No objects were found according to the specified selection rules
-- DMS Timestamp: 2026-03-21T05:11:40.220985
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- =====================================================
INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated) VALUES (@cartId, @productId, 1, NOW());

-- =====================================================
-- Statement 10: AddToCart - Update existing item (ShoppingCart.cs)
-- Source File: Services/ShoppingCart.cs
-- Method: AddToCart(int id) - when item already exists in cart
-- Original MS SQL: UPDATE dbo.Carts SET Count = Count + 1 WHERE CartId = @cartId AND ProductId = @productId;
-- DMS Status: FAILED - Metadata model creation failed: No objects were found according to the specified selection rules
-- DMS Timestamp: 2026-03-21T05:12:02.953185
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- =====================================================
UPDATE gadgetsonline_dbo.carts SET count = count + 1 WHERE cartid = @cartId AND productid = @productId;

-- =====================================================
-- Statement 11: RemoveFromCart - Delete item (ShoppingCart.cs)
-- Source File: Services/ShoppingCart.cs
-- Method: RemoveFromCart(int id) - when Count <= 1
-- Original MS SQL: DELETE FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @productId;
-- DMS Status: FAILED - Metadata model creation failed: No objects were found according to the specified selection rules
-- DMS Timestamp: 2026-03-21T05:12:34.723473
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- =====================================================
DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @cartId AND productid = @productId;

-- =====================================================
-- Statement 12: RemoveFromCart - Decrement count (ShoppingCart.cs)
-- Source File: Services/ShoppingCart.cs
-- Method: RemoveFromCart(int id) - when Count > 1
-- Original MS SQL: UPDATE dbo.Carts SET Count = Count - 1 WHERE CartId = @cartId AND ProductId = @productId;
-- DMS Status: FAILED - Metadata model creation failed: No objects were found according to the specified selection rules
-- DMS Timestamp: 2026-03-21T05:12:58.602892
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- =====================================================
UPDATE gadgetsonline_dbo.carts SET count = count - 1 WHERE cartid = @cartId AND productid = @productId;

-- =====================================================
-- Statement 13: EmptyCart (ShoppingCart.cs)
-- Source File: Services/ShoppingCart.cs
-- Method: EmptyCart()
-- Original MS SQL: DELETE FROM dbo.Carts WHERE CartId = @cartId;
-- DMS Status: FAILED - Metadata model creation failed: No objects were found according to the specified selection rules
-- DMS Timestamp: 2026-03-21T05:13:21.756368
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- =====================================================
DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;

-- =====================================================
-- Statement 14: CreateOrder - Insert order details (ShoppingCart.cs)
-- Source File: Services/ShoppingCart.cs
-- Method: CreateOrder(Order order)
-- Original MS SQL: INSERT INTO dbo.OrderDetails (OrderId, ProductId, Quantity, UnitPrice) VALUES (@orderId, @productId, @quantity, @unitPrice);
-- DMS Status: FAILED - Metadata model creation failed: No objects were found according to the specified selection rules
-- DMS Timestamp: 2026-03-21T05:13:44.541403
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- =====================================================
INSERT INTO gadgetsonline_dbo.orderdetails (orderid, productid, quantity, unitprice) VALUES (@orderId, @productId, @quantity, @unitPrice);

-- =====================================================
-- Statement 15: ProcessOrder - Insert order (OrderProcessing.cs)
-- Source File: Services/OrderProcessing.cs
-- Method: ProcessOrder(Order order, HttpContext httpContext)
-- Original MS SQL: INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);
-- DMS Status: FAILED - Metadata model creation failed: No objects were found according to the specified selection rules
-- DMS Timestamp: 2026-03-21T05:14:08.396639
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- =====================================================
INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);

-- =====================================================
-- Statement 16: Seed Categories (GadgetsOnlineInitializer.cs)
-- Source File: Models/GadgetsOnlineInitializer.cs
-- Method: Seed(GadgetsOnlineEntities context)
-- Original MS SQL: INSERT INTO dbo.Categories (CategoryId, Name, Description) VALUES (@categoryId, @name, @description);
-- DMS Status: FAILED - Metadata model creation failed: No objects were found according to the specified selection rules
-- DMS Timestamp: 2026-03-21T05:14:32.619441
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- =====================================================
INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description) VALUES (@categoryId, @name, @description);

-- =====================================================
-- Statement 17: Seed Products (GadgetsOnlineInitializer.cs)
-- Source File: Models/GadgetsOnlineInitializer.cs
-- Method: Seed(GadgetsOnlineEntities context)
-- Original MS SQL: INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (@productId, @categoryId, @name, @price, @productArtUrl);
-- DMS Status: FAILED - Metadata model creation failed: No objects were found according to the specified selection rules
-- DMS Timestamp: 2026-03-21T05:14:55.734137
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- =====================================================
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (@productId, @categoryId, @name, @price, @productArtUrl);
