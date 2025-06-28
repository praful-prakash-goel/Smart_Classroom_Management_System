const express = require("express");
const router = express.Router();
const { getTodayClasses } = require("../Controllers/numClassesController");

router.get("/", getTodayClasses);

module.exports = router;