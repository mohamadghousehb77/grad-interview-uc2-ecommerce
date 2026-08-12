USE GradInterviewSQL;
GO

CREATE OR ALTER VIEW vw_active_orders AS
SELECT
    o.order_id,
    o.customer_id,
    o.order_amount,
    o.region_id
FROM nv_orders o;
GO

CREATE OR ALTER VIEW vw_customer_promotions AS
SELECT
    p.customer_id,
    p.promo_code
FROM nv_promotions p;
GO

CREATE OR ALTER VIEW vw_order_with_promo AS
SELECT DISTINCT
    ao.order_id,
    ao.customer_id,
    ao.order_amount,
    ao.region_id
FROM vw_active_orders ao
LEFT JOIN vw_customer_promotions cp
    ON ao.customer_id = cp.customer_id;
GO

CREATE OR ALTER VIEW vw_region_revenue_report AS
SELECT
    r.region_name,
    SUM(owp.order_amount) AS total_revenue
FROM vw_order_with_promo owp
JOIN regions r
    ON owp.region_id = r.region_id
GROUP BY
    r.region_name;
GO

SELECT *
FROM vw_region_revenue_report
ORDER BY region_name;