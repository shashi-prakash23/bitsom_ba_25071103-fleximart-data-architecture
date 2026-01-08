-- Query 1: Customer Purchase History
--SELECT
    c.first_name + ' ' + c.last_name AS customer_name,
    c.email,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.subtotal) AS total_amount_spent
FROM dbo.customers c
JOIN dbo.orders o
    ON c.customer_id = o.customer_id
JOIN dbo.order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.first_name,
    c.last_name,
    c.email
HAVING
    COUNT(DISTINCT o.order_id) >= 2
    AND SUM(oi.subtotal) > 5000
ORDER BY
    total_amount_spent DESC;
