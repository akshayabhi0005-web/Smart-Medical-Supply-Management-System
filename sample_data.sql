-- ==============================================================================
-- Smart Medical Supply Management System (SMSMS) - Sample Data
-- ==============================================================================

USE smsms_db;

-- ------------------------------------------------------------------------------
-- 1. Departments
-- ------------------------------------------------------------------------------
INSERT INTO Departments (department_name, location, contact_number) VALUES ('Emergency', 'Building A', '555-0100');
INSERT INTO Departments (department_name, location, contact_number) VALUES ('ICU', 'Building B', '555-0101');
INSERT INTO Departments (department_name, location, contact_number) VALUES ('Cardiology', 'Building C', '555-0102');
INSERT INTO Departments (department_name, location, contact_number) VALUES ('Neurology', 'Building D', '555-0103');
INSERT INTO Departments (department_name, location, contact_number) VALUES ('General Ward', 'Building E', '555-0104');

-- ------------------------------------------------------------------------------
-- 2. Users
-- ------------------------------------------------------------------------------
INSERT INTO Users (department_id, username, password_hash, full_name, role) VALUES (NULL, 'user1', '$2b$12$somehashedpasswordstring', 'User 1', 'Admin');
INSERT INTO Users (department_id, username, password_hash, full_name, role) VALUES (NULL, 'user2', '$2b$12$somehashedpasswordstring', 'User 2', 'Inventory Manager');
INSERT INTO Users (department_id, username, password_hash, full_name, role) VALUES (3, 'user3', '$2b$12$somehashedpasswordstring', 'User 3', 'Department Head');
INSERT INTO Users (department_id, username, password_hash, full_name, role) VALUES (NULL, 'user4', '$2b$12$somehashedpasswordstring', 'User 4', 'Pharmacist');
INSERT INTO Users (department_id, username, password_hash, full_name, role) VALUES (5, 'user5', '$2b$12$somehashedpasswordstring', 'User 5', 'Department Head');

-- ------------------------------------------------------------------------------
-- 3. Suppliers
-- ------------------------------------------------------------------------------
INSERT INTO Suppliers (supplier_name, contact_person, phone_number, email, address) VALUES ('Supplier 1 Healthcare', 'Contact 1', '555-2001', 'contact1@supplier1.com', '100 Health St, Cityville');
INSERT INTO Suppliers (supplier_name, contact_person, phone_number, email, address) VALUES ('Supplier 2 Healthcare', 'Contact 2', '555-2002', 'contact2@supplier2.com', '200 Health St, Cityville');
INSERT INTO Suppliers (supplier_name, contact_person, phone_number, email, address) VALUES ('Supplier 3 Healthcare', 'Contact 3', '555-2003', 'contact3@supplier3.com', '300 Health St, Cityville');
INSERT INTO Suppliers (supplier_name, contact_person, phone_number, email, address) VALUES ('Supplier 4 Healthcare', 'Contact 4', '555-2004', 'contact4@supplier4.com', '400 Health St, Cityville');
INSERT INTO Suppliers (supplier_name, contact_person, phone_number, email, address) VALUES ('Supplier 5 Healthcare', 'Contact 5', '555-2005', 'contact5@supplier5.com', '500 Health St, Cityville');
INSERT INTO Suppliers (supplier_name, contact_person, phone_number, email, address) VALUES ('Supplier 6 Healthcare', 'Contact 6', '555-2006', 'contact6@supplier6.com', '600 Health St, Cityville');
INSERT INTO Suppliers (supplier_name, contact_person, phone_number, email, address) VALUES ('Supplier 7 Healthcare', 'Contact 7', '555-2007', 'contact7@supplier7.com', '700 Health St, Cityville');
INSERT INTO Suppliers (supplier_name, contact_person, phone_number, email, address) VALUES ('Supplier 8 Healthcare', 'Contact 8', '555-2008', 'contact8@supplier8.com', '800 Health St, Cityville');
INSERT INTO Suppliers (supplier_name, contact_person, phone_number, email, address) VALUES ('Supplier 9 Healthcare', 'Contact 9', '555-2009', 'contact9@supplier9.com', '900 Health St, Cityville');
INSERT INTO Suppliers (supplier_name, contact_person, phone_number, email, address) VALUES ('Supplier 10 Healthcare', 'Contact 10', '555-20010', 'contact10@supplier10.com', '1000 Health St, Cityville');

-- ------------------------------------------------------------------------------
-- 4. Medicines (20 required items included)
-- ------------------------------------------------------------------------------
INSERT INTO Medicines (name, generic_name, category, unit_of_measure, reorder_level) VALUES ('Dolo 650', 'Paracetamol 650mg', 'Tablet', 'Strips', 178);
INSERT INTO Medicines (name, generic_name, category, unit_of_measure, reorder_level) VALUES ('Paracetamol', 'Paracetamol 500mg', 'Tablet', 'Strips', 147);
INSERT INTO Medicines (name, generic_name, category, unit_of_measure, reorder_level) VALUES ('Amoxicillin', 'Amoxicillin 500mg', 'Capsule', 'Strips', 123);
INSERT INTO Medicines (name, generic_name, category, unit_of_measure, reorder_level) VALUES ('Insulin', 'Insulin Human Injection', 'Injection', 'Vials', 91);
INSERT INTO Medicines (name, generic_name, category, unit_of_measure, reorder_level) VALUES ('Syringes', 'Syringe 5ml Disposable', 'Consumable', 'Pieces', 118);
INSERT INTO Medicines (name, generic_name, category, unit_of_measure, reorder_level) VALUES ('Gloves', 'Nitrile Examination Gloves', 'Consumable', 'Boxes', 64);
INSERT INTO Medicines (name, generic_name, category, unit_of_measure, reorder_level) VALUES ('Face Masks', 'N95 Surgical Mask', 'Consumable', 'Boxes', 57);
INSERT INTO Medicines (name, generic_name, category, unit_of_measure, reorder_level) VALUES ('Bandages', 'Cotton Roll Bandage', 'Consumable', 'Rolls', 154);
INSERT INTO Medicines (name, generic_name, category, unit_of_measure, reorder_level) VALUES ('Ibuprofen', 'Ibuprofen 400mg', 'Tablet', 'Strips', 195);
INSERT INTO Medicines (name, generic_name, category, unit_of_measure, reorder_level) VALUES ('Cetirizine', 'Cetirizine 10mg', 'Tablet', 'Strips', 161);
INSERT INTO Medicines (name, generic_name, category, unit_of_measure, reorder_level) VALUES ('Pantoprazole', 'Pantoprazole 40mg', 'Tablet', 'Strips', 77);
INSERT INTO Medicines (name, generic_name, category, unit_of_measure, reorder_level) VALUES ('Aspirin', 'Aspirin 75mg', 'Tablet', 'Strips', 154);
INSERT INTO Medicines (name, generic_name, category, unit_of_measure, reorder_level) VALUES ('Azithromycin', 'Azithromycin 500mg', 'Tablet', 'Strips', 119);
INSERT INTO Medicines (name, generic_name, category, unit_of_measure, reorder_level) VALUES ('Metformin', 'Metformin 500mg', 'Tablet', 'Strips', 113);
INSERT INTO Medicines (name, generic_name, category, unit_of_measure, reorder_level) VALUES ('Amlodipine', 'Amlodipine 5mg', 'Tablet', 'Strips', 54);
INSERT INTO Medicines (name, generic_name, category, unit_of_measure, reorder_level) VALUES ('Losartan', 'Losartan 50mg', 'Tablet', 'Strips', 130);
INSERT INTO Medicines (name, generic_name, category, unit_of_measure, reorder_level) VALUES ('Atorvastatin', 'Atorvastatin 10mg', 'Tablet', 'Strips', 149);
INSERT INTO Medicines (name, generic_name, category, unit_of_measure, reorder_level) VALUES ('Salbutamol', 'Salbutamol 100mcg', 'Inhaler', 'Pieces', 194);
INSERT INTO Medicines (name, generic_name, category, unit_of_measure, reorder_level) VALUES ('Omeprazole', 'Omeprazole 20mg', 'Capsule', 'Strips', 72);
INSERT INTO Medicines (name, generic_name, category, unit_of_measure, reorder_level) VALUES ('Diclofenac', 'Diclofenac Sodium', 'Gel', 'Tubes', 168);

-- ------------------------------------------------------------------------------
-- 5. Purchases, Purchase Details, and Inventory Batches (50 Transactions)
-- ------------------------------------------------------------------------------

-- Purchase #1
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (5, 2, '2026-05-04', 2517.83, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (1, 16, 921, 921, 86.15);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (16, 'B11694', '2026-02-25', '2027-05-12', 921, 86.15, 'Available');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (1, 8, 465, 465, 15.8);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (8, 'B1872', '2026-03-06', '2028-03-29', 465, 15.8, 'Available');

-- Purchase #2
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (9, 2, '2025-09-04', 3520.65, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (2, 4, 287, 287, 25.77);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (4, 'B2442', '2025-06-06', '2026-12-28', 287, 25.77, 'Available');

-- Purchase #3
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (9, 2, '2025-11-15', 4781.23, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (3, 19, 390, 390, 97.8);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (19, 'B31937', '2025-08-29', '2027-11-28', 390, 97.8, 'Available');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (3, 12, 242, 242, 67.0);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (12, 'B31284', '2025-09-22', '2026-07-27', 242, 67.0, 'Available');

-- Purchase #4
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (2, 2, '2026-03-01', 2829.02, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (4, 8, 263, 263, 50.92);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (8, 'B4878', '2025-12-22', '2026-09-28', 263, 50.92, 'Available');

-- Purchase #5
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (7, 2, '2026-03-29', 3902.54, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (5, 18, 659, 659, 23.08);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (18, 'B51839', '2026-01-30', '2027-11-05', 659, 23.08, 'Available');

-- Purchase #6
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (5, 2, '2026-05-17', 1382.71, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (6, 10, 798, 798, 18.63);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (10, 'B61035', '2026-04-17', '2028-03-11', 798, 18.63, 'Available');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (6, 4, 259, 259, 28.99);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (4, 'B6455', '2026-03-22', '2027-01-04', 259, 28.99, 'Available');

-- Purchase #7
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (2, 2, '2026-04-20', 599.21, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (7, 9, 620, 620, 61.53);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (9, 'B7925', '2026-01-28', '2027-06-28', 620, 61.53, 'Available');

-- Purchase #8
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (3, 2, '2025-07-17', 2130.24, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (8, 11, 343, 343, 15.93);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (11, 'B81153', '2025-05-05', '2026-07-22', 343, 15.93, 'Available');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (8, 3, 782, 782, 51.81);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (3, 'B8365', '2025-06-07', '2027-04-12', 782, 51.81, 'Available');

-- Purchase #9
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (5, 2, '2026-04-09', 3339.84, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (9, 11, 593, 593, 78.02);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (11, 'B91186', '2026-01-14', '2027-05-20', 593, 78.02, 'Available');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (9, 14, 563, 563, 47.26);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (14, 'B91481', '2026-02-10', '2028-02-10', 563, 47.26, 'Available');

-- Purchase #10
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (2, 2, '2026-01-26', 4374.37, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (10, 18, 941, 941, 50.89);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (18, 'B101851', '2025-11-14', '2026-09-22', 941, 50.89, 'Available');

-- Purchase #11
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (4, 2, '2025-11-08', 4534.75, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (11, 16, 486, 486, 54.23);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (16, 'B111619', '2025-08-18', '2027-10-03', 486, 54.23, 'Available');

-- Purchase #12
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (7, 2, '2025-12-18', 1411.32, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (12, 7, 508, 508, 84.25);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (7, 'B12727', '2025-11-15', '2028-05-10', 508, 84.25, 'Available');

-- Purchase #13
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (2, 2, '2026-04-28', 4114.06, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (13, 12, 805, 805, 38.97);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (12, 'B131284', '2026-02-02', '2026-12-28', 805, 38.97, 'Available');

-- Purchase #14
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (3, 2, '2026-03-20', 507.68, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (14, 5, 362, 362, 16.55);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (5, 'B14517', '2026-01-16', '2026-09-06', 362, 16.55, 'Available');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (14, 14, 277, 277, 7.19);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (14, 'B141429', '2026-02-14', '2027-11-28', 277, 7.19, 'Available');

-- Purchase #15
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (1, 2, '2026-04-25', 1893.74, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (15, 6, 561, 561, 51.03);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (6, 'B15618', '2026-02-25', '2027-07-11', 561, 51.03, 'Available');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (15, 6, 432, 432, 28.57);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (6, 'B15642', '2026-03-21', '2026-09-29', 432, 28.57, 'Available');

-- Purchase #16
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (8, 2, '2025-06-25', 4335.94, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (16, 19, 164, 164, 28.74);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (19, 'B161910', '2025-04-12', '2027-08-28', 164, 28.74, 'Available');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (16, 1, 182, 182, 82.41);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (1, 'B16159', '2025-04-02', '2026-12-25', 182, 82.41, 'Available');

-- Purchase #17
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (2, 2, '2026-02-07', 3703.1, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (17, 15, 913, 913, 16.56);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (15, 'B171578', '2025-11-10', '2026-07-29', 913, 16.56, 'Available');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (17, 20, 999, 999, 29.55);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (20, 'B172093', '2025-11-09', '2026-12-30', 999, 29.55, 'Available');

-- Purchase #18
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (5, 2, '2025-10-06', 4079.77, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (18, 13, 489, 489, 18.63);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (13, 'B181366', '2025-08-22', '2026-12-20', 489, 18.63, 'Available');

-- Purchase #19
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (4, 2, '2026-05-17', 1712.63, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (19, 4, 440, 440, 97.67);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (4, 'B19437', '2026-03-14', '2026-12-11', 440, 97.67, 'Available');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (19, 17, 990, 990, 36.83);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (17, 'B191790', '2026-02-16', '2027-07-29', 990, 36.83, 'Available');

-- Purchase #20
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (1, 2, '2025-07-20', 2391.32, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (20, 8, 217, 217, 47.28);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (8, 'B20872', '2025-04-21', '2027-04-16', 217, 47.28, 'Available');

-- Purchase #21
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (1, 2, '2025-06-22', 1661.57, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (21, 8, 525, 525, 40.16);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (8, 'B21865', '2025-05-09', '2028-06-06', 525, 40.16, 'Available');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (21, 16, 596, 596, 55.34);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (16, 'B211685', '2025-04-14', '2028-04-13', 596, 55.34, 'Available');

-- Purchase #22
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (2, 2, '2025-11-18', 3312.51, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (22, 18, 778, 778, 11.64);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (18, 'B221856', '2025-10-18', '2027-09-17', 778, 11.64, 'Available');

-- Purchase #23
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (10, 2, '2026-01-31', 771.74, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (23, 12, 136, 136, 13.86);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (12, 'B231271', '2025-12-27', '2026-09-20', 136, 13.86, 'Available');

-- Purchase #24
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (9, 2, '2026-02-21', 3208.98, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (24, 20, 499, 499, 91.54);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (20, 'B242051', '2026-01-06', '2027-06-16', 499, 91.54, 'Available');

-- Purchase #25
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (9, 2, '2026-04-18', 1807.95, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (25, 4, 217, 217, 73.57);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (4, 'B25454', '2026-03-08', '2027-12-02', 217, 73.57, 'Available');

-- Purchase #26
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (10, 2, '2025-12-25', 4015.38, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (26, 1, 351, 351, 31.09);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (1, 'B26144', '2025-11-09', '2027-10-22', 351, 31.09, 'Available');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (26, 17, 626, 626, 11.83);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (17, 'B261710', '2025-10-26', '2027-05-15', 626, 11.83, 'Available');

-- Purchase #27
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (7, 2, '2026-06-02', 3608.0, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (27, 8, 628, 628, 33.2);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (8, 'B27815', '2026-04-18', '2026-09-30', 628, 33.2, 'Available');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (27, 1, 315, 315, 66.07);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (1, 'B27140', '2026-03-27', '2026-11-28', 315, 66.07, 'Available');

-- Purchase #28
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (8, 2, '2026-03-28', 3426.33, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (28, 12, 698, 698, 96.41);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (12, 'B281250', '2026-01-26', '2027-02-07', 698, 96.41, 'Available');

-- Purchase #29
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (9, 2, '2025-07-24', 3692.32, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (29, 2, 698, 698, 81.78);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (2, 'B29246', '2025-05-08', '2026-10-04', 698, 81.78, 'Available');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (29, 17, 497, 497, 90.95);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (17, 'B291776', '2025-05-04', '2028-05-18', 497, 90.95, 'Available');

-- Purchase #30
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (1, 2, '2025-12-30', 3181.87, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (30, 1, 522, 522, 82.21);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (1, 'B30147', '2025-11-07', '2027-01-01', 522, 82.21, 'Available');

-- Purchase #31
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (9, 2, '2025-08-18', 4384.73, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (31, 15, 181, 181, 11.52);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (15, 'B311576', '2025-06-27', '2027-05-21', 181, 11.52, 'Available');

-- Purchase #32
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (2, 2, '2025-09-01', 3979.95, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (32, 6, 140, 140, 88.72);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (6, 'B32630', '2025-07-22', '2027-08-28', 140, 88.72, 'Available');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (32, 12, 736, 736, 73.87);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (12, 'B321256', '2025-06-20', '2027-05-19', 736, 73.87, 'Available');

-- Purchase #33
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (10, 2, '2025-08-08', 713.59, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (33, 11, 729, 729, 23.8);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (11, 'B331118', '2025-06-03', '2027-04-04', 729, 23.8, 'Available');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (33, 16, 126, 126, 9.29);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (16, 'B331618', '2025-05-26', '2027-03-21', 126, 9.29, 'Available');

-- Purchase #34
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (1, 2, '2026-02-14', 4059.0, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (34, 18, 433, 433, 45.56);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (18, 'B341838', '2025-11-26', '2027-10-06', 433, 45.56, 'Available');

-- Purchase #35
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (4, 2, '2026-04-19', 2572.78, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (35, 5, 543, 543, 56.86);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (5, 'B35572', '2026-03-13', '2026-09-16', 543, 56.86, 'Available');

-- Purchase #36
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (3, 2, '2025-06-21', 2178.67, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (36, 3, 713, 713, 5.19);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (3, 'B36347', '2025-05-18', '2027-09-12', 713, 5.19, 'Available');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (36, 17, 257, 257, 56.87);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (17, 'B361779', '2025-05-10', '2028-06-04', 257, 56.87, 'Available');

-- Purchase #37
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (6, 2, '2026-03-14', 3502.35, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (37, 16, 231, 231, 83.07);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (16, 'B371663', '2025-12-17', '2027-04-07', 231, 83.07, 'Available');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (37, 6, 155, 155, 87.58);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (6, 'B37636', '2025-12-27', '2027-03-19', 155, 87.58, 'Available');

-- Purchase #38
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (8, 2, '2025-11-17', 3188.19, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (38, 6, 350, 350, 61.97);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (6, 'B38634', '2025-09-17', '2026-09-25', 350, 61.97, 'Available');

-- Purchase #39
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (7, 2, '2025-12-15', 3387.68, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (39, 4, 957, 957, 66.38);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (4, 'B39460', '2025-11-14', '2027-05-15', 957, 66.38, 'Available');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (39, 5, 263, 263, 61.18);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (5, 'B39548', '2025-10-25', '2027-12-31', 263, 61.18, 'Available');

-- Purchase #40
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (6, 2, '2025-07-16', 1156.64, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (40, 20, 947, 947, 72.33);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (20, 'B402063', '2025-05-04', '2027-10-28', 947, 72.33, 'Available');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (40, 17, 504, 504, 97.57);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (17, 'B401714', '2025-04-21', '2027-04-19', 504, 97.57, 'Available');

-- Purchase #41
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (2, 2, '2025-08-20', 2459.12, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (41, 19, 299, 299, 26.6);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (19, 'B411992', '2025-06-14', '2028-04-01', 299, 26.6, 'Available');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (41, 6, 482, 482, 40.25);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (6, 'B41677', '2025-07-07', '2026-08-24', 482, 40.25, 'Available');

-- Purchase #42
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (2, 2, '2025-08-06', 2880.32, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (42, 18, 858, 858, 82.5);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (18, 'B421883', '2025-06-04', '2027-12-27', 858, 82.5, 'Available');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (42, 15, 338, 338, 44.65);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (15, 'B421595', '2025-06-13', '2026-08-20', 338, 44.65, 'Available');

-- Purchase #43
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (9, 2, '2025-06-18', 1387.79, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (43, 3, 316, 316, 33.07);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (3, 'B43330', '2025-04-01', '2028-01-30', 316, 33.07, 'Available');

-- Purchase #44
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (1, 2, '2025-07-14', 4470.86, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (44, 19, 236, 236, 30.9);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (19, 'B441968', '2025-05-24', '2027-06-07', 236, 30.9, 'Available');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (44, 8, 581, 581, 41.9);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (8, 'B44890', '2025-05-15', '2027-07-04', 581, 41.9, 'Available');

-- Purchase #45
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (4, 2, '2025-10-28', 1241.66, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (45, 15, 300, 300, 12.52);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (15, 'B451531', '2025-08-01', '2027-04-11', 300, 12.52, 'Available');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (45, 19, 680, 680, 63.79);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (19, 'B451967', '2025-09-15', '2026-11-15', 680, 63.79, 'Available');

-- Purchase #46
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (1, 2, '2025-11-17', 2711.49, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (46, 10, 206, 206, 96.94);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (10, 'B461014', '2025-08-27', '2027-07-08', 206, 96.94, 'Available');

-- Purchase #47
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (2, 2, '2026-02-02', 1437.24, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (47, 11, 996, 996, 9.02);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (11, 'B471147', '2025-11-10', '2026-08-19', 996, 9.02, 'Available');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (47, 7, 600, 600, 36.22);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (7, 'B47775', '2025-11-13', '2027-08-25', 600, 36.22, 'Available');

-- Purchase #48
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (3, 2, '2026-03-30', 1002.12, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (48, 2, 854, 854, 21.24);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (2, 'B48257', '2026-02-25', '2026-12-12', 854, 21.24, 'Available');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (48, 14, 861, 861, 22.26);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (14, 'B481466', '2026-01-31', '2026-11-18', 861, 22.26, 'Available');

-- Purchase #49
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (7, 2, '2025-07-09', 3682.4, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (49, 6, 262, 262, 83.4);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (6, 'B49664', '2025-05-27', '2028-02-28', 262, 83.4, 'Available');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (49, 2, 541, 541, 28.58);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (2, 'B49276', '2025-06-06', '2027-10-14', 541, 28.58, 'Available');

-- Purchase #50
INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES (2, 2, '2026-03-19', 3095.33, 'Completed');
INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES (50, 9, 126, 126, 7.49);
INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES (9, 'B50944', '2026-02-04', '2027-11-01', 126, 7.49, 'Available');

-- ------------------------------------------------------------------------------
-- 6. Distributions (50 Transactions)
-- ------------------------------------------------------------------------------
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (1, 13, 4, 5, 50, '2026-06-12 10:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (4, 19, 4, 5, 8, '2026-06-15 03:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (1, 27, 4, 3, 35, '2026-06-15 03:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (4, 51, 4, 3, 44, '2026-06-16 21:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (4, 49, 4, 3, 47, '2026-06-10 08:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (5, 74, 4, 3, 18, '2026-06-14 02:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (1, 19, 4, 5, 26, '2026-06-12 10:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (1, 10, 4, 5, 44, '2026-06-14 23:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (4, 31, 4, 5, 43, '2026-06-15 01:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (5, 52, 4, 3, 36, '2026-06-16 09:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (4, 9, 4, 3, 30, '2026-06-15 23:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (3, 39, 4, 3, 7, '2026-06-14 08:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (3, 35, 4, 3, 26, '2026-06-16 07:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (5, 1, 4, 3, 19, '2026-06-08 20:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (2, 27, 4, 5, 14, '2026-06-13 07:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (2, 30, 4, 5, 12, '2026-06-11 13:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (3, 39, 4, 3, 5, '2026-06-07 23:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (5, 33, 4, 3, 5, '2026-06-16 19:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (5, 74, 4, 3, 21, '2026-06-10 16:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (5, 76, 4, 5, 33, '2026-06-14 20:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (5, 45, 4, 3, 10, '2026-06-13 11:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (3, 3, 4, 5, 15, '2026-06-10 21:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (1, 3, 4, 5, 29, '2026-06-15 00:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (2, 26, 4, 3, 22, '2026-06-10 02:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (2, 77, 4, 5, 19, '2026-06-11 12:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (3, 47, 4, 5, 45, '2026-06-12 19:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (1, 40, 4, 5, 50, '2026-06-16 00:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (1, 23, 4, 3, 40, '2026-06-10 12:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (5, 72, 4, 3, 39, '2026-06-10 14:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (5, 33, 4, 5, 33, '2026-06-10 15:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (2, 71, 4, 3, 27, '2026-06-14 10:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (5, 9, 4, 3, 41, '2026-06-14 02:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (2, 48, 4, 5, 22, '2026-06-12 03:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (3, 5, 4, 5, 32, '2026-06-14 18:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (4, 71, 4, 3, 48, '2026-06-16 13:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (3, 56, 4, 5, 42, '2026-06-11 15:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (3, 11, 4, 5, 19, '2026-06-10 17:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (5, 26, 4, 3, 37, '2026-06-11 13:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (2, 48, 4, 5, 26, '2026-06-08 16:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (5, 9, 4, 3, 8, '2026-06-11 20:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (1, 45, 4, 5, 12, '2026-06-14 19:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (2, 6, 4, 5, 40, '2026-06-15 20:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (5, 77, 4, 5, 7, '2026-06-15 11:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (3, 2, 4, 3, 36, '2026-06-13 12:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (5, 71, 4, 3, 18, '2026-06-12 08:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (2, 24, 4, 5, 9, '2026-06-09 09:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (5, 74, 4, 5, 23, '2026-06-16 21:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (2, 31, 4, 5, 43, '2026-06-11 14:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (3, 30, 4, 3, 18, '2026-06-15 10:54:47');
INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES (4, 51, 4, 5, 18, '2026-06-15 02:54:47');
