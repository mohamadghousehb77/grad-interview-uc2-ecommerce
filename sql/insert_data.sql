-- ============================================================
-- insert_data.sql
-- SQL Server / T-SQL
-- Run after create_tables.sql.
-- ============================================================

USE GradInterviewSQL;
GO

-- ------------------------------------------------------------
-- Exercise 1: Revenue by Region
-- ------------------------------------------------------------
INSERT INTO regions (region_id, region_name) VALUES
(1, 'North'), (2, 'South'), (3, 'East'), (4, 'West');

INSERT INTO customers (customer_id, customer_name, region_id) VALUES
(1,  'Aarav Traders',      1),
(2,  'Bala Textiles',      2),
(3,  'Chitra Foods',       3),
(4,  'Deepak Motors',      4),
(5,  'Elango Steel',       1),
(6,  'Farida Exports',     2),
(7,  'Ganesh Logistics',   3),
(8,  'Harini Retail',      4),
(9,  'Ilango Pharma',      1),
(10, 'Jaya Electronics',   2),
(11, 'Kavya Chemicals',    3),
(12, 'Lokesh Furniture',   4),
(13, 'Meena Agro',         1),
(14, 'Naveen Plastics',    2),
(15, 'Om Enterprises',     3);

INSERT INTO orders (order_id, customer_id, order_date, region_id) VALUES
(100, '1',   '02-06-2024', 1),
(101, '2',   '05-06-2024', 2),
(102, '3',   '10-06-2024', 3),
(103, '4',   '12-06-2024', 4),
(104, '5',   '01-06-2024', 1),
(105, '6',   '07-06-2024', 2),
(106, '007', '15-06-2024', 3),
(107, '8',   '20-06-2024', 4),
(108, '9',   '03-06-2024', 1),
(109, '10',  '06-06-2024', 2),
(110, '11',  '09-06-2024', 3),
(111, '12',  '11-06-2024', 4),
(112, '13',  '04-06-2024', 1),
(113, '14',  '08-06-2024', 2),
(114, '15',  '25-06-2024', 3),
(115, '1',   '28-06-2024', 1),
(116, '3',   '30-06-2024', 3),
(117, '007', '18-06-2024', 3),
(118, '2',   '10-01-2024', 2),
(119, '5',   '15-02-2024', 1),
(120, '9',   '20-03-2024', 1),
(121, '11',  '05-04-2024', 3),
(122, '14',  '25-05-2024', 2),
(123, '4',   '12-07-2024', 4),
(124, '8',   '18-08-2024', 4),
(125, '13',  '22-09-2024', 1),
(126, '10',  '09-10-2024', 2),
(127, '15',  '14-11-2024', 3),
(128, '6',   '19-12-2024', 2),
(129, '3',   '05-12-2023', 3),
(130, '1',   '08-06-2025', 1);

INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price) VALUES
(1,  100, 1, 10, 100.00), (2,  101, 2,  5, 200.00), (3,  102, 1,  8, 100.00),
(4,  103, 3,  2, 500.00), (5,  104, 2,  6, 200.00), (6,  105, 1,  4, 100.00),
(7,  106, 4,  3, 150.00), (8,  107, 3,  1, 500.00), (9,  108, 1,  7, 100.00),
(10, 109, 2,  9, 200.00), (11, 110, 4,  2, 150.00), (12, 111, 1,  3, 100.00),
(13, 112, 3,  4, 500.00), (14, 113, 2,  5, 200.00), (15, 114, 1,  6, 100.00),
(16, 115, 4,  2, 150.00), (17, 116, 3,  3, 500.00), (18, 117, 2,  4, 200.00),
(19, 118, 1,  5, 100.00), (20, 119, 2,  3, 200.00), (21, 120, 3,  2, 500.00),
(22, 121, 4,  6, 150.00), (23, 122, 1,  4, 100.00), (24, 123, 2,  8, 200.00),
(25, 124, 3,  1, 500.00), (26, 125, 1, 10, 100.00), (27, 126, 4,  3, 150.00),
(28, 127, 2,  5, 200.00), (29, 128, 3,  2, 500.00), (30, 129, 1,  6, 100.00),
(31, 130, 4,  4, 150.00);

INSERT INTO product_promotions (promo_id, product_id, promo_code, is_active) VALUES
(1, 1, 'SUMMER10', 'Y'), (2, 1, 'FLASH5', 'Y'), (3, 2, 'SUMMER10', 'Y'),
(4, 2, 'LOYALTY', 'Y'),  (5, 3, 'SUMMER10', 'Y'), (6, 4, 'SUMMER10', 'Y');

INSERT INTO blacklisted_customers (customer_id) VALUES (99), (NULL);

-- ------------------------------------------------------------
-- Exercise 2: Nested Views
-- ------------------------------------------------------------
INSERT INTO nv_customers (customer_id, customer_name, region_id) VALUES
(1, 'Aarav Traders',  1), (2, 'Bala Textiles',  2), (3, 'Chitra Foods',   3),
(4, 'Deepak Motors',  4), (5, 'Elango Steel',   1), (6, 'Farida Exports', 2);

INSERT INTO nv_orders (order_id, customer_id, order_amount, status, region_id) VALUES
(100, 1, 500.00, 'ACTIVE',    1),
(101, 1, 300.00, 'CANCELLED', 1),
(102, 2, 400.00, 'ACTIVE',    2),
(103, 2, 200.00, 'REFUNDED',  2),
(104, 3, 600.00, 'PENDING',   3),
(105, 4, 350.00, 'ACTIVE',    4),
(106, 5, 450.00, 'ACTIVE',    1),
(107, 6, 250.00, 'CANCELLED', 2);

INSERT INTO nv_promotions (promo_id, customer_id, promo_code) VALUES
(1, 1, 'WELCOME10'), (2, 1, 'REPEAT5'), (3, 2, 'WELCOME10');

-- ------------------------------------------------------------
-- Exercise 3: Customer Engagement Summary
-- ------------------------------------------------------------
INSERT INTO sales_reps (sales_rep_id, rep_name) VALUES
(1, 'Priya Shankar'), (2, 'Rahul Menon'), (3, 'Sara Fernandez');

INSERT INTO eng_customers (customer_id, first_name, middle_name, last_name, email, sales_rep_id) VALUES
(1,  'Aarav',  NULL, 'Traders',     'aarav@example.com',   1),
(2,  'Bala',   'K',  'Textiles',    'bala@example.com',    1),
(3,  'Chitra', NULL, 'Foods',       NULL,                  2),
(4,  'Deepak', NULL, 'Motors',      'deepak@example.com',  2),
(5,  'Elango', 'R',  'Steel',       'elango@example.com',  3),
(6,  'Farida', NULL, 'Exports',     NULL,                  3),
(7,  'Ganesh', NULL, 'Logistics',   'ganesh@example.com',  NULL),
(8,  'Harini', 'S',  'Retail',      'harini@example.com',  NULL),
(9,  'Ilango', NULL, 'Pharma',      'ilango@example.com',  1),
(10, 'Jaya',   NULL, 'Electronics', 'jaya@example.com',    2);

INSERT INTO eng_orders (order_id, customer_id, discount_pct, order_amount, status) VALUES
(1,  1,  10.00, 500.00, 'A'), (2,  1,  NULL, 300.00, 'A'), (3,  2,  5.00,  200.00, 'I'),
(4,  3,  NULL,  450.00, 'P'), (5,  4,  15.00, 600.00, 'A'), (6,  5,  NULL,  250.00, 'A'),
(7,  6,  20.00, 700.00, 'P'), (8,  7,  NULL,  400.00, 'I'), (9,  8,  10.00, 350.00, 'A'),
(10, 9,  NULL,  550.00, 'P'), (11, 10, 5.00,  150.00, 'A');

-- ------------------------------------------------------------
-- Exercise 4: Weekend Offer Calendar — no data required.
-- ------------------------------------------------------------
GO
