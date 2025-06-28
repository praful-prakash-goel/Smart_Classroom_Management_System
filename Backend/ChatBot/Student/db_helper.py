# import psycopg2
# import psycopg2.extras
import mysql.connector

# https://smart-classroom-management-oji4.onrender.com/webhook
# DB_URL = "postgresql://postgres:pgoel2010@db.iocnbbqkijfuqjuikmfn.supabase.co:6543/postgres"

DB_CONFIG = {
    'host': 'localhost',
    'user': 'root',
    'password': 'nick@1234',
    'database': 'scms_db'
}

def get_attendance(roll: int):
    try:
        print(roll)
        connection = mysql.connector.connect(**DB_CONFIG)
        cursor = connection.cursor()
        print("Connection successfull")

        query = "SELECT * FROM attendance_report WHERE roll_no = %s"
        cursor.execute(query, (roll,))
        
        
        result = cursor.fetchall()
        print(result)
        if not result:
            print("Didnot recieved attendance report from database")
            return None
        return [(row) for row in result]
            
    except mysql.connector.Error as err:
        print(f"Error : {err}")
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()


def get_instructor_details(subject: str):
    try:
        connection = mysql.connector.connect(**DB_CONFIG)
        cursor = connection.cursor()
        print("Connected successfully!")

        query = '''
            SELECT instructor_name, day, time 
            FROM instructor_details 
            JOIN faculty_slots ON instructor_details.instructor_id = faculty_slots.instructor_id
            WHERE LOWER(subject) = LOWER(%s)
        '''
        cursor.execute(query, (subject,))
        rows = cursor.fetchall()
        
        if not rows:
            print("Didnot recieved slot details from database")
            return None

        column_names = [desc[0] for desc in cursor.description]
        return [dict(zip(column_names, row)) for row in rows]

    except mysql.connector.Error as err:
        print(f"Error : {err}")
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()


def save_appointment_details(instructor: str, time_period: str, day: str):
    try:
        connection = mysql.connector.connect(**DB_CONFIG)
        cursor = connection.cursor()

        instructor_id_query = "SELECT instructor_id FROM instructor_details WHERE LOWER(instructor_name) = LOWER(%s)"
        cursor.execute(instructor_id_query, (instructor,))
        result = cursor.fetchone()
        if not result:
            print("Didnot recieved instructor_id from database")
            return None
        instructor_id = result[0]

        query = "SELECT * FROM faculty_slots WHERE instructor_id = %s AND LOWER(day) = LOWER(%s) AND LOWER(time) = LOWER(%s)"
        cursor.execute(query, (instructor_id, day, time_period))
        rows = cursor.fetchall()
        column_names = [desc[0] for desc in cursor.description]
        if not rows:
            print("Didnot recieved slots from database")
            return None

        result_data = [dict(zip(column_names, data)) for data in rows]
        insertion_query = "INSERT INTO appointment_details VALUES (%s, %s, %s)"
        cursor.execute(
            insertion_query,
            (result_data[0]['instructor_id'], result_data[0]['day'], result_data[0]['time'])
        )
        connection.commit()
        return f"Appointment booked with {instructor} on {day} at {time_period}"

    except mysql.connector.Error as err:
        print(f"Error : {err}")
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()
