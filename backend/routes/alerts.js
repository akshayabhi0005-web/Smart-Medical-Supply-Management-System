const express = require('express');
const router = express.Router();

router.get('/', async (req, res) => {
    try {
        const [rows] = await req.db.query(`
            SELECT sa.*, m.name as medicine_name, mb.batch_number 
            FROM Stock_Alerts sa
            LEFT JOIN Medicines m ON sa.medicine_id = m.medicine_id
            LEFT JOIN Medicine_Batches mb ON sa.batch_id = mb.batch_id
            ORDER BY sa.alert_date DESC
        `);
        res.json(rows);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Database error fetching alerts' });
    }
});

module.exports = router;
