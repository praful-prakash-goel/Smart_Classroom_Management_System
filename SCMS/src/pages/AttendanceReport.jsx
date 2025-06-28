// import { useState } from 'react';
// import attReportstyles from '../styles/attendanceReport.module.css';

// const AttendanceReport = () => {
//   const [rollNumber, setRollNumber] = useState('');
//   const [attendance, setAttendance] = useState([]);
//   const [error, setError] = useState('');
//   const [isLoading, setIsLoading] = useState(false);

//   const fetchAttendance = async () => {
//   if (!rollNumber.trim()) {
//     setError('Please enter a valid roll number');
//     return;
//   }

//   setIsLoading(true);
//   setError('');
  
//   try {
//     const response = await fetch(`http://localhost:3001/api/attendance?rollNumber=${rollNumber}`);
//     const data = await response.json();

//     if (!response.ok || !data.success) {
//       throw new Error(data.message || 'Failed to fetch attendance');
//     }

//     if (!data.data || data.data.length === 0) {
//       throw new Error("No attendance records found");
//     }

//     setAttendance(data.data); // Use data.data if nested
//   } catch (err) {
//     setError(err.message || 'Could not fetch attendance');
//     setAttendance([]);
//   } finally {
//     setIsLoading(false);
//   }
// };

//   return (
//     <div className={attReportstyles.container}>
//       <h2 className={attReportstyles.title}>📋 Attendance Report</h2>
      
//       <div className={attReportstyles.inputGroup}>
//         <label htmlFor="rollNumber">Enter Roll Number</label>
//         <input
//           id="rollNumber"
//           type="text"
//           value={rollNumber}
//           onChange={(e) => setRollNumber(e.target.value)}
//           placeholder="e.g., 2301148"
//           className={attReportstyles.input}
//         />
//       </div>

//       <button 
//         onClick={fetchAttendance}
//         disabled={isLoading}
//         className={`${attReportstyles.button} ${isLoading ? attReportstyles.disabled : ''}`}
//       >
//         {isLoading ? 'Loading...' : 'Get Attendance'}
//       </button>

//       {error && <p className={attReportstyles.error}>❌ {error}</p>}

//       {attendance.length > 0 && (
//         <div className={attReportstyles.results}>
//           <h3>Subject-wise Attendance:</h3>
//           <ul className={attReportstyles.list}>
//             {attendance.map((item, index) => (
//               <li key={index} className={attReportstyles.listItem}>
//                 <span className={attReportstyles.subject}>{item.subject}:</span>
//                 <span className={attReportstyles.percentage}>{item.percentage}%</span>
//               </li>
//             ))}
//           </ul>
//         </div>
//       )}
//     </div>
//   );
// };

// export default AttendanceReport;

import { useLocation } from 'react-router-dom';
import { useEffect, useState } from 'react';
import attReportstyles from '../styles/attendanceReport.module.css';

const AttendanceReport = () => {
  const location = useLocation();
  const params = new URLSearchParams(location.search);
  const rollNumber = params.get('user_id');  // Extract roll number from URL param
  console.log(rollNumber);

  const [attendance, setAttendance] = useState([]);
  const [error, setError] = useState('');
  const [isLoading, setIsLoading] = useState(false);

  useEffect(() => {
    const fetchAttendance = async () => {
      if (!rollNumber) {
        setError('No Roll Number provided in URL');
        return;
      }

      setIsLoading(true);
      setError('');

      try {
        const response = await fetch(`http://localhost:5000/attendance/${rollNumber}`);
        const data = await response.json();

        if (!response.ok) {
          throw new Error(data.message || 'Failed to fetch attendance');
        }

        if (!data.data || data.data.length === 0) {
          throw new Error('No attendance records found');
        }

        setAttendance(data.data);
      } catch (err) {
        setError(err.message || 'Could not fetch attendance');
        setAttendance([]);
      } finally {
        setIsLoading(false);
      }
    };

    fetchAttendance();
  }, [rollNumber]);

  return (
    <div className={attReportstyles.container}>
      <h2 className={attReportstyles.title}>Attendance Report</h2>

      {isLoading && <p>Loading...</p>}

      {error && <p className={attReportstyles.error}>❌ {error}</p>}

      {attendance.length > 0 && (
        <div className={attReportstyles.results}>
          <h3>Subject-wise Attendance:</h3>
          <ul className={attReportstyles.list}>
            {attendance.map((item, index) => (
              <li key={index} className={attReportstyles.listItem}>
                <span className={attReportstyles.subject}>{item.subject}:</span>
                <span className={attReportstyles.percentage}>{item.attendance_percentage}%</span>
              </li>
            ))}
          </ul>
        </div>
      )}
    </div>
  );
};

export default AttendanceReport;
