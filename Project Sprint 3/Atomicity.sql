-- Implementing Atomicity
-- Atomicity ensures that each transaction is all-or-nothing: it either completes entirely or not at all.
-- Transaction Management in MySQL:
-- Use BEGIN, COMMIT, and ROLLBACK to manage transactions.
-- Ensure that all operations that need to be completed together are included in the transaction.

-- Start a transaction
START TRANSACTION;

-- Example operations, you can use other invenrory id for demo.
UPDATE Inventory SET status = 'Rented' WHERE inventory_id = 1;
INSERT INTO Rentals (customer_id, inventory_id, rental_start_date, total_cost) VALUES (1, 1, NOW(), 50.00);

-- If everything is successful, commit the transaction
COMMIT;

-- If something goes wrong, rollback the transaction
ROLLBACK;

-- run this first, and then run the above, then run this again, make sure you change the id corresponding to above.
SELECT * FROM Inventory WHERE inventory_id = 1;

-- Implementing Consistency
-- Consistency ensures that a transaction brings the database from one valid state to another.
-- 1. Define and Apply Constraints
-- foreign keys, unique constraints, and data types, have already been defined which help maintain consistency.
-- 2. Validate Business Rules
-- ensure that inventory status is updated correctly and rental start and end dates are logical.
