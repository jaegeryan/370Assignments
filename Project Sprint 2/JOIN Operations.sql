-- INNER JOIN
-- To find the total amount spent by each customer, we need to join the Customers table with the Rentals and Transactions tables.
-- We can use an INNER JOIN to combine the data from these tables based on the customer_id column.
SELECT c.customer_id, c.first_name, c.last_name, con.model
FROM Customers c
INNER JOIN Rentals r ON c.customer_id = r.customer_id
INNER JOIN Inventory i ON r.inventory_id = i.inventory_id
INNER JOIN Consoles con ON i.console_id = con.console_id;

-- To find the total number of different consoles rented by each customer,
-- we can use an INNER JOIN to combine the Customers, Rentals, Inventory, and Consoles tables.
SELECT c.customer_id, c.first_name, c.last_name, COUNT(DISTINCT i.console_id) AS number_of_different_consoles_rented
FROM Customers c
INNER JOIN Rentals r ON c.customer_id = r.customer_id
INNER JOIN Inventory i ON r.inventory_id = i.inventory_id
INNER JOIN Consoles con ON i.console_id = con.console_id
GROUP BY c.customer_id;

-- LEFT JOIN
-- To find the total amount spent by each customer,
-- we need to join the Customers table with the Rentals and Transactions tables.
SELECT con.console_id, con.model, r.rental_id
FROM Consoles con
LEFT JOIN Inventory i ON con.console_id = i.console_id
LEFT JOIN Rentals r ON i.inventory_id = r.inventory_id;

-- To find the total number of rentals for each customer,
-- we can use a LEFT JOIN to include all customers even if they have not rented any consoles.
SELECT c.customer_id, c.first_name, c.last_name, r.rental_start_date, r.rental_end_date
FROM Customers c
LEFT JOIN (
    SELECT *
    FROM Rentals
    ORDER BY rental_start_date DESC
) r ON c.customer_id = r.customer_id
GROUP BY c.customer_id;

-- To find the most recent rental details for each console,
-- we can use a LEFT JOIN to include all consoles even if they have not been rented.
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
-- To find the total amount spent by each customer,
-- we need to join the Customers table with the Rentals and Transactions tables.
SELECT con.console_id, con.model, r.rental_id
FROM Consoles con
RIGHT JOIN Inventory i ON con.console_id = i.console_id
RIGHT JOIN Rentals r ON i.inventory_id = r.inventory_id;
