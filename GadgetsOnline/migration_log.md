# DMS Migration Log - GadgetsOnline SQL Statement Conversion

## Summary
- **Total Statements**: 19
- **DMS Successful Conversions**: 0
- **DMS Failed Conversions**: 19
- **Manual Conversions Applied**: 19
- **Conversion Method for All**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA

## DMS Configuration
- **Migration Project ARN**: arn:aws:dms:us-east-1:789616364195:migration-project:73N4TGCKEFESJJWR43O334CC7U
- **Database Name**: GadgetsOnline
- **Schema Name**: dbo
- **Region**: us-east-1
- **Server Name**: 172.31.82.226

## Common DMS Error
All 19 DMS calls failed with the same error:
```
Metadata model creation failed: {'error': "Metadata model creation failed: {'default_error_details': {'message': 'No objects were found according to the specified selection rules. Please review your selection rules and try again.'}}"}
```

## Manual Conversion Schema Mapping Rules Applied
| SQL Server | PostgreSQL |
|---|---|
| dbo.Products | gadgetsonline_dbo.products |
| dbo.Categories | gadgetsonline_dbo.categories |
| dbo.Carts | gadgetsonline_dbo.carts |
| dbo.Orders | gadgetsonline_dbo.orders |
| dbo.OrderDetails | gadgetsonline_dbo.orderdetails |
| TOP N ... | ... LIMIT N |
| PascalCase columns | lowercase columns |

---

## Statement-by-Statement DMS Call Results

### Statement 1: Inventory.GetBestSellers
- **Source File**: Services/Inventory.cs
- **DMS Input**: `SELECT TOP(@count) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products;`
- **DMS Status**: error
- **DMS Error**: Metadata model creation failed: No objects were found according to the specified selection rules.
- **DMS Timestamp**: 2026-03-22T17:24:57
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Manual Output**: `SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products LIMIT @count;`

### Statement 2: Inventory.GetAllCategories
- **Source File**: Services/Inventory.cs
- **DMS Input**: `SELECT CategoryId, Name, Description FROM dbo.Categories;`
- **DMS Status**: error
- **DMS Error**: Metadata model creation failed: No objects were found according to the specified selection rules.
- **DMS Timestamp**: 2026-03-22T17:25:12
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Manual Output**: `SELECT categoryid, name, description FROM gadgetsonline_dbo.categories;`

### Statement 3: Inventory.GetAllProductsInCategory
- **Source File**: Services/Inventory.cs
- **DMS Input**: `SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl FROM dbo.Products p INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @category;`
- **DMS Status**: error
- **DMS Error**: Metadata model creation failed: No objects were found according to the specified selection rules.
- **DMS Timestamp**: 2026-03-22T17:25:28
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Manual Output**: `SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products p INNER JOIN gadgetsonline_dbo.categories c ON p.categoryid = c.categoryid WHERE c.name = @category;`

### Statement 4: Inventory.GetProductById
- **Source File**: Services/Inventory.cs
- **DMS Input**: `SELECT TOP 1 ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products WHERE ProductId = @id;`
- **DMS Status**: error
- **DMS Error**: Metadata model creation failed: No objects were found according to the specified selection rules.
- **DMS Timestamp**: 2026-03-22T17:25:44
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Manual Output**: `SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;`

### Statement 5: Inventory.GetProductNameById
- **Source File**: Services/Inventory.cs
- **DMS Input**: `SELECT TOP 1 Name FROM dbo.Products WHERE ProductId = @id;`
- **DMS Status**: error
- **DMS Error**: Metadata model creation failed: No objects were found according to the specified selection rules.
- **DMS Timestamp**: 2026-03-22T17:25:59
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Manual Output**: `SELECT name FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;`

### Statement 6: ShoppingCart.GetCartItems
- **Source File**: Services/ShoppingCart.cs
- **DMS Input**: `SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @ShoppingCartId;`
- **DMS Status**: error
- **DMS Error**: Metadata model creation failed: No objects were found according to the specified selection rules.
- **DMS Timestamp**: 2026-03-22T17:26:32
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Manual Output**: `SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @ShoppingCartId;`

### Statement 7: ShoppingCart.GetCount
- **Source File**: Services/ShoppingCart.cs
- **DMS Input**: `SELECT SUM(Count) FROM dbo.Carts WHERE CartId = @ShoppingCartId;`
- **DMS Status**: error
- **DMS Error**: Metadata model creation failed: No objects were found according to the specified selection rules.
- **DMS Timestamp**: 2026-03-22T17:26:48
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Manual Output**: `SELECT SUM(count) FROM gadgetsonline_dbo.carts WHERE cartid = @ShoppingCartId;`

### Statement 8: ShoppingCart.GetTotal
- **Source File**: Services/ShoppingCart.cs
- **DMS Input**: `SELECT SUM(c.Count * p.Price) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.ProductId = p.ProductId WHERE c.CartId = @ShoppingCartId;`
- **DMS Status**: error
- **DMS Error**: Metadata model creation failed: No objects were found according to the specified selection rules.
- **DMS Timestamp**: 2026-03-22T17:27:03
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Manual Output**: `SELECT SUM(c.count * p.price) FROM gadgetsonline_dbo.carts c INNER JOIN gadgetsonline_dbo.products p ON c.productid = p.productid WHERE c.cartid = @ShoppingCartId;`

### Statement 9: ShoppingCart.AddToCart - Select
- **Source File**: Services/ShoppingCart.cs
- **DMS Input**: `SELECT TOP 1 RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @ShoppingCartId AND ProductId = @ProductId;`
- **DMS Status**: error
- **DMS Error**: Metadata model creation failed: No objects were found according to the specified selection rules.
- **DMS Timestamp**: 2026-03-22T17:27:19
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Manual Output**: `SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @ShoppingCartId AND productid = @ProductId LIMIT 1;`

### Statement 10: ShoppingCart.AddToCart - Insert
- **Source File**: Services/ShoppingCart.cs
- **DMS Input**: `INSERT INTO dbo.Carts (CartId, ProductId, Count, DateCreated) VALUES (@CartId, @ProductId, @Count, @DateCreated);`
- **DMS Status**: error
- **DMS Error**: Metadata model creation failed: No objects were found according to the specified selection rules.
- **DMS Timestamp**: 2026-03-22T17:27:34
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Manual Output**: `INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated) VALUES (@CartId, @ProductId, @Count, @DateCreated);`

### Statement 11: ShoppingCart.RemoveFromCart - Select
- **Source File**: Services/ShoppingCart.cs
- **DMS Input**: `SELECT TOP 1 RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @ShoppingCartId AND ProductId = @ProductId;`
- **DMS Status**: error
- **DMS Error**: Metadata model creation failed: No objects were found according to the specified selection rules.
- **DMS Timestamp**: 2026-03-22T17:28:08
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Manual Output**: `SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @ShoppingCartId AND productid = @ProductId LIMIT 1;`

### Statement 12: ShoppingCart.RemoveFromCart - Delete
- **Source File**: Services/ShoppingCart.cs
- **DMS Input**: `DELETE FROM dbo.Carts WHERE RecordId = @RecordId;`
- **DMS Status**: error
- **DMS Error**: Metadata model creation failed: No objects were found according to the specified selection rules.
- **DMS Timestamp**: 2026-03-22T17:28:24
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Manual Output**: `DELETE FROM gadgetsonline_dbo.carts WHERE recordid = @RecordId;`

### Statement 13: ShoppingCart.RemoveFromCart - Update
- **Source File**: Services/ShoppingCart.cs
- **DMS Input**: `UPDATE dbo.Carts SET Count = Count - 1 WHERE RecordId = @RecordId;`
- **DMS Status**: error
- **DMS Error**: Metadata model creation failed: No objects were found according to the specified selection rules.
- **DMS Timestamp**: 2026-03-22T17:28:39
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Manual Output**: `UPDATE gadgetsonline_dbo.carts SET count = count - 1 WHERE recordid = @RecordId;`

### Statement 14: ShoppingCart.EmptyCart - Select
- **Source File**: Services/ShoppingCart.cs
- **DMS Input**: `SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @ShoppingCartId;`
- **DMS Status**: error
- **DMS Error**: Metadata model creation failed: No objects were found according to the specified selection rules.
- **DMS Timestamp**: 2026-03-22T17:28:55
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Manual Output**: `SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @ShoppingCartId;`

### Statement 15: ShoppingCart.EmptyCart - Delete
- **Source File**: Services/ShoppingCart.cs
- **DMS Input**: `DELETE FROM dbo.Carts WHERE CartId = @ShoppingCartId;`
- **DMS Status**: error
- **DMS Error**: Metadata model creation failed: No objects were found according to the specified selection rules.
- **DMS Timestamp**: 2026-03-22T17:29:10
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Manual Output**: `DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @ShoppingCartId;`

### Statement 16: ShoppingCart.CreateOrder - Insert OrderDetail
- **Source File**: Services/ShoppingCart.cs
- **DMS Input**: `INSERT INTO dbo.OrderDetails (ProductId, OrderId, UnitPrice, Quantity) VALUES (@ProductId, @OrderId, @UnitPrice, @Quantity);`
- **DMS Status**: error
- **DMS Error**: Metadata model creation failed: No objects were found according to the specified selection rules.
- **DMS Timestamp**: 2026-03-22T17:29:41
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Manual Output**: `INSERT INTO gadgetsonline_dbo.orderdetails (productid, orderid, unitprice, quantity) VALUES (@ProductId, @OrderId, @UnitPrice, @Quantity);`

### Statement 17: OrderProcessing.ProcessOrder - Insert Order
- **Source File**: Services/OrderProcessing.cs
- **DMS Input**: `INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@OrderDate, @Username, @FirstName, @LastName, @Address, @City, @State, @PostalCode, @Country, @Phone, @Email, @Total);`
- **DMS Status**: error
- **DMS Error**: Metadata model creation failed: No objects were found according to the specified selection rules.
- **DMS Timestamp**: 2026-03-22T17:29:58
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Manual Output**: `INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@OrderDate, @Username, @FirstName, @LastName, @Address, @City, @State, @PostalCode, @Country, @Phone, @Email, @Total);`

### Statement 18: GadgetsOnlineInitializer.Seed - Insert Categories
- **Source File**: Models/GadgetsOnlineInitializer.cs
- **DMS Input**: `INSERT INTO dbo.Categories (CategoryId, Name, Description) VALUES (@CategoryId, @Name, @Description);`
- **DMS Status**: error
- **DMS Error**: Metadata model creation failed: No objects were found according to the specified selection rules.
- **DMS Timestamp**: 2026-03-22T17:30:14
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Manual Output**: `INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description) VALUES (@CategoryId, @Name, @Description);`

### Statement 19: GadgetsOnlineInitializer.Seed - Insert Products
- **Source File**: Models/GadgetsOnlineInitializer.cs
- **DMS Input**: `INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (@ProductId, @CategoryId, @Name, @Price, @ProductArtUrl);`
- **DMS Status**: error
- **DMS Error**: Metadata model creation failed: No objects were found according to the specified selection rules.
- **DMS Timestamp**: 2026-03-22T17:30:29
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Manual Output**: `INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (@ProductId, @CategoryId, @Name, @Price, @ProductArtUrl);`
