const { Router } = require("express");
const multer = require("multer");
const path = require("path");
const fs = require("fs");
const { handleFaceUpload } = require("../Controllers/faceController");

const faceRouter = Router();

// Multer setup
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    const dir = "uploads/People";
    if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
    cb(null, dir);
  },
  filename: (req, file, cb) => {
    const { name, user_id } = req.body;
    const ext = path.extname(file.originalname);
    cb(null, `${name}_${user_id}${ext}.jpg`);
  },
});

const upload = multer({ storage });

// Route
faceRouter.post("/", upload.single("image"), handleFaceUpload);

module.exports = faceRouter;
