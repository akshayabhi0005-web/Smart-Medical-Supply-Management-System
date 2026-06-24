USE smsms_db;

-- ==============================================================================
-- I. INVENTORY REPORTS
-- ==============================================================================

-- 1. Total available quantity and unique medicines in the system
SELECT 
    COUNT(medicine_id) AS total_unique_medicines,
    SUM(total_stock) AS total_items_in_stock
FROM Medicines;

-- 2. Total inventory value (Cost) per medicine category
-- Uses JOIN and GROUP BY
SELECT 
    m.category,
    SUM(mb.quantity * mb.unit_price) AS total_inventory_value
FROM Medicines m
JOIN Medicine_Batches mb ON m.medicine_id = mb.medicine_id
WHERE mb.status = 'Available'
GROUP BY m.category
ORDER BY total_inventory_value DESC;

-- 3. Number of active batches available per medicine
-- Uses LEFT JOIN, GROUP BY, and HAVING
SELECT 
    m.name AS medicine_name,
    COUNT(mb.batch_id) AS active_batch_count,
    SUM(mb.quantity) AS physical_stock
FROM Medicines m
LEFT JOIN Medicine_Batches mb ON m.medicine_id = mb.medicine_id AND mb.status = 'Available'
GROUP BY m.medicine_id, m.name
HAVING COUNT(mb.batch_id) > 0;

-- 4. Find the most expensive available batch currently in stock
SELECT 
    m.name,
    mb.batch_number,
    mb.unit_price,
    mb.quantity
FROM Medicine_Batches mb
JOIN Medicines m ON mb.medicine_id = m.medicine_id
WHERE mb.status = 'Available'
ORDER BY mb.unit_price DESC
LIMIT 1;


-- ==============================================================================
-- II. LOW-STOCK REPORTS
-- ==============================================================================

-- 5. List of all medicines currently below their reorder level
SELECT 
    name, 
    category, 
    total_stock, 
    reorder_level
FROM Medicines
WHERE total_stock <= reorder_level;

-- 6. Categories that have more than 2 low-stock medicines
-- Uses GROUP BY and HAVING
SELECT 
    category,
    COUNT(medicine_id) AS low_stock_count
FROM Medicines
WHERE total_stock <= reorder_level
GROUP BY category
HAVING COUNT(medicine_id) > 2;

-- 7. Medicines that have absolutely ZERO physical stock available
-- Uses LEFT JOIN, GROUP BY, and HAVING
SELECT 
    m.name,
    m.category
FROM Medicines m
LEFT JOIN Medicine_Batches mb ON m.medicine_id = mb.medicine_id AND mb.status = 'Available'
GROUP BY m.medicine_id, m.name, m.category
HAVING IFNULL(SUM(mb.quantity), 0) = 0;

-- 8. Top 5 medicines that we need to order urgently (highest deficit)
SELECT 
    name,
    reorder_level,
    total_stock,
    (reorder_level - total_stock) AS deficit
FROM Medicines
WHERE total_stock < reorder_level
ORDER BY deficit DESC
LIMIT 5;


-- ==============================================================================
-- III. EXPIRY REPORTS
-- ==============================================================================

-- 9. Batches expiring in the next 60 days
SELECT 
    m.name,
    mb.batch_number,
    mb.expiry_date,
    mb.quantity,
    DATEDIFF(mb.expiry_date, CURDATE()) AS days_left
FROM Medicine_Batches mb
JOIN Medicines m ON mb.medicine_id = m.medicine_id
WHERE mb.status = 'Available' AND mb.expiry_date <= DATE_ADD(CURDATE(), INTERVAL 60 DAY)
ORDER BY days_left ASC;

-- 10. Total potential financial loss from currently expired batches
-- Uses Aggregate functions
SELECT 
    IFNULL(SUM(quantity * unit_price), 0) AS total_financial_loss
FROM Medicine_Batches
WHERE expiry_date < CURDATE() OR status = 'Expired';

-- 11. Count of expired batches grouped by category
-- Uses JOIN, GROUP BY, and HAVING
SELECT 
    m.category,
    COUNT(mb.batch_id) AS expired_batch_count
FROM Medicine_Batches mb
JOIN Medicines m ON mb.medicine_id = m.medicine_id
WHERE mb.expiry_date < CURDATE() OR mb.status = 'Expired'
GROUP BY m.category
HAVING COUNT(mb.batch_id) > 0;


-- ==============================================================================
-- IV. SUPPLIER REPORTS
-- ==============================================================================

-- 12. Total amount spent per supplier (Lifetime)
-- Uses JOIN and GROUP BY
SELECT 
    s.supplier_name,
    COUNT(p.purchase_id) AS total_orders,
    SUM(p.total_amount) AS total_spent
FROM Suppliers s
JOIN Purchases p ON s.supplier_id = p.supplier_id
WHERE p.status = 'Completed'
GROUP BY s.supplier_id, s.supplier_name
ORDER BY total_spent DESC;

-- 13. Suppliers who have fulfilled more than 3 orders
-- Uses JOIN, GROUP BY, and HAVING
SELECT 
    s.supplier_name,
    COUNT(p.purchase_id) AS completed_orders
FROM Suppliers s
JOIN Purchases p ON s.supplier_id = p.supplier_id
WHERE p.status = 'Completed'
GROUP BY s.supplier_id, s.supplier_name
HAVING COUNT(p.purchase_id) > 3;

-- 14. Average purchase order cost for each supplier
-- Uses JOIN, GROUP BY, and AVG aggregate
SELECT 
    s.supplier_name,
    ROUND(AVG(p.total_amount), 2) AS avg_order_value
FROM Suppliers s
JOIN Purchases p ON s.supplier_id = p.supplier_id
GROUP BY s.supplier_id, s.supplier_name;


-- ==============================================================================
-- V. DEPARTMENT USAGE REPORTS
-- ==============================================================================

-- 15. Total quantity of items issued to each department
-- Uses JOIN and GROUP BY
SELECT 
    d.department_name,
    SUM(dist.quantity_issued) AS total_items_received
FROM Departments d
JOIN Distributions dist ON d.department_id = dist.department_id
GROUP BY d.department_id, d.department_name
ORDER BY total_items_received DESC;

-- 16. Department that consumed the highest financial value of medicines
-- Uses Multiple JOINs and GROUP BY
SELECT 
    d.department_name,
    SUM(dist.quantity_issued * mb.unit_price) AS total_consumption_value
FROM Distributions dist
JOIN Departments d ON dist.department_id = d.department_id
JOIN Medicine_Batches mb ON dist.batch_id = mb.batch_id
GROUP BY d.department_id, d.department_name
ORDER BY total_consumption_value DESC
LIMIT 1;

-- 17. Most frequently issued medicine to the 'ICU' department
-- Uses Multiple JOINs, GROUP BY, and ORDER BY
SELECT 
    m.name AS medicine_name,
    SUM(dist.quantity_issued) AS total_quantity_issued
FROM Distributions dist
JOIN Departments d ON dist.department_id = d.department_id
JOIN Medicine_Batches mb ON dist.batch_id = mb.batch_id
JOIN Medicines m ON mb.medicine_id = m.medicine_id
WHERE d.department_name = 'ICU'
GROUP BY m.medicine_id, m.name
ORDER BY total_quantity_issued DESC
LIMIT 1;

-- 18. Departments that requested more than 50 units in total across all time
-- Uses JOIN, GROUP BY, and HAVING
SELECT 
    d.department_name,
    SUM(dist.quantity_issued) AS total_units_requested
FROM Departments d
JOIN Distributions dist ON d.department_id = dist.department_id
GROUP BY d.department_id, d.department_name
HAVING SUM(dist.quantity_issued) > 50;


-- ==============================================================================
-- VI. MONTHLY PURCHASE REPORTS
-- ==============================================================================

-- 19. Monthly purchase expenditure (Grouping by Month and Year)
-- Uses GROUP BY Date Functions
SELECT 
    YEAR(order_date) AS order_year,
    MONTHNAME(order_date) AS order_month,
    COUNT(purchase_id) AS total_purchases,
    SUM(total_amount) AS monthly_expenditure
FROM Purchases
GROUP BY YEAR(order_date), MONTH(order_date), MONTHNAME(order_date)
ORDER BY order_year DESC, MONTH(order_date) DESC;

-- 20. Number of purchases and average cost by status per month
-- Uses GROUP BY with multiple columns
SELECT 
    MONTHNAME(order_date) AS order_month,
    status,
    COUNT(purchase_id) AS order_count,
    ROUND(AVG(total_amount), 2) AS average_cost
FROM Purchases
GROUP BY MONTH(order_date), MONTHNAME(order_date), status
ORDER BY MONTH(order_date) DESC, status;
