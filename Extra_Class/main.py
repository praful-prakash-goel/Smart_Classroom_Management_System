from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import mysql.connector
from typing import List
import uvicorn

app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=['*'],
    allow_methods=['*'],
    allow_headers=['*']
)

db_config = {
    'host':'localhost',
    'user':'root',
    'password':'nick@1234',
    'database':'scms_db'
}

@app.get('/get_subjects')
def get_subjects():
    conn = None
    cursor = None
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()

        query = "SELECT subject_code, name FROM subject_details"
        cursor.execute(query)
        result = cursor.fetchall()

        subjects = [{"subject_code": row[0], "subject_name": row[1]} for row in result]
        return subjects

    except mysql.connector.Error as err:
        print(f"Error: {err}")
        return {"error": "Database error"}

    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

@app.get('/get_instructors')
def get_instructors(subject_name : str):
    try:
        if 'lab' in subject_name.lower():
            subject_name = subject_name[:-4]

        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()

        query = "SELECT DISTINCT instructor_id, instructor_name FROM instructor_details WHERE subject = %s"
        cursor.execute(query, (subject_name,))
        result = cursor.fetchall()

        names = [{"Instructor ID":row[0], "Instructor name":row[1]} for row in result]
        return names
    
    except mysql.connector.Error as err:
        print(f"Error : {err}")

    finally:
        if conn:
            conn.close()
        if cursor:
            cursor.close()

@app.get('/get_available_rooms')
def get_available_rooms(day : str, start_time : str, end_time : str):
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()
        
        query = '''WITH class_details AS (
                SELECT classroom.room_id, 
                    class_schedule.offering_id, 
                    day, 
                    start_time, 
                    end_time
                FROM classroom
                JOIN course_offerings ON classroom.room_id = course_offerings.room_id
                JOIN class_schedule ON class_schedule.offering_id = course_offerings.offering_id
            )
            SELECT classroom.room_id
            FROM classroom
            LEFT JOIN class_details ON classroom.room_id = class_details.room_id 
                                    AND class_details.day = %s
                                    AND class_details.start_time BETWEEN %s AND %s
            LEFT JOIN extra_class_schedule ON classroom.room_id = extra_class_schedule.room_id
                                            AND extra_class_schedule.day = %s
                                            AND extra_class_schedule.start_time BETWEEN %s AND %s
            WHERE class_details.room_id IS NULL   
            AND extra_class_schedule.room_id IS NULL;  
        '''
        cursor.execute(query, (day, start_time, end_time, day, start_time, end_time,))
        result = cursor.fetchall()
        
        classrooms = [{"room_id": row[0]} for row in result]
        return classrooms
    
    except mysql.connector.Error as err:
        print(f"Error : {err}")
    
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()
            
@app.get("/confirm_extra_class")
def confirm_extra_class(subject_code : str, instructor_id : int, room_id : str, start_time : str, end_time : str, day : str, semester : int):
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()
        
        query = '''INSERT INTO extra_class_schedule(subject_code, instructor_id, room_id, start_time, end_time, day, semester, status) 
                   VALUES 
                   (%s, %s, %s, %s, %s, %s, %s, 'confirmed');'''
        cursor.execute(query, (subject_code, instructor_id, room_id, start_time, end_time, day, semester,))
        conn.commit()
        print("Inserted successfully")
        
    except mysql.connector.Error as err:
        print(f"Error : {err}")
        
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

if __name__ == '__main__':
    uvicorn.run(app, host="0.0.0.0", port=8003)