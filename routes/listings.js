const express = require('express');
const router = express.Router();
const pool = require('../db');

// Get all company assets (Equipment)
router.get('/', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM equipment');
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;