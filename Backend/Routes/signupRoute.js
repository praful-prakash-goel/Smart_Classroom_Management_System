const Router = require("express");
const { body } = require("express-validator");
const { handleSignup } = require("../Controllers/signupController");

const signupRouter = Router();

signupRouter.post("/",
  [
    body("user_id")
      .trim()
      .escape()
      .notEmpty()
      .withMessage("Roll No / Employee ID is required"),

    body("name")
      .trim()
      .escape()
      .notEmpty()
      .withMessage("Name is required"),

    body("email")
      .trim()
      .normalizeEmail()
      .isEmail()
      .withMessage("Valid email is required"),

    body("phone")
      .trim()
      .isMobilePhone()
      .withMessage("Valid phone number is required"),

    body("password")
      .trim()
      .isLength({ min: 6 })
      .withMessage("Password must be at least 6 characters"),

    body("confirmPassword")
      .trim()
      .custom((value, { req }) => {
        if (value !== req.body.password) {
          throw new Error("Passwords do not match");
        }
        return true;
      }),
  ],
  handleSignup
);

module.exports = signupRouter;
