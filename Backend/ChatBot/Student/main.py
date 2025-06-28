from fastapi import FastAPI, HTTPException, Request
import uvicorn
import generic_helper
import db_helper
import re
import numpy as np
from datetime import datetime
import json

TOTAL_CLASSES = 42
# DB_URL = "postgresql://postgres.iocnbbqkijfuqjuikmfn:pgoel2010@aws-0-ap-south-1.pooler.supabase.com:5432/postgres"

app = FastAPI()

def handle_welcome_intent(parameters: dict, session_id: str):
    responses = [
        "Hi! How are you doing? You can begin with 'Appointment Booking,' or 'Attendance Report.'",
        "Hello! Hope you're doing well. Start by saying 'Appointment Booking,' or 'Attendance Report.'",
        "Hey there! How's your day going? You may begin with 'Appointment Booking,' or 'Attendance Report.'",
        "Hi! Hope you're having a great day. You can start with 'Appointment Booking,' or 'Attendance Report.'",
        "Hello! How's it going? Feel free to start with 'Appointment Booking,' or 'Attendance Report.'",
        "Hey! How are you today? Pick an option to begin: 'Appointment Booking,' or 'Attendance Report.'",
        "Hi! Hope you're doing well. Start by selecting 'Appointment Booking,' or 'Attendance Report.'",
        "Hello! How's your day been? You can kick things off with 'Appointment Booking,' or 'Attendance Report.'",
        "Hi! How’s everything going? Choose one to get started: 'Appointment Booking,' or 'Attendance Report.'",
        "Hey there! Hope you're having a good day. Begin by selecting 'Appointment Booking,' or 'Attendance Report.'"
    ]
    idx = np.random.randint(low=0, high=10)
    return {
        "fulfillmentText": responses[idx]
    }

def handle_attendance_fetch(parameters: dict, session_id: str):
    roll = parameters.get("roll_number", [])[0]
    print(roll)
    if not roll:
        print("Roll not provided")
        return {"fulfillmentText" : "Could not fetch your attendance. Please provide your roll number and subject to fetch attendance."}
    
    results = db_helper.get_attendance(roll=roll)
    if not results:
        print("Nothing recieved from database")
        return{
            "fulfillmentText" : "There was an error while fetching the attendance. Please try again."
        }
         
    rich_content = []
    rich_content.append({
        "type": "info",
        "title": "📊 Attendance Report",
        "subtitle": f"🆔 {int(roll)}",
        "icon": {"type": "none"}
    })

    days_attended = 0
    num_subjects = 0
    for row in results:
        _, subject, attendance = row
        rich_content.append({
            "type": "description",
            "compact": True,
            "text": [f"📚 {subject}: 📈 {attendance}%"]
        })
        days_attended += (attendance/100) * TOTAL_CLASSES
        num_subjects += 1

    overall_attendance = days_attended / (num_subjects * TOTAL_CLASSES) * 100
    rich_content.append({
        "type": "description",
        "compact": True,
        "text": [f"✅ Overall: {overall_attendance:.2f}%"]
    })

    return {
        "fulfillmentMessages": [
            {
                "platform": "DIALOGFLOW_MESSENGER",
                "payload": {
                    "richContent": [rich_content]
                }
            }
        ]
    }

def handle_appointment_booking(parameters: dict, session_id: str):
    subject = parameters.get("subject", [])[0]
    if not subject:
        return {
            "fulfillmentText": "Cannot book an appointment. Please specify the subject in which you are facing an issue."
        }

    result = db_helper.get_instructor_details(subject=subject)
    if result is None:
        return {
            "fulfillmentText": "No data found for the given subject. Please try again."
        }

    messages = [
        {"text": {"text": ["Here are the available instructors:"]}},
        {
            "payload": {
                "richContent": [
                    [
                        {
                            "type": "chips",
                            "options": [
                                {
                                    "text": f"{instructor['instructor_name']} - {instructor['day']} ({instructor['time']})"
                                }
                                for instructor in result
                            ]
                        }
                    ]
                ]
            }
        }
    ]
    
    
    messages.append({"text": {"text": ["Please select one of the options"]}})
    
    return {"fulfillmentMessages": messages}


def handle_appointment_save(parameters: dict, session_id: str):
    instructor = parameters.get("instructor")
    time_period = parameters.get("time-period")
    day = parameters.get("day")

    if not all([instructor, time_period, day]):
        print("Missing required parameters.")
        return {
            "fulfillmentText": "Error while booking appointment. Please provide all the necessary information."
        }

    try:
        start_time = re.findall(r'.*T(..:..)', time_period.get('startTime'))[0]
        start_time = datetime.strptime(start_time, "%H:%M").strftime("%I:%M").lstrip("0")
        
        end_time = re.findall(r'.*T(..:..)', time_period.get('endTime'))[0]
        end_time = datetime.strptime(end_time, "%H:%M").strftime("%I:%M").lstrip("0")
        
        time = start_time + '-' + end_time + " PM"
    except Exception as e:
        print(f"Error extracting time: {e}")
        return {
            "fulfillmentText": "Error while processing the time. Please try again."
        }

    print(f"Booking appointment with instructor: {instructor}, Time: {time}, Day: {day}")

    try:
        message = db_helper.save_appointment_details(instructor=instructor.get('name'), time_period=time, day=day)
    except Exception as e:
        print(f"Error while saving appointment: {e}")
        return {
            "fulfillmentText": "Error while booking appointment. Please try again."
        }
    
    if message is None:
        print("No message returned from the database function.")
        return {
            "fulfillmentText": "Error while booking appointment. Please try again."
        }
    
    response = {
        "fulfillmentText": message
    }
    return response



@app.post("/webhook")
async def webhook_handler(request : Request):
    try:
        body = await request.json()

        intent = body["queryResult"]["intent"]["displayName"]
        parameters = body["queryResult"]["parameters"]
        session_id = generic_helper.extract_session_id(str(body['session']))
        intent_handler_dict = {
            "Default Welcome Intent" : handle_welcome_intent,
            "attendance.report.fetch - Context: attendance_report" : handle_attendance_fetch,
            "apppointment.booking.helper - context : appointment_booking" : handle_appointment_booking,
            "appointment.details - context : appointment.booking" : handle_appointment_save
        }
        handler = intent_handler_dict.get(intent)
        if not handler:
            return {"fulfillmentText": f"No handler for intent: {intent}"}
        return handler(parameters=parameters, session_id=session_id)
    
    except Exception as e:
        print("Error in Webhook:", str(e))
        raise HTTPException(status_code=400, detail=str(e))

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8002)