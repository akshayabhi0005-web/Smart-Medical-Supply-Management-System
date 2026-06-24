const express = require('express');
const router = express.Router();

router.get('/department-usage', async (req, res) => {
    try {
        const [rows] = await req.db.query('SELECT * FROM DepartmentUsageView');
        res.json(rows);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Database error fetching reports' });
    }
});

module.exports = router;
