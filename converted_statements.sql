-- =====================================================================
-- CONVERTED SQL STATEMENTS CATALOG
-- Source: MS SQL Server (dbo schema) -> Target: PostgreSQL (gadgetsonline_dbo schema)
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- All 16 statements failed DMS conversion. Manual conversion applied with lowercase schema mapping.
-- Total Statements: 16
-- =====================================================================

-- =====================================================================
-- FILE: GadgetsOnline/Services/Inventory.cs
-- =====================================================================

-- Statement 1: GetBestSellers
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- Original: SELECT TOP(@count) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products;
-- Converted:
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products LIMIT @count;

-- Statement 2: GetAllCategories
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- Original: SELECT CategoryId, Name, Description FROM dbo.Categories;
-- Converted:
SELECT categoryid, name, description FROM gadgetsonline_dbo.categories;

-- Statement 3: GetAllProductsInCategory
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- Original: SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl FROM dbo.Products p INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @category;
-- Converted:
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products p INNER JOIN gadgetsonline_dbo.categories c ON p.categoryid = c.categoryid WHERE c.name = @category;

-- Statement 4: GetProductById
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- Original: SELECT TOP(1) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products WHERE ProductId = @id;
-- Converted:
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;

-- Statement 5: GetProductNameById
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- Original: SELECT TOP(1) Name FROM dbo.Products WHERE ProductId = @id;
-- Converted:
SELECT name FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;

-- =====================================================================
-- FILE: GadgetsOnline/Services/ShoppingCart.cs
-- =====================================================================

-- Statement 6: GetCartItems
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- Original: SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @ShoppingCartId;
-- Converted:
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @ShoppingCartId;

-- Statement 7: GetCount
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- Original: SELECT SUM(Count) FROM dbo.Carts WHERE CartId = @ShoppingCartId;
-- Converted:
SELECT SUM(count) FROM gadgetsonline_dbo.carts WHERE cartid = @ShoppingCartId;

-- Statement 8: GetTotal
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- Original: SELECT SUM(c.Count * p.Price) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.ProductId = p.ProductId WHERE c.CartId = @ShoppingCartId;
-- Converted:
SELECT SUM(c.count * p.price) FROM gadgetsonline_dbo.carts c INNER JOIN gadgetsonline_dbo.products p ON c.productid = p.productid WHERE c.cartid = @ShoppingCartId;

-- Statement 9: AddToCart - Select existing cart item
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- Original: SELECT TOP(1) RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @ShoppingCartId AND ProductId = @id;
-- Converted:
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @ShoppingCartId AND productid = @id LIMIT 1;

-- Statement 10: AddToCart - Insert new cart item
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- Original: INSERT INTO dbo.Carts (CartId, ProductId, Count, DateCreated) VALUES (@CartId, @ProductId, @Count, @DateCreated);
-- Converted:
INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated) VALUES (@CartId, @ProductId, @Count, @DateCreated);

-- Statement 11: RemoveFromCart - Delete cart item
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- Original: DELETE FROM dbo.Carts WHERE RecordId = @RecordId;
-- Converted:
DELETE FROM gadgetsonline_dbo.carts WHERE recordid = @RecordId;

-- Statement 12: EmptyCart - Delete all cart items for a cart
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- Original: DELETE FROM dbo.Carts WHERE CartId = @ShoppingCartId;
-- Converted:
DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @ShoppingCartId;

-- Statement 13: CreateOrder - Insert order detail
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- Original: INSERT INTO dbo.OrderDetails (OrderId, ProductId, Quantity, UnitPrice) VALUES (@OrderId, @ProductId, @Quantity, @UnitPrice);
-- Converted:
INSERT INTO gadgetsonline_dbo.orderdetails (orderid, productid, quantity, unitprice) VALUES (@OrderId, @ProductId, @Quantity, @UnitPrice);

-- =====================================================================
-- FILE: GadgetsOnline/Services/OrderProcessing.cs
-- =====================================================================

-- Statement 14: ProcessOrder - Insert order
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- Original: INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@OrderDate, @Username, @FirstName, @LastName, @Address, @City, @State, @PostalCode, @Country, @Phone, @Email, @Total);
-- Converted:
INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@OrderDate, @Username, @FirstName, @LastName, @Address, @City, @State, @PostalCode, @Country, @Phone, @Email, @Total);

-- =====================================================================
-- FILE: GadgetsOnline/Models/GadgetsOnlineInitializer.cs
-- =====================================================================

-- Statement 15: Seed Categories
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- Original: INSERT INTO dbo.Categories (CategoryId, Name, Description) VALUES (@CategoryId, @Name, @Description);
-- Converted:
INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description) VALUES (@CategoryId, @Name, @Description);

-- Statement 16: Seed Products
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- Original: INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (@ProductId, @CategoryId, @Name, @Price, @ProductArtUrl);
-- Converted:
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (@ProductId, @CategoryId, @Name, @Price, @ProductArtUrl);
