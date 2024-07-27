-- inheritance

-- sub-class
-- use sub-class to create a new VIP system for customer
CREATE TABLE VIP_Customers (
    Customer_ID INT NOT NULL,
    Membership_Level VARCHAR(50),
    Additional_Discount DECIMAL(5, 2),
    PRIMARY KEY (Customer_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);

-- weak entity set
-- provide a Membership-Rewards system to give customer a batter experience
CREATE TABLE Membership_Rewards (
    Customer_ID INT NOT NULL,
    Reward_ID INT NOT NULL AUTO_INCREMENT,
    Reward_points INT,
    Reward_date DATE,
    Reward_description VARCHAR(255),
    PRIMARY KEY (Reward_ID),  -- Make Reward_ID the primary key
    UNIQUE KEY (Customer_ID, Reward_ID),  -- Define a unique constraint
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);
-- add a new column in customer
ALTER TABLE Customers
ADD COLUMN rewards_points INT DEFAULT 0;

SELECT * FROM Customers;

SET GLOBAL LOCAL_infile = 1;

-- load data to the new tables
LOAD DATA LOCAL INFILE 'C:/Users/54694/Desktop/csc370/Membership_Rewards'
INTO TABLE Membership_Rewards
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(Customer_ID, Reward_ID, Reward_points, Reward_date, Reward_description
);

LOAD DATA LOCAL INFILE 'C:/Users/54694/Desktop/csc370/VIP_Customers'
INTO TABLE VIP_Customers
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(Customer_ID, Membership_Level, Additional_Discount
);

DELIMITER //
CREATE TRIGGER update_rewards_and_membership
AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
    -- Update rewards_points in Customers table
    UPDATE Customers
    SET rewards_points = rewards_points + NEW.amount / 100
    WHERE customer_id = (SELECT customer_id FROM Rentals WHERE rental_id = NEW.rental_id);

    -- Insert into Membership_Rewards table
    INSERT INTO Membership_Rewards (Customer_ID, Reward_points, Reward_date, Reward_description)
    VALUES ((SELECT customer_id FROM Rentals WHERE rental_id = NEW.rental_id), 
            NEW.amount / 100,
            NEW.transaction_date,
            CONCAT('Reward for transaction ID ', NEW.transaction_id));
END//
DELIMITER ;