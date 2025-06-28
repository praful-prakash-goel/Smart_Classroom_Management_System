const express = require("express");
const router = express.Router();
const { exec } = require("child_process");
const path = require("path");

router.get("/start", (req, res) => {
  const scriptPath = path.join(__dirname, "../Face_Attendance/main.py");

  const command = `conda run -n face_env python "${scriptPath}"`;

  exec(command, (error, stdout, stderr) => {
    if (error) {
      console.error(`Error running Face Attendance: ${error.message}`);
      console.error(stderr);
      return res.status(500).json({ message: "Failed to start Face Attendance app" });
    }

    console.log(`Face Attendance Output:\n${stdout}`);
    res.status(200).json({ message: "Face Attendance app launched successfully" });
  });
});

module.exports = router;
