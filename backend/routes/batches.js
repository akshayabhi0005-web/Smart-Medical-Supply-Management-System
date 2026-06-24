const express = require('express');
const router = express.Router();

router.get('/', async (req, res) => {
    try {
        const [rows] = await req.db.query(`
            SELECT mb.*, m.name as medicine_name, m.category 
            FROM Medicine_Batches mb
            JOIN Medicines m ON mb.medicine_id = m.medicine_id
            ORDER BY mb.expiry_date ASC
        `);
        res.json(rows);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Database error fetching batches' });
    }
});

router.post('/', async (req, res) => {
    const { medicine_id, batch_number, mfg_date, exp_date, quantity, unit_price } = req.body;
    try {
        await req.db.query(
            'CALL AddBatch(?, ?, ?, ?, ?, ?)',
            [medicine_id, batch_number, mfg_date, exp_date, quantity, unit_price]
        );
        res.status(201).json({ message: 'Batch added successfully' });
    } catch (error) {
        console.error("Error adding batch:", error);
        res.status(500).json({ error: 'Failed to add batch' });
    }
});

module.exports = router;
