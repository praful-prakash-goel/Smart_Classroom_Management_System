const express = require("express");
const router = express.Router();
const pool = require("../db");

// router.get("/:user_id", async (req, res) => {
//   const { user_id } = req.params;
//   try {
//     const result = await pool.query(
//       "SELECT subject, attendance_percentage FROM attendance_report WHERE roll_no = $1",
//       [user_id]
//     );
//     console.log(result);

//     if (result.rows.length === 0) {
//       return res.status(404).json({ message: "No attendance found for this user_id." });
//     }

//     res.json({ attendance: result.rows });
//   } catch (err) {
//     console.error("Error fetching attendance:", err);
//     res.status(500).json({ message: "Server error" });
//   }
// });

router.get("/:user_id", async (req, res) => {
  const { user_id } = req.params;
  console.log("Received user_id number:", user_id);

  try {
    const result = await pool.query(
      "SELECT subject, attendance_percentage FROM attendance_report WHERE roll_no = $1",
      [user_id]
    );
    console.log(result);
    if (result.rows.length === 0) {
      return res.status(404).json({ message: "No attendance found for this user_id." });
    }

    res.json({ data: result.rows });
  } catch (err) {
    console.error("Error fetching attendance:", err);
    res.status(500).json({ message: "Server error" });
  }
});

module.exports = router;