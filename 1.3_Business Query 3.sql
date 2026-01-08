-- Query 3

WITH monthly_sales AS (
    SELECT
        MONTH(o.order_date) AS month_number,
        DATENAME(MONTH, o.order_date) AS month_name,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(oi.subtotal) AS monthly_revenue
    FROM dbo.orders o
    JOIN dbo.order_items oi
        ON o.order_id = oi.order_id
    WHERE YEAR(o.order_date) = 2024
    GROUP BY
        MONTH(o.order_date),
        DATENAME(MONTH, o.order_date)
)
SELECT
    month_name,
    total_orders,
    monthly_revenue,
    SUM(monthly_revenue) OVER (
        ORDER BY month_number
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_revenue
FROM monthly_sales
ORDER BY month_number;
