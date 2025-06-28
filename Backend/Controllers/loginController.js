const { validationResult } = require("express-validator");
const bcrypt = require("bcrypt");
const pool = require("../db");

const handleLogin = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }

  const { email, password, user_type } = req.body;

  try {
    const result = await pool.query(
      "SELECT * FROM users WHERE email = $1 AND user_type = $2",
      [email, user_type]
    );

    const user = result.rows[0];

    if (!user) {
      return res.status(401).json({ message: "Invalid credentials" });
    }

    const isMatch = await bcrypt.compare(password, user.password);

    if (!isMatch) {
      return res.status(401).json({ message: "Invalid credentials" });
    }

    // Success
    res.status(200).json({ message: "Login successful", user_id: user.user_id });
  } catch (err) {
    console.error("Login error:", err);
    res.status(500).json({ message: "Server error during login" });
  }
};

module.exports = { handleLogin };
