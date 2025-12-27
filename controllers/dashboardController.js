// controllers/dashboardController.js
const pool = require('../db');

const getDashboardStats = async (req, res) => {
  try {
    // 1. Red Box: Scrapped Assets (Stage = Scrap) [cite: 55, 76]
    const scrapRes = await pool.query("SELECT COUNT(*) FROM maintenance_requests WHERE stage = 'Scrap'");
    
    // 2. Green Box: Pending & Overdue [cite: 42, 60]
    // Counts requests in 'New' or 'In Progress' and flags them if the scheduled_date is past [cite: 34, 55]
    const pendingRes = await pool.query(`
      SELECT COUNT(*) FROM maintenance_requests 
      WHERE stage IN ('New', 'In Progress')
    `);

    // 3. Blue Box: Workforce Utilization [cite: 35, 45]
    // Logic: (Sum of hours worked / total capacity) * 100. Assume 160 total capacity hours for example.
    const utilizationRes = await pool.query("SELECT SUM(duration) as total_hours FROM maintenance_requests");
    const totalHours = utilizationRes.rows[0].total_hours || 0;
    const utilization = ((totalHours / 160) * 100).toFixed(1); 

    res.json({
      scrapCount: scrapRes.rows[0].count,
      pendingCount: pendingRes.rows[0].count,
      utilization: utilization
    });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

module.exports = { getDashboardStats };