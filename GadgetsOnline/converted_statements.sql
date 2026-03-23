-- ============================================================
-- Converted SQL Statements - GadgetsOnline Migration
-- Target: PostgreSQL (gadgetsonline_dbo schema)
-- Total: 18 statements (5 DDL + 13 DML)
-- Conversion method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- All 18 DMS calls made (timestamps: 2026-03-23T00:51:25 through 2026-03-23T00:58:28)
-- All DMS conversions failed with: Metadata model creation failed: No objects were found
-- Manual conversion applied lowercase schema object names per rules:
--   - dbo schema mapped to gadgetsonline_dbo
--   - All identifiers converted to lowercase
--   - IDENTITY -> SERIAL, NVARCHAR -> VARCHAR/TEXT, DATETIME -> TIMESTAMP, TOP -> LIMIT
-- ============================================================

-- ============================================================
-- DDL Statements (CREATE TABLE)
-- ============================================================

-- Statement 1: CREATE TABLE categories
CREATE TABLE gadgetsonline_dbo.categories (
    categoryid SERIAL PRIMARY KEY,
    name TEXT NULL,
    description TEXT NULL
);

-- Statement 2: CREATE TABLE products
CREATE TABLE gadgetsonline_dbo.products (
    productid SERIAL PRIMARY KEY,
    categoryid INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(18,2) NOT NULL,
    productarturl VARCHAR(1024) NULL,
    CONSTRAINT fk_products_categories FOREIGN KEY (categoryid) REFERENCES gadgetsonline_dbo.categories(categoryid)
);

-- Statement 3: CREATE TABLE carts
CREATE TABLE gadgetsonline_dbo.carts (
    recordid SERIAL PRIMARY KEY,
    cartid TEXT NULL,
    productid INT NOT NULL,
    count INT NOT NULL,
    datecreated TIMESTAMP NOT NULL,
    CONSTRAINT fk_carts_products FOREIGN KEY (productid) REFERENCES gadgetsonline_dbo.products(productid)
);

-- Statement 4: CREATE TABLE orders
CREATE TABLE gadgetsonline_dbo.orders (
    orderid SERIAL PRIMARY KEY,
    orderdate TIMESTAMP NOT NULL,
    username TEXT NULL,
    firstname VARCHAR(160) NOT NULL,
    lastname VARCHAR(160) NOT NULL,
    address VARCHAR(70) NOT NULL,
    city VARCHAR(40) NOT NULL,
    state VARCHAR(40) NOT NULL,
    postalcode VARCHAR(10) NOT NULL,
    country VARCHAR(40) NOT NULL,
    phone VARCHAR(24) NOT NULL,
    email TEXT NOT NULL,
    total DECIMAL(18,2) NOT NULL
);

-- Statement 5: CREATE TABLE orderdetails
CREATE TABLE gadgetsonline_dbo.orderdetails (
    orderdetailid SERIAL PRIMARY KEY,
    orderid INT NOT NULL,
    productid INT NOT NULL,
    quantity INT NOT NULL,
    unitprice DECIMAL(18,2) NOT NULL,
    CONSTRAINT fk_orderdetails_orders FOREIGN KEY (orderid) REFERENCES gadgetsonline_dbo.orders(orderid),
    CONSTRAINT fk_orderdetails_products FOREIGN KEY (productid) REFERENCES gadgetsonline_dbo.products(productid)
);

-- ============================================================
-- DML Statements - SELECT (from Inventory service)
-- ============================================================

-- Statement 6: GetBestSellers (Inventory.cs)
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products LIMIT @count;

-- Statement 7: GetAllCategories (Inventory.cs)
SELECT categoryid, name, description FROM gadgetsonline_dbo.categories;

-- Statement 8: GetAllProductsInCategory (Inventory.cs)
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl
FROM gadgetsonline_dbo.products p INNER JOIN gadgetsonline_dbo.categories c ON p.categoryid = c.categoryid
WHERE c.name = @categoryName;

-- Statement 9: GetProductById (Inventory.cs)
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products WHERE productid = @id;

-- Statement 10: GetProductNameById (Inventory.cs)
SELECT name FROM gadgetsonline_dbo.products WHERE productid = @id;

-- ============================================================
-- DML Statements - SELECT (from ShoppingCart service)
-- ============================================================

-- Statement 11: AddToCart - lookup (ShoppingCart.cs)
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @cartId AND productid = @productId;

-- Statement 12: GetCartItems (ShoppingCart.cs)
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;

-- Statement 13: GetCount (ShoppingCart.cs)
SELECT SUM(count) FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;

-- Statement 14: GetTotal (ShoppingCart.cs)
SELECT SUM(c.count * p.price) FROM gadgetsonline_dbo.carts c INNER JOIN gadgetsonline_dbo.products p ON c.productid = p.productid WHERE c.cartid = @cartId;

-- ============================================================
-- DML Statements - INSERT/UPDATE/DELETE
-- ============================================================

-- Statement 15: AddToCart - insert (ShoppingCart.cs)
INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated) VALUES (@cartId, @productId, @count, @dateCreated);

-- Statement 16: EmptyCart (ShoppingCart.cs)
DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;

-- Statement 17: ProcessOrder - insert order (OrderProcessing.cs)
INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total)
VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);

-- Statement 18: CreateOrder - insert order detail (ShoppingCart.cs)
INSERT INTO gadgetsonline_dbo.orderdetails (orderid, productid, quantity, unitprice) VALUES (@orderId, @productId, @quantity, @unitPrice);
