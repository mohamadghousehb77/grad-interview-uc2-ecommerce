-- ============================================================
-- stored_procedures.sql
-- SQL Server / T-SQL
-- Run after views.sql.
-- ============================================================

USE GradInterviewSQL;
GO

IF OBJECT_ID('get_revenue_by_region_foramonth', 'P') IS NOT NULL
    DROP PROCEDURE get_revenue_by_region_foramonth;
GO

-- ------------------------------------------------------------
-- Exercise 1: Revenue by Region
--
-- Bug report: "Finance flagged that the monthly regional revenue
-- numbers from this procedure don't look right. Numbers seem off
-- compared to what they're seeing in the source system."
-- ------------------------------------------------------------
CREATE PROCEDURE get_revenue_by_region_foramonth
    @yearmonth VARCHAR(6)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @lower_bound VARCHAR(10) = '01-' + RIGHT(@yearmonth, 2) + '-' + LEFT(@yearmonth, 4);
    DECLARE @upper_bound VARCHAR(10) = '31-' + RIGHT(@yearmonth, 2) + '-' + LEFT(@yearmonth, 4);
    SELECT
        r.region_name,
        SUM(oi.quantity * oi.unit_price) AS total_revenue
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN regions r ON c.region_id = r.region_id
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN product_promotions pp ON oi.product_id = pp.product_id AND pp.is_active = 'Y'
    WHERE o.order_date >= @lower_bound AND o.order_date <= @upper_bound
      AND o.customer_id NOT IN (SELECT customer_id FROM blacklisted_customers)
    GROUP BY r.region_name
    ORDER BY r.region_name;
END;
GO

-- ------------------------------------------------------------
-- Exercise 3: Customer Engagement Summary
-- get_customer_engagement_summary is NOT provided — build it from
-- scratch per the requirements in README.md.
-- ------------------------------------------------------------
