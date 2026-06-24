const express = require('express');
const router = express.Router();

router.get('/', async (req, res) => {
    try {
        const [rows] = await req.db.query(`
            SELECT p.*, s.supplier_name, u.full_name as ordered_by_name
            FROM Purchases p
            JOIN Suppliers s ON p.supplier_id = s.supplier_id
            JOIN Users u ON p.ordered_by = u.user_id
            ORDER BY p.order_date DESC
        `);
        res.json(rows);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Database error fetching purchases' });
    }
});

module.exports = router;
