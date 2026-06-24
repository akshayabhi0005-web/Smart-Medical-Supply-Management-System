const express = require('express');
const router = express.Router();

// GET dashboard widgets summary data
router.get('/widgets', async (req, res) => {
    try {
        const [meds] = await req.db.query('SELECT COUNT(*) as total FROM Medicines');
        const [orders] = await req.db.query('SELECT COUNT(*) as total FROM Purchases WHERE status="Pending"');
        const [lowStock] = await req.db.query('SELECT COUNT(*) as total FROM LowStockView');
        const [expiring] = await req.db.query('SELECT COUNT(*) as total FROM ExpiringMedicinesView');
        
        res.json({
            totalMedicines: meds[0].total,
            pendingOrders: orders[0].total,
            lowStockItems: lowStock[0].total,
            expiringBatches: expiring[0].total
        });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Database error fetching dashboard widgets' });
    }
});

// GET recent system alerts
router.get('/alerts', async (req, res) => {
    try {
        const [rows] = await req.db.query(`
            SELECT sa.alert_id, sa.alert_type, sa.alert_date, m.name as medicine_name, mb.batch_number 
            FROM Stock_Alerts sa
            LEFT JOIN Medicines m ON sa.medicine_id = m.medicine_id
            LEFT JOIN Medicine_Batches mb ON sa.batch_id = mb.batch_id
            WHERE sa.status = 'Unread'
            ORDER BY sa.alert_date DESC LIMIT 5
        `);
        res.json(rows);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Database error fetching alerts' });
    }
});

module.exports = router;
