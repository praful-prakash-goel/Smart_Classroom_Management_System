const path = require("path");
const pool = require("../db");

const handleFaceUpload = async (req, res) => {
  const { user_id } = req.body;

  if (!req.file) {
    return res.status(400).json({ message: "No file uploaded." });
  }

  const filename = req.file.filename;

  try {
    await pool.query(
      `UPDATE users SET face_id = $1 WHERE user_id = $2`,
      [filename, user_id]
    );
    res.status(200).json({ message: "Face ID uploaded successfully.\n Redirecting to login page..." });
  } catch (err) {
    console.error("Error updating user face_id:", err);
    res.status(500).json({ message: "Server error while saving Face ID." });
  }
};

module.exports = {
  handleFaceUpload,
};
