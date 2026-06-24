USE smsms_db;

-- ==============================================================================
-- Schema Adjustment for Triggers
-- ==============================================================================
-- To fulfill the requirement of "increasing/reducing stock automatically" using triggers,
-- we add a denormalized `total_stock` column to the `Medicines` table. 
-- While our previous design used 3NF (calculating stock on the fly), using triggers 
-- to maintain a cached total is a very common performance optimization in DBMS projects.

ALTER TABLE Medicines ADD COLUMN total_stock INT NOT NULL DEFAULT 0;

-- Backfill existing data to ensure current stock is accurate before applying triggers
UPDATE Medicines m 
SET total_stock = (
    SELECT IFNULL(SUM(quantity), 0) 
    FROM Medicine_Batches mb 
    WHERE mb.medicine_id = m.medicine_id AND mb.status = 'Available'
);

DELIMITER //

-- ==============================================================================
-- 1. Increase Stock Automatically After Purchase
-- ==============================================================================
-- Fires when a new physical batch is received and inserted into Medicine_Batches
CREATE TRIGGER trg_Increase_Stock_After_Purchase
AFTER INSERT ON Medicine_Batches
FOR EACH ROW
BEGIN
    -- Automatically increase the cached total stock in the Medicines table
    UPDATE Medicines 
    SET total_stock = total_stock + NEW.quantity
    WHERE medicine_id = NEW.medicine_id;
    
    -- Bonus requirement 4: If a newly added batch is already near expiry (e.g., < 60 days)
    IF NEW.expiry_date <= DATE_ADD(CURDATE(), INTERVAL 60 DAY) THEN
        INSERT INTO Stock_Alerts (medicine_id, batch_id, alert_type, status)
        VALUES (NEW.medicine_id, NEW.batch_id, 'Expiring Soon', 'Unread');
    END IF;
END //

-- ==============================================================================
-- 2. Reduce Stock Automatically After Distribution
-- ==============================================================================
-- Fires immediately after a new record is added to the Distributions table
CREATE TRIGGER trg_Reduce_Stock_After_Distribution
AFTER INSERT ON Distributions
FOR EACH ROW
BEGIN
    DECLARE v_medicine_id INT;
    
    -- Deduct the specific batch's physical quantity
    UPDATE Medicine_Batches 
    SET quantity = quantity - NEW.quantity_issued
    WHERE batch_id = NEW.batch_id;
    
    -- Find the parent medicine_id for this batch
    SELECT medicine_id INTO v_medicine_id 
    FROM Medicine_Batches 
    WHERE batch_id = NEW.batch_id;
    
    -- Automatically reduce the cached total stock in the Medicines table
    UPDATE Medicines 
    SET total_stock = total_stock - NEW.quantity_issued
    WHERE medicine_id = v_medicine_id;
END //

-- ==============================================================================
-- 3. Create Low-Stock Alerts Automatically
-- ==============================================================================
-- Fires whenever the total_stock in the Medicines table is updated
CREATE TRIGGER trg_Low_Stock_Alert
AFTER UPDATE ON Medicines
FOR EACH ROW
BEGIN
    -- Check if the stock just dropped below the reorder level threshold
    IF NEW.total_stock <= NEW.reorder_level AND OLD.total_stock > OLD.reorder_level THEN
        -- Prevent spam: Check if an unread alert already exists for this medicine
        IF NOT EXISTS (
            SELECT 1 FROM Stock_Alerts 
            WHERE medicine_id = NEW.medicine_id 
              AND alert_type = 'Low Stock' 
              AND status = 'Unread'
        ) THEN
            INSERT INTO Stock_Alerts (medicine_id, alert_type, status)
            VALUES (NEW.medicine_id, 'Low Stock', 'Unread');
        END IF;
    END IF;
END //

-- ==============================================================================
-- 4. Create Expiry Alerts Automatically (Via Event Scheduler)
-- ==============================================================================
-- Note on Triggers vs Events: Triggers ONLY fire upon DML events (INSERT/UPDATE/DELETE). 
-- Time passing (a batch getting closer to expiry while sitting on a shelf) does NOT 
-- fire a trigger. Therefore, to truly "automatically" create expiry alerts daily, 
-- a MySQL Event Scheduler is the architecturally correct mechanism.

DELIMITER ;

-- Enable the global event scheduler
SET GLOBAL event_scheduler = ON;

DELIMITER //

CREATE EVENT evt_Daily_Expiry_Alert
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP
DO
BEGIN
    -- Find active batches expiring within 30 days that don't already have an unread alert
    INSERT INTO Stock_Alerts (medicine_id, batch_id, alert_type, status)
    SELECT 
        medicine_id, 
        batch_id, 
        'Expiring Soon', 
        'Unread'
    FROM Medicine_Batches mb
    WHERE mb.status = 'Available'
      AND mb.expiry_date <= DATE_ADD(CURDATE(), INTERVAL 30 DAY)
      AND NOT EXISTS (
          SELECT 1 FROM Stock_Alerts sa 
          WHERE sa.batch_id = mb.batch_id 
            AND sa.alert_type = 'Expiring Soon'
            AND sa.status = 'Unread'
      );
      
    -- Automatically update batch statuses if they have actually expired
    UPDATE Medicine_Batches
    SET status = 'Expired'
    WHERE expiry_date < CURDATE() AND status != 'Expired';
END //

DELIMITER ;
