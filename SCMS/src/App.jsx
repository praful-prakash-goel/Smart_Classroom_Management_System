import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import Home from "./pages/Home";
import LoginPage from "./pages/LoginPage";
import SignUpPage from "./pages/SignupPage";
import CapturePhotoPage from "./pages/CapturePhotoPage";
import Knowlio from "./pages/Knowliomain";
import HomePage from "./pages/HomePage";
import AttendanceReport from "./pages/AttendanceReport";
import PerformanceInsights from "./pages/PerformanceInsights";
import CodeAnalysis from "./pages/CodeAnalysis";
import ExtraClass from "./pages/ExtraClass";

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/login" element={<LoginPage />} />
        <Route path="/signup" element={<SignUpPage />} />
        <Route path="/capture-photo" element={<CapturePhotoPage />} />
        <Route path="/knowlio" element={<Knowlio />} />
        <Route path="/homepage" element={<HomePage />} />
        <Route path="/attendance" element={<AttendanceReport />} />
        <Route path="/performance" element={<PerformanceInsights />}/>
        <Route path="/code-analysis" element={<CodeAnalysis />} />
        <Route path="/extra-class" element={<ExtraClass />} />
      </Routes>
    </Router>
  );
}

export default App;
