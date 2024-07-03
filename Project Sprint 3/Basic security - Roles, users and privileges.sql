-- Our project assumes that the game company rental company is running offline and there is only one database control terminal (the boss's PC), the boss has the highest privileges and logs in through the user 'boss', while all other employees log in through the user 'employee'.
-- Create Roles
CREATE ROLE Boss_role;  
CREATE ROLE Employee_role;  

-- Create Boss User
CREATE USER 'boss'@'localhost' IDENTIFIED BY 'boss_password';

-- Create Employee User
CREATE USER 'employee'@'localhost' IDENTIFIED BY 'employee_password';

-- Boss has all privileges - Grant By Root
GRANT ALL PRIVILEGES ON customers.* TO Boss_role WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON consoles.* TO Boss_role WITH GRANT OPTION;  
GRANT ALL PRIVILEGES ON inventory.* TO Boss_role WITH GRANT OPTION;  
GRANT ALL PRIVILEGES ON rentals.* TO Boss_role WITH GRANT OPTION;  
GRANT ALL PRIVILEGES ON transactions.* TO Boss_role WITH GRANT OPTION; 
GRANT Boss_role TO 'boss'@'localhost';

-- Employees have the priviledges to select all the contents of the Customers table, Select all the contents of the Consoles table, Select and insert data into the inventory table, and update only the status column of the inventory table, Select, insert, update, and delete data from the rentals table, Select and insert data into the transactions table. - Grant By Boss.
GRANT SELECT ON customers TO Employee_role;
GRANT SELECT ON consoles TO Employee_role;
GRANT SELECT, INSERT, UPDATE(status) ON inventory TO Employee_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON rentals TO Employee_role;
GRANT SELECT, INSERT ON transactions TO Employee_role;
GRANT Employee_role TO 'employee'@'localhost';

-- Suppose it is later discovered that it is inappropriate to allow employees to see customers' addresses and phone numbers. Can create a view that blocks out addresses and phone numbers.
CREATE VIEW Customers_Employee AS
SELECT customer_id, first_name, last_name, email, created_at
FROM customers;

-- Revoke employee's SELECT privilege on customer. -- Revoke SELECT privilege ON customers for a role (this affects all users granted the role, Like CASCADE) 
REVOKE SELECT ON customers FROM Employee_role;

-- Grant SELECT priviledge ON Customers_Employee view to a role (this affects all users granted the role) 
GRANT SELECT ON Customers_Employee TO Employee_role;

-- To ensure durability, the transactions table should not be deleted or updated, so need to revoke the boss's delete and update privilege on the transactions table. - Revoke privileges for a role (this affects all users granted the role, Like CASCADE)
REVOKE DELETE ON transactions.* FROM Boss_role;  
REVOKE UPDATE ON transactions.* FROM Boss_role; 

-- Refresh PRIVILEGES
FLUSH PRIVILEGES;

-- We don't need additional RESTRICT and CASCADE because all users get their privileges by inheriting the role, the user doesn't grant privileges to other users, so there's no need for restrict, and when the privileges of the role are modified, the privileges of all the users who are inheriting the role will be affected in the same way, so there's no need for CASCADE.

-- Demonstrate the current privileges of each user and role.
SHOW GRANTS FOR Boss_role;  
SHOW GRANTS FOR 'boss'@'localhost';  
SHOW GRANTS FOR Employee_role;  
SHOW GRANTS FOR 'employee'@'localhost';  