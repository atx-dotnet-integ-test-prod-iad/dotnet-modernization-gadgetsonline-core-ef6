-- ============================================================================
-- CONVERTED SQL STATEMENTS - GadgetsOnline Application (PostgreSQL)
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed - No objects found per selection rules
-- All 19 statements attempted through DMS MCP tool (2026-03-23T12:43-12:50 UTC)
-- All 19 DMS attempts returned error: "Metadata model creation failed: No objects
--   were found according to the specified selection rules."
-- Manual conversion applied with lowercase schema object names per TD guidelines
-- Schema mapping: dbo -> gadgetsonline_dbo (lowercase)
-- Date: 2026-03-23 (Re-attempted Step 1)
-- ============================================================================

-- ============================================================================
-- SOURCE FILE: Services/Inventory.cs
-- ============================================================================

-- Statement 1: GetBestSellers(int count)
-- DMS Attempt: FAILED (2026-03-23T12:43:11 UTC) - Metadata model creation failed
-- Manual Conversion: TOP(@count) -> LIMIT @count, lowercase schema/columns
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products LIMIT @count;

-- Statement 2: GetAllCategories()
-- DMS Attempt: FAILED (2026-03-23T12:43:38 UTC) - Metadata model creation failed
-- Manual Conversion: lowercase schema/columns
SELECT categoryid, name, description FROM gadgetsonline_dbo.categories;

-- Statement 3: GetAllProductsInCategory(string category)
-- DMS Attempt: FAILED (2026-03-23T12:44:01 UTC) - Metadata model creation failed
-- Manual Conversion: lowercase schema/columns/aliases
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products p INNER JOIN gadgetsonline_dbo.categories c ON p.categoryid = c.categoryid WHERE c.name = @category;

-- Statement 4: GetProductById(int id)
-- DMS Attempt: FAILED (2026-03-23T12:44:25 UTC) - Metadata model creation failed
-- Manual Conversion: TOP(1) -> LIMIT 1, lowercase schema/columns
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;

-- Statement 5: GetProductNameById(int id)
-- DMS Attempt: FAILED (2026-03-23T12:44:49 UTC) - Metadata model creation failed
-- Manual Conversion: TOP(1) -> LIMIT 1, lowercase schema/columns
SELECT name FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;

-- ============================================================================
-- SOURCE FILE: Services/ShoppingCart.cs
-- ============================================================================

-- Statement 6: AddToCart - Select existing cart item
-- DMS Attempt: FAILED (2026-03-23T12:45:14 UTC) - Metadata model creation failed
-- Manual Conversion: TOP(1) -> LIMIT 1, lowercase schema/columns
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @cartId AND productid = @productId LIMIT 1;

-- Statement 7: AddToCart - Insert new cart item
-- DMS Attempt: FAILED (2026-03-23T12:45:38 UTC) - Metadata model creation failed
-- Manual Conversion: lowercase schema/columns
INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated) VALUES (@cartId, @productId, 1, @dateCreated);

-- Statement 8: AddToCart - Update cart item count
-- DMS Attempt: FAILED (2026-03-23T12:46:02 UTC) - Metadata model creation failed
-- Manual Conversion: lowercase schema/columns
UPDATE gadgetsonline_dbo.carts SET count = count + 1 WHERE recordid = @recordId;

-- Statement 9: GetCount()
-- DMS Attempt: FAILED (2026-03-23T12:46:24 UTC) - Metadata model creation failed
-- Manual Conversion: lowercase schema/columns
SELECT SUM(count) FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;

-- Statement 10: RemoveFromCart - Get cart item
-- DMS Attempt: FAILED (2026-03-23T12:45:14 UTC) - Metadata model creation failed
-- Manual Conversion: TOP(1) -> LIMIT 1, lowercase schema/columns
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @cartId AND productid = @productId LIMIT 1;

-- Statement 11: RemoveFromCart - Decrement count
-- DMS Attempt: FAILED (2026-03-23T12:46:47 UTC) - Metadata model creation failed
-- Manual Conversion: lowercase schema/columns
UPDATE gadgetsonline_dbo.carts SET count = count - 1 WHERE recordid = @recordId;

-- Statement 12: RemoveFromCart - Delete item
-- DMS Attempt: FAILED (2026-03-23T12:47:10 UTC) - Metadata model creation failed
-- Manual Conversion: lowercase schema/columns
DELETE FROM gadgetsonline_dbo.carts WHERE recordid = @recordId;

-- Statement 13: GetCartItems()
-- DMS Attempt: FAILED (2026-03-23T12:47:34 UTC) - Metadata model creation failed
-- Manual Conversion: lowercase schema/columns
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;

-- Statement 14: GetTotal()
-- DMS Attempt: FAILED (2026-03-23T12:47:59 UTC) - Metadata model creation failed
-- Manual Conversion: lowercase schema/columns/aliases
SELECT SUM(c.count * p.price) FROM gadgetsonline_dbo.carts c INNER JOIN gadgetsonline_dbo.products p ON c.productid = p.productid WHERE c.cartid = @cartId;

-- Statement 15: EmptyCart()
-- DMS Attempt: FAILED (2026-03-23T12:48:22 UTC) - Metadata model creation failed
-- Manual Conversion: lowercase schema/columns
DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;

-- Statement 16: CreateOrder - Insert order detail
-- DMS Attempt: FAILED (2026-03-23T12:48:46 UTC) - Metadata model creation failed
-- Manual Conversion: lowercase schema/columns
INSERT INTO gadgetsonline_dbo.orderdetails (productid, orderid, unitprice, quantity) VALUES (@productId, @orderId, @unitPrice, @quantity);

-- ============================================================================
-- SOURCE FILE: Services/OrderProcessing.cs
-- ============================================================================

-- Statement 17: ProcessOrder - Insert order
-- DMS Attempt: FAILED (2026-03-23T12:49:10 UTC) - Metadata model creation failed
-- Manual Conversion: lowercase schema/columns
INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);

-- ============================================================================
-- SOURCE FILE: Models/GadgetsOnlineInitializer.cs
-- ============================================================================

-- Statement 18: Seed - Insert categories
-- DMS Attempt: FAILED (2026-03-23T12:49:33 UTC) - Metadata model creation failed
-- Manual Conversion: lowercase schema/columns
INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description) VALUES (@categoryId, @name, @description);

-- Statement 19: Seed - Insert products
-- DMS Attempt: FAILED (2026-03-23T12:49:57 UTC) - Metadata model creation failed
-- Manual Conversion: lowercase schema/columns
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (@productId, @categoryId, @name, @price, @productArtUrl);
