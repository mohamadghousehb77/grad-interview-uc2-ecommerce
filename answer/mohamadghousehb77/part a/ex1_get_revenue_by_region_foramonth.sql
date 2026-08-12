USE GradInterviewSQL;
GO

IF OBJECT_ID('get_revenue_by_region_foramonth', 'P') IS NOT NULL
    DROP PROCEDURE get_revenue_by_region_foramonth;
GO

CREATE PROCEDURE get_revenue_by_region_foramonth
    @yearmonth VARCHAR(6)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @month_start DATE =
        TRY_CONVERT(DATE, @yearmonth + '01', 112);

    DECLARE @next_month DATE =
        DATEADD(MONTH, 1, @month_start);

    SELECT
        r.region_name,
        SUM(oi.quantity * oi.unit_price) AS total_revenue
    FROM orders o
    JOIN customers c
        ON TRY_CONVERT(INT, o.customer_id) = c.customer_id
    JOIN regions r
        ON c.region_id = r.region_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE TRY_CONVERT(DATE, o.order_date, 105) >= @month_start
      AND TRY_CONVERT(DATE, o.order_date, 105) < @next_month
      AND NOT EXISTS (
          SELECT 1
          FROM blacklisted_customers bc
          WHERE bc.customer_id = c.customer_id
      )
      AND EXISTS (
          SELECT 1
          FROM product_promotions pp
          WHERE pp.product_id = oi.product_id
            AND pp.is_active = 'Y'
      )
    GROUP BY r.region_name
    ORDER BY r.region_name;
END;
GO

EXEC get_revenue_by_region_foramonth '202406';
EXEC get_revenue_by_region_foramonth '202412';
EXEC get_revenue_by_region_foramonth '202401';