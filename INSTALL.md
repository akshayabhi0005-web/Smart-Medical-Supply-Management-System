# Smart Medical Supply Management System (SMSMS)
## Full-Stack Installation Guide

This guide will walk you through setting up and running the complete full-stack SMSMS application (React + Node.js + MySQL).

---

### Prerequisites
*   **Node.js** (v18+ recommended)
*   **MySQL Server** (XAMPP, WAMP, or standalone)

---

### Step 1: Database Setup
1. Ensure your MySQL server is running locally on port 3306.
2. In the project root (`smds/`), double click the `run_project.bat` script.
3. This automatically initializes the entire database schema, inserts sample data, and creates stored procedures.

---

### Step 2: Backend Setup
1. Open a terminal and navigate to the `backend` directory:
   ```bash
   cd smds/backend
   ```
2. Install dependencies (if not already installed):
   ```bash
   npm install
   ```
3. **Important:** The `.env` file has been pre-configured. If your local MySQL `root` user requires a password, open `backend/.env` and update `DB_PASSWORD=yourpassword`.
4. Start the Node.js Express server:
   ```bash
   node server.js
   ```
   *You should see a success message: `Backend API Server running on http://localhost:5000`*

---

### Step 3: Frontend Setup
1. Open a **new, separate** terminal window and navigate to the `frontend` directory:
   ```bash
   cd smds/frontend
   ```
2. Install dependencies (if not already installed):
   ```bash
   npm install
   ```
3. Start the Vite React development server:
   ```bash
   npm run dev
   ```
4. Open your browser and navigate to the URL provided in the terminal (usually `http://localhost:5173`).

---

🎉 **You are now running the full-stack system!** The React frontend is successfully fetching real live data from your MySQL database via the Express backend!
