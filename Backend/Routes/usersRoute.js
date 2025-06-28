const express = require("express");
const router = express.Router();
const { getUserDetails } = require("../Controllers/usersController");

router.get("/:user_id", getUserDetails);

module.exports = router;