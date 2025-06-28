import React, { useState } from "react";
import styles from "../styles/PerformanceInsights.module.css";

const PerformanceInsights = () => {
  const [file, setFile] = useState(null);
  const [results, setResults] = useState([]);

  const handleFileChange = (e) => {
    setFile(e.target.files[0]);
  };

  const handleUpload = async (e) => {
    e.preventDefault();
    if (!file) {
      alert("Please select a file first.");
      return;
    }

    const formData = new FormData();
    formData.append("file", file);

    try {
      const response = await fetch("http://localhost:5001/performance", {
        method: "POST",
        body: formData,
      });
      const data = await response.json();
      if (data.status !== "ok") {
        alert(data.message || "Upload failed.");
        return;
      }
      setResults(data.full_results || []);
    } catch (error) {
      console.error("Upload error:", error);
      alert("Something went wrong.");
    }
  };

  const topPerformers = results.filter((r) => r.Performance === "Excellent");
  const atRisk = results.filter((r) => r.Performance.toLowerCase() === "fail");

  return (
    <div className={styles.container}>
      <h2 className={styles.heading}>Performance Insights</h2>

      <form onSubmit={handleUpload} className={styles.form}>
        <input
          type="file"
          accept=".xlsx,.xls"
          onChange={handleFileChange}
          className={styles.inputFile}
        />
        <button type="submit" className={styles.button}>
          Get Insights
        </button>
      </form>

      {(topPerformers.length > 0 || atRisk.length > 0) && (
        <div className={styles.resultGrid}>
          {atRisk.length > 0 && (
            <div className={styles.resultBox}>
              <h3>At Risk Students</h3>
              <ul>
                {atRisk.map((s, idx) => (
                  <li key={idx}>{s.Student_ID}</li>
                ))}
              </ul>
            </div>
          )}

          {topPerformers.length > 0 && (
            <div className={styles.resultBox}>
              <h3>Top Performers</h3>
              <ul>
                {topPerformers.map((s, idx) => (
                  <li key={idx}>{s.Student_ID}</li>
                ))}
              </ul>
            </div>
          )}
        </div>
      )}

      {results.length > 0 && (
        <table className={styles.table}>
          <thead>
            <tr>
              <th>Student ID</th>
              <th>Performance</th>
            </tr>
          </thead>
          <tbody>
            {results.map((row, idx) => (
              <tr key={idx}>
                <td>{row.Student_ID}</td>
                <td style={{ color: "#40a0ff", fontWeight: 500 }}>{row.Performance}</td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </div>
  );
};

export default PerformanceInsights;



