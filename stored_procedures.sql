USE smsms_db;

DELIMITER //

-- ==============================================================================
-- 1. AddMedicine
-- ==============================================================================
CREATE PROCEDURE AddMedicine(
    IN p_name VARCHAR(150),
    IN p_generic_name VARCHAR(150),
    IN p_category VARCHAR(100),
    IN p_uom VARCHAR(50),
    IN p_reorder_level INT
)
BEGIN
    INSERT INTO Medicines (name, generic_name, category, unit_of_measure, reorder_level)
    VALUES (p_name, p_generic_name, p_category, p_uom, p_reorder_level);
END //

-- ==============================================================================
-- 2. AddBatch
-- ==============================================================================
CREATE PROCEDURE AddBatch(
    IN p_medicine_id INT,
    IN p_batch_number VARCHAR(50),
    IN p_mfg_date DATE,
    IN p_exp_date DATE,
    IN p_quantity INT,
    IN p_unit_price DECIMAL(10,2)
)
BEGIN
    INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price)
    VALUES (p_medicine_id, p_batch_number, p_mfg_date, p_exp_date, p_quantity, p_unit_price);
END //

-- ==============================================================================
-- 3. PurchaseMedicine
-- ==============================================================================
CREATE PROCEDURE PurchaseMedicine(
    IN p_supplier_id INT,
    IN p_ordered_by INT,
    IN p_medicine_id INT,
    IN p_quantity INT,
    IN p_unit_price DECIMAL(10,2)
)
BEGIN
    DECLARE v_purchase_id INT;
    DECLARE v_total DECIMAL(12,2);
    
    SET v_total = p_quantity * p_unit_price;

    -- Enforce ACID properties using transactions
    START TRANSACTION;
    
    -- 1. Create Purchase Order Header
    INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status)
    VALUES (p_supplier_id, p_ordered_by, CURDATE(), v_total, 'Pending');
    
    -- Get the ID of the newly created purchase order
    SET v_purchase_id = LAST_INSERT_ID();
    
    -- 2. Create Purchase Order Detail Line
    INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, unit_price)
    VALUES (v_purchase_id, p_medicine_id, p_quantity, p_unit_price);
    
    COMMIT;
END //

-- ==============================================================================
-- 4. IssueMedicine
-- ==============================================================================
CREATE PROCEDURE IssueMedicine(
    IN p_department_id INT,
    IN p_batch_id INT,
    IN p_issued_by INT,
    IN p_requested_by INT,
    IN p_quantity_issued INT
)
BEGIN
    DECLARE v_available_qty INT;
    
    -- Lock the row to prevent race conditions during concurrent requests
    SELECT quantity INTO v_available_qty 
    FROM Medicine_Batches 
    WHERE batch_id = p_batch_id FOR UPDATE;
    
    -- Check if we have enough stock in this specific batch
    IF v_available_qty >= p_quantity_issued THEN
        START TRANSACTION;
        
        -- 1. Log the distribution audit trail
        INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued)
        VALUES (p_department_id, p_batch_id, p_issued_by, p_requested_by, p_quantity_issued);
        
        -- 2. Deduct the stock from the physical inventory
        UPDATE Medicine_Batches 
        SET quantity = quantity - p_quantity_issued 
        WHERE batch_id = p_batch_id;
        
        COMMIT;
    ELSE
        -- Raise a MySQL error if stock is insufficient
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: Insufficient batch quantity for this distribution request.';
    END IF;
END //

-- ==============================================================================
-- 5. GenerateLowStockReport
-- ==============================================================================
CREATE PROCEDURE GenerateLowStockReport()
BEGIN
    -- Calculates dynamic total stock by summing all active batches for a medicine
    -- and compares it directly to the reorder level threshold.
    SELECT 
        m.medicine_id, 
        m.name, 
        m.category, 
        m.reorder_level, 
        IFNULL(SUM(mb.quantity), 0) AS total_stock
    FROM Medicines m
    LEFT JOIN Medicine_Batches mb ON m.medicine_id = mb.medicine_id AND mb.status = 'Available'
    GROUP BY m.medicine_id, m.name, m.category, m.reorder_level
    HAVING total_stock <= m.reorder_level
    ORDER BY total_stock ASC;
END //

-- ==============================================================================
-- 6. GenerateExpiryReport
-- ==============================================================================
CREATE PROCEDURE GenerateExpiryReport(
    IN p_days_threshold INT
)
BEGIN
    -- Finds batches expiring within a dynamic number of days (e.g., 30, 60, 90)
    SELECT 
        m.name,
        mb.batch_number,
        mb.expiry_date,
        mb.quantity,
        DATEDIFF(mb.expiry_date, CURDATE()) AS days_until_expiry
    FROM Medicine_Batches mb
    JOIN Medicines m ON mb.medicine_id = m.medicine_id
    WHERE mb.status = 'Available' 
      AND mb.quantity > 0
      AND mb.expiry_date <= DATE_ADD(CURDATE(), INTERVAL p_days_threshold DAY)
    ORDER BY mb.expiry_date ASC;
END //

DELIMITER ;
