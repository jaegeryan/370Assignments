-- 添加或更新客户存储过程
DELIMITER //

CREATE PROCEDURE add_or_update_customer(
    IN p_first_name VARCHAR(50), 
    IN p_last_name VARCHAR(50), 
    IN p_email VARCHAR(100), 
    IN p_phone_number VARCHAR(15), 
    IN p_address TEXT
)
BEGIN
    DECLARE v_customer_id INT;

    -- 检查客户是否已经存在
    SELECT customer_id INTO v_customer_id
    FROM customers
    WHERE email = p_email;

    IF v_customer_id IS NULL THEN
        -- 如果客户不存在，添加新客户
        INSERT INTO customers (first_name, last_name, email, phone_number, address, created_at)
        VALUES (p_first_name, p_last_name, p_email, p_phone_number, p_address, NOW());
    ELSE
        -- 如果客户存在，更新客户信息
        UPDATE customers
        SET first_name = p_first_name, 
            last_name = p_last_name, 
            phone_number = p_phone_number, 
            address = p_address
        WHERE customer_id = v_customer_id;
    END IF;
END //

DELIMITER ;

-- 调用存储过程添加或更新客户
CALL add_or_update_customer('John', 'Doe', 'john.doe@example.com', '1234567890', '123 Elm St, Springfield');

-- 更新客户信息
START TRANSACTION;

UPDATE customers
SET email = 'twilliams@example.org', phone_number = '0987654321'
WHERE customer_id = 1;

COMMIT;

-- 更新客户地址
START TRANSACTION;

UPDATE customers
SET address = '84493 Eric Plain, Port Rickyhaven, KY 31702'
WHERE customer_id = 1;

COMMIT;

-- 查看具体客户详细信息
SELECT * FROM Customers WHERE customer_id = 1;

-- 查看具体客户详细信息包括租赁历史
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
       total_cost,
       r.created_at AS rental_created_at 
FROM Customers AS c
LEFT JOIN rentals AS r ON c.customer_id = r.customer_id 
WHERE c.customer_id = 1;

-- 添加新的游戏机
START TRANSACTION;

INSERT INTO consoles (model, type, storage_capacity, purchase_date, cost)  
VALUES ('Xbox', 'Console', '512GB', CURRENT_TIMESTAMP, 399.99);

INSERT INTO inventory (console_id, serial_number, status)  
VALUES (LAST_INSERT_ID(), 'XB1234', 'Available');

COMMIT;

-- 更新游戏机状态
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

-- 查看游戏机详细信息
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

-- 查看特定游戏机详细信息
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

-- 查看库存详细信息
SELECT * FROM inventory;

-- 查看特定库存详细信息
SELECT * FROM inventory WHERE inventory_id = 101;


-- 先需要的是检查机器还在不在租如果已经被租了则返回信息已被租如果没有返回available信息

DELIMITER //

CREATE PROCEDURE check_console_model_availability(
    IN p_console_id INT,
    OUT p_message VARCHAR(255)
)
BEGIN
    DECLARE v_available_count INT;

    -- 检查该型号的游戏机是否有可用的
    SELECT COUNT(*) INTO v_available_count
    FROM inventory
    WHERE console_id = p_console_id AND status = 'Available';

    -- 根据可用数量设置返回信息
    IF v_available_count > 0 THEN
        SET p_message = 'Available';
    ELSE
        SET p_message = 'Not Available';
    END IF;
END //

DELIMITER ;
-- 调用
CALL check_console_model_availability(1, @message);
SELECT @message;

-- 为客户添加奖励记录
START TRANSACTION;

INSERT INTO membership_rewards (customer_id, reward_points, reward_date, Reward_description)  
VALUES (1,100, CURRENT_TIMESTAMP, 'Pre-paid Card $20');

COMMIT;

-- 更新奖励描述
START TRANSACTION;

UPDATE membership_rewards  
SET reward_description = 'Spend 100 points to get $20 gift card'  
WHERE reward_id = 1;

COMMIT;

-- 查看具体客户的奖励记录
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

-- 查看租赁记录
SELECT * FROM rentals;


-- 记录交易
START TRANSACTION;

INSERT INTO transactions (rental_id, amount, payment_method, transaction_date)
VALUES (1, 100.00, 'Credit Card', NOW());

COMMIT;

-- 查看交易记录
SELECT * FROM transactions;

-- 添加VIP客户
START TRANSACTION;

INSERT INTO VIP_Customers (Customer_ID, Membership_Level, Additional_Discount)
VALUES (1, 'Gold', 0.05); 

COMMIT;

-- 更新VIP客户信息
START TRANSACTION;

UPDATE VIP_Customers
SET Membership_Level = 'Platinum',  -- 更新会员等级
    Additional_Discount = 0.10  -- 更新额外折扣
WHERE Customer_ID = 1;  -- 示例客户ID，根据实际情况修改

COMMIT;

-- 查看VIP客户信息
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

-- 计算总价格包括vip和普通用户不同的价格，然后再记录付款

DELIMITER //

CREATE PROCEDURE calculate_total_fee(
    IN rentalId INT, 
    OUT totalFee DECIMAL(10, 2)
)
BEGIN
    DECLARE vipDiscount DECIMAL(5, 2) DEFAULT 0.00;
    DECLARE originalFee DECIMAL(10, 2);

    -- 获取原始费用
    SELECT DATEDIFF(NOW(), r.rental_start_date) * c.cost
    INTO originalFee
    FROM rentals r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN consoles c ON i.console_id = c.console_id
    WHERE r.rental_id = rentalId;

    -- 检查客户是否为VIP客户并获取额外折扣
    SELECT COALESCE(v.Additional_Discount, 0.00) INTO vipDiscount
    FROM rentals r
    JOIN customers cu ON r.customer_id = cu.customer_id
    LEFT JOIN VIP_Customers v ON cu.customer_id = v.Customer_ID
    WHERE r.rental_id = rentalId;

    -- 计算总费用
    IF vipDiscount > 0 THEN
        SET totalFee = originalFee * (1 - (0.20 + vipDiscount));
    ELSE
        SET totalFee = originalFee;
    END IF;
END //

CREATE PROCEDURE process_payment(
    IN rentalId INT,
    IN amount DECIMAL(10, 2),
    IN paymentMethod ENUM('Cash', 'Credit Card', 'Debit Card', 'Online'),
    OUT message VARCHAR(255)
)
BEGIN
    DECLARE totalFee DECIMAL(10, 2);

    -- 计算总费用
    CALL calculate_total_fee(rentalId, totalFee);

    -- 检查支付金额是否足够
    IF amount < totalFee THEN
        SET message = 'Payment amount is not sufficient to cover the total fee.';
    ELSE
        START TRANSACTION;

        -- 插入付款信息到 transactions 表
        INSERT INTO transactions (rental_id, amount, payment_method)
        VALUES (rentalId, amount, paymentMethod);

        -- 更新租赁记录状态为已完成
        UPDATE rentals
        SET rental_status = 'Completed', rental_end_date = NOW(), total_cost = totalFee
        WHERE rental_id = rentalId;

        -- 更新相关游戏机状态为可用
        UPDATE inventory
        SET status = 'Available'
        WHERE inventory_id = (SELECT inventory_id FROM rentals WHERE rental_id = rentalId);

        COMMIT;
        SET message = CONCAT('Payment processed successfully. Total fee: ', totalFee);
    END IF;
END //

DELIMITER ;
-- 调用
CALL process_payment(1, 150.00, 'Credit Card', @message);
SELECT @message;