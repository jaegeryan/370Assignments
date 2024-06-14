-- INNER JOIN
-- If you want to know which customers rented which consoles, you can use the following query:
SELECT c.customer_id, c.first_name, c.last_name, con.model
FROM Customers c
INNER JOIN Rentals r ON c.customer_id = r.customer_id
INNER JOIN Consoles con ON r.console_id = con.console_id;

-- If you want to know which customers rented which consoles and the rental start date, you can use the following query:
SELECT c.customer_id, c.first_name, c.last_name, COUNT(DISTINCT r.console_id) AS number_of_different_consoles_rented
FROM Customers c
INNER JOIN Rentals r ON c.customer_id = r.customer_id
INNER JOIN Consoles con ON r.console_id = con.console_id
GROUP BY c.customer_id;

-- LEFT JOIN
-- If you want to know all the consoles and whether they have been rented or not, you can use the following query:
SELECT con.console_id, con.model, r.rental_id
FROM Consoles con
LEFT JOIN Rentals r ON con.console_id = r.console_id;

--
SELECT c.customer_id, c.first_name, c.last_name, r.rental_start_date, r.rental_end_date
FROM Customers c
LEFT JOIN (
    SELECT *
    FROM Rentals
    ORDER BY rental_start_date DESC
) r ON c.customer_id = r.customer_id
GROUP BY c.customer_id;

SELECT con.console_id, con.model, r.rental_start_date, r.rental_end_date
FROM Consoles con
LEFT JOIN (
    SELECT *
    FROM Rentals
    ORDER BY rental_start_date DESC
) r ON con.console_id = r.console_id
GROUP BY con.console_id;

-- RIGHT JOIN
SELECT con.console_id, con.model, r.rental_id
FROM Consoles con
RIGHT JOIN Rentals r ON con.console_id = r.console_id;