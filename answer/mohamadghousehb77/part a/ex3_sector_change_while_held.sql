-- Check the bad blacklist data
SELECT *
FROM blacklisted_customers;

-- Demonstrate the NULL problem with NOT IN
SELECT c.customer_id
FROM customers c
WHERE c.customer_id NOT IN
(
    SELECT customer_id
    FROM blacklisted_customers
);

-- Check duplicate active promotions
SELECT
    product_id,
    COUNT(*) AS active_promotion_count
FROM product_promotions
WHERE is_active = 'Y'
GROUP BY product_id
HAVING COUNT(*) > 1;

-- Check the stored order dates as actual dates
SELECT
    order_id,
    order_date,
    TRY_CONVERT(DATE, order_date, 105) AS converted_order_date
FROM orders
ORDER BY order_id;

-- Validate the required executions
EXEC get_revenue_by_region_foramonth '202406';
EXEC get_revenue_by_region_foramonth '202412';
EXEC get_revenue_by_region_foramonth '202401';