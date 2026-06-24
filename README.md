🏥 Smart Medical Supply Management System (SMSMS)
<div align="center">
Streamlining Medical Inventory Management with Smart Automation

A full-stack web application designed to efficiently manage medical supplies, inventory tracking, supplier management, stock monitoring, and healthcare logistics.










</div>
📖 Overview

The Smart Medical Supply Management System (SMSMS) is a web-based platform developed to simplify and automate the management of medical inventories in hospitals, pharmacies, clinics, and healthcare organizations.

The system helps administrators efficiently manage medicines, suppliers, departments, purchases, stock levels, distributions, and reports while reducing manual errors and improving operational efficiency.

✨ Key Features
💊 Medicine Management
Add, update, and delete medicines
Track medicine availability
Manage stock quantities
Monitor inventory status
📦 Batch Management
Track medicine batches
Manage batch details
Maintain stock records
Batch-wise inventory control
🏢 Department Management
Create and manage departments
Department-wise supply allocation
Resource tracking
🚚 Supplier Management
Add supplier information
Maintain supplier records
Track supplier transactions
Vendor management system
🛒 Purchase Management
Record medicine purchases
Purchase tracking
Inventory updates
Procurement management
📤 Distribution Management
Supply distribution tracking
Department allocation
Real-time stock updates
🚨 Smart Alerts
Low-stock notifications
Inventory monitoring
Supply management alerts
📊 Dashboard & Reports
Interactive dashboard
Inventory analytics
Purchase reports
Distribution reports
Healthcare supply insights
🏗️ System Architecture
Frontend (React + Vite)
            │
            ▼
Backend API (Node.js + Express)
            │
            ▼
      MySQL Database
            │
            ▼
 Inventory • Suppliers • Purchases
 Departments • Distributions • Reports
🛠️ Tech Stack
Frontend
React.js
Vite
JavaScript
HTML5
CSS3
Backend
Node.js
Express.js
Database
MySQL
MySQL2
Tools & Utilities
XAMPP
VS Code
Git & GitHub
REST APIs
📂 Project Structure
Smart-Medical-Supply-Management-System/
│
├── backend/
│   ├── routes/
│   ├── server.js
│   ├── package.json
│
├── frontend/
│   ├── src/
│   ├── public/
│   ├── vite.config.js
│
├── schema.sql
├── sample_data.sql
├── queries.sql
├── README.md
└── INSTALL.md
⚙️ Installation Guide
1️⃣ Clone Repository
git clone https://github.com/akshayabhi0005-web/Smart-Medical-Supply-Management-System.git
cd Smart-Medical-Supply-Management-System
2️⃣ Setup Database
Start XAMPP
Open phpMyAdmin
Create a database:
smsms_db
Import:
schema.sql
sample_data.sql
3️⃣ Configure Environment Variables

Create a .env file inside the backend folder.

DB_HOST=localhost
DB_USER=root
DB_PASSWORD=
DB_NAME=smsms_db
PORT=5000
4️⃣ Start Backend Server
cd backend
npm install
node server.js

Output:

Successfully connected to MySQL database
Backend API Server running on http://localhost:5000
5️⃣ Start Frontend
cd frontend
npm install
npm run dev

Open:

http://localhost:5173
📸 Screenshots
🔐 Login Page

Add screenshot here

📊 Dashboard

Add screenshot here

💊 Inventory Management

Add screenshot here

📦 Supplier Management

Add screenshot here

📈 Reports Section

Add screenshot here

🎯 Objectives
Improve inventory accuracy
Reduce manual record keeping
Prevent stock shortages
Enhance healthcare supply management
Generate analytical reports
Improve operational efficiency
🚀 Future Enhancements
Barcode Scanner Integration
QR Code Tracking
AI-Based Demand Forecasting
Email & SMS Notifications
Cloud Deployment
Multi-Hospital Support
Mobile Application
👨‍💻 Developed By

Akshay N 

Computer Science Engineering Student

📧 Contact: akshaybhi0005@gmail.com

🔗 GitHub: akshayabhi0005-web


<div align="center">
💙 Transforming Healthcare Inventory Management Through Technology

Smart Medical Supply Management System (SMSMS)

</div>
