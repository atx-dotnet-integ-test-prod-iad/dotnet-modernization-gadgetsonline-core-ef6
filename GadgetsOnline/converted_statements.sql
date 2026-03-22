-- ============================================================================
-- Converted SQL Statements - PostgreSQL Equivalents
-- Application: GadgetsOnline
-- Target Schema: gadgetsonline_dbo (lowercase)
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- All 19 DMS calls failed with metadata model creation error
-- Total Statements: 19
-- ============================================================================

-- ============================================================================
-- SOURCE FILE: Services/Inventory.cs (5 statements)
-- ============================================================================

-- Statement 1: Inventory.GetBestSellers(int count)
-- Original: SELECT TOP(@count) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products;
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products LIMIT @count;

-- Statement 2: Inventory.GetAllCategories()
-- Original: SELECT CategoryId, Name, Description FROM dbo.Categories;
SELECT categoryid, name, description FROM gadgetsonline_dbo.categories;

-- Statement 3: Inventory.GetAllProductsInCategory(string category)
-- Original: SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl FROM dbo.Products p INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @category;
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products p INNER JOIN gadgetsonline_dbo.categories c ON p.categoryid = c.categoryid WHERE c.name = @category;

-- Statement 4: Inventory.GetProductById(int id)
-- Original: SELECT TOP 1 ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products WHERE ProductId = @id;
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;

-- Statement 5: Inventory.GetProductNameById(int id)
-- Original: SELECT TOP 1 Name FROM dbo.Products WHERE ProductId = @id;
SELECT name FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;

-- ============================================================================
-- SOURCE FILE: Services/ShoppingCart.cs (12 statements)
-- ============================================================================

-- Statement 6: ShoppingCart.GetCartItems()
-- Original: SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @ShoppingCartId;
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @ShoppingCartId;

-- Statement 7: ShoppingCart.GetCount()
-- Original: SELECT SUM(Count) FROM dbo.Carts WHERE CartId = @ShoppingCartId;
SELECT SUM(count) FROM gadgetsonline_dbo.carts WHERE cartid = @ShoppingCartId;

-- Statement 8: ShoppingCart.GetTotal()
-- Original: SELECT SUM(c.Count * p.Price) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.ProductId = p.ProductId WHERE c.CartId = @ShoppingCartId;
SELECT SUM(c.count * p.price) FROM gadgetsonline_dbo.carts c INNER JOIN gadgetsonline_dbo.products p ON c.productid = p.productid WHERE c.cartid = @ShoppingCartId;

-- Statement 9: ShoppingCart.AddToCart - Select existing cart item
-- Original: SELECT TOP 1 RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @ShoppingCartId AND ProductId = @ProductId;
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @ShoppingCartId AND productid = @ProductId LIMIT 1;

-- Statement 10: ShoppingCart.AddToCart - Insert new cart item
-- Original: INSERT INTO dbo.Carts (CartId, ProductId, Count, DateCreated) VALUES (@CartId, @ProductId, @Count, @DateCreated);
INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated) VALUES (@CartId, @ProductId, @Count, @DateCreated);

-- Statement 11: ShoppingCart.RemoveFromCart - Select cart item
-- Original: SELECT TOP 1 RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @ShoppingCartId AND ProductId = @ProductId;
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @ShoppingCartId AND productid = @ProductId LIMIT 1;

-- Statement 12: ShoppingCart.RemoveFromCart - Delete cart item (when count = 1)
-- Original: DELETE FROM dbo.Carts WHERE RecordId = @RecordId;
DELETE FROM gadgetsonline_dbo.carts WHERE recordid = @RecordId;

-- Statement 13: ShoppingCart.RemoveFromCart - Update cart item (when count > 1)
-- Original: UPDATE dbo.Carts SET Count = Count - 1 WHERE RecordId = @RecordId;
UPDATE gadgetsonline_dbo.carts SET count = count - 1 WHERE recordid = @RecordId;

-- Statement 14: ShoppingCart.EmptyCart - Select all cart items
-- Original: SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @ShoppingCartId;
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @ShoppingCartId;

-- Statement 15: ShoppingCart.EmptyCart - Delete all cart items
-- Original: DELETE FROM dbo.Carts WHERE CartId = @ShoppingCartId;
DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @ShoppingCartId;

-- Statement 16: ShoppingCart.CreateOrder - Insert order detail
-- Original: INSERT INTO dbo.OrderDetails (ProductId, OrderId, UnitPrice, Quantity) VALUES (@ProductId, @OrderId, @UnitPrice, @Quantity);
INSERT INTO gadgetsonline_dbo.orderdetails (productid, orderid, unitprice, quantity) VALUES (@ProductId, @OrderId, @UnitPrice, @Quantity);

-- ============================================================================
-- SOURCE FILE: Services/OrderProcessing.cs (1 statement)
-- ============================================================================

-- Statement 17: OrderProcessing.ProcessOrder - Insert order
-- Original: INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@OrderDate, @Username, @FirstName, @LastName, @Address, @City, @State, @PostalCode, @Country, @Phone, @Email, @Total);
INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@OrderDate, @Username, @FirstName, @LastName, @Address, @City, @State, @PostalCode, @Country, @Phone, @Email, @Total);

-- ============================================================================
-- SOURCE FILE: Models/GadgetsOnlineInitializer.cs (2 statements)
-- ============================================================================

-- Statement 18: GadgetsOnlineInitializer.Seed - Insert Categories
-- Original: INSERT INTO dbo.Categories (CategoryId, Name, Description) VALUES (@CategoryId, @Name, @Description);
INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description) VALUES (@CategoryId, @Name, @Description);

-- Statement 19: GadgetsOnlineInitializer.Seed - Insert Products
-- Original: INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (@ProductId, @CategoryId, @Name, @Price, @ProductArtUrl);
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (@ProductId, @CategoryId, @Name, @Price, @ProductArtUrl);
