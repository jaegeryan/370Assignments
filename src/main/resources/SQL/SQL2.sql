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

-- 添加租赁
START TRANSACTION;

INSERT INTO rentals (customer_id, console_id, rental_date, status)
VALUES (1, 2, NOW(), 'ongoing');

COMMIT;

-- 更新租赁
START TRANSACTION;

UPDATE rentals
SET status = 'completed'
WHERE rental_id = 1;

COMMIT;

-- 查看记录

SELECT * FROM rentals;

-- 计算总费用
SELECT rental_id, customer_id, console_id, 
       DATEDIFF(return_date, rental_date) * rental_fee AS total_fee
FROM rentals
JOIN consoles ON rentals.console_id = consoles.console_id;


-- 记录交易

START TRANSACTION;

INSERT INTO transactions (rental_id, amount, payment_method, transaction_date)
VALUES (1, 100.00, 'Credit Card', NOW());

COMMIT;

-- 查看交易记录
SELECT * FROM transactions;

-- 添加vip客户
START TRANSACTION;

INSERT INTO VIP_Customers (Customer_ID, Membership_Level, Additional_Discount)
VALUES (1, 'Gold', 0.05); 

COMMIT;
-- 更新vip客户
START TRANSACTION;

UPDATE VIP_Customers
SET Membership_Level = 'Platinum',  -- 更新会员等级
    Additional_Discount = 0.10  -- 更新额外折扣
WHERE Customer_ID = 1;  -- 示例客户ID，根据实际情况修改

COMMIT;
-- 查看客户信息
SELECT c.customer_id, 
       c.first_name, 
       c.last_name, 
       c.email, 
       c.phone_number, 
       c.address, 
       v.Membership_Level, 
       v.Additional_Discount
FROM Customers c
JOIN VIP_Customers v ON c.customer_id = v.Customer_ID;


-- 计算普通用户的总花费以及包括是不是vip客户
DELIMITER //

CREATE PROCEDURE calculate_total_fee(IN rentalId INT, OUT totalFee DECIMAL(10, 2))
BEGIN
    DECLARE vipDiscount DECIMAL(5, 2);
    DECLARE originalFee DECIMAL(10, 2);

    -- 获取原始费用
    SELECT DATEDIFF(r.return_date, r.rental_date) * c.rental_fee
    INTO originalFee
    FROM rentals r
    JOIN consoles c ON r.console_id = c.console_id
    WHERE r.rental_id = rentalId;

    -- 检查客户是否为VIP客户并获取额外折扣
    SELECT v.Additional_Discount INTO vipDiscount
    FROM rentals r
    JOIN customers cu ON r.customer_id = cu.customer_id
    LEFT JOIN VIP_Customers v ON cu.customer_id = v.Customer_ID
    WHERE r.rental_id = rentalId;

    -- 计算总费用
    IF vipDiscount IS NOT NULL THEN
        SET totalFee = originalFee * (1 - (0.20 + vipDiscount));
    ELSE
        SET totalFee = originalFee;
    END IF;
END //

DELIMITER ;
-- 调用
CALL calculate_total_fee(1, @totalFee);
SELECT @totalFee;

