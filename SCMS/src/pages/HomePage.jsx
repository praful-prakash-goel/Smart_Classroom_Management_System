import { useLocation } from "react-router-dom";
import { useEffect, useState } from "react";
import homePageStyles from "../styles/homePage.module.css";
import nexlearnLogo from "../assets/Logo_White.png";
// import profileBtn from "../assets/profilephoto.png"

const features = {
  student: [
    // {
    //   title: "Live Timetable",
    //   description: "Access your real-time class schedule instantly.",
    //   link: "/timetable",
    // },
    {
      title: "KnowLio",
      description: "Ask academic questions and get AI-powered assistance.",
      link: "/knowlio",
    },
    {
      title: "Attendance Insights",
      description: "Track and review your attendance records easily.",
      link: (userId) => `/attendance?user_id=${userId}`, 
    },
    // {
    //   title: "Performance Insights",
    //   description: "View your grades and progress in one place.",
    //   link: "/performance",
    // },
  ],

  faculty: [
    // {
    //   title: "Live Timetable",
    //   description: "Stay updated with your scheduled lectures.",
    //   link: "/timetable",
    // },
    // {
    //   title: "Attendance Insights",
    //   description: "Monitor and manage students' attendance records.",
    //   link: "/attendance",
    // },
    {
      title: "Performance Insights",
      description: "Analyze students' academic performance and growth.",
      link: "/performance",
    },
    {
      title: "Schedule extra class",
      description: "",
      link: "/extra-class"
    },
    {
      title:"Analyze Code",
      link: "/code-analysis"   /////
    },
    {
      title: "Record Attendance",
      description: "",
      link: "/record-attendance"
    }
  ],
};

const HomePage = () => {
  const location = useLocation();
  const params = new URLSearchParams(location.search);
  const userType = params.get("user") || "student";
  const userFeatures = features[userType] || [];
  const userId = params.get("user_id") || "default_id";
  console.log(userId);

  const [classCount, setClassCount] = useState(0);
  const [userName, setUserName] = useState("User");
  const [attendancePercent, setAttendancePercent] = useState(0);

  useEffect(() => {
    const fetchData = async () => {
      try {
        // Fetch today's class count
        const res1 = await fetch('http://localhost:5000/today-classes');
        const data1 = await res1.json();
        setClassCount(data1.classCount);

        // Fetch user name
        const res2 = await fetch(`http://localhost:5000/users/${userId}`);
        const data2 = await res2.json();
        setUserName(data2.name);

        // Fetch individual subject attendance for overall attendance calculation
        const res3 = await fetch(`http://localhost:5000/attendance/${userId}`);
        const data3 = await res3.json();

        const TOTAL_CLASSES = 42;
        let daysAttended = 0;
        let numSubjects = 0;

        data3.data.forEach((subject) => {
          daysAttended += (subject.attendance_percentage / 100) * TOTAL_CLASSES;
          numSubjects += 1;
        });

        let overall = 0;
        if (numSubjects > 0) {
          overall = (daysAttended / (numSubjects * TOTAL_CLASSES)) * 100;
        }

        setAttendancePercent(overall.toFixed(2));

      }  catch (error) {
        console.error("Error fetching homepage data:", error);
      }
    };

    fetchData();
  }, [userId]);


  const [typedWelcome, setTypedWelcome] = useState("");
    const [typedMessage, setTypedMessage] = useState("");
  
    useEffect(() => {
      const welcomeStr = `Welcome ${userName}`;
let msgStr = "";

if (userType === "student") {
  msgStr = `- ${classCount} classes scheduled\n- Attendance: ${attendancePercent}% this month`;
} else if (userType === "faculty") {
  msgStr = `- ${classCount} classes scheduled`;
} else {
  msgStr = `- ${classCount} classes scheduled`;
}  
      setTypedWelcome("");
      setTypedMessage("");
  
      let wIndex = 0;
      const typeWelcome = () => {
        if (wIndex <= welcomeStr.length) {
          setTypedWelcome(welcomeStr.slice(0, wIndex));
          wIndex++;
          setTimeout(typeWelcome, 35);
        }
      };
  
      let mIndex = 0;
      const typeMessage = () => {
        if (mIndex <= msgStr.length) {
          setTypedMessage(msgStr.slice(0, mIndex));
          mIndex++;
          setTimeout(typeMessage, 35);
        }
      };
  
      typeWelcome();
      setTimeout(typeMessage, welcomeStr.length * 35 + 400);
    }, [userName, classCount, attendancePercent, userType]);

//   const handleRecordAttendance = async () => {
//   try {
//     const response = await fetch("http://localhost:5000/face-attendance/start");
//     const data = await response.json();
//     alert(data.message);
//   } catch (error) {
//     console.error("Error starting Face Attendance:", error);
//     alert("Failed to start Face Attendance app.");
//   }
// };

  return (
    <div className={homePageStyles.container}>
      <header className={homePageStyles.header}>
        <a href="/">
          <img src={nexlearnLogo} alt="NexLearn Logo" className={homePageStyles.logo} />
        </a>
        <nav className={homePageStyles.nav}>
          {userFeatures.map((feature, index) => (
          <a
            href={typeof feature.link === 'function' ? feature.link(userId) : feature.link}
            className={homePageStyles.navItem}
            key={index}
          >
            <h3>{feature.title}</h3>
          </a>
        ))}

          {/* <a className={homePageStyles.navItem} onClick={handleRecordAttendance}>
            Record Attendance
          </a> */}

        </nav>
        {/* <img src={profileBtn} alt="Profile" className={homePageStyles.profileBtn} /> */}
      </header>

      <main className={homePageStyles.mainContent}>
        {/* <h1 className={homePageStyles["welcome-heading"]}>Welcome</h1> */}
          <div className={homePageStyles.welcomeWidget}>
          <div className={homePageStyles.widgetHeader}>
            <span className={homePageStyles.red}></span>
            <span className={homePageStyles.yellow}></span>
            <span className={homePageStyles.green}></span>
            <span className={homePageStyles.widgetTitle}>{typedWelcome}</span>
          </div>
          <pre className={homePageStyles.widgetContent}>
      {/* {- ${classCount} classes scheduled
- Attendance: 88% this month
      } */}
      {typedMessage}
          </pre>
        </div>
      </main>
    
    {userType === 'student' && (
      <df-messenger
      chat-title="NexLearn Assistant"
      agent-id="e4628cb9-28a6-4da9-a158-8387710e8d39"
      language-code="en"
      // expand="true"
      intent="WELCOME"
      // chat-icon="http://localhost:5000/images/chatbot_icon.png"
      user-identity="USER_ID"
      show-close-button="true"
    ></df-messenger>
    )}
    
    {userType === 'faculty' && (
      <df-messenger
      chat-title="NexLearn Assistant"
      agent-id="85d1effa-e4d6-47df-9075-41635bb13b37"
      language-code="en"
      // expand="true"
      intent="WELCOME"
      // chat-icon="http://localhost:5000/images/chatbot_icon.png"
      user-identity="USER_ID"
      show-close-button="true"
    ></df-messenger>
    )}

    </div>
  );
};

export default HomePage;
