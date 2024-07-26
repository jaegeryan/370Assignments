-- Implementing Consistency
-- Consistency ensures that a transaction brings the database from one valid state to another.
-- 1. Define and Apply Constraints
-- foreign keys, unique constraints, and data types, have already been defined which help maintain consistency.
-- 2. Validate Business Rules
-- ensure that inventory status is updated correctly and rental start and end dates are logical.


CREATE TRIGGER before_rental_insert
BEFORE INSERT ON Rentals
FOR EACH ROW
BEGIN
    -- Ensure the inventory item is available for rent
    IF (SELECT status FROM Inventory WHERE inventory_id = NEW.inventory_id) != 'Available' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Inventory item is not available for rent';
    END IF;

    -- Ensure rental start date is before the end date
    IF NEW.rental_end_date IS NOT NULL AND NEW.rental_start_date >= NEW.rental_end_date THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Rental start date must be before the end date';
    END IF;
END;

-- Use the following commends for demo
-- Attempt to insert the record where it is already rented
INSERT INTO Rentals (customer_id, inventory_id, rental_start_date, rental_end_date, total_cost)
VALUES (1, 1, NOW(), DATE_ADD(NOW(), INTERVAL 7 DAY), 50.00);

-- Attempt to insert the rental_start_date > rental_end_date
INSERT INTO Rentals (customer_id, inventory_id, rental_start_date, rental_end_date, total_cost)
VALUES (10000, 100000, DATE_ADD(NOW(), INTERVAL 7 DAY), NOW(), 50.00);
