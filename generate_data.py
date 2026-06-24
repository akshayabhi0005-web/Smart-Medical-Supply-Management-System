import random
from datetime import datetime, timedelta

def esc(s):
    return s.replace("'", "''")

with open('C:\\Users\\aksha\\Desktop\\smds\\sample_data.sql', 'w') as f:
    f.write("-- ==============================================================================\n")
    f.write("-- Smart Medical Supply Management System (SMSMS) - Sample Data\n")
    f.write("-- ==============================================================================\n\n")
    f.write("USE smsms_db;\n\n")

    # 1. Departments (5)
    departments = ["Emergency", "ICU", "Cardiology", "Neurology", "General Ward"]
    f.write("-- ------------------------------------------------------------------------------\n")
    f.write("-- 1. Departments\n")
    f.write("-- ------------------------------------------------------------------------------\n")
    for i, d in enumerate(departments):
        f.write(f"INSERT INTO Departments (department_name, location, contact_number) VALUES ('{d}', 'Building {chr(65+i)}', '555-010{i}');\n")

    # 2. Users (5)
    f.write("\n-- ------------------------------------------------------------------------------\n")
    f.write("-- 2. Users\n")
    f.write("-- ------------------------------------------------------------------------------\n")
    roles = ['Admin', 'Inventory Manager', 'Department Head', 'Pharmacist', 'Department Head']
    for i in range(5):
        dept_id = i + 1 if roles[i] == 'Department Head' else 'NULL'
        f.write(f"INSERT INTO Users (department_id, username, password_hash, full_name, role) VALUES ({dept_id}, 'user{i+1}', '$2b$12$somehashedpasswordstring', 'User {i+1}', '{roles[i]}');\n")

    # 3. Suppliers (10)
    f.write("\n-- ------------------------------------------------------------------------------\n")
    f.write("-- 3. Suppliers\n")
    f.write("-- ------------------------------------------------------------------------------\n")
    for i in range(1, 11):
        f.write(f"INSERT INTO Suppliers (supplier_name, contact_person, phone_number, email, address) VALUES ('Supplier {i} Healthcare', 'Contact {i}', '555-200{i}', 'contact{i}@supplier{i}.com', '{i}00 Health St, Cityville');\n")

    # 4. Medicines (20)
    f.write("\n-- ------------------------------------------------------------------------------\n")
    f.write("-- 4. Medicines (20 required items included)\n")
    f.write("-- ------------------------------------------------------------------------------\n")
    meds = [
        ("Dolo 650", "Paracetamol 650mg", "Tablet", "Strips"),
        ("Paracetamol", "Paracetamol 500mg", "Tablet", "Strips"),
        ("Amoxicillin", "Amoxicillin 500mg", "Capsule", "Strips"),
        ("Insulin", "Insulin Human Injection", "Injection", "Vials"),
        ("Syringes", "Syringe 5ml Disposable", "Consumable", "Pieces"),
        ("Gloves", "Nitrile Examination Gloves", "Consumable", "Boxes"),
        ("Face Masks", "N95 Surgical Mask", "Consumable", "Boxes"),
        ("Bandages", "Cotton Roll Bandage", "Consumable", "Rolls"),
        ("Ibuprofen", "Ibuprofen 400mg", "Tablet", "Strips"),
        ("Cetirizine", "Cetirizine 10mg", "Tablet", "Strips"),
        ("Pantoprazole", "Pantoprazole 40mg", "Tablet", "Strips"),
        ("Aspirin", "Aspirin 75mg", "Tablet", "Strips"),
        ("Azithromycin", "Azithromycin 500mg", "Tablet", "Strips"),
        ("Metformin", "Metformin 500mg", "Tablet", "Strips"),
        ("Amlodipine", "Amlodipine 5mg", "Tablet", "Strips"),
        ("Losartan", "Losartan 50mg", "Tablet", "Strips"),
        ("Atorvastatin", "Atorvastatin 10mg", "Tablet", "Strips"),
        ("Salbutamol", "Salbutamol 100mcg", "Inhaler", "Pieces"),
        ("Omeprazole", "Omeprazole 20mg", "Capsule", "Strips"),
        ("Diclofenac", "Diclofenac Sodium", "Gel", "Tubes")
    ]
    for m in meds:
        f.write(f"INSERT INTO Medicines (name, generic_name, category, unit_of_measure, reorder_level) VALUES ('{esc(m[0])}', '{esc(m[1])}', '{m[2]}', '{m[3]}', {random.randint(50, 200)});\n")

    # 5. Purchases & Details & Batches (50 transactions)
    f.write("\n-- ------------------------------------------------------------------------------\n")
    f.write("-- 5. Purchases, Purchase Details, and Inventory Batches (50 Transactions)\n")
    f.write("-- ------------------------------------------------------------------------------\n")
    
    batch_counter = 1
    for p_id in range(1, 51):
        supp_id = random.randint(1, 10)
        ordered_by = 2 # Inventory Manager
        days_ago = random.randint(10, 365)
        o_date = (datetime.now() - timedelta(days=days_ago)).strftime('%Y-%m-%d')
        total = round(random.uniform(500, 5000), 2)
        
        f.write(f"\n-- Purchase #{p_id}\n")
        f.write(f"INSERT INTO Purchases (supplier_id, ordered_by, order_date, total_amount, status) VALUES ({supp_id}, {ordered_by}, '{o_date}', {total}, 'Completed');\n")
        
        # Details (1 to 2 items per purchase to keep it realistic but compact)
        num_items = random.randint(1, 2)
        for _ in range(num_items):
            med_id = random.randint(1, 20)
            qty = random.randint(100, 1000)
            price = round(random.uniform(5, 100), 2)
            f.write(f"INSERT INTO Purchase_Details (purchase_id, medicine_id, ordered_quantity, received_quantity, unit_price) VALUES ({p_id}, {med_id}, {qty}, {qty}, {price});\n")
            
            # Create a batch for each received item in the purchase
            b_num = f"B{p_id}{med_id}{random.randint(10,99)}"
            m_date = (datetime.now() - timedelta(days=days_ago+random.randint(30,90))).strftime('%Y-%m-%d')
            e_date = (datetime.now() + timedelta(days=random.randint(30, 730))).strftime('%Y-%m-%d')
            
            # Some batches might be expired if e_date is past, let's keep status simple
            status = 'Available'
            if datetime.strptime(e_date, '%Y-%m-%d') < datetime.now():
                status = 'Expired'
                
            f.write(f"INSERT INTO Medicine_Batches (medicine_id, batch_number, manufacturing_date, expiry_date, quantity, unit_price, status) VALUES ({med_id}, '{b_num}', '{m_date}', '{e_date}', {qty}, {price}, '{status}');\n")
            batch_counter += 1

    # 6. Distributions (50 transactions)
    f.write("\n-- ------------------------------------------------------------------------------\n")
    f.write("-- 6. Distributions (50 Transactions)\n")
    f.write("-- ------------------------------------------------------------------------------\n")
    for d_id in range(1, 51):
        dept_id = random.randint(1, 5)
        batch_id = random.randint(1, batch_counter - 1)
        issued_by = 4 # Pharmacist
        requested_by = random.choice([3, 5]) # Department Head User IDs
        qty = random.randint(5, 50)
        days_ago = random.randint(1, 9)
        i_date = (datetime.now() - timedelta(days=days_ago, hours=random.randint(1, 23))).strftime('%Y-%m-%d %H:%M:%S')
        f.write(f"INSERT INTO Distributions (department_id, batch_id, issued_by, requested_by, quantity_issued, issue_date) VALUES ({dept_id}, {batch_id}, {issued_by}, {requested_by}, {qty}, '{i_date}');\n")
        
print("Sample data generated successfully in sample_data.sql")
