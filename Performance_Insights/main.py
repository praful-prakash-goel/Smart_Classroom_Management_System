from io import BytesIO
from category_encoders import TargetEncoder
from fastapi import FastAPI, File, UploadFile
from fastapi.middleware.cors import CORSMiddleware
import pandas as pd
import numpy as np
from sklearn.base import BaseEstimator, TransformerMixin
from sklearn.compose import ColumnTransformer
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import RobustScaler
import uvicorn
from keras.models import load_model
import os
import joblib
from custom_transformers import outlier_clipper
import os

model = load_model(r".\models\performance_pred_model.keras")

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

result_dict = {0:'Average', 1:'Excellent', 2:'Fail', 3:'Good'}
numerical_features =  ['Difficulty_Level', 'Midterm_Score', 'Final_Score', 'Quiz_Avg', 'Assignment_Completion_%', 'Attendance_%', 'Help_Seeking_Freq', 'Classroom_Behavior_Score']
continous_features = ['Midterm_Score', 'Final_Score', 'Quiz_Avg', 'Assignment_Completion_%', 'Attendance_%', 'Classroom_Behavior_Score']
preprocessor = joblib.load(r'.\models\preprocessor.pkl')

def predict(student_data, model):
    sample_input_processed = preprocessor.transform(student_data)
    prediction = model.predict(sample_input_processed)
    idx = np.argmax(prediction)
    result = result_dict[idx]
    return result

@app.post("/performance")
async def submit_data(file: UploadFile = File(...)):
    print("found")
    if not file.filename.endswith((".xlsx", ".xls")):
        return {"status": "error", "message": "Please upload a valid Excel file."}

    contents = await file.read()
    df = pd.read_excel(BytesIO(contents))

    required_columns = ["Student_ID", "Subject", "Difficulty_Level", "Midterm_Score", "Final_Score",
                        "Quiz_Avg", "Assignment_Completion_%", "Attendance_%", "Help_Seeking_Freq",
                        "Classroom_Behavior_Score", "Submission_Punctuality"]

    if not all(col in df.columns for col in required_columns):
        return {"status": "error", "message": f"Missing required columns. Required: {required_columns}"}

    df = df.rename(columns={
        "Assignment_Completion": "Assignment_Completion_%",
        "Attendance": "Attendance_%"
    })

    processed_data = preprocessor.transform(df)
    predictions = model.predict(processed_data)
    prediction_indices = np.argmax(predictions, axis=1)
    df["Performance"] = [result_dict[idx] for idx in prediction_indices]

    top_performers = df[df["Performance"].isin(["Excellent"])]
    at_risk = df[df["Performance"] == "Fail"]

    return {
        "status": "ok",
        "summary": {
            "total_students": len(df),
            "top_performers": top_performers["Student_ID"].tolist(),
            "at_risk": at_risk["Student_ID"].tolist(),
        },
        "full_results": df[["Student_ID", "Performance"]].to_dict(orient="records")
    }

if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=5001)
