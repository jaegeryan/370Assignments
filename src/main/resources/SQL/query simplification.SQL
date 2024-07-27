-- query simplification
-- query1: list all customers that
FROM Customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM Rentals r
    WHERE r.customer_id = c.customer_id
);
-- simplified query
SELECT c.customer_id, c.first_name, c.last_name
FROM Customers c
LEFT JOIN Rentals r ON c.customer_id = r.customer_id
WHERE r.customer_id IS NULL;

-- query2: search the last rental information for all customers who
-- registered after a certain date
SELECT c.customer_id, c.first_name, c.last_name, c.created_at,
       (SELECT r.rental_start_date
        FROM Rentals r
        WHERE r.customer_id = c.customer_id
        ORDER BY r.rental_start_date DESC
        LIMIT 1) AS last_rental_date
FROM Customers c
WHERE c.created_at > '2023-01-01';
-- simplified query
SELECT c.customer_id, c.first_name, c.last_name, c.created_at, MAX(r.rental_start_date) AS last_rental_date
FROM Customers c
LEFT JOIN Rentals r ON c.customer_id = r.customer_id
WHERE c.created_at > '2023-01-01'
GROUP BY c.customer_id;

-- qeury3: list the console model that are most frequently rented
SELECT cons.type, cons.model
FROM Consoles cons
WHERE cons.console_id = (
    SELECT i.console_id
    FROM Rentals r
    JOIN Inventory i ON r.inventory_id = i.inventory_id
    WHERE i.console_id = cons.console_id
    GROUP BY i.console_id
    ORDER BY COUNT(r.rental_id) DESC
    LIMIT 1
);
-- simplified query
SELECT cons.type, cons.model, COUNT(r.rental_id) AS rental_count
FROM Consoles cons
JOIN Inventory i ON cons.console_id = i.console_id
JOIN Rentals r ON i.inventory_id = r.inventory_id
GROUP BY cons.type, cons.model
ORDER BY rental_count DESC;