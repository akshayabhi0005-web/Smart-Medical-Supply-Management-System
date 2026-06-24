USE smsms_db;

-- ==============================================================================
-- 1. CurrentInventoryView
-- Purpose: Provides a quick, comprehensive snapshot of the entire master catalog
-- and the current physical stock levels.
-- ==============================================================================
CREATE OR REPLACE VIEW CurrentInventoryView AS
SELECT 
    m.medicine_id,
    m.name AS medicine_name,
    m.generic_name,
    m.category,
    m.unit_of_measure,
    m.total_stock,
    m.reorder_level,
    CASE 
        WHEN m.total_stock = 0 THEN 'Out of Stock'
        WHEN m.total_stock <= m.reorder_level THEN 'Reorder Required'
        ELSE 'Sufficient'
    END AS stock_status
FROM Medicines m;

-- ==============================================================================
-- 2. LowStockView
-- Purpose: Acts as a live dashboard filter showing ONLY items that have dropped
-- below their safe reorder threshold, calculating exactly how much deficit exists.
-- ==============================================================================
CREATE OR REPLACE VIEW LowStockView AS
SELECT 
    m.medicine_id,
    m.name AS medicine_name,
    m.category,
    m.total_stock,
    m.reorder_level,
    (m.reorder_level - m.total_stock) AS deficit_amount
FROM Medicines m
WHERE m.total_stock <= m.reorder_level;

-- ==============================================================================
-- 3. ExpiringMedicinesView
-- Purpose: Helps hospital staff maintain the FEFO principle by isolating active
-- inventory batches that are expiring within the next 90 days.
-- ==============================================================================
CREATE OR REPLACE VIEW ExpiringMedicinesView AS
SELECT 
    m.name AS medicine_name,
    m.category,
    mb.batch_number,
    mb.quantity AS available_batch_stock,
    mb.expiry_date,
    DATEDIFF(mb.expiry_date, CURDATE()) AS days_until_expiry
FROM Medicine_Batches mb
JOIN Medicines m ON mb.medicine_id = m.medicine_id
WHERE mb.status = 'Available'
  AND mb.quantity > 0
  AND mb.expiry_date <= DATE_ADD(CURDATE(), INTERVAL 90 DAY)
ORDER BY mb.expiry_date ASC;

-- ==============================================================================
-- 4. SupplierSummaryView
-- Purpose: Aggregates historical purchase data to evaluate supplier performance,
-- showing total order volume and overall financial spend per vendor.
-- ==============================================================================
CREATE OR REPLACE VIEW SupplierSummaryView AS
SELECT 
    s.supplier_id,
    s.supplier_name,
    s.contact_person,
    s.phone_number,
    COUNT(p.purchase_id) AS total_orders_placed,
    IFNULL(SUM(p.total_amount), 0.00) AS total_money_spent
FROM Suppliers s
LEFT JOIN Purchases p ON s.supplier_id = p.supplier_id AND p.status = 'Completed'
GROUP BY s.supplier_id, s.supplier_name, s.contact_person, s.phone_number;

-- ==============================================================================
-- 5. DepartmentUsageView
-- Purpose: Analyzes consumption patterns by linking distributions to departments.
-- It shows exactly which department is using what medicine, the total amount 
-- consumed, and the estimated financial cost of that consumption.
-- ==============================================================================
CREATE OR REPLACE VIEW DepartmentUsageView AS
SELECT 
    d.department_name,
    m.name AS medicine_name,
    m.category,
    SUM(dist.quantity_issued) AS total_quantity_consumed,
    SUM(dist.quantity_issued * mb.unit_price) AS total_cost_incurred
FROM Distributions dist
JOIN Departments d ON dist.department_id = d.department_id
JOIN Medicine_Batches mb ON dist.batch_id = mb.batch_id
JOIN Medicines m ON mb.medicine_id = m.medicine_id
GROUP BY d.department_id, d.department_name, m.medicine_id, m.name, m.category
ORDER BY d.department_name ASC, total_cost_incurred DESC;
