-- INNER JOIN
-- To find the total amount spent by each customer, we need to join the Customers table with the Rentals and Transactions tables.
-- We can use an INNER JOIN to combine the data from these tables based on the customer_id column.
SELECT c.customer_id, c.first_name, c.last_name, SUM(t.amount) as total_spent
FROM Customers c
INNER JOIN Rentals r ON c.customer_id = r.customer_id
INNER JOIN Transactions t ON r.rental_id = t.rental_id 
GROUP BY c.customer_id
ORDER BY customer_id;

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
SELECT cu.customer_id, SUM(total_cost) as total_cost
FROM Customers cu
LEFT JOIN rentals r ON cu.customer_id = r.customer_id
GROUP BY cu.customer_id
ORDER BY customer_id

-- To find the total number of rentals for each customer,
-- we can use a LEFT JOIN to include all customers even if they have not rented any consoles.
SELECT count(*) as total_number, c.customer_id, c.first_name, c.last_name
FROM Customers c
LEFT JOIN 
		Rentals r ON c.customer_id = r.customer_id
GROUP BY c.customer_id;

-- To find the most recent rental details for each console,
-- we can use a LEFT JOIN to include all consoles even if they have not been rented.
SELECT con.console_id, con.model, r.rental_start_date, r.rental_end_date
FROM Consoles con
LEFT JOIN Inventory i ON con.console_id = i.console_id
LEFT JOIN Rentals r ON i.inventory_id = r.inventory_id
ORDER BY con.console_id, r.rental_start_date DESC;

-- RIGHT JOIN
-- To find the total amount spent by each customer,
-- we need to join the Customers table with the Rentals and Transactions tables.
SELECT cu.customer_id, SUM(total_cost) as total_cost
FROM Customers cu
RIGHT JOIN rentals r ON cu.customer_id = r.customer_id
GROUP BY cu.customer_id
ORDER BY customer_id;
