const pool = require("../db");

const getUserDetails = async (req, res) => {
  const { user_id } = req.params;

  try {
    const result = await pool.query(
      "SELECT user_id, name, email, phone, user_type FROM users WHERE user_id = $1",
      [user_id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ message: "User not found" });
    }

    res.json(result.rows[0]);
  } catch (error) {
    console.error("Error fetching user details:", error);
    res.status(500).json({ message: "Server error" });
  }
};

module.exports = { getUserDetails };
