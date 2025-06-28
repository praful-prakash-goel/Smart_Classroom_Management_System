const { validationResult } = require("express-validator");
const bcrypt = require("bcrypt");
const pool = require("../db");

const handleSignup = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }

  const { user_id, name, email, phone, password, user_type } = req.body;

  try {
    const existingUser = await pool.query(
      "SELECT * FROM users WHERE user_id = $1",
      [user_id]
    );

    if (existingUser.rows.length > 0) {
      return res.status(409).json({ message: "User already exists" });
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    await pool.query(
      `INSERT INTO users (user_id, name, email, phone, password, user_type, created_at)
       VALUES ($1, $2, $3, $4, $5, $6, NOW())`,
      [user_id, name, email, phone, hashedPassword, user_type]
    );

    res.status(201).json({ message: "Signup successful" });
  } catch (err) {
    console.error("Signup error:", err);
    res.status(500).json({ message: "Server error during signup" });
  }
};

module.exports = { handleSignup };
