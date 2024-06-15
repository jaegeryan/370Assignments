-- INNER JOIN
-- If you want to know which customers rented which consoles, you can use the following query:
SELECT c.customer_id, c.first_name, c.last_name, con.model
FROM Customers c
INNER JOIN Rentals r ON c.customer_id = r.customer_id
INNER JOIN Inventory i ON r.inventory_id = i.inventory_id
INNER JOIN Consoles con ON i.console_id = con.console_id;

-- If you want to know which customers rented which consoles and the rental start date, you can use the following query:
SELECT c.customer_id, c.first_name, c.last_name, COUNT(DISTINCT i.console_id) AS number_of_different_consoles_rented
FROM Customers c
INNER JOIN Rentals r ON c.customer_id = r.customer_id
INNER JOIN Inventory i ON r.inventory_id = i.inventory_id
GROUP BY c.customer_id;

-- LEFT JOIN
-- If you want to know all the consoles and whether they have been rented or not, you can use the following query:
SELECT con.console_id, con.model, r.rental_id
FROM Consoles con
LEFT JOIN Inventory i ON con.console_id = i.console_id
LEFT JOIN Rentals r ON i.inventory_id = r.inventory_id;

-- To retrieve the most recent rental record for each customer from a database.
SELECT c.customer_id, c.first_name, c.last_name, r.rental_start_date, r.rental_end_date
FROM Customers c
LEFT JOIN (
    SELECT *
    FROM Rentals
    ORDER BY rental_start_date DESC
) r ON c.customer_id = r.customer_id
GROUP BY c.customer_id;

-- This query returns the most recent rental record for each console.
SELECT con.console_id, con.model, r.rental_start_date, r.rental_end_date
FROM Consoles con
LEFT JOIN Inventory i ON con.console_id = i.console_id
LEFT JOIN (
    SELECT *
    FROM Rentals
    ORDER BY rental_start_date DESC
) r ON i.inventory_id = r.inventory_id
GROUP BY con.console_id;

-- RIGHT JOIN
--  This query returns a list of all rental records, along with the console information for those rentals that have a matching console.
-- If a rental does not have a matching console, the console information will be NULL.
SELECT con.console_id, con.model, r.rental_id
FROM Consoles con
RIGHT JOIN Inventory i ON con.console_id = i.console_id
RIGHT JOIN Rentals r ON i.inventory_id = r.inventory_id;