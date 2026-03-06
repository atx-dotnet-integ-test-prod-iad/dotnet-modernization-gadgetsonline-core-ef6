-- ============================================================================
-- CONVERTED SQL STATEMENTS CATALOG
-- Project: GadgetsOnline - SQL Server to PostgreSQL Migration
-- Date: 2026-03-06
-- ============================================================================

-- CONVERSION RESULTS:
-- No raw SQL statements were found in the codebase, therefore no SQL conversion
-- was needed via the DMS MCP tool.

-- The application uses Entity Framework 6 with LINQ queries exclusively.
-- EF6 with the Npgsql provider (EntityFramework6.Npgsql) automatically generates
-- PostgreSQL-compatible SQL at runtime.

-- All database schema mappings have been configured in GadgetsOnlineEntities.cs
-- using EF6 Fluent API with lowercase table/column names and the gadgetsonline_dbo schema:
--   - Product -> gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl)
--   - Category -> gadgetsonline_dbo.categories (categoryid, name, description)
--   - Cart -> gadgetsonline_dbo.carts (recordid, cartid, productid, count, datecreated)
--   - Order -> gadgetsonline_dbo.orders (orderid, orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total)
--   - OrderDetail -> gadgetsonline_dbo.orderdetails (orderdetailid, orderid, productid, quantity, unitprice)

-- No DMS MCP tool conversion was required.
-- No manual SQL conversion was required.
