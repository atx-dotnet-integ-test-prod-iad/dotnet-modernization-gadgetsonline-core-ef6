-- ============================================================================
-- Converted SQL Statements Catalog (PostgreSQL)
-- Target: gadgetsonline_dbo schema (PostgreSQL)
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Tool: dms-mcp___statement_conversion_tool
-- DMS Migration Project: arn:aws:dms:us-east-1:789616364195:migration-project:73N4TGCKEFESJJWR43O334CC7U
-- DMS Database: GadgetsOnline, Schema: dbo, Region: us-east-1
-- DMS Error: Metadata model creation failed - The selected objects were not found
-- DMS Attempted: All 19 statements passed through DMS tool individually, all failed
-- Manual Conversion Applied: 2026-03-07
-- Manual Conversion Rules:
--   Schema: dbo -> gadgetsonline_dbo
--   All identifiers: lowercase
--   TOP N -> LIMIT N
--   NVARCHAR -> VARCHAR
--   DATETIME -> TIMESTAMP
--   IDENTITY -> SERIAL
-- ============================================================================

-- Statement 1: GetBestSellers (Inventory.cs)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original: SELECT TOP(@count) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products
-- DMS Timestamp: 2026-03-07T18:29:55, DMS Status: error
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products LIMIT @count;

-- Statement 2: GetAllCategories (Inventory.cs)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original: SELECT * FROM dbo.Categories
-- DMS Timestamp: 2026-03-07T18:30:19, DMS Status: error
SELECT * FROM gadgetsonline_dbo.categories;

-- Statement 3: GetAllProductsInCategory (Inventory.cs)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original: SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl FROM dbo.Products p INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @category
-- DMS Timestamp: 2026-03-07T18:30:42, DMS Status: error
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products p INNER JOIN gadgetsonline_dbo.categories c ON p.categoryid = c.categoryid WHERE c.name = @category;

-- Statement 4: GetProductById (Inventory.cs)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original: SELECT TOP 1 ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products WHERE ProductId = @id
-- DMS Timestamp: 2026-03-07T18:31:07, DMS Status: error
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;

-- Statement 5: GetProductNameById (Inventory.cs)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original: SELECT TOP 1 Name FROM dbo.Products WHERE ProductId = @id
-- DMS Timestamp: 2026-03-07T18:31:30, DMS Status: error
SELECT name FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;

-- Statement 6: CreateOrder - Insert OrderDetail (ShoppingCart.cs)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original: INSERT INTO dbo.OrderDetails (ProductId, OrderId, UnitPrice, Quantity) VALUES (@ProductId, @OrderId, @UnitPrice, @Quantity)
-- DMS Timestamp: 2026-03-07T18:31:53, DMS Status: error
INSERT INTO gadgetsonline_dbo.orderdetails (productid, orderid, unitprice, quantity) VALUES (@ProductId, @OrderId, @UnitPrice, @Quantity);

-- Statement 7: EmptyCart - Delete cart items (ShoppingCart.cs)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original: DELETE FROM dbo.Carts WHERE CartId = @CartId
-- DMS Timestamp: 2026-03-07T18:32:16, DMS Status: error
DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @CartId;

-- Statement 8: AddToCart - Find existing cart item (ShoppingCart.cs)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original: SELECT TOP 1 * FROM dbo.Carts WHERE CartId = @CartId AND ProductId = @ProductId
-- DMS Timestamp: 2026-03-07T18:32:40, DMS Status: error
SELECT * FROM gadgetsonline_dbo.carts WHERE cartid = @CartId AND productid = @ProductId LIMIT 1;

-- Statement 9: AddToCart - Insert new cart item (ShoppingCart.cs)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original: INSERT INTO dbo.Carts (ProductId, CartId, Count, DateCreated) VALUES (@ProductId, @CartId, 1, @DateCreated)
-- DMS Timestamp: 2026-03-07T18:33:03, DMS Status: error
INSERT INTO gadgetsonline_dbo.carts (productid, cartid, count, datecreated) VALUES (@ProductId, @CartId, 1, @DateCreated);

-- Statement 10: AddToCart - Update cart item count (ShoppingCart.cs)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original: UPDATE dbo.Carts SET Count = Count + 1 WHERE CartId = @CartId AND ProductId = @ProductId
-- DMS Timestamp: 2026-03-07T18:33:27, DMS Status: error
UPDATE gadgetsonline_dbo.carts SET count = count + 1 WHERE cartid = @CartId AND productid = @ProductId;

-- Statement 11: GetCount (ShoppingCart.cs)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original: SELECT SUM(Count) FROM dbo.Carts WHERE CartId = @CartId
-- DMS Timestamp: 2026-03-07T18:33:50, DMS Status: error
SELECT SUM(count) FROM gadgetsonline_dbo.carts WHERE cartid = @CartId;

-- Statement 12: RemoveFromCart - Find cart item (ShoppingCart.cs)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original: SELECT TOP 1 * FROM dbo.Carts WHERE CartId = @CartId AND ProductId = @ProductId
-- DMS Timestamp: 2026-03-07T18:32:40 (same statement as #8, re-attempted)
SELECT * FROM gadgetsonline_dbo.carts WHERE cartid = @CartId AND productid = @ProductId LIMIT 1;

-- Statement 13: RemoveFromCart - Decrement count (ShoppingCart.cs)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original: UPDATE dbo.Carts SET Count = Count - 1 WHERE CartId = @CartId AND ProductId = @ProductId
-- DMS Timestamp: 2026-03-07T18:34:13, DMS Status: error
UPDATE gadgetsonline_dbo.carts SET count = count - 1 WHERE cartid = @CartId AND productid = @ProductId;

-- Statement 14: RemoveFromCart - Delete cart item (ShoppingCart.cs)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original: DELETE FROM dbo.Carts WHERE CartId = @CartId AND ProductId = @ProductId
-- DMS Timestamp: 2026-03-07T18:34:36, DMS Status: error
DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @CartId AND productid = @ProductId;

-- Statement 15: GetCartItems (ShoppingCart.cs)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original: SELECT * FROM dbo.Carts WHERE CartId = @CartId
-- DMS Timestamp: 2026-03-07T18:35:03, DMS Status: error
SELECT * FROM gadgetsonline_dbo.carts WHERE cartid = @CartId;

-- Statement 16: GetTotal (ShoppingCart.cs)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original: SELECT SUM(c.Count * p.Price) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.ProductId = p.ProductId WHERE c.CartId = @CartId
-- DMS Timestamp: 2026-03-07T18:35:26, DMS Status: error
SELECT SUM(c.count * p.price) FROM gadgetsonline_dbo.carts c INNER JOIN gadgetsonline_dbo.products p ON c.productid = p.productid WHERE c.cartid = @CartId;

-- Statement 17: ProcessOrder - Insert order (OrderProcessing.cs)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original: INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@OrderDate, @Username, @FirstName, @LastName, @Address, @City, @State, @PostalCode, @Country, @Phone, @Email, @Total)
-- DMS Timestamp: 2026-03-07T18:35:50, DMS Status: error
INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@OrderDate, @Username, @FirstName, @LastName, @Address, @City, @State, @PostalCode, @Country, @Phone, @Email, @Total);

-- Statement 18: Seed - Insert categories (GadgetsOnlineInitializer.cs)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original: INSERT INTO dbo.Categories (CategoryId, Name, Description) VALUES (@CategoryId, @Name, @Description)
-- DMS Timestamp: 2026-03-07T18:36:15, DMS Status: error
INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description) VALUES (@CategoryId, @Name, @Description);

-- Statement 19: Seed - Insert products (GadgetsOnlineInitializer.cs)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original: INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (@ProductId, @CategoryId, @Name, @Price, @ProductArtUrl)
-- DMS Timestamp: 2026-03-07T18:36:38, DMS Status: error
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (@ProductId, @CategoryId, @Name, @Price, @ProductArtUrl);
