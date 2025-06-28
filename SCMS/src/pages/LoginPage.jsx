import { useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import { Link } from "react-router-dom";
import loginStyles from "../styles/LoginPage.module.css";
import loginLogo from "../assets/Logo_Black.png";

const LoginPage = () => {

  const location = useLocation();
  const navigate = useNavigate();
  const userType = new URLSearchParams(location.search).get("user") || "student"; // Default: student  

  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  const handleLogin = async () => {
  if (!email || !password) {
    alert("Please fill in all fields.");
    return;
  }

  try {
    const response = await fetch("http://localhost:5000/login", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        email,
        password,
        user_type: userType,
      }),
    });

    const data = await response.json();
    console.log(data);

    if (response.ok) {
      alert("Login successful!");
      const userId = data.user_id;
      navigate(`/homepage?user=${userType}&user_id=${userId}`); // redirect on success
    } else {
      alert(data.message || "Login failed.");
    }
  } catch (err) {
    console.error("Login error:", err);
    alert("Server error. Please try again later.");
  }
};

  return (
   <main> 
    <img src={loginLogo} alt="NexLearn Logo" className={loginStyles.loginLogo} />
    <div className={loginStyles.loginContainer}>
      
      <div className={loginStyles.loginBox}>
        <h2>Welcome Back</h2>
        
        <label>Email address*</label>
        <input type="email" 
          placeholder="Enter your email" 
          className={loginStyles.inputField} 
          value={email}
          onChange={(e) => setEmail(e.target.value)}
        />
        
        <label>Password*</label>
        <input 
          type="password" 
          placeholder="Enter your password" 
          className={loginStyles.inputField} 
          value={password}
          onChange={(e) => setPassword(e.target.value)}
        />
        
        <button className={loginStyles.continueBtn} onClick={handleLogin}>Continue</button>
        
        {/* <p className={loginStyles.signupText}>
          Don't have an account? <Link to="/signup">Sign Up</Link>
        </p> */}

        <p className={loginStyles.signupText}>
          Don't have an account?{" "}
          <span onClick={() => navigate(`/signup?user=${userType}`)} className={loginStyles.signupLink}>
            Sign Up
          </span>
        </p>

      </div>
      
      <div className={loginStyles.footerLinks}>
        <Link to="/terms">Terms of Use</Link> | <Link to="/privacy">Privacy Policy</Link>
      </div>
    </div>
    </main>
  );
};

export default LoginPage;