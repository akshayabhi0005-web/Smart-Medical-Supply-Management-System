# 🏥 Smart Medical Supply Management System (SMSMS)

<div align="center">

### Streamlining Healthcare Inventory Management with Smart Automation

A full-stack web application designed to efficiently manage medical inventory, suppliers, purchases, distributions, and stock monitoring in healthcare organizations.

![React](https://img.shields.io/badge/React-Frontend-blue?logo=react)
![Node.js](https://img.shields.io/badge/Node.js-Backend-green?logo=node.js)
![Express.js](https://img.shields.io/badge/Express.js-API-black?logo=express)
![MySQL](https://img.shields.io/badge/MySQL-Database-orange?logo=mysql)
![Vite](https://img.shields.io/badge/Vite-Build_Tool-purple?logo=vite)

</div>

---

## 📖 Overview

The **Smart Medical Supply Management System (SMSMS)** is a modern healthcare inventory management solution developed to streamline the tracking and management of medical supplies.

The system enables healthcare facilities to efficiently manage medicines, suppliers, purchases, stock levels, distributions, departments, and reports through a centralized dashboard. It reduces manual workload, improves inventory visibility, and helps prevent stock shortages.

---

## ✨ Features

### 💊 Medicine Management
- Add, edit, and delete medicines
- Track medicine inventory
- Monitor stock levels
- Maintain medicine records

### 📦 Batch Management
- Manage medicine batches
- Batch-wise stock tracking
- Inventory control and monitoring

### 🏢 Department Management
- Create and manage departments
- Allocate supplies to departments
- Department-wise inventory tracking

### 🚚 Supplier Management
- Add and manage supplier details
- Track supplier information
- Maintain vendor records

### 🛒 Purchase Management
- Record medical supply purchases
- Manage procurement activities
- Update inventory automatically

### 📤 Distribution Management
- Track medicine distributions
- Monitor supply allocations
- Maintain distribution history

### 🚨 Inventory Alerts
- Low-stock notifications
- Inventory monitoring
- Stock management assistance

### 📊 Dashboard & Reports
- Real-time inventory overview
- Purchase reports
- Distribution reports
- Inventory analytics
- Healthcare supply insights

---

## 🏗️ System Architecture

```text
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
```

---

## 🛠️ Tech Stack

### Frontend
- React.js
- Vite
- HTML5
- CSS3
- JavaScript

### Backend
- Node.js
- Express.js

### Database
- MySQL
- MySQL2

### Development Tools
- VS Code
- XAMPP
- Git
- GitHub

---

## 📂 Project Structure

```text
Smart-Medical-Supply-Management-System/
│
├── backend/
│   ├── routes/
│   ├── server.js
│   ├── package.json
│   └── .env
│
├── frontend/
│   ├── src/
│   ├── public/
│   ├── package.json
│   └── vite.config.js
│
├── schema.sql
├── sample_data.sql
├── queries.sql
├── INSTALL.md
└── README.md
```

---

## ⚙️ Installation & Setup

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/akshayabhi0005-web/Smart-Medical-Supply-Management-System.git
cd Smart-Medical-Supply-Management-System
```

---

### 2️⃣ Setup MySQL Database

Start **XAMPP** and ensure **Apache** and **MySQL** are running.

Open phpMyAdmin and create a database:

```sql
smsms_db
```

Import the following files:

```text
schema.sql
sample_data.sql
```

---

### 3️⃣ Configure Environment Variables

Create a `.env` file inside the `backend` directory:

```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=
DB_NAME=smsms_db
PORT=5000
```

---

### 4️⃣ Install Backend Dependencies

```bash
cd backend
npm install
```

Run the backend server:

```bash
node server.js
```

Expected Output:

```text
Successfully connected to MySQL database (smsms_db)
Backend API Server running on http://localhost:5000
```

---

### 5️⃣ Install Frontend Dependencies

Open a new terminal:

```bash
cd frontend
npm install
npm run dev
```

Expected Output:

```text
Local: http://localhost:5173
```

Open your browser and visit:

```text
http://localhost:5173
```

-

## 🎯 Project Objectives

- Improve healthcare inventory management
- Reduce manual record-keeping efforts
- Prevent stock shortages
- Improve procurement tracking
- Enhance supply chain visibility
- Generate useful reports and analytics
- Increase operational efficiency

---

## 🚀 Future Enhancements

- Barcode Scanner Integration
- QR Code Tracking
- AI-Based Demand Forecasting
- Automated Email Notifications
- Cloud Deployment
- Multi-Hospital Support
- Mobile Application Support

---

## 👨‍💻 Developed By

### Akshay N Abhi

**Computer Science Engineering Student**

🔗 GitHub: https://github.com/akshayabhi0005-web

---

<div align="center">

### 💙 Transforming Healthcare Inventory Management Through Technology

**Smart Medical Supply Management System (SMSMS)**

⭐ If you like this project, consider giving it a star!

</div>
