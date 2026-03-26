# DMS Conversion Log - GadgetsOnline SQL Server to PostgreSQL Migration

## Summary
- **Date**: 2026-03-26
- **Total Statements**: 20
- **DMS Successful Conversions**: 0
- **DMS Failed Conversions**: 20
- **Manual Conversions (DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA)**: 20

## DMS Configuration
- **Migration Project ARN**: arn:aws:dms:us-east-1:789616364195:migration-project:73N4TGCKEFESJJWR43O334CC7U
- **Database Name**: GadgetsOnline
- **Schema Name**: dbo
- **Server Name**: 172.31.82.226
- **Region**: us-east-1

## Common DMS Error
All 20 statements failed with the same error:
```
Metadata model creation failed: {'error': "Metadata model creation failed: {'default_error_details': {'message': 'No objects were found according to the specified selection rules. Please review your selection rules and try again.'}}"}
```

## Manual Conversion Rules Applied
Since all DMS conversions failed, the following manual conversion rules were applied (DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA):
1. Convert all table names to lowercase
2. Convert all column names to lowercase
3. Map schema from `dbo` to `gadgetsonline_dbo`
4. Convert `TOP(N)` to `LIMIT N`
5. Convert `TOP(@param)` to `LIMIT @param`
6. Preserve SQL logic and structure

---

## Statement 1: INSERT Category
- **Source**: Models/GadgetsOnlineInitializer.cs - context.Categories.Add()
- **DMS Status**: FAILED
- **DMS Error**: Metadata model creation failed
- **DMS Timestamp**: 2026-03-26T06:14:31.761835
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Original (MS SQL)**:
```sql
INSERT INTO Categories (CategoryId, Name, Description) VALUES (1, 'Mobile Phones', 'Latest collection of Mobile Phones');
```
- **Converted (PostgreSQL)**:
```sql
INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description) VALUES (1, 'Mobile Phones', 'Latest collection of Mobile Phones');
```

## Statement 2: INSERT Product
- **Source**: Models/GadgetsOnlineInitializer.cs - context.Products.Add()
- **DMS Status**: FAILED
- **DMS Error**: Metadata model creation failed
- **DMS Timestamp**: 2026-03-26T06:14:55.031651
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Original (MS SQL)**:
```sql
INSERT INTO Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (1, 1, 'Phone 12', 699.00, '/Content/Images/Mobile/1.jpg');
```
- **Converted (PostgreSQL)**:
```sql
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (1, 1, 'Phone 12', 699.00, '/Content/Images/Mobile/1.jpg');
```

## Statement 3: SELECT Products with TOP/LIMIT
- **Source**: Services/Inventory.cs - GetBestSellers
- **DMS Status**: FAILED
- **DMS Error**: Metadata model creation failed
- **DMS Timestamp**: 2026-03-26T06:15:18.080162
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Original (MS SQL)**:
```sql
SELECT TOP(@p0) ProductId, CategoryId, Name, Price, ProductArtUrl FROM Products;
```
- **Converted (PostgreSQL)**:
```sql
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products LIMIT @p0;
```

## Statement 4: SELECT All Categories
- **Source**: Services/Inventory.cs - GetAllCategories
- **DMS Status**: FAILED
- **DMS Error**: Metadata model creation failed
- **DMS Timestamp**: 2026-03-26T06:15:39.730366
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Original (MS SQL)**:
```sql
SELECT CategoryId, Name, Description FROM Categories;
```
- **Converted (PostgreSQL)**:
```sql
SELECT categoryid, name, description FROM gadgetsonline_dbo.categories;
```

## Statement 5: SELECT Products by Category Name
- **Source**: Services/Inventory.cs - GetAllProductsInCategory
- **DMS Status**: FAILED
- **DMS Error**: Metadata model creation failed
- **DMS Timestamp**: 2026-03-26T06:16:01.681462
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Original (MS SQL)**:
```sql
SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl FROM Products p INNER JOIN Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @p0;
```
- **Converted (PostgreSQL)**:
```sql
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products p INNER JOIN gadgetsonline_dbo.categories c ON p.categoryid = c.categoryid WHERE c.name = @p0;
```

## Statement 6: SELECT Product by Id
- **Source**: Services/Inventory.cs - GetProductById
- **DMS Status**: FAILED
- **DMS Error**: Metadata model creation failed
- **DMS Timestamp**: 2026-03-26T06:16:26.523546
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Original (MS SQL)**:
```sql
SELECT TOP(1) ProductId, CategoryId, Name, Price, ProductArtUrl FROM Products WHERE ProductId = @p0;
```
- **Converted (PostgreSQL)**:
```sql
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products WHERE productid = @p0 LIMIT 1;
```

## Statement 7: SELECT Product Name by Id
- **Source**: Services/Inventory.cs - GetProductNameById
- **DMS Status**: FAILED
- **DMS Error**: Metadata model creation failed
- **DMS Timestamp**: 2026-03-26T06:16:53.920015
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Original (MS SQL)**:
```sql
SELECT TOP(1) Name FROM Products WHERE ProductId = @p0;
```
- **Converted (PostgreSQL)**:
```sql
SELECT name FROM gadgetsonline_dbo.products WHERE productid = @p0 LIMIT 1;
```

## Statement 8: SELECT Cart Items by CartId
- **Source**: Services/ShoppingCart.cs - GetCartItems
- **DMS Status**: FAILED
- **DMS Error**: Metadata model creation failed
- **DMS Timestamp**: 2026-03-26T06:17:17.515411
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Original (MS SQL)**:
```sql
SELECT RecordId, CartId, ProductId, Count, DateCreated FROM Carts WHERE CartId = @p0;
```
- **Converted (PostgreSQL)**:
```sql
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @p0;
```

## Statement 9: SELECT Single Cart Item
- **Source**: Services/ShoppingCart.cs - AddToCart SingleOrDefault
- **DMS Status**: FAILED
- **DMS Error**: Metadata model creation failed
- **DMS Timestamp**: 2026-03-26T06:17:40.129759
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Original (MS SQL)**:
```sql
SELECT TOP(1) RecordId, CartId, ProductId, Count, DateCreated FROM Carts WHERE CartId = @p0 AND ProductId = @p1;
```
- **Converted (PostgreSQL)**:
```sql
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @p0 AND productid = @p1 LIMIT 1;
```

## Statement 10: INSERT Cart Item
- **Source**: Services/ShoppingCart.cs - AddToCart Add
- **DMS Status**: FAILED
- **DMS Error**: Metadata model creation failed
- **DMS Timestamp**: 2026-03-26T06:18:01.937477
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Original (MS SQL)**:
```sql
INSERT INTO Carts (CartId, ProductId, Count, DateCreated) VALUES (@p0, @p1, @p2, @p3);
```
- **Converted (PostgreSQL)**:
```sql
INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated) VALUES (@p0, @p1, @p2, @p3);
```

## Statement 11: UPDATE Cart Item Count
- **Source**: Services/ShoppingCart.cs - AddToCart Count++
- **DMS Status**: FAILED
- **DMS Error**: Metadata model creation failed
- **DMS Timestamp**: 2026-03-26T06:18:24.389693
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Original (MS SQL)**:
```sql
UPDATE Carts SET Count = @p0 WHERE RecordId = @p1;
```
- **Converted (PostgreSQL)**:
```sql
UPDATE gadgetsonline_dbo.carts SET count = @p0 WHERE recordid = @p1;
```

## Statement 12: SELECT SUM of Cart Count
- **Source**: Services/ShoppingCart.cs - GetCount
- **DMS Status**: FAILED
- **DMS Error**: Metadata model creation failed
- **DMS Timestamp**: 2026-03-26T06:18:47.416030
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Original (MS SQL)**:
```sql
SELECT SUM(Count) FROM Carts WHERE CartId = @p0;
```
- **Converted (PostgreSQL)**:
```sql
SELECT SUM(count) FROM gadgetsonline_dbo.carts WHERE cartid = @p0;
```

## Statement 13: SELECT SUM of Cart Total
- **Source**: Services/ShoppingCart.cs - GetTotal
- **DMS Status**: FAILED
- **DMS Error**: Metadata model creation failed
- **DMS Timestamp**: 2026-03-26T06:19:11.062445
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Original (MS SQL)**:
```sql
SELECT SUM(c.Count * p.Price) FROM Carts c INNER JOIN Products p ON c.ProductId = p.ProductId WHERE c.CartId = @p0;
```
- **Converted (PostgreSQL)**:
```sql
SELECT SUM(c.count * p.price) FROM gadgetsonline_dbo.carts c INNER JOIN gadgetsonline_dbo.products p ON c.productid = p.productid WHERE c.cartid = @p0;
```

## Statement 14: DELETE Cart Items by CartId
- **Source**: Services/ShoppingCart.cs - EmptyCart
- **DMS Status**: FAILED
- **DMS Error**: Metadata model creation failed
- **DMS Timestamp**: 2026-03-26T06:19:33.264661
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Original (MS SQL)**:
```sql
DELETE FROM Carts WHERE CartId = @p0;
```
- **Converted (PostgreSQL)**:
```sql
DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @p0;
```

## Statement 15: SELECT Cart Item for Remove
- **Source**: Services/ShoppingCart.cs - RemoveFromCart Single
- **DMS Status**: FAILED
- **DMS Error**: Metadata model creation failed
- **DMS Timestamp**: 2026-03-26T06:19:56.035167
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Original (MS SQL)**:
```sql
SELECT TOP(1) RecordId, CartId, ProductId, Count, DateCreated FROM Carts WHERE CartId = @p0 AND ProductId = @p1 ORDER BY RecordId;
```
- **Converted (PostgreSQL)**:
```sql
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @p0 AND productid = @p1 ORDER BY recordid LIMIT 1;
```

## Statement 16: DELETE Single Cart Item
- **Source**: Services/ShoppingCart.cs - RemoveFromCart Remove
- **DMS Status**: FAILED
- **DMS Error**: Metadata model creation failed
- **DMS Timestamp**: 2026-03-26T06:20:17.593886
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Original (MS SQL)**:
```sql
DELETE FROM Carts WHERE RecordId = @p0;
```
- **Converted (PostgreSQL)**:
```sql
DELETE FROM gadgetsonline_dbo.carts WHERE recordid = @p0;
```

## Statement 17: INSERT Order Detail
- **Source**: Services/ShoppingCart.cs - CreateOrder OrderDetails.Add
- **DMS Status**: FAILED
- **DMS Error**: Metadata model creation failed
- **DMS Timestamp**: 2026-03-26T06:20:40.182536
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Original (MS SQL)**:
```sql
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice) VALUES (@p0, @p1, @p2, @p3);
```
- **Converted (PostgreSQL)**:
```sql
INSERT INTO gadgetsonline_dbo.orderdetails (orderid, productid, quantity, unitprice) VALUES (@p0, @p1, @p2, @p3);
```

## Statement 18: UPDATE Order Total
- **Source**: Services/ShoppingCart.cs - CreateOrder order.Total
- **DMS Status**: FAILED
- **DMS Error**: Metadata model creation failed
- **DMS Timestamp**: 2026-03-26T06:21:02.123963
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Original (MS SQL)**:
```sql
UPDATE Orders SET Total = @p0 WHERE OrderId = @p1;
```
- **Converted (PostgreSQL)**:
```sql
UPDATE gadgetsonline_dbo.orders SET total = @p0 WHERE orderid = @p1;
```

## Statement 19: INSERT Order
- **Source**: Services/OrderProcessing.cs - ProcessOrder Orders.Add
- **DMS Status**: FAILED
- **DMS Error**: Metadata model creation failed
- **DMS Timestamp**: 2026-03-26T06:21:25.455149
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Original (MS SQL)**:
```sql
INSERT INTO Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@p0, @p1, @p2, @p3, @p4, @p5, @p6, @p7, @p8, @p9, @p10, @p11);
```
- **Converted (PostgreSQL)**:
```sql
INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@p0, @p1, @p2, @p3, @p4, @p5, @p6, @p7, @p8, @p9, @p10, @p11);
```

## Statement 20: SELECT Order Details by OrderId
- **Source**: Models/Order.cs - OrderDetails navigation property (lazy loading)
- **DMS Status**: FAILED
- **DMS Error**: Metadata model creation failed
- **DMS Timestamp**: 2026-03-26T06:21:48.994911
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Original (MS SQL)**:
```sql
SELECT OrderDetailId, OrderId, ProductId, Quantity, UnitPrice FROM OrderDetails WHERE OrderId = @p0;
```
- **Converted (PostgreSQL)**:
```sql
SELECT orderdetailid, orderid, productid, quantity, unitprice FROM gadgetsonline_dbo.orderdetails WHERE orderid = @p0;
```
