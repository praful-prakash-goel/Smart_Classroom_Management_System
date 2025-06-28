import mysql.connector
from datetime import datetime, date

DB_CONFIG = {
    'host': 'localhost',
    'user': 'root',
    'password': 'nick@1234',
    'database': 'scms_db'
}

def fetch_instructor_id(instructor_name):
    try:
        connection = mysql.connector.connect(**DB_CONFIG)
        cursor = connection.cursor()
        
        instructor_name = instructor_name + '%'
        query = "SELECT instructor_id FROM instructor_details WHERE LOWER(instructor_name) LIKE LOWER(%s)"
        
        cursor.execute(query, (instructor_name,))
        result = cursor.fetchone()
        if not result:
            return None
        instructor_id = result[0]
        
        return instructor_id
    except mysql.connector.Error as err:
        print(f"Error : {err}")
        
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()
            
def fetch_appointment_details(instructor_id):
    try:
        connection = mysql.connector.connect(**DB_CONFIG)
        cursor = connection.cursor()
        
        query = "SELECT * FROM appointment_details WHERE instructor_id = %s"
        cursor.execute(query, (instructor_id,))
        
        result = cursor.fetchall()
        if not result:
            return None
        
        appointments = []
        for row in result:
            day, time = row[1], row[2]
            appointments.append((day, time))
        
        return appointments
        
    except mysql.connector.Error as err:
        print(f"Error : {err}")
        
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()
 
def fetch_extra_class_details(instructor_id):
    try:
        connection = mysql.connector.connect(**DB_CONFIG)
        cursor = connection.cursor()
        
        today = date.today()
        weekday = today.strftime("%A")
        
        query = "SELECT * FROM extra_class_schedule WHERE instructor_id = %s AND day = %s"
        cursor.execute(query, (instructor_id,))
        
        result = cursor.fetchall()
        if not result:
            return None
        details = []
        for row in result:
            subject_code, classroom, start_time, end_time, day, semester = row[1], row[3], row[4], row[5], row[6], row[7]
            start_time_str = str(datetime.min + start_time)[11:19]
            end_time_str = str(datetime.min + end_time)[11:19]
            details.append((subject_code, classroom, start_time_str, end_time_str, day, semester))
            
        return details
            
    except mysql.connector.Error as err:
        print(f"Error : {err}")
    
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()
            
def fetch_class_details(instructor_id):
    try:
        connection = mysql.connector.connect(**DB_CONFIG)
        cursor = connection.cursor()
        
        today = date.today()
        day = today.strftime("%A")
        
        if day == 'Saturday' or day == 'Sunday':
            return None
        
        query = "SELECT * FROM class_schedule NATURAL JOIN course_offerings WHERE instructor_id = %s AND day = %s"
        cursor.execute(query, (instructor_id, day))
        
        result = cursor.fetchall()
        if not result:
            return None
        
        details = []
        for row in result:
            subject, semester, weekday, start_time, end_time, classroom = row[1], row[2], row[3], row[4], row[5], row[8] 
            start_time_str = str(datetime.min + start_time)[11:19]
            end_time_str = str(datetime.min + end_time)[11:19]
            details.append((subject, semester, weekday, start_time_str, end_time_str, classroom))
        return details
        
    except mysql.connector.Error as err:
        print(f"Error : {err}")
        
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()