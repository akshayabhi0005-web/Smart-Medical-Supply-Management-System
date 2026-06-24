const express = require('express');
const router = express.Router();

// GET all medicines (Utilizing the SQL View we created for efficiency)
router.get('/', async (req, res) => {
    try {
        const [rows] = await req.db.query('SELECT * FROM CurrentInventoryView');
        res.json(rows);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Database error fetching medicines catalog' });
    }
});

// GET specific medicine with its batches
router.get('/:id', async (req, res) => {
    try {
        const [medicineInfo] = await req.db.query('SELECT * FROM CurrentInventoryView WHERE medicine_id = ?', [req.params.id]);
        if (medicineInfo.length === 0) return res.status(404).json({ error: 'Medicine not found' });
        
        const [batches] = await req.db.query('SELECT batch_number, quantity, expiry_date, status FROM Medicine_Batches WHERE medicine_id = ? ORDER BY expiry_date ASC', [req.params.id]);
        
        res.json({
            ...medicineInfo[0],
            batches: batches
        });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Database error fetching medicine details' });
    }
});

// POST new medicine
router.post('/', async (req, res) => {
    const { name, generic_name, category, uom, reorder_level } = req.body;
    try {
        await req.db.query(
            'CALL AddMedicine(?, ?, ?, ?, ?)',
            [name, generic_name, category, uom, reorder_level]
        );
        res.status(201).json({ message: 'Medicine added successfully' });
    } catch (error) {
        console.error("Error adding medicine:", error);
        res.status(500).json({ error: 'Failed to add medicine' });
    }
});

// GET low stock medicines specifically
router.get('/low-stock', async (req, res) => {
    try {
        const [rows] = await req.db.query('SELECT * FROM LowStockView');
        res.json(rows);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Database error fetching low stock data' });
    }
});

module.exports = router;
