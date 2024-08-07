-- Creating tables with appropriate indexes
CREATE TABLE consoles (
    console_id INT AUTO_INCREMENT PRIMARY KEY,
    model VARCHAR(100) NOT NULL,
    type VARCHAR(50),
    storage_capacity VARCHAR(20),
    purchase_date DATE,
    cost DECIMAL(10, 2),
    INDEX (type)
);

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(15),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX (email)
);

CREATE TABLE inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    console_id INT NOT NULL,
    serial_number VARCHAR(100) UNIQUE NOT NULL,
    status ENUM ('Available', 'Rented', 'Maintenance') DEFAULT 'Available',
    FOREIGN KEY (console_id) REFERENCES consoles (console_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    INDEX (console_id)
);

CREATE TABLE rentals (
    rental_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    inventory_id INT NOT NULL,
    rental_start_date DATETIME NOT NULL,
    rental_end_date DATETIME,
    rental_status ENUM ('Ongoing', 'Completed') DEFAULT 'Ongoing',
    total_cost DECIMAL(10, 2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (inventory_id) REFERENCES inventory (inventory_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    INDEX (customer_id),
    INDEX (inventory_id)
);

CREATE TABLE transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    rental_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM ('Cash', 'Credit Card', 'Debit Card', 'Online') NOT NULL,
    FOREIGN KEY (rental_id) REFERENCES rentals (rental_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    INDEX (rental_id)
);
