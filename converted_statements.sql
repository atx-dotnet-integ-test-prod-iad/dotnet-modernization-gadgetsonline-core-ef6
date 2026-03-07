-- ============================================================================
-- Converted SQL Statements Catalog (PostgreSQL)
-- Project: GadgetsOnline - SQL Server to PostgreSQL Migration
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Failure Reason: Metadata model creation failed - The selected objects were not found.
-- Schema Mapping: dbo -> gadgetsonline_dbo, all table/column names to lowercase
-- ============================================================================

-- =====================================================
-- Source File: Services/Inventory.cs
-- =====================================================

-- Statement 1: GetBestSellers(count)
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products LIMIT @count;

-- Statement 2: GetAllCategories()
SELECT categoryid, name, description FROM gadgetsonline_dbo.categories;

-- Statement 3: GetAllProductsInCategory(category)
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products AS p INNER JOIN gadgetsonline_dbo.categories AS c ON p.categoryid = c.categoryid WHERE c.name = @category;

-- Statement 4: GetProductById(id)
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;

-- Statement 5: GetProductNameById(id)
SELECT name FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;

-- =====================================================
-- Source File: Services/ShoppingCart.cs
-- =====================================================

-- Statement 6: GetCartItems()
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @ShoppingCartId;

-- Statement 7: GetTotal()
SELECT SUM(c.count * p.price) FROM gadgetsonline_dbo.carts AS c INNER JOIN gadgetsonline_dbo.products AS p ON c.productid = p.productid WHERE c.cartid = @ShoppingCartId;

-- Statement 8: GetCount()
SELECT SUM(count) FROM gadgetsonline_dbo.carts WHERE cartid = @ShoppingCartId;

-- Statement 9: AddToCart - SELECT existing cart item
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @ShoppingCartId AND productid = @id LIMIT 1;

-- Statement 10: AddToCart - INSERT new cart item
INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated) VALUES (@CartId, @ProductId, @Count, @DateCreated);

-- Statement 11: AddToCart - UPDATE existing cart item count
UPDATE gadgetsonline_dbo.carts SET count = @Count WHERE recordid = @RecordId;

-- Statement 12: RemoveFromCart - SELECT cart item
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @ShoppingCartId AND productid = @id LIMIT 1;

-- Statement 13: RemoveFromCart - UPDATE decrement count
UPDATE gadgetsonline_dbo.carts SET count = @Count WHERE recordid = @RecordId;

-- Statement 14: RemoveFromCart - DELETE cart item
DELETE FROM gadgetsonline_dbo.carts WHERE recordid = @RecordId;

-- Statement 15: EmptyCart - SELECT cart items for deletion
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @ShoppingCartId;

-- Statement 16: EmptyCart - DELETE cart items
DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @ShoppingCartId;

-- Statement 17: CreateOrder - INSERT order detail
INSERT INTO gadgetsonline_dbo.orderdetails (productid, orderid, unitprice, quantity) VALUES (@ProductId, @OrderId, @UnitPrice, @Quantity);

-- Statement 18: CreateOrder - UPDATE order total
UPDATE gadgetsonline_dbo.orders SET total = @Total WHERE orderid = @OrderId;

-- =====================================================
-- Source File: Services/OrderProcessing.cs
-- =====================================================

-- Statement 19: ProcessOrder - INSERT order
INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@OrderDate, @Username, @FirstName, @LastName, @Address, @City, @State, @PostalCode, @Country, @Phone, @Email, @Total);

-- =====================================================
-- Source File: Models/GadgetsOnlineInitializer.cs
-- Seed Data INSERT Statements
-- =====================================================

-- Statement 20: Seed Categories
INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description) VALUES (1, 'Mobile Phones', 'Latest collection of Mobile Phones');
INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description) VALUES (2, 'Laptops', 'Latest Laptops in 2022');
INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description) VALUES (3, 'Desktops', 'Latest Desktops in 2022');
INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description) VALUES (4, 'Audio', 'Latest audio devices');
INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description) VALUES (5, 'Accessories', 'USB Cables, Mobile chargers and Keyboards etc');

-- Statement 21: Seed Products
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (1, 1, 'Phone 12', 699.00, '/Content/Images/Mobile/1.jpg');
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (2, 1, 'Phone 13 Pro', 999.00, '/Content/Images/Mobile/2.jpg');
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (3, 1, 'Phone 13 Pro Max', 1199.00, '/Content/Images/Mobile/3.jpg');
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (4, 2, 'XTS 13''', 899.00, '/Content/Images/Laptop/1.jpg');
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (5, 2, 'PC 15.5''', 479.00, '/Content/Images/Laptop/2.jpg');
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (6, 2, 'Notebook 14', 169.00, '/Content/Images/Laptop/3.jpg');
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (7, 3, 'The IdeaCenter', 539.00, '/Content/Images/placeholder.gif');
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (8, 3, 'COMP 22-df003w', 389.00, '/Content/Images/placeholder.gif');
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (9, 4, 'Bluetooth Headphones Over Ear', 28.00, '/Content/Images/Headphones/1.png');
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (10, 4, 'ZX Series ', 10.00, '/Content/Images/Headphones/2.png');
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (11, 5, 'Wireless charger', 9.99, '/Content/Images/placeholder.gif');
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (12, 5, 'Mousepad', 2.99, '/Content/Images/placeholder.gif');
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (13, 5, 'Keyboard', 9.99, '/Content/Images/placeholder.gif');
