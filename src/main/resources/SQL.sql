-- Add New Customer

START TRANSACTION;

INSERT INTO customers (first_name, last_name, email, phone_number, address, created_at)
VALUES ('John', 'Doe', 'john.doe@example.com', '1234567890', '123 Elm St, Springfield', NOW());

COMMIT;

-- Update customer information
-- Update email
START TRANSACTION;

UPDATE customers
SET email = 'twilliams@example.org', phone_number = '0987654321'
WHERE customer_id = 1;

COMMIT;

-- Update address
START TRANSACTION;

UPDATE customers
SET address = '84493 Eric Plain
Port Rickyhaven, KY 31702'
WHERE customer_id = 1;

COMMIT;

-- View specific customer details
SELECT * FROM Customers WHERE customer_id = 1;

-- View specific customer details include rental history
SELECT c.customer_id,
       first_name,
       last_name,
       email,
       phone_number,
       address,
       c.created_at,
       rewards_points,
       rental_id,
       inventory_id,
       rental_start_date,
       rental_end_date,
       rental_status,
       total_cost,r.created_at AS rental_created_at 
FROM Customers AS c
LEFT JOIN rentals AS r ON c.customer_id = r.customer_id 
where c.customer_id = 1;

-- Add a new console
START TRANSACTION;

INSERT INTO consoles (model, type, storage_capacity, purchase_date, cost)  
VALUES ('Xbox', 'Console', '512GB', CURRENT_TIMESTAMP, 399.99);

INSERT INTO inventory (console_id, serial_number, status)  
VALUES (LAST_INSERT_ID(), 'XB1234', 'Available');

COMMIT;

-- Update console status
START TRANSACTION;

UPDATE inventory  
SET status = 'Available'  
WHERE inventory_id = 101;

COMMIT;

START TRANSACTION;

UPDATE inventory  
SET status = 'Maintenance'  
WHERE inventory_id = 101;

COMMIT;

START TRANSACTION;

UPDATE inventory  
SET status = 'Rented'  
WHERE inventory_id = 101;

COMMIT;

-- View console details
SELECT   
    c.console_id,  
    c.model,  
    c.type,  
    c.storage_capacity,  
    c.purchase_date,  
    c.cost,  
    i.inventory_id,  
    i.serial_number,  
    i.status  
FROM   
    consoles c  
INNER JOIN   
    inventory i ON c.console_id = i.console_id;

-- View a specific console detail
SELECT   
    c.console_id,  
    c.model,  
    c.type,  
    c.storage_capacity,  
    c.purchase_date,  
    c.cost,  
    i.inventory_id,  
    i.serial_number,  
    i.status  
FROM   
    consoles c  
INNER JOIN   
    inventory i ON c.console_id = i.console_id
WHERE c.console_id = 51;

-- View inventory details
SELECT * FROM inventory;

-- View a specific inventory detail
SELECT * FROM inventory WHERE inventory_id = 101;

-- View specific model consoles
SELECT   
    c.console_id,  
    c.model,  
    c.type,  
    c.storage_capacity,  
    c.purchase_date,  
    c.cost,  
    i.inventory_id,  
    i.serial_number,  
    i.status  
FROM   
    consoles c  
INNER JOIN   
    inventory i ON c.console_id = i.console_id
WHERE model = 'PlayStation 5';

-- View available consoles
SELECT   
    c.console_id,  
    c.model,  
    c.type,  
    c.storage_capacity,  
    c.purchase_date,  
    c.cost,  
    i.inventory_id,  
    i.serial_number,  
    i.status  
FROM   
    consoles c  
INNER JOIN   
    inventory i ON c.console_id = i.console_id
WHERE status = 'Available';

-- Add Reward Records for a customer
START TRANSACTION;

INSERT INTO membership_rewards (customer_id, reward_points, reward_date, Reward_description)  
VALUES (1,100, CURRENT_TIMESTAMP, 'Pre-paid Card $20');

COMMIT;

-- Update Reward_description
START TRANSACTION;

UPDATE membership_rewards  
SET reward_description = 'Spend 100 points to get $20 gift card'  
WHERE reward_id = 1;

COMMIT;

-- View a specific customer's reward records
SELECT c.customer_id,
       Reward_ID,
       first_name,
       last_name,
       c.rewards_points,
       m.Reward_points AS cost,
       Reward_date,
       Reward_description 
FROM Customers AS c
LEFT JOIN membership_rewards AS m
ON c.customer_id = m.customer_id
WHERE c.customer_id = 1;