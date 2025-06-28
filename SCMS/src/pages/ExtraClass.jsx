import { useState, useEffect } from 'react';
import styles from '../styles/ExtraClass.module.css';

const ExtraClass = () => {
  const [formData, setFormData] = useState({
    subject: '',
    instructor: '',
    semester: '',
    day: '',
    start_time: '',
    end_time: '',
    room_id: ''
  });
  const [subjects, setSubjects] = useState([]);
  const [instructors, setInstructors] = useState([]);
  const [rooms, setRooms] = useState([]);
  const [loading, setLoading] = useState({
    subjects: false,
    instructors: false,
    rooms: false,
    submitting: false
  });
  const [error, setError] = useState('');
  const [success, setSuccess] = useState('');

  // Fetch subjects on component mount
  useEffect(() => {
    const fetchSubjects = async () => {
      setLoading(prev => ({ ...prev, subjects: true }));
      try {
        const response = await fetch('http://127.0.0.1:8003/get_subjects');
        if (!response.ok) throw new Error('Failed to fetch subjects');
        const data = await response.json();
        setSubjects(data);
      } catch (err) {
        setError('Could not load subjects. Check backend API.');
        console.error(err);
      } finally {
        setLoading(prev => ({ ...prev, subjects: false }));
      }
    };
    fetchSubjects();
  }, []);

  // Fetch instructors when subject changes
  useEffect(() => {
    if (!formData.subject) return;
    
    const fetchInstructors = async () => {
      setLoading(prev => ({ ...prev, instructors: true }));
      try {
        const subjectName = subjects.find(s => s.subject_code === formData.subject)?.subject_name;
        if (!subjectName) return;
        
        const response = await fetch(
          `http://127.0.0.1:8003/get_instructors?subject_name=${encodeURIComponent(subjectName)}`
        );
        if (!response.ok) throw new Error('Failed to fetch instructors');
        const data = await response.json();
        setInstructors(data);
      } catch (err) {
        setError('Failed to load instructors');
        console.error(err);
      } finally {
        setLoading(prev => ({ ...prev, instructors: false }));
      }
    };
    fetchInstructors();
  }, [formData.subject, subjects]);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({ ...prev, [name]: value }));
    if (name === 'subject') {
      setInstructors([]);
      setFormData(prev => ({ ...prev, instructor: '' }));
    }
  };

  const fetchAvailableRooms = async () => {
    if (!formData.day || !formData.start_time || !formData.end_time) {
      setError('Please fill in day, start time, and end time');
      return;
    }

    setLoading(prev => ({ ...prev, rooms: true }));
    setError('');
    try {
      const response = await fetch(
        `http://127.0.0.1:8003/get_available_rooms?day=${encodeURIComponent(formData.day)}` +
        `&start_time=${encodeURIComponent(formData.start_time)}` +
        `&end_time=${encodeURIComponent(formData.end_time)}`
      );
      if (!response.ok) throw new Error('Failed to fetch rooms');
      const data = await response.json();
      setRooms(data);
    } catch (err) {
      setError('Failed to fetch available rooms');
      console.error(err);
    } finally {
      setLoading(prev => ({ ...prev, rooms: false }));
    }
  };

  const confirmSchedule = async () => {
    if (!formData.subject || !formData.instructor || !formData.room_id || 
        !formData.start_time || !formData.end_time || !formData.day || !formData.semester) {
      setError('Please fill all fields before confirming');
      return;
    }

    setLoading(prev => ({ ...prev, submitting: true }));
    setError('');
    try {
      const response = await fetch(
        `http://127.0.0.1:8003/confirm_extra_class?subject_code=${encodeURIComponent(formData.subject)}` +
        `&instructor_id=${encodeURIComponent(formData.instructor)}` +
        `&room_id=${encodeURIComponent(formData.room_id)}` +
        `&start_time=${encodeURIComponent(formData.start_time)}` +
        `&end_time=${encodeURIComponent(formData.end_time)}` +
        `&day=${encodeURIComponent(formData.day)}` +
        `&semester=${encodeURIComponent(formData.semester)}`
      );
      
      if (response.ok) {
        setSuccess('Extra class scheduled successfully!');
        setFormData({
          subject: '',
          instructor: '',
          semester: '',
          day: '',
          start_time: '',
          end_time: '',
          room_id: ''
        });
        setRooms([]);
      } else {
        throw new Error('Failed to schedule extra class');
      }
    } catch (err) {
      setError('Error occurred while scheduling');
      console.error(err);
    } finally {
      setLoading(prev => ({ ...prev, submitting: false }));
    }
  };

  return (
    <div className={styles.container}>
      <h2 className={styles.title}>Schedule Extra Class</h2>
      
      {/* {error && <div className={styles.error}>❌ {error}</div>}
      {success && <div className={styles.success}>✅ {success}</div>} */}

      <div className={styles.formGroup}>
        <label className={styles.label}>Subject</label>
        <select
          name="subject"
          value={formData.subject}
          onChange={handleChange}
          className={styles.select}
          disabled={loading.subjects}
        >
          <option value="">{loading.subjects ? 'Loading subjects...' : 'Select Subject'}</option>
          {subjects.map(subject => (
            <option key={subject.subject_code} value={subject.subject_code}>
              {subject.subject_name}
            </option>
          ))}
        </select>
      </div>

      <div className={styles.formGroup}>
        <label className={styles.label}>Instructor</label>
        <select
          name="instructor"
          value={formData.instructor}
          onChange={handleChange}
          className={styles.select}
          disabled={loading.instructors || !formData.subject}
        >
          <option value="">{loading.instructors ? 'Loading instructors...' : 'Select Instructor'}</option>
          {instructors.map(instructor => (
            <option key={instructor['Instructor ID']} value={instructor['Instructor ID']}>
              {instructor['Instructor name']}
            </option>
          ))}
        </select>
      </div>

      <div className={styles.formGroup}>
        <label className={styles.label}>Semester</label>
        <input
          type="text"
          name="semester"
          value={formData.semester}
          onChange={handleChange}
          className={styles.input}
          placeholder="e.g., 4"
        />
      </div>

      <div className={styles.formGroup}>
        <label className={styles.label}>Day</label>
        <input
          type="text"
          name="day"
          value={formData.day}
          onChange={handleChange}
          className={styles.input}
          placeholder="e.g., Thursday"
        />
      </div>

      <div className={styles.formGroup}>
        <label className={styles.label}>Start Time (HH:MM:SS)</label>
        <input
          type="text"
          name="start_time"
          value={formData.start_time}
          onChange={handleChange}
          className={styles.input}
          placeholder="e.g., 11:00:00"
        />
      </div>

      <div className={styles.formGroup}>
        <label className={styles.label}>End Time (HH:MM:SS)</label>
        <input
          type="text"
          name="end_time"
          value={formData.end_time}
          onChange={handleChange}
          className={styles.input}
          placeholder="e.g., 12:00:00"
        />
      </div>

      <button
        onClick={fetchAvailableRooms}
        className={styles.button}
        disabled={loading.rooms || !formData.day || !formData.start_time || !formData.end_time}
      >
        {loading.rooms ? 'Checking...' : 'Check Available Rooms'}
      </button>

      {rooms.length > 0 && (
        <div className={styles.formGroup}>
          <label className={styles.label}>Available Rooms</label>
          <select
            name="room_id"
            value={formData.room_id}
            onChange={handleChange}
            className={styles.select}
          >
            <option value="">Select Room</option>
            {rooms.map(room => (
              <option key={room.room_id} value={room.room_id}>
                {room.room_id}
              </option>
            ))}
          </select>
        </div>
      )}

      {formData.room_id && (
        <button
          onClick={confirmSchedule}
          className={`${styles.button} ${styles.confirmButton}`}
          disabled={loading.submitting}
        >
          {loading.submitting ? 'Scheduling...' : 'Confirm Schedule'}
        </button>
      )}

    {error && <div className={styles.error}>❌ {error}</div>}
      {success && <div className={styles.success}>✅ {success}</div>}

    </div>
  );
};

export default ExtraClass;