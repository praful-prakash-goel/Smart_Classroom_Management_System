const Router = require("express");
const { body } = require("express-validator");
const { handleLogin } = require("../Controllers/loginController");

const loginRouter = Router();

loginRouter.post("/",
  [
    body("email").isEmail().withMessage("Valid email required"),
    body("password").notEmpty().withMessage("Password is required"),
    body("user_type")
      .isIn(["student", "faculty"])
      .withMessage("User type must be student or faculty"),
  ],
  handleLogin
);

module.exports = loginRouter;
