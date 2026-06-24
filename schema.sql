-- ==============================================================================
-- Smart Medical Supply Management System (SMSMS)
-- Complete MySQL Database Initialization Script
-- Description: Creates the database, normalized tables (3NF), constraints, 
--              and indexing optimized for read/write performance.
-- ==============================================================================

CREATE DATABASE IF NOT EXISTS smsms_db;
USE smsms_db;

-- ------------------------------------------------------------------------------
-- 1. Departments Table
-- ------------------------------------------------------------------------------
CREATE TABLE Departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    location VARCHAR(100),
    contact_number VARCHAR(20)
);

-- ------------------------------------------------------------------------------
-- 2. Users Table
-- ------------------------------------------------------------------------------
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    department_id INT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    role ENUM('Admin', 'Inventory Manager', 'Department Head', 'Pharmacist') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign Keys
    FOREIGN KEY (department_id) REFERENCES Departments(department_id) ON DELETE SET NULL,
    
    -- Indexes for frequently searched columns
    INDEX idx_username (username),
    INDEX idx_role (role)
);

-- ------------------------------------------------------------------------------
-- 3. Suppliers Table
-- ------------------------------------------------------------------------------
CREATE TABLE Suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(150) NOT NULL,
    contact_person VARCHAR(100),
    phone_number VARCHAR(20) NOT NULL,
    email VARCHAR(100),
    address TEXT,
    status ENUM('Active', 'Inactive') DEFAULT 'Active',
    
    INDEX idx_supplier_status (status)
);

-- ------------------------------------------------------------------------------
-- 4. Medicines Table (Master Catalog)
-- ------------------------------------------------------------------------------
CREATE TABLE Medicines (
    medicine_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    generic_name VARCHAR(150) NOT NULL,
    category VARCHAR(100) NOT NULL,
    unit_of_measure VARCHAR(50) NOT NULL,
    reorder_level INT NOT NULL DEFAULT 0,
    description TEXT,
    
    INDEX idx_medicine_name (name),
    INDEX idx_medicine_category (category)
);

-- ------------------------------------------------------------------------------
-- 5. Medicine_Batches Table (Physical Inventory)
-- ------------------------------------------------------------------------------
CREATE TABLE Medicine_Batches (
    batch_id INT AUTO_INCREMENT PRIMARY KEY,
    medicine_id INT NOT NULL,
    batch_number VARCHAR(50) NOT NULL,
    manufacturing_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    quantity INT NOT NULL DEFAULT 0 CHECK (quantity >= 0),
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price >= 0),
    status ENUM('Available', 'Quarantine', 'Expired') DEFAULT 'Available',
    
    -- Foreign Keys
    FOREIGN KEY (medicine_id) REFERENCES Medicines(medicine_id) ON DELETE CASCADE,
    
    -- Indexes for FEFO sorting and filtering
    INDEX idx_expiry_date (expiry_date),
    INDEX idx_batch_status (status)
);

-- ------------------------------------------------------------------------------
-- 6. Purchases Table
-- ------------------------------------------------------------------------------
CREATE TABLE Purchases (
    purchase_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_id INT NOT NULL,
    ordered_by INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    status ENUM('Pending', 'Partial', 'Completed', 'Cancelled') DEFAULT 'Pending',
    
    -- Foreign Keys
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id) ON DELETE RESTRICT,
    FOREIGN KEY (ordered_by) REFERENCES Users(user_id) ON DELETE RESTRICT,
    
    INDEX idx_purchase_status (status),
    INDEX idx_order_date (order_date)
);

-- ------------------------------------------------------------------------------
-- 7. Purchase_Details Table
-- ------------------------------------------------------------------------------
CREATE TABLE Purchase_Details (
    purchase_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    purchase_id INT NOT NULL,
    medicine_id INT NOT NULL,
    ordered_quantity INT NOT NULL CHECK (ordered_quantity > 0),
    received_quantity INT NOT NULL DEFAULT 0 CHECK (received_quantity >= 0),
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price >= 0),
    
    -- Foreign Keys
    FOREIGN KEY (purchase_id) REFERENCES Purchases(purchase_id) ON DELETE CASCADE,
    FOREIGN KEY (medicine_id) REFERENCES Medicines(medicine_id) ON DELETE RESTRICT
);

-- ------------------------------------------------------------------------------
-- 8. Distributions Table
-- ------------------------------------------------------------------------------
CREATE TABLE Distributions (
    distribution_id INT AUTO_INCREMENT PRIMARY KEY,
    department_id INT NOT NULL,
    batch_id INT NOT NULL,
    issued_by INT NOT NULL,
    requested_by INT NOT NULL,
    quantity_issued INT NOT NULL CHECK (quantity_issued > 0),
    issue_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign Keys
    FOREIGN KEY (department_id) REFERENCES Departments(department_id) ON DELETE RESTRICT,
    FOREIGN KEY (batch_id) REFERENCES Medicine_Batches(batch_id) ON DELETE RESTRICT,
    FOREIGN KEY (issued_by) REFERENCES Users(user_id) ON DELETE RESTRICT,
    FOREIGN KEY (requested_by) REFERENCES Users(user_id) ON DELETE RESTRICT,
    
    INDEX idx_issue_date (issue_date)
);

-- ------------------------------------------------------------------------------
-- 9. Stock_Alerts Table
-- ------------------------------------------------------------------------------
CREATE TABLE Stock_Alerts (
    alert_id INT AUTO_INCREMENT PRIMARY KEY,
    medicine_id INT NULL,
    batch_id INT NULL,
    alert_type ENUM('Low Stock', 'Expiring Soon', 'Expired') NOT NULL,
    alert_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Unread', 'Read', 'Resolved') DEFAULT 'Unread',
    
    -- Foreign Keys
    FOREIGN KEY (medicine_id) REFERENCES Medicines(medicine_id) ON DELETE CASCADE,
    FOREIGN KEY (batch_id) REFERENCES Medicine_Batches(batch_id) ON DELETE CASCADE,
    
    INDEX idx_alert_status (status),
    INDEX idx_alert_type (alert_type)
);
