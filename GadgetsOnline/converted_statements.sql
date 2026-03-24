-- ============================================================================
-- CONVERTED SQL STATEMENTS CATALOG (PostgreSQL)
-- Application: GadgetsOnline
-- Target Database: PostgreSQL 13
-- Total Statements: 18
-- Description: PostgreSQL equivalents of all extracted MS SQL Server statements
-- 
-- NOTE: All 18 statements were attempted through DMS MCP tool first.
-- DMS Status: ALL FAILED with error "Metadata model creation failed: 
--   No objects were found according to the specified selection rules."
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Schema Mapping: dbo -> gadgetsonline_dbo
-- Naming Convention: All identifiers converted to lowercase
-- ============================================================================

-- ============================================================================
-- SOURCE FILE: Services/Inventory.cs
-- ============================================================================

-- Statement 1: GetBestSellers
-- Source: Services/Inventory.cs :: GetBestSellers(int count)
-- DMS Status: FAILED - Metadata model creation failed
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: [dbo].[Products] -> gadgetsonline_dbo.products, TOP(@count) -> LIMIT @count, columns lowercase
SELECT productid, categoryid, name, price, productarturl
FROM gadgetsonline_dbo.products
LIMIT @count;

-- Statement 2: GetAllCategories
-- Source: Services/Inventory.cs :: GetAllCategories()
-- DMS Status: FAILED - Metadata model creation failed
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: [dbo].[Categories] -> gadgetsonline_dbo.categories, columns lowercase
SELECT categoryid, name, description
FROM gadgetsonline_dbo.categories;

-- Statement 3: GetAllProductsInCategory
-- Source: Services/Inventory.cs :: GetAllProductsInCategory(string category)
-- DMS Status: FAILED - Metadata model creation failed
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: [dbo] -> gadgetsonline_dbo, tables/columns lowercase
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl
FROM gadgetsonline_dbo.products p
INNER JOIN gadgetsonline_dbo.categories c ON p.categoryid = c.categoryid
WHERE c.name = @category;

-- Statement 4: GetProductById
-- Source: Services/Inventory.cs :: GetProductById(int id)
-- DMS Status: FAILED - Metadata model creation failed
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: [dbo].[Products] -> gadgetsonline_dbo.products, TOP 1 -> LIMIT 1, columns lowercase
SELECT productid, categoryid, name, price, productarturl
FROM gadgetsonline_dbo.products
WHERE productid = @id
LIMIT 1;

-- Statement 5: GetProductNameById
-- Source: Services/Inventory.cs :: GetProductNameById(int id)
-- DMS Status: FAILED - Metadata model creation failed
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: [dbo].[Products] -> gadgetsonline_dbo.products, TOP 1 -> LIMIT 1, columns lowercase
SELECT name
FROM gadgetsonline_dbo.products
WHERE productid = @id
LIMIT 1;

-- ============================================================================
-- SOURCE FILE: Services/ShoppingCart.cs
-- ============================================================================

-- Statement 6: GetCartItems
-- Source: Services/ShoppingCart.cs :: GetCartItems()
-- DMS Status: FAILED - Metadata model creation failed
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: [dbo].[Carts] -> gadgetsonline_dbo.carts, columns lowercase
SELECT recordid, cartid, productid, count, datecreated
FROM gadgetsonline_dbo.carts
WHERE cartid = @ShoppingCartId;

-- Statement 7: GetCount
-- Source: Services/ShoppingCart.cs :: GetCount()
-- DMS Status: FAILED - Metadata model creation failed
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: [dbo].[Carts] -> gadgetsonline_dbo.carts, columns lowercase
SELECT SUM(count)
FROM gadgetsonline_dbo.carts
WHERE cartid = @ShoppingCartId;

-- Statement 8: GetTotal
-- Source: Services/ShoppingCart.cs :: GetTotal()
-- DMS Status: FAILED - Metadata model creation failed
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: [dbo] -> gadgetsonline_dbo, tables/columns lowercase
SELECT SUM(c.count * p.price)
FROM gadgetsonline_dbo.carts c
INNER JOIN gadgetsonline_dbo.products p ON c.productid = p.productid
WHERE c.cartid = @ShoppingCartId;

-- Statement 9: AddToCart - SELECT (check existing)
-- Source: Services/ShoppingCart.cs :: AddToCart(int id)
-- DMS Status: FAILED - Metadata model creation failed
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: [dbo].[Carts] -> gadgetsonline_dbo.carts, columns lowercase
SELECT recordid, cartid, productid, count, datecreated
FROM gadgetsonline_dbo.carts
WHERE cartid = @ShoppingCartId AND productid = @id;

-- Statement 10: AddToCart - INSERT (new cart item)
-- Source: Services/ShoppingCart.cs :: AddToCart(int id)
-- DMS Status: FAILED - Metadata model creation failed
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: [dbo].[Carts] -> gadgetsonline_dbo.carts, GETDATE() -> NOW(), columns lowercase
INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated)
VALUES (@ShoppingCartId, @ProductId, 1, NOW());

-- Statement 11: RemoveFromCart - SELECT (get cart item)
-- Source: Services/ShoppingCart.cs :: RemoveFromCart(int id)
-- DMS Status: FAILED - Metadata model creation failed
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: [dbo].[Carts] -> gadgetsonline_dbo.carts, columns lowercase
SELECT recordid, cartid, productid, count, datecreated
FROM gadgetsonline_dbo.carts
WHERE cartid = @ShoppingCartId AND productid = @id;

-- Statement 12: RemoveFromCart - DELETE (remove cart item)
-- Source: Services/ShoppingCart.cs :: RemoveFromCart(int id)
-- DMS Status: FAILED - Metadata model creation failed
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: [dbo].[Carts] -> gadgetsonline_dbo.carts, columns lowercase
DELETE FROM gadgetsonline_dbo.carts
WHERE recordid = @RecordId;

-- Statement 13: EmptyCart - SELECT (get cart items for deletion)
-- Source: Services/ShoppingCart.cs :: EmptyCart()
-- DMS Status: FAILED - Metadata model creation failed
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: [dbo].[Carts] -> gadgetsonline_dbo.carts, columns lowercase
SELECT recordid, cartid, productid, count, datecreated
FROM gadgetsonline_dbo.carts
WHERE cartid = @ShoppingCartId;

-- Statement 14: EmptyCart - DELETE (remove all cart items)
-- Source: Services/ShoppingCart.cs :: EmptyCart()
-- DMS Status: FAILED - Metadata model creation failed
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: [dbo].[Carts] -> gadgetsonline_dbo.carts, columns lowercase
DELETE FROM gadgetsonline_dbo.carts
WHERE cartid = @ShoppingCartId;

-- Statement 15: CreateOrder - INSERT OrderDetails
-- Source: Services/ShoppingCart.cs :: CreateOrder(Order order)
-- DMS Status: FAILED - Metadata model creation failed
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: [dbo].[OrderDetails] -> gadgetsonline_dbo.orderdetails, columns lowercase
INSERT INTO gadgetsonline_dbo.orderdetails (orderid, productid, quantity, unitprice)
VALUES (@OrderId, @ProductId, @Quantity, @UnitPrice);

-- ============================================================================
-- SOURCE FILE: Services/OrderProcessing.cs
-- ============================================================================

-- Statement 16: ProcessOrder - INSERT Orders
-- Source: Services/OrderProcessing.cs :: ProcessOrder(Order order, HttpContext httpContext)
-- DMS Status: FAILED - Metadata model creation failed
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: [dbo].[Orders] -> gadgetsonline_dbo.orders, columns lowercase
INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total)
VALUES (@OrderDate, @Username, @FirstName, @LastName, @Address, @City, @State, @PostalCode, @Country, @Phone, @Email, @Total);

-- ============================================================================
-- SOURCE FILE: Models/GadgetsOnlineInitializer.cs
-- ============================================================================

-- Statement 17: Seed Categories - INSERT
-- Source: Models/GadgetsOnlineInitializer.cs :: Seed(GadgetsOnlineEntities context)
-- DMS Status: FAILED - Metadata model creation failed
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: [dbo].[Categories] -> gadgetsonline_dbo.categories, columns lowercase
INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description)
VALUES
    (1, 'Mobile Phones', 'Latest collection of Mobile Phones'),
    (2, 'Laptops', 'Latest Laptops in 2022'),
    (3, 'Desktops', 'Latest Desktops in 2022'),
    (4, 'Audio', 'Latest audio devices'),
    (5, 'Accessories', 'USB Cables, Mobile chargers and Keyboards etc');

-- Statement 18: Seed Products - INSERT
-- Source: Models/GadgetsOnlineInitializer.cs :: Seed(GadgetsOnlineEntities context)
-- DMS Status: FAILED - Metadata model creation failed
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: [dbo].[Products] -> gadgetsonline_dbo.products, columns lowercase
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl)
VALUES
    (1, 1, 'Phone 12', 699.00, '/Content/Images/Mobile/1.jpg'),
    (2, 1, 'Phone 13 Pro', 999.00, '/Content/Images/Mobile/2.jpg'),
    (3, 1, 'Phone 13 Pro Max', 1199.00, '/Content/Images/Mobile/3.jpg'),
    (4, 2, 'XTS 13''', 899.00, '/Content/Images/Laptop/1.jpg'),
    (5, 2, 'PC 15.5''', 479.00, '/Content/Images/Laptop/2.jpg'),
    (6, 2, 'Notebook 14', 169.00, '/Content/Images/Laptop/3.jpg'),
    (7, 3, 'The IdeaCenter', 539.00, '/Content/Images/placeholder.gif'),
    (8, 3, 'COMP 22-df003w', 389.00, '/Content/Images/placeholder.gif'),
    (9, 4, 'Bluetooth Headphones Over Ear', 28.00, '/Content/Images/Headphones/1.png'),
    (10, 4, 'ZX Series ', 10.00, '/Content/Images/Headphones/2.png'),
    (11, 5, 'Wireless charger', 9.99, '/Content/Images/placeholder.gif'),
    (12, 5, 'Mousepad', 2.99, '/Content/Images/placeholder.gif'),
    (13, 5, 'Keyboard', 9.99, '/Content/Images/placeholder.gif');
