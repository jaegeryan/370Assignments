CREATE TABLE Consoles (
    console_id       INT AUTO_INCREMENT PRIMARY KEY,
    model            VARCHAR(100) NOT NULL,
    type             VARCHAR(50) NULL,
    storage_capacity VARCHAR(20) NULL,
    status           ENUM ('Available', 'Rented', 'Maintenance') DEFAULT 'Available',
    purchase_date    DATE NULL,
    cost             DECIMAL(10, 2) NULL
);

CREATE TABLE Customers (
    customer_id  INT AUTO_INCREMENT PRIMARY KEY,
    first_name   VARCHAR(50) NOT NULL,
    last_name    VARCHAR(50) NOT NULL,
    email        VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(15) NULL,
    address      TEXT NULL,
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    console_id INT NOT NULL,
    serial_number VARCHAR(100) UNIQUE NOT NULL,
    purchase_date DATE NULL,
    status ENUM ('Available', 'Rented', 'Maintenance') DEFAULT 'Available',
    FOREIGN KEY (console_id) REFERENCES Consoles(console_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Rentals (
    rental_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    inventory_id INT NOT NULL,
    rental_start_date DATETIME NOT NULL,
    rental_end_date DATETIME NULL,
    rental_status ENUM ('Ongoing', 'Completed') DEFAULT 'Ongoing',
    total_cost DECIMAL(10, 2) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (inventory_id) REFERENCES Inventory(inventory_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX idx_inventory_id ON Rentals (inventory_id);
CREATE INDEX idx_customer_id ON Rentals (customer_id);

CREATE TABLE Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    rental_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM ('Cash', 'Credit Card', 'Debit Card', 'Online') NOT NULL,
    FOREIGN KEY (rental_id) REFERENCES Rentals(rental_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX idx_rental_id ON Transactions (rental_id);