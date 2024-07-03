-- INNER JOIN
-- Find the total amount spent by each customer using INNER JOIN
SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    SUM(t.amount) AS total_spent
FROM 
    customers c
INNER JOIN 
    rentals r ON c.customer_id = r.customer_id
INNER JOIN 
    transactions t ON r.rental_id = t.rental_id
GROUP BY 
    c.customer_id
ORDER BY 
    c.customer_id;
-- Find the total number of different consoles rented by each customer
SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    COUNT(DISTINCT i.console_id) AS number_of_different_consoles_rented
FROM 
    customers c
INNER JOIN 
    rentals r ON c.customer_id = r.customer_id
INNER JOIN 
    inventory i ON r.inventory_id = i.inventory_id
INNER JOIN 
    consoles con ON i.console_id = con.console_id
GROUP BY 
    c.customer_id;


-- LEFT JOIN
-- Find the total amount spent by each customer using LEFT JOIN
SELECT 
    cu.customer_id, 
    SUM(r.total_cost) AS total_cost
FROM 
    customers cu
LEFT JOIN 
    rentals r ON cu.customer_id = r.customer_id
GROUP BY 
    cu.customer_id
ORDER BY 
    cu.customer_id;



-- Find the total number of rentals for each customer using LEFT JOIN
SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    COUNT(r.rental_id) AS total_number
FROM 
    customers c
LEFT JOIN 
    rentals r ON c.customer_id = r.customer_id
GROUP BY 
    c.customer_id;

-- Find the most recent rental details for each console
SELECT 
    con.console_id, 
    con.model, 
    r.rental_start_date, 
    r.rental_end_date
FROM 
    consoles con
LEFT JOIN 
    inventory i ON con.console_id = i.console_id
LEFT JOIN 
    rentals r ON i.inventory_id = r.inventory_id
ORDER BY 
    con.console_id, 
    r.rental_start_date DESC;

-- RIGHT JOIN
-- Find the total amount spent by each customer using RIGHT JOIN
SELECT 
    cu.customer_id, 
    SUM(r.total_cost) AS total_cost
FROM 
    customers cu
RIGHT JOIN 
    rentals r ON cu.customer_id = r.customer_id
GROUP BY 
    cu.customer_id
ORDER BY 
    cu.customer_id;
