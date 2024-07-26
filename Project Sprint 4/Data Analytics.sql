-- If indexes on customer_id and rental_id are not already created, create them to optimize the query.
CREATE INDEX idx_customer_id ON customers(customer_id);
CREATE INDEX idx_rental_id ON rentals(rental_id);
CREATE INDEX idx_console_id ON consoles(console_id);


-- Optimized INNER JOIN query to find the total amount spent by each customer
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

-- Or Optimized query to find the total amount spent by each customer
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
    total_spent DESC;

-- Optimized query using a view for employee access, excluding sensitive information
CREATE VIEW Customers_Info_For_Employees AS
SELECT customer_id, first_name, last_name, email, created_at
FROM customers;

-- Example of using the view for employee access
SELECT * FROM Customers_Info_For_Employees;

-- Create a view to store the precomputed total amount spent by each customer
CREATE VIEW total_amount_spent AS
SELECT
    c.customer_id,
    SUM(t.amount) AS total_spent
FROM
    customers c
JOIN
    rentals r ON c.customer_id = r.customer_id
JOIN
    transactions t ON r.rental_id = t.rental_id
GROUP BY
    c.customer_id;

-- Example of a scheduled job or manual query to update the table (specific implementation depends on your database system)

-- Creating a view that excludes customers' addresses and phone numbers
CREATE VIEW view_customers_safe AS
SELECT
    customer_id,
    first_name,
    last_name,
    email,
    created_at
FROM
    customers;

-- Creating a trigger to check rental dates
DELIMITER $$
CREATE TRIGGER trigger_check_rental_dates
BEFORE INSERT ON rentals
FOR EACH ROW
BEGIN
    IF NEW.rental_start_date >= NEW.rental_end_date THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Rental start date must be before the end date.';
    END IF;
END$$
DELIMITER ;

-- Incorporating data integrity check for rental dates
DELIMITER $$
CREATE TRIGGER Check_Rental_Dates
BEFORE INSERT ON rentals
FOR EACH ROW
BEGIN
    IF NEW.rental_end_date IS NOT NULL AND NEW.rental_start_date >= NEW.rental_end_date THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Rental start date must be before the end date';
    END IF;
END$$
DELIMITER ;

-- Insert example with data integrity check
INSERT INTO Rentals (customer_id, inventory_id, rental_start_date, rental_end_date, total_cost)
VALUES (10000, 100000, '2023-05-01', '2023-04-30', 50.00); -- !!!!! This should fail due to the trigger

-- Revoking unnecessary privileges from a role
REVOKE INSERT, UPDATE ON customers FROM some_role;

-- Granting necessary privileges to a role
GRANT SELECT ON view_customers_safe TO some_role;