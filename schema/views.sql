-- ============================================================
-- views.sql
-- SQL Server / T-SQL
-- Run after insert_data.sql.
-- ============================================================

USE GradInterviewSQL;
GO

IF OBJECT_ID('vw_region_revenue_report', 'V') IS NOT NULL DROP VIEW vw_region_revenue_report;
IF OBJECT_ID('vw_order_with_promo', 'V')      IS NOT NULL DROP VIEW vw_order_with_promo;
IF OBJECT_ID('vw_customer_promotions', 'V')   IS NOT NULL DROP VIEW vw_customer_promotions;
IF OBJECT_ID('vw_active_orders', 'V')         IS NOT NULL DROP VIEW vw_active_orders;
GO

-- ------------------------------------------------------------
-- Exercise 2: Nested Views
-- ------------------------------------------------------------
CREATE VIEW vw_active_orders AS
SELECT o.order_id, o.customer_id, o.order_amount, o.region_id
FROM nv_orders o
WHERE o.status = 'ACTIVE';
GO

CREATE VIEW vw_customer_promotions AS
SELECT p.customer_id, p.promo_code
FROM nv_promotions p;
GO

CREATE VIEW vw_order_with_promo AS
SELECT ao.order_id, ao.customer_id, ao.order_amount, ao.region_id, cp.promo_code
FROM vw_active_orders ao
INNER JOIN vw_customer_promotions cp ON ao.customer_id = cp.customer_id;
GO

CREATE VIEW vw_region_revenue_report AS
SELECT r.region_name, SUM(owp.order_amount) AS total_revenue
FROM vw_order_with_promo owp
JOIN regions r ON owp.region_id = r.region_id
GROUP BY r.region_name;
GO
