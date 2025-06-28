# import tkinter as tk
# import util
# import cv2
# from PIL import Image, ImageTk
# import os
# import sqlite3
# from datetime import datetime
# import numpy as np
# import face_recognition
# import mediapipe as mp
# from scipy.spatial import distance as dist
# import time
# from skimage.feature import local_binary_pattern
# import platform

# class DatabaseManager:
#     def __init__(self):
#         db_path = os.path.expanduser("~/Library/Application Support/AttendanceSystem/attendance.db")
#         os.makedirs(os.path.dirname(db_path), exist_ok=True)
#         self.conn = sqlite3.connect(db_path)
#         self.cursor = self.conn.cursor()
#         self.cursor.execute('''
#             CREATE TABLE IF NOT EXISTS attendance (
#                 id INTEGER PRIMARY KEY AUTOINCREMENT,
#                 name TEXT NOT NULL,
#                 roll_number TEXT NOT NULL,
#                 timestamp TEXT NOT NULL,
#                 date TEXT NOT NULL,
#                 device_id TEXT
#             )
#         ''')
#         self.conn.commit()

#     def has_attended(self, roll_number, date):
#         self.cursor.execute("SELECT * FROM attendance WHERE roll_number=? AND date=?", (roll_number, date))
#         return bool(self.cursor.fetchall())

#     def mark_attendance(self, name, roll_number, timestamp, date, device_id):
#         self.cursor.execute(
#             "INSERT INTO attendance (name, roll_number, timestamp, date, device_id) VALUES (?, ?, ?, ?, ?)",
#             (name, roll_number, timestamp, date, device_id))
#         self.conn.commit()

#     def close(self):
#         self.conn.close()

# class LivenessChecker:
#     def __init__(self, cap, face_mesh):
#         self.cap = cap
#         self.face_mesh = face_mesh
#         self.ear_threshold = 0.20
#         self.min_blinks = 1
#         self.max_frames = 30
#         self.lbp_threshold = 0.38  # Threshold for texture difference
#         self.verbose = True

#     def compute_ear(self, eye):
#         A = dist.euclidean(eye[1], eye[5])
#         B = dist.euclidean(eye[2], eye[4])
#         C = dist.euclidean(eye[0], eye[3])
#         return (A + B) / (2.0 * C)

#     def analyze_texture(self, face_crop):
#         gray = cv2.cvtColor(face_crop, cv2.COLOR_BGR2GRAY)
#         lbp = local_binary_pattern(gray, 8 * 2, 2, method='uniform')
#         hist, _ = np.histogram(lbp.ravel(), bins=59, range=(0, 59))
#         hist = hist.astype("float")
#         hist /= (hist.sum() + 1e-7)
#         entropy = -np.sum(hist * np.log2(hist + 1e-7))
#         return entropy > self.lbp_threshold

#     def check_frame(self, frame):
#         results = {'face_found': False, 'blink': False, 'texture_real': False, 'reason': ''}

#         try:
#             rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
#             face_locations = face_recognition.face_locations(rgb)

#             if not face_locations:
#                 results['reason'] = "No face"
#                 return results

#             results['face_found'] = True
#             mesh_result = self.face_mesh.process(rgb)

#             if not mesh_result.multi_face_landmarks:
#                 results['reason'] = "No landmarks"
#                 return results

#             h, w = frame.shape[:2]
#             mesh = mesh_result.multi_face_landmarks[0].landmark
#             left_eye = [(int(mesh[i].x * w), int(mesh[i].y * h)) for i in [33,160,158,133,153,144]]
#             right_eye = [(int(mesh[i].x * w), int(mesh[i].y * h)) for i in [362,385,387,263,373,380]]

#             ear = (self.compute_ear(left_eye) + self.compute_ear(right_eye)) / 2.0
#             results['blink'] = ear < self.ear_threshold

#             top, right, bottom, left = face_locations[0]
#             crop = frame[top:bottom, left:right]
#             results['texture_real'] = self.analyze_texture(crop)

#             results['reason'] = f"EAR: {ear:.2f}, Entropy: {results['texture_real']}"
#         except Exception as e:
#             results['reason'] = f"Error: {e}"
#         return results

#     def check_liveness(self):
#         blink_count = 0
#         real_texture_frames = 0
#         frames = 0

#         while frames < self.max_frames:
#             ret, frame = self.cap.read()
#             if not ret:
#                 continue

#             frame = cv2.flip(frame, 1)
#             result = self.check_frame(frame)
#             frames += 1

#             if self.verbose:
#                 print(f"[{frames}] {result['reason']}")

#             if result['blink']:
#                 blink_count += 1
#             if result['texture_real']:
#                 real_texture_frames += 1

#             if blink_count >= self.min_blinks and real_texture_frames >= 3:
#                 print("✅ Liveness Confirmed.")
#                 return True

#         print("❌ Liveness Failed.")
#         return False


# class App:
#     def __init__(self):
#         self.main_window = tk.Tk()
#         self.main_window.geometry("1050x520+350+100")
#         self.main_window.title("Attendance System - Mac")

#         self.db = DatabaseManager()
#         self.db_dir = './People'
#         self.known_face_encodings = []
#         self.known_face_names = []

#         self.login_button = util.get_button(self.main_window, "Mark Attendance", "green", self.login)
#         self.login_button.place(x=750, y=300)

#         self.webcam_label = util.get_img_label(self.main_window)
#         self.webcam_label.place(x=10, y=0, width=700, height=500)

#         self.load_known_faces()
#         self.setup_camera()
#         self.setup_face_mesh()
#         self.process_webcam()

#     def setup_camera(self):
#         self.cap = cv2.VideoCapture(0)
#         if not self.cap.isOpened():
#             util.msg_box("Error", "Could not open webcam!")
#             self.main_window.destroy()
#             return
        
#         # Set optimal resolution for Mac cameras
#         self.cap.set(cv2.CAP_PROP_FRAME_WIDTH, 1280)
#         self.cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 720)
#         self.cap.set(cv2.CAP_PROP_FPS, 30)

#     def setup_face_mesh(self):
#         self.face_mesh = mp.solutions.face_mesh.FaceMesh(
#             static_image_mode=False,
#             max_num_faces=1,
#             refine_landmarks=True,
#             min_detection_confidence=0.6,
#             min_tracking_confidence=0.6
#         )
#         self.liveness_checker = LivenessChecker(self.cap, self.face_mesh)

#     def load_known_faces(self):
#         for filename in os.listdir(self.db_dir):
#             if filename.lower().endswith((".jpg", ".jpeg", ".png")):
#                 try:
#                     path = os.path.join(self.db_dir, filename)
#                     image = face_recognition.load_image_file(path)
#                     encodings = face_recognition.face_encodings(image)
#                     if encodings:
#                         self.known_face_encodings.append(encodings[0])
#                         self.known_face_names.append(filename)
#                 except Exception as e:
#                     print(f"Error loading {filename}: {str(e)}")

#     def process_webcam(self):
#         ret, frame = self.cap.read()
#         if ret:
#             frame = cv2.flip(frame, 1)
#             rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
#             img = ImageTk.PhotoImage(Image.fromarray(rgb))
#             self.webcam_label.imgtk = img
#             self.webcam_label.configure(image=img)
#         self.webcam_label.after(10, self.process_webcam)

#     def login(self):
#         util.msg_box("Liveness Check", "Please look at the camera and blink naturally")
        
#         if not self.liveness_checker.check_liveness():
#             util.msg_box("Verification Failed", "Could not verify liveness. Please try again.")
#             return

#         ret, frame = self.cap.read()
#         if not ret:
#             util.msg_box("Error", "Failed to capture image!")
#             return

#         try:
#             rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
#             encodings = face_recognition.face_encodings(rgb)
            
#             if not encodings:
#                 util.msg_box("Error", "No face detected in the image.")
#                 return

#             face_encoding = encodings[0]
#             distances = face_recognition.face_distance(self.known_face_encodings, face_encoding)
#             best_match_index = np.argmin(distances)
            
#             if distances[best_match_index] < 0.6:  # Face recognition threshold
#                 recognized_name = self.known_face_names[best_match_index]
#                 name_with_roll = os.path.splitext(recognized_name)[0]
                
#                 if "_" in name_with_roll:
#                     name, roll = name_with_roll.rsplit("_", 1)
#                     name = name.capitalize()
#                     today = datetime.now().strftime("%Y-%m-%d")
                    
#                     if self.db.has_attended(roll, today):
#                         util.msg_box("Already Marked", f"{name}, attendance already recorded today.")
#                     else:
#                         self.db.mark_attendance(
#                             name, 
#                             roll, 
#                             datetime.now().strftime("%Y-%m-%d %H:%M:%S"), 
#                             today, 
#                             platform.node()
#                         )
#                         util.msg_box("Success", f"Welcome {name}! Attendance recorded.")
#                 else:
#                     util.msg_box("Error", "Invalid filename format. Use 'Name_RollNumber.jpg'")
#             else:
#                 util.msg_box("Unknown", "Face not recognized in database.")
                
#         except Exception as e:
#             util.msg_box("Error", f"An error occurred: {str(e)}")

#     def start(self):
#         self.main_window.mainloop()
#         if hasattr(self, 'cap') and self.cap.isOpened():
#             self.cap.release()
#         if hasattr(self, 'face_mesh'):
#             self.face_mesh.close()
#         if hasattr(self, 'db'):
#             self.db.close()


# if __name__ == "__main__":
#     app = App()
#     app.start()

import tkinter as tk
import util
import cv2
from PIL import Image, ImageTk
import os
import sqlite3
from datetime import datetime
import numpy as np
import face_recognition
import mediapipe as mp
from scipy.spatial import distance as dist
import platform

class DatabaseManager:
    def __init__(self):
        db_path = os.path.join(os.getcwd(), "facial_recognition", "attendance.db")
        os.makedirs(os.path.dirname(db_path), exist_ok=True)
        self.conn = sqlite3.connect(db_path)
        self.cursor = self.conn.cursor()
        self.cursor.execute('''
            CREATE TABLE IF NOT EXISTS attendance (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL,
                roll_number TEXT NOT NULL,
                timestamp TEXT NOT NULL,
                date TEXT NOT NULL,
                device_id TEXT
            )
        ''')
        self.conn.commit()

    def has_attended(self, roll_number, date):
        self.cursor.execute("SELECT * FROM attendance WHERE roll_number=? AND date=?", (roll_number, date))
        return bool(self.cursor.fetchall())

    def mark_attendance(self, name, roll_number, timestamp, date, device_id):
        self.cursor.execute(
            "INSERT INTO attendance (name, roll_number, timestamp, date, device_id) VALUES (?, ?, ?, ?, ?)",
            (name, roll_number, timestamp, date, device_id))
        self.conn.commit()

    def close(self):
        self.conn.close()

class LivenessChecker:
    def __init__(self, cap, face_mesh):
        self.cap = cap
        self.face_mesh = face_mesh
        self.ear_threshold = 0.20
        self.min_blinks = 1
        self.max_frames = 30

    def compute_ear(self, eye):
        A = dist.euclidean(eye[1], eye[5])
        B = dist.euclidean(eye[2], eye[4])
        C = dist.euclidean(eye[0], eye[3])
        return (A + B) / (2.0 * C)

    def check_frame(self, frame):
        results = {'face_found': False, 'blink': False, 'reason': ''}

        rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
        face_locations = face_recognition.face_locations(rgb)

        if not face_locations:
            results['reason'] = "No face"
            return results

        results['face_found'] = True
        mesh_result = self.face_mesh.process(rgb)

        if not mesh_result.multi_face_landmarks:
            results['reason'] = "No landmarks"
            return results

        h, w = frame.shape[:2]
        mesh = mesh_result.multi_face_landmarks[0].landmark
        left_eye = [(int(mesh[i].x * w), int(mesh[i].y * h)) for i in [33,160,158,133,153,144]]
        right_eye = [(int(mesh[i].x * w), int(mesh[i].y * h)) for i in [362,385,387,263,373,380]]

        ear = (self.compute_ear(left_eye) + self.compute_ear(right_eye)) / 2.0
        results['blink'] = ear < self.ear_threshold
        results['reason'] = f"EAR: {ear:.2f}"

        return results

    def check_liveness(self):
        blink_count = 0
        frames = 0

        while frames < self.max_frames:
            ret, frame = self.cap.read()
            if not ret:
                continue

            frame = cv2.flip(frame, 1)
            result = self.check_frame(frame)
            frames += 1

            print(f"[{frames}] {result['reason']}")

            if result['blink']:
                blink_count += 1

            if blink_count >= self.min_blinks:
                print("✅ Liveness Confirmed.")
                return True

        print("❌ Liveness Failed.")
        return False

class App:
    def __init__(self):
        self.main_window = tk.Tk()
        self.main_window.geometry("1050x520+350+100")
        self.main_window.title("Face Attendance - Windows")

        self.db = DatabaseManager()
        self.db_dir = os.path.join(os.getcwd(), "People")
        self.known_face_encodings = []
        self.known_face_names = []

        self.login_button = util.get_button(self.main_window, "Mark Attendance", "green", self.login)
        self.login_button.place(x=750, y=300)

        self.webcam_label = util.get_img_label(self.main_window)
        self.webcam_label.place(x=10, y=0, width=700, height=500)

        self.load_known_faces()
        self.setup_camera()
        self.setup_face_mesh()
        self.process_webcam()

    def setup_camera(self):
        self.cap = cv2.VideoCapture(0)
        if not self.cap.isOpened():
            util.msg_box("Error", "Could not open webcam!")
            self.main_window.destroy()
            return

    def setup_face_mesh(self):
        self.face_mesh = mp.solutions.face_mesh.FaceMesh(
            static_image_mode=False,
            max_num_faces=1,
            refine_landmarks=True,
            min_detection_confidence=0.6,
            min_tracking_confidence=0.6
        )
        self.liveness_checker = LivenessChecker(self.cap, self.face_mesh)

    def load_known_faces(self):
        for filename in os.listdir(self.db_dir):
            if filename.lower().endswith((".jpg", ".jpeg", ".png")):
                try:
                    path = os.path.join(self.db_dir, filename)
                    image = face_recognition.load_image_file(path)
                    encodings = face_recognition.face_encodings(image)
                    if encodings:
                        self.known_face_encodings.append(encodings[0])
                        self.known_face_names.append(filename)
                except Exception as e:
                    print(f"Error loading {filename}: {str(e)}")

    def process_webcam(self):
        ret, frame = self.cap.read()
        if ret:
            frame = cv2.flip(frame, 1)
            rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
            img = ImageTk.PhotoImage(Image.fromarray(rgb))
            self.webcam_label.imgtk = img
            self.webcam_label.configure(image=img)
        self.webcam_label.after(10, self.process_webcam)

    def login(self):
        util.msg_box("Liveness Check", "Please look at the camera and blink naturally")

        if not self.liveness_checker.check_liveness():
            util.msg_box("Verification Failed", "Could not verify liveness. Please try again.")
            return

        ret, frame = self.cap.read()
        if not ret:
            util.msg_box("Error", "Failed to capture image!")
            return

        rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
        encodings = face_recognition.face_encodings(rgb)

        if not encodings:
            util.msg_box("Error", "No face detected.")
            return

        face_encoding = encodings[0]
        distances = face_recognition.face_distance(self.known_face_encodings, face_encoding)
        best_match_index = np.argmin(distances)

        if distances[best_match_index] < 0.6:
            recognized_name = self.known_face_names[best_match_index]
            name_with_roll = os.path.splitext(recognized_name)[0]

            if "_" in name_with_roll:
                name, roll = name_with_roll.rsplit("_", 1)
                today = datetime.now().strftime("%Y-%m-%d")

                if self.db.has_attended(roll, today):
                    util.msg_box("Already Marked", f"{name}, attendance already recorded today.")
                else:
                    self.db.mark_attendance(
                        name,
                        roll,
                        datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
                        today,
                        platform.node()
                    )
                    util.msg_box("Success", f"Welcome {name}! Attendance recorded.")
            else:
                util.msg_box("Error", "Invalid filename format. Use 'Name_RollNumber.jpg'")
        else:
            util.msg_box("Unknown", "Face not recognized in database.")

    def start(self):
        self.main_window.mainloop()
        if hasattr(self, 'cap') and self.cap.isOpened():
            self.cap.release()
        if hasattr(self, 'face_mesh'):
            self.face_mesh.close()
        if hasattr(self, 'db'):
            self.db.close()

if __name__ == "__main__":
    app = App()
    app.start()
