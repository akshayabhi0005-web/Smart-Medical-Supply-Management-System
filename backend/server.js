const express = require('express');
const cors = require('cors');
const mysql = require('mysql2/promise');
require('dotenv').config();

const app = express();
const port = process.env.PORT || 5000;

app.use(cors());
app.use(express.json());

// Database Connection Pool
const pool = mysql.createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});

// Test Database Connection
pool.getConnection()
    .then((connection) => {
        console.log('Successfully connected to MySQL database (smsms_db)');
        connection.release();
    })
    .catch((err) => {
        console.error('Error connecting to the database:', err.message);
    });

// Middleware to inject DB pool into requests
app.use((req, res, next) => {
    req.db = pool;
    next();
});

// Import Routes
app.use('/api/medicines', require('./routes/medicines'));
app.use('/api/dashboard', require('./routes/dashboard'));
app.use('/api/batches', require('./routes/batches'));
app.use('/api/suppliers', require('./routes/suppliers'));
app.use('/api/departments', require('./routes/departments'));
app.use('/api/purchases', require('./routes/purchases'));
app.use('/api/distributions', require('./routes/distributions'));
app.use('/api/alerts', require('./routes/alerts'));
app.use('/api/reports', require('./routes/reports'));

// Health check endpoint
app.get('/api/health', (req, res) => {
    res.json({ status: 'OK', message: 'SMSMS API is running' });
});

app.listen(port, () => {
    console.log(`Backend API Server running on http://localhost:${port}`);
});
