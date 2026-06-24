const express = require('express');
const router = express.Router();

router.get('/', async (req, res) => {
    try {
        const [rows] = await req.db.query(`
            SELECT d.distribution_id, dept.department_name, m.name as medicine_name, mb.batch_number, 
                   d.quantity_issued, d.issue_date, u.full_name as requested_by_name
            FROM Distributions d
            JOIN Departments dept ON d.department_id = dept.department_id
            JOIN Medicine_Batches mb ON d.batch_id = mb.batch_id
            JOIN Medicines m ON mb.medicine_id = m.medicine_id
            JOIN Users u ON d.requested_by = u.user_id
            ORDER BY d.issue_date DESC
        `);
        res.json(rows);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Database error fetching distributions' });
    }
});

router.post('/', async (req, res) => {
    const { department_id, batch_id, quantity } = req.body;
    // Hardcode user IDs to 1 for demonstration as there's no auth session yet
    const issued_by = 1;
    const requested_by = 1;

    try {
        await req.db.query(
            'CALL IssueMedicine(?, ?, ?, ?, ?)',
            [department_id, batch_id, issued_by, requested_by, quantity]
        );
        res.status(201).json({ message: 'Item issued successfully' });
    } catch (error) {
        console.error("Error issuing item:", error);
        res.status(400).json({ error: error.message || 'Failed to issue item' });
    }
});

module.exports = router;
