-- ============================================================
-- create_tables.sql
-- SQL Server / T-SQL
-- Run after create_database.sql.
-- ============================================================

USE GradInterviewSQL;
GO

IF OBJECT_ID('eng_orders', 'U')            IS NOT NULL DROP TABLE eng_orders;
IF OBJECT_ID('eng_customers', 'U')         IS NOT NULL DROP TABLE eng_customers;
IF OBJECT_ID('sales_reps', 'U')            IS NOT NULL DROP TABLE sales_reps;
IF OBJECT_ID('nv_promotions', 'U')         IS NOT NULL DROP TABLE nv_promotions;
IF OBJECT_ID('nv_orders', 'U')             IS NOT NULL DROP TABLE nv_orders;
IF OBJECT_ID('nv_customers', 'U')          IS NOT NULL DROP TABLE nv_customers;
IF OBJECT_ID('blacklisted_customers', 'U') IS NOT NULL DROP TABLE blacklisted_customers;
IF OBJECT_ID('product_promotions', 'U')    IS NOT NULL DROP TABLE product_promotions;
IF OBJECT_ID('order_items', 'U')           IS NOT NULL DROP TABLE order_items;
IF OBJECT_ID('orders', 'U')                IS NOT NULL DROP TABLE orders;
IF OBJECT_ID('customers', 'U')             IS NOT NULL DROP TABLE customers;
IF OBJECT_ID('regions', 'U')               IS NOT NULL DROP TABLE regions;
GO

-- ------------------------------------------------------------
-- Exercise 1: Revenue by Region
-- ------------------------------------------------------------
CREATE TABLE regions (
    region_id   INT PRIMARY KEY,
    region_name VARCHAR(50)
);

CREATE TABLE customers (
    customer_id   INT PRIMARY KEY,
    customer_name VARCHAR(100),
    region_id     INT
);

CREATE TABLE orders (
    order_id    INT PRIMARY KEY,
    customer_id VARCHAR(10),
    order_date  VARCHAR(10),
    region_id   INT
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id      INT,
    product_id    INT,
    quantity      INT,
    unit_price    DECIMAL(10,2)
);

CREATE TABLE product_promotions (
    promo_id    INT PRIMARY KEY,
    product_id  INT,
    promo_code  VARCHAR(20),
    is_active   CHAR(1)
);

CREATE TABLE blacklisted_customers (
    customer_id INT
);

-- ------------------------------------------------------------
-- Exercise 2: Nested Views (reuses "regions" above)
-- ------------------------------------------------------------
CREATE TABLE nv_customers (
    customer_id   INT PRIMARY KEY,
    customer_name VARCHAR(100),
    region_id     INT
);

CREATE TABLE nv_orders (
    order_id     INT PRIMARY KEY,
    customer_id  INT,
    order_amount DECIMAL(10,2),
    status       VARCHAR(20),
    region_id    INT
);

CREATE TABLE nv_promotions (
    promo_id    INT PRIMARY KEY,
    customer_id INT,
    promo_code  VARCHAR(20)
);

-- ------------------------------------------------------------
-- Exercise 3: Customer Engagement Summary
-- ------------------------------------------------------------
CREATE TABLE sales_reps (
    sales_rep_id INT PRIMARY KEY,
    rep_name     VARCHAR(100)
);

CREATE TABLE eng_customers (
    customer_id   INT PRIMARY KEY,
    first_name    VARCHAR(50),
    middle_name   VARCHAR(50) NULL,
    last_name     VARCHAR(50),
    email         VARCHAR(100) NULL,
    sales_rep_id  INT NULL
);

CREATE TABLE eng_orders (
    order_id      INT PRIMARY KEY,
    customer_id   INT,
    discount_pct  DECIMAL(5,2) NULL,
    order_amount  DECIMAL(10,2),
    status        CHAR(1)
);

-- ------------------------------------------------------------
-- Exercise 4: Weekend Offer Calendar
-- No tables required — pure date logic.
-- ------------------------------------------------------------
GO
