--Bulk Update: Set all consoles purchased before a certain date to "Maintenance" status
UPDATE Inventory i
JOIN Consoles c ON i.console_id = c.console_id
SET i.status = 'Maintenance'
WHERE c.purchase_date < '2020-01-01';
--Bulk Updates: Apply Discounts to Ongoing Rentals
UPDATE Rentals
SET total_cost = total_cost * 0.9
WHERE rental_status = 'Ongoing';
--Batch insert: add multiple customers at once
INSERT INTO Customers (first_name, last_name, email, phone_number, address)
VALUES
    ('John', 'Doe', 'john.doe@example.com', '1234567890', '123 Main St'),
    ('Jane', 'Smith', 'jane.smith@example.com', '0987654321', '456 Oak St'),
    ('Alice', 'Johnson', 'alice.johnson@example.com', '1122334455', '789 Pine St');

--Batch Updates: Adjust console costs based on type
UPDATE Consoles
SET cost = cost * 1.1
WHERE type = 'Handheld';
--Bulk update: Set all lease statuses to "Completed" if the lease end date has passed
UPDATE Rentals
SET rental_status = 'Completed'
WHERE rental_end_date < CURRENT_TIMESTAMP AND rental_status = 'Ongoing';
--Batch Update: Set console status in all inventories to "Available" status (assuming maintenance is complete)
UPDATE Inventory
SET status = 'Available'
WHERE status = 'Maintenance';
--Bulk Updates: Adds 10% cost to all consoles purchased before a certain date (assuming price adjustments)
UPDATE Consoles
SET cost = cost * 1.1
WHERE purchase_date < '2021-01-01';
