import { useNavigate, useLocation } from "react-router-dom";
import { useState } from "react";
import signupStyles from "../styles/SignupPage.module.css";
import signupLogo from "../assets/Logo_Black.png";

const SignUpPage = () => {
  const navigate = useNavigate();
  const location = useLocation();
  const userType = new URLSearchParams(location.search).get("user") || "student";
  const [formData, setFormData] = useState({
    name: "",
    // lastName: "",
    email: "",
    phone: "",
    password: "",
    confirmPassword: "",
    user_id: "",
  });

  const handleInputChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  // const handleSubmit = (e) => {
  //   e.preventDefault();
  //   console.log("Form submitted:", formData);
  //   // TODO: Send form data to backend
  //   navigate(`/capture-photo?name=${formData.name}&roll=${formData.user_id}`);

  // };

  const handleSubmit = async (e) => {
  e.preventDefault();

  if (formData.password !== formData.confirmPassword) {
    alert("Passwords do not match!");
    return;
  }

  const userPayload = {
    user_id: formData.user_id,
    name: formData.name,
    email: formData.email,
    phone: formData.phone,
    password: formData.password,
    confirmPassword: formData.confirmPassword,
    user_type: userType, // either "student" or "faculty"
  };

  // console.log(userPayload);

  try {
    const response = await fetch("http://localhost:5000/signup", {
      method: "POST",
      credentials: "include", 
      headers: { "Content-Type": "application/json", },
      body: JSON.stringify(userPayload),
    });
    // console.log(response);

    const data = await response.json();

    if (response.ok) {
      alert("Signup successful!");
      navigate(`/capture-photo?name=${formData.name}&user_id=${formData.user_id}&user=${userType}`);
    } else {
      alert(data.message || "Signup failed.");
    }
  } catch (error) {
    console.error("Signup error:", error);
    alert("Server error. Please try again later.");
  }
};


  return (
  <main>
    <img src={signupLogo} alt="NexLearn Logo" className={signupStyles.signupLogo} />
    <div className={signupStyles.signupContainer}>
      <div className={signupStyles.signupBox}>
        <h2>Sign Up</h2>
        <form onSubmit={handleSubmit}>
          <label htmlFor="name">Name*</label>
          <input type="text" id="name" name="name" placeholder="Name" value={formData.name} onChange={handleInputChange} required />

          {/* <label>Last Name*</label>
          <input type="text" name="lastName" placeholder="Last Name" value={formData.lastName} onChange={handleInputChange} required /> */}

          <label htmlFor="user_id">{userType === "student" ? "Roll No*" : "Employee ID*"}</label>
          <input type="text" id="user_id" name="user_id" placeholder={userType === "student" ? "Roll No" : "Employee ID"} value={formData.user_id} onChange={handleInputChange} required />

          <label htmlFor="email">Email ID*</label>
          <input type="email" id="email" name="email" placeholder="Email ID" value={formData.email} onChange={handleInputChange} required />

          <label htmlFor="phone">Phone Number*</label>
          <input type="tel" id="phone" name="phone" placeholder="Phone Number" value={formData.phone} onChange={handleInputChange} required />

          <label htmlFor="password">Set Password*</label>
          <input type="password" id="password" name="password" placeholder="Set Password" value={formData.password} onChange={handleInputChange} required />

          <label htmlFor="confirmPassword">Confirm Password*</label>
          <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password" value={formData.confirmPassword} onChange={handleInputChange} required />

          <button type="submit" className={signupStyles.continueBtn}>Continue</button>
        </form>
      </div>
      <div className={signupStyles.footerLinks}>
        <a href="/terms">Terms of Use</a> | <a href="/privacy">Privacy Policy</a>
      </div>
    </div>
    </main>
  );
};

export default SignUpPage;
