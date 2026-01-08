-- this code is on SQL Server Managment Studios
SELECT
    COALESCE(c.firstname + ' ' + c.lastname, CAST(o.customerid AS NVARCHAR(200))) AS customer_name,
    COALESCE(c.email, CAST(o.customerid AS NVARCHAR(200))) AS email,
    COUNT(*) AS total_orders,
    SUM(COALESCE(o.totalamount, 0)) AS total_spent
FROM dbo.orders AS o
LEFT JOIN dbo.customers AS c
    ON o.customerid = c.email
GROUP BY
    COALESCE(c.firstname + ' ' + c.lastname, CAST(o.customerid AS NVARCHAR(200))),
    COALESCE(c.email, CAST(o.customerid AS NVARCHAR(200)))
ORDER BY SUM(COALESCE(o.totalamount, 0)) DESC;
