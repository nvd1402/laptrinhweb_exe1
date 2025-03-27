----b Truy vấn đơn hàng
---1.
SELECT users.user_id, users.user_name, orders.order_id
FROM users
JOIN orders ON users.user_id = orders.user_id;
---2.
SELECT users.user_id, users.user_name, COUNT(orders.order_id) AS number_of_orders
FROM users
JOIN orders ON users.user_id = orders.user_id
GROUP BY users.user_id;


---3.
SELECT orders.order_id, COUNT(order_details.product_id) AS number_of_products
FROM orders
JOIN order_details ON orders.order_id = order_details.order_id
GROUP BY orders.order_id;

---4.
SELECT users.user_id, users.user_name, orders.order_id, products.product_name
FROM users
JOIN orders ON users.user_id = orders.user_id
JOIN order_details ON orders.order_id = order_details.order_id
JOIN products ON order_details.product_id = products.product_id;

---5.
SELECT users.user_id, users.user_name, COUNT(orders.order_id) AS number_of_orders
FROM users
JOIN orders ON users.user_id = orders.user_id
GROUP BY users.user_id
ORDER BY number_of_orders DESC
LIMIT 7;

---6
SELECT users.user_id, users.user_name, orders.order_id, products.product_name
FROM users
JOIN orders ON users.user_id = orders.user_id
JOIN order_details ON orders.order_id = order_details.order_id
JOIN products ON order_details.product_id = products.product_id
WHERE products.product_name LIKE '%Samsung%' OR products.product_name LIKE '%Apple%'
LIMIT 7;

---7
SELECT users.user_id, users.user_name, orders.order_id, SUM(products.product_price) AS total_amount
FROM users
JOIN orders ON users.user_id = orders.user_id
JOIN order_details ON orders.order_id = order_details.order_id
JOIN products ON order_details.product_id = products.product_id
GROUP BY orders.order_id;

---8
SELECT users.user_id, users.user_name, orders.order_id, SUM(products.product_price) AS total_amount
FROM users
JOIN orders ON users.user_id = orders.user_id
JOIN order_details ON orders.order_id = order_details.order_id
JOIN products ON order_details.product_id = products.product_id
JOIN (
    SELECT orders.user_id, orders.order_id, SUM(products.product_price) AS total_amount
    FROM orders
    JOIN order_details ON orders.order_id = order_details.order_id
    JOIN products ON order_details.product_id = products.product_id
    GROUP BY orders.user_id, orders.order_id
) AS order_totals ON orders.user_id = order_totals.user_id AND orders.order_id = order_totals.order_id
JOIN (
    SELECT orders.user_id, MAX(order_totals.total_amount) AS max_total_amount
    FROM orders
    JOIN (
        SELECT orders.user_id, orders.order_id, SUM(products.product_price) AS total_amount
        FROM orders
        JOIN order_details ON orders.order_id = order_details.order_id
        JOIN products ON order_details.product_id = products.product_id
        GROUP BY orders.user_id, orders.order_id
    ) AS order_totals ON orders.order_id = order_totals.order_id
    GROUP BY orders.user_id
) AS max_orders ON orders.user_id = max_orders.user_id AND order_totals.total_amount = max_orders.max_total_amount
GROUP BY users.user_id, orders.order_id;


---9
SELECT users.user_id, users.user_name, orders.order_id, SUM(products.product_price) AS total_amount, COUNT(order_details.product_id) AS number_of_products
FROM users
JOIN orders ON users.user_id = orders.user_id
JOIN order_details ON orders.order_id = order_details.order_id
JOIN products ON order_details.product_id = products.product_id
JOIN (
    SELECT orders.user_id, orders.order_id, SUM(products.product_price) AS total_amount
    FROM orders
    JOIN order_details ON orders.order_id = order_details.order_id
    JOIN products ON order_details.product_id = products.product_id
    GROUP BY orders.user_id, orders.order_id
) AS order_totals ON orders.user_id = order_totals.user_id AND orders.order_id = order_totals.order_id
JOIN (
    SELECT orders.user_id, MIN(order_totals.total_amount) AS min_total_amount
    FROM orders
    JOIN (
        SELECT orders.user_id, orders.order_id, SUM(products.product_price) AS total_amount
        FROM orders
        JOIN order_details ON orders.order_id = order_details.order_id
        JOIN products ON order_details.product_id = products.product_id
        GROUP BY orders.user_id, orders.order_id
    ) AS order_totals ON orders.order_id = order_totals.order_id
    GROUP BY orders.user_id
) AS min_orders ON orders.user_id = min_orders.user_id AND order_totals.total_amount = min_orders.min_total_amount
GROUP BY users.user_id, orders.order_id;


---10

SELECT users.user_id, users.user_name, orders.order_id, SUM(products.product_price) AS total_amount, COUNT(order_details.product_id) AS number_of_products
FROM users
JOIN orders ON users.user_id = orders.user_id
JOIN order_details ON orders.order_id = order_details.order_id
JOIN products ON order_details.product_id = products.product_id
JOIN (
    SELECT orders.user_id, orders.order_id, COUNT(order_details.product_id) AS number_of_products
    FROM orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.user_id, orders.order_id
) AS product_counts ON orders.user_id = product_counts.user_id AND orders.order_id = product_counts.order_id
JOIN (
    SELECT orders.user_id, MAX(product_counts.number_of_products) AS max_number_of_products
    FROM orders
    JOIN (
        SELECT orders.user_id, orders.order_id, COUNT(order_details.product_id) AS number_of_products
        FROM orders
        JOIN order_details ON orders.order_id = order_details.order_id
        GROUP BY orders.user_id, orders.order_id
    ) AS product_counts ON orders.order_id = product_counts.order_id
    GROUP BY orders.user_id
) AS max_products ON orders.user_id = max_products.user_id AND product_counts.number_of_products = max_products.max_number_of_products
GROUP BY users.user_id, orders.order_id;
