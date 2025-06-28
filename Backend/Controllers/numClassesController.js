const pool = require("../db");

const getTodayClasses = async (req, res) => {
  const today = new Date().toLocaleString('en-US', { weekday: 'long' });

  try {
    const result = await pool.query(
      `SELECT COUNT(*) FROM class_schedule
       WHERE day = $1`,
      [today]
    );

    const classCount = result.rows[0].count;
    res.json({ classCount });
  } catch (err) {
    console.error('Error fetching class count:', err);
    res.status(500).json({ message: 'Server error' });
  }
};

module.exports = { getTodayClasses };