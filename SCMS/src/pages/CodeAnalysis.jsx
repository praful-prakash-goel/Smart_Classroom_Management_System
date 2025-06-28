import { useState } from 'react';
import styles from '../styles/codeAnalysis.module.css';

const CodeAnalysis = () => {
  const [problemStatement, setProblemStatement] = useState('');
  const [file, setFile] = useState(null);
  const [report, setReport] = useState(null);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState('');

  const handleSubmit = async (e) => {
    e.preventDefault();
    
    if (!file) {
      setError('Please select a file');
      return;
    }

    setIsLoading(true);
    setError('');

    try {
      const formData = new FormData();
      formData.append('file', file);
      formData.append('problem', problemStatement);

      const response = await fetch('http://localhost:5002/api/code-analysis', {
  method: 'POST',
  body: formData,
});


      if (!response.ok) {
        throw new Error('Analysis failed');
      }

      // Get the HTML response
      const result = await response.text();
      const parser = new DOMParser();
      const doc = parser.parseFromString(result, 'text/html');
      const feedback = doc.querySelector('.report')?.innerHTML;

      if (!feedback) {
        throw new Error('No analysis results found');
      }

      setReport(feedback);
    } catch (err) {
      setError(err.message);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className={styles.container}>
    <div className={styles.content}>
      <h1 className={styles.title}>Code Analysis Portal</h1>
      
      <form onSubmit={handleSubmit} className={styles.form}>
        <div className={styles.inputGroup}>
          <label htmlFor="problem">Enter Problem Statement:</label>
          <textarea
            id="problem"
            value={problemStatement}
            onChange={(e) => setProblemStatement(e.target.value)}
            placeholder="Enter problem statement..."
            required
          />
        </div>

        <div className={styles.inputGroup}>
          <label htmlFor="file">Upload Code File:</label>
          <input 
            id="file"
            type="file" 
            onChange={(e) => setFile(e.target.files[0])}
            accept=".py,.java,.c,.cpp"
            required
          />
        </div>

        <button 
          type="submit" 
          disabled={isLoading}
          className={styles.button}
        >
          {isLoading ? 'Analyzing...' : 'Analyze Code'}
        </button>

        {error && <p className={styles.error}>❌ {error}</p>}
      </form>

      {report && (
        <div className={styles.report} dangerouslySetInnerHTML={{ __html: report }} />
      )}
    </div>
    </div>
  );
};

export default CodeAnalysis;