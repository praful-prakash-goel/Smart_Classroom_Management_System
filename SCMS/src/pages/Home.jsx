import { useEffect } from "react";
import { useNavigate } from "react-router-dom";
import homelogo from "../assets/Logo_White.png";
import homeStyles from "../styles/home.module.css";

const Home = () => {
  const navigate = useNavigate();

  //testing backend connection
  useEffect(() => {
    fetch("http://localhost:5000/")
      .then((res) => res.json())
      .then((data) => console.log("Msg:", data.message))
      .catch((err) => console.error("Connection failed:", err));
  }, []);

  return (
    <div className={homeStyles.homeContainer}>
      {/* Logo */}
      <img src={homelogo} alt="Nexlearn Logo" className={homeStyles.homelogo} />

      {/* Buttons */}
      <div className={homeStyles.buttonContainer}>
        <button 
          className={homeStyles.studentButton} 
          onClick={() => navigate("/login?user=student")}>
            Login as Student
        </button>
        <button 
          className={homeStyles.teacherButton} 
          onClick={() => navigate("/login?user=faculty")}>
            Login as Faculty
        </button>
      </div>
    </div>
  );
};

export default Home;
