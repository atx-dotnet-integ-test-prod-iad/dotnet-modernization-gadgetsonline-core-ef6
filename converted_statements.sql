-- ============================================================================
-- Converted PostgreSQL Statements for GadgetsOnline Application
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS tool failed for all statements; manual conversion applied with lowercase schema objects
-- Date: 2026-03-27
-- ============================================================================

-- Statement 1: Products table (converted from dbo.Products)
CREATE TABLE gadgetsonline_dbo.products (
    productid SERIAL PRIMARY KEY,
    categoryid INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL,
    price NUMERIC(18,2) NOT NULL,
    productarturl VARCHAR(1024) NULL,
    CONSTRAINT fk_products_categories FOREIGN KEY (categoryid) REFERENCES gadgetsonline_dbo.categories(categoryid)
);

-- Statement 2: Categories table (converted from dbo.Categories)
CREATE TABLE gadgetsonline_dbo.categories (
    categoryid SERIAL PRIMARY KEY,
    name TEXT NULL,
    description TEXT NULL
);

-- Statement 3: Carts table (converted from dbo.Carts)
CREATE TABLE gadgetsonline_dbo.carts (
    recordid SERIAL PRIMARY KEY,
    cartid TEXT NULL,
    productid INTEGER NOT NULL,
    count INTEGER NOT NULL,
    datecreated TIMESTAMP NOT NULL,
    CONSTRAINT fk_carts_products FOREIGN KEY (productid) REFERENCES gadgetsonline_dbo.products(productid)
);

-- Statement 4: Orders table (converted from dbo.Orders)
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
    total NUMERIC(18,2) NOT NULL
);

-- Statement 5: OrderDetails table (converted from dbo.OrderDetails)
CREATE TABLE gadgetsonline_dbo.orderdetails (
    orderdetailid SERIAL PRIMARY KEY,
    orderid INTEGER NOT NULL,
    productid INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    unitprice NUMERIC(18,2) NOT NULL,
    CONSTRAINT fk_orderdetails_orders FOREIGN KEY (orderid) REFERENCES gadgetsonline_dbo.orders(orderid),
    CONSTRAINT fk_orderdetails_products FOREIGN KEY (productid) REFERENCES gadgetsonline_dbo.products(productid)
);
