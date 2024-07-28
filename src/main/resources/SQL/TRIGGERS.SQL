-- Trigger 1: Check if the Customer Exists
CREATE TRIGGER before_transaction_insert
BEFORE INSERT ON Transactions
FOR EACH ROW
BEGIN
    DECLARE customer_exists INT;

    SELECT COUNT(*) INTO customer_exists
    FROM Customers c
    JOIN Rentals r ON c.customer_id = r.customer_id
    WHERE r.rental_id = NEW.rental_id;

    IF customer_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Customer does not exist';
    END IF;
END;

-- Trigger 2: Update the Total Cost in the Rentals Table
CREATE TRIGGER after_transaction_insert_update_total_cost
AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
    UPDATE Rentals
    SET total_cost = (SELECT SUM(amount)
                      FROM Transactions
                      WHERE rental_id = NEW.rental_id)
    WHERE rental_id = NEW.rental_id;
END;

-- Trigger 3: Update Customer Rewards Points
CREATE TRIGGER after_transaction_insert_update_rewards
AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
    UPDATE Customers
    SET rewards_points = rewards_points + NEW.amount
    WHERE customer_id = (SELECT customer_id FROM Rentals WHERE rental_id = NEW.rental_id);
END;

-- Trigger 4: Update VIP Membership Level
CREATE TRIGGER after_transaction_insert_update_vip
AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
    UPDATE VIP_Customers
    SET Membership_Level = 'Gold'
    WHERE Customer_ID = (SELECT customer_id FROM Rentals WHERE rental_id = NEW.rental_id);
END;



-- Trigger5: Update console if console does not exists for new inserted inventory
CREATE
.m n TRIGGER after_inventory_insert
AFTER INSERT ON Inventory
FOR EACH ROW
BEGIN
    DECLARE console_exists INT;

    -- Check if there is a corresponding console record
    SELECT COUNT(*) INTO console_exists
    FROM Consoles
    WHERE console_id = NEW.console_id;

    -- If no corresponding console record exists, insert a new one
    IF console_exists = 0 THEN
        INSERT INTO Consoles (console_id, model, type, storage_capacity, purchase_date, cost)
        VALUES (NEW.console_id, 'Default Model', 'Default Type', 'Default Capacity', CURDATE(), 0.00);
    END IF;
END;

-- trigger 6
CREATE TRIGGER update_inventory_status_after_rental_end
AFTER UPDATE ON Rentals
FOR EACH ROW
BEGIN
    IF NEW.rental_end_date = CURDATE() THEN
        UPDATE Inventory
        SET status = 'Available'
        WHERE inventory_id = NEW.inventory_id;
    END IF;
END;

-- trigger 7
CREATE TRIGGER before_rental_insert_apply_vip_discount
BEFORE INSERT ON Rentals
FOR EACH ROW
BEGIN
    DECLARE vip_discount DECIMAL(5, 2);

    -- Check if the customer is a VIP and get the discount
    SELECT Additional_Discount INTO vip_discount
    FROM VIP_Customers
    WHERE Customer_ID = NEW.customer_id;

    -- If the customer is a VIP, apply the discount
    IF vip_discount IS NOT NULL THEN
        SET NEW.total_cost = NEW.total_cost * (1 - vip_discount);
    END IF;
END;