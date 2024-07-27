-- 1. Trigger: Update Inventory Status on New Rental Insertion
CREATE TRIGGER after_rental_insert
AFTER INSERT ON Rentals
FOR EACH ROW
BEGIN
    UPDATE Inventory
    SET status = 'Rented'
    WHERE inventory_id = NEW.inventory_id;
END;

DROP TRIGGER after_rental_insert;

-- 2. Trigger: Update Inventory Status on Rental Completion
CREATE TRIGGER after_rental_update
AFTER UPDATE ON Rentals
FOR EACH ROW
BEGIN
    IF NEW.rental_status = 'Completed' THEN
        UPDATE Inventory
        SET status = 'Available'
        WHERE inventory_id = NEW.inventory_id;
    END IF;
END;

DROP TRIGGER after_rental_update;

-- 3. Trigger: Delete Related Reward Records on VIP Customer Deletion
CREATE TRIGGER after_vip_customer_delete
AFTER DELETE ON VIP_Customers
FOR EACH ROW
BEGIN
    DELETE FROM Membership_Rewards
    WHERE Customer_ID = OLD.Customer_ID;
END;

DROP TRIGGER after_vip_customer_delete;

-- 4. Trigger: Update Customer Rewards Points on Rental Completion
CREATE TRIGGER after_rental_completion
AFTER UPDATE ON Rentals
FOR EACH ROW
BEGIN
    IF NEW.rental_status = 'Completed' THEN
        UPDATE Customers
        SET rewards_points = rewards_points + NEW.total_cost
        WHERE customer_id = NEW.customer_id;
    END IF;
END;
DROP TRIGGER after_rental_completion;

-- 5. Trigger: Prevent Deleting a Console if It's Rented Out
CREATE TRIGGER before_console_delete
BEFORE DELETE ON Consoles
FOR EACH ROW
BEGIN
    DECLARE rental_count INT;

    SELECT COUNT(*) INTO rental_count
    FROM Inventory i
    JOIN Rentals r ON i.inventory_id = r.inventory_id
    WHERE i.console_id = OLD.console_id AND r.rental_status = 'Ongoing';

    IF rental_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete console as it is currently rented out';
    END IF;
END;

DROP TRIGGER before_console_delete;