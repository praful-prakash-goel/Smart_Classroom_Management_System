from fastapi import FastAPI, HTTPException, Request
from fastapi.responses import JSONResponse
import uvicorn
import numpy as np
import db_helper

def handle_welcome_intent(parameters):
    responses = [
        "Hello! How’s it going? You can start by saying 'Appointment Details', 'Extra Class Schedule' or 'Today's Class Schedule.'",
        "Hi there! Hope you're doing well. Try typing 'Appointment Details', 'Extra Class Schedule' or 'Today's Class Schedule.' to begin.",
        "Hey! How are you? To get started, enter 'Appointment Details', 'Extra Class Schedule' or 'Today's Class Schedule.'",
        "Hi! Everything good? You may begin with 'Appointment Details', 'Extra Class Schedule' or 'Today's Class Schedule.'",
        "Hello! How have you been? Type 'Appointment Details', 'Extra Class Schedule' or 'Today's Class Schedule.' to proceed.",
        "Hi! Feeling good today? Just start with 'Appointment Details', 'Extra Class Schedule' or 'Today's Class Schedule.'",
        "Hey there! You can begin by entering 'Appointment Details', 'Extra Class Schedule' or 'Today's Class Schedule.'",
        "Hi! Hope all is well. Begin with 'Appointment Details', 'Extra Class Schedule' or 'Today's Class Schedule' to continue.",
        "Hello! Ready to begin? Say 'Appointment Details', 'Extra Class Schedule' or 'Today's Class Schedule' to get started.",
        "Hi! You can start by saying or typing 'Appointment Details', 'Extra Class Schedule' or 'Today's Class Schedule.'"
    ]
    idx = np.random.randint(low=0, high=len(responses))
    return{
        "fulfillmentText" : responses[idx]
    }
    
def fetch_appointment_details(parameters):
    instructor_name = parameters.get("appointment_instructor")["name"]
    if not instructor_name:
        return{
            "fulfillmentText":"Please provide instructor name."
        }
    
    instructor_id = db_helper.fetch_instructor_id(instructor_name)
    if not instructor_id:
        print("No instructor id")
        return{
            "fulfillmentText":"An error occured while fetching appointment, please try again."
        }
        
    appointments = db_helper.fetch_appointment_details(instructor_id)
    if not appointments:
        return{
            "fulfillmentText":"There are no appointments scheduled for you."
        }
    
    rich_content = []
    rich_content.append({
        "type": "info",
        "title": "Here are your appointment details:",
    })

    for day, time in appointments:
        rich_content.append({
            "type": "description",
            "title": f"📅 {day}",
            "text": [f"🕒 {time}"],
            "icon": {
                "color": "#4285F4",
                "type": "event"
            }
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
    
def fetch_extra_class(parameters):
    instructor_name = parameters.get("extra_class_instructor")["name"]
    if not instructor_name:
        return{
            "fulfillmentText":"Please provide instructor name."
        }
    
    instructor_id = db_helper.fetch_instructor_id(instructor_name)
    if not instructor_id:
        print("No instructor id")
        return{
            "fulfillmentText":"An error occured while fetching appointment, please try again."
        }
        
    extra_class_details = db_helper.fetch_extra_class_details(instructor_id)
    if not extra_class_details:
        return{
            "fulfillmentText":"There are no extra class scheduled for you."
        }
    
    rich_content = []
    rich_content.append({
        "type": "info",
        "title": "Here are your extra class details:",
    })

    for row in extra_class_details:
        subject_code, classroom, start_time, end_time, day, semester = row
        rich_content.append({
            "type": "description",
            "title": f"📚 {subject_code}",
            "text": [
                f"📅 {day} | 🏫 {classroom} | ⏰ {start_time}-{end_time} | 🎓 Sem: {semester}",
            ]
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
    
def fetch_class_details(parameters):
    instructor_name = parameters.get("class_instructor")["name"]
    if not instructor_name:
        return{
            "fulfillmentText":"Please provide instructor name."
        }
        
    instructor_id = db_helper.fetch_instructor_id(instructor_name)
    if not instructor_id:
        print("No instructor id")
        return{
            "fulfillmentText":"An error occured while fetching appointment, please try again."
        }
        
    details = db_helper.fetch_class_details(instructor_id)
    if not details:
        return{
            "fulfillmentText":"There are no classes scheduled for you today."
        }
        
    rich_content = []
    rich_content.append({
        "type":"info",
        "title":"Here are your class details:"
    })
    
    for row in details:
        subject_code, semester, day, start_time, end_time, classroom = row
        rich_content.append({
            "type": "description",
            "title": f"📚 {subject_code}",
            "text": [
                f"📅 {day} | 🏫 {classroom} | ⏰ {start_time}-{end_time} | 🎓 Sem: {semester}",
            ]
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

app = FastAPI()
@app.post("/webhook")
         
async def webhook_handler(request : Request):
    try:
        body = await request.json()
        
        intent = body["queryResult"]["intent"]["displayName"]
        parameters = body["queryResult"]["parameters"]
        
        intent_handler_dict = {
            "Default Welcome Intent" : handle_welcome_intent,
            "fetch.appointment.details - context: appointment_details" : fetch_appointment_details,
            "extra.class.helper - context : extra_class" : fetch_extra_class,
            "class.details.helper - context : class_details" : fetch_class_details
        }
        
        handler = intent_handler_dict.get(intent)
        if not handler:
            return {"fulfillmentText": f"No handler for intent: {intent}"}
        return handler(parameters=parameters)

    except Exception as e:
        print("Error in Webhook:", str(e))
        raise HTTPException(status_code=400, detail=str(e))
        
    
if __name__ == '__main__':
    uvicorn.run(app, host="0.0.0.0", port=8001)
    #ngrok http --url=platypus-welcomed-bear.ngrok-free.app 8000