# Smart Classroom Management System (SCMS)

## Overview
The Smart Classroom Management System (SCMS) is a sophisticated solution designed to revolutionize the educational environment by harmonizing technology with teaching. It addresses the inefficiencies of traditional classroom management by automating attendance, resource scheduling, and providing data-driven insights to enhance learning experiences and operational efficiency. This platform creates a dynamic and adaptable ecosystem, responding to the unique needs of each student and educator. Key features include facial recognition for real-time attendance tracking, resource management to prevent scheduling conflicts, performance insights, code analysis, extra class scheduling, and a student/teacher chatbot for enhanced communication. Additionally, it integrates with Knowlio for advanced AI-driven functionalities.

## Problem Statement
Traditional classroom management is manual, error-prone, and inefficient. SCMS automates critical tasks such as attendance tracking, resource scheduling, and provides data-driven insights, enabling educators to focus on teaching and fostering student engagement and creativity through interactive tools, digital resources, and collaborative spaces.

## Solution
SCMS leverages automation, real-time analysis, and AI tools to benefit both students and educators. Key components include:
- **Facial Recognition**: Provides real-time attendance reports for educators and students.
- **Resource Management**: Detects scheduling overlaps and checks resource availability.
- **Performance Insights**: Analyzes student performance to provide actionable insights.
- **Code Analysis**: Evaluates student code submissions for quality and correctness.
- **Extra Class Management**: Facilitates scheduling and management of additional classes.
- **Student/Teacher Chatbot**: Enhances communication using a Dialogflow-based chatbot hosted locally and exposed via ngrok.
- **Knowlio Integration**: Uses Llama3.2 via Ollama for advanced AI functionalities.

## Table of Contents
- [Overview](#overview)
- [Problem Statement](#problem-statement)
- [Solution](#solution)
- [Prerequisites](#prerequisites)
  - [MySQL Setup](#mysql-setup)
  - [PostgreSQL Setup](#postgresql-setup)
  - [ReactJS Setup](#reactjs-setup)
  - [ngrok Setup and Static Domain](#ngrok-setup-and-static-domain)
  - [Conda Environment Setup](#conda-environment-setup)
  - [Ollama for Llama3.2](#ollama-for-llama32)
- [Project Structure](#project-structure)
- [Setup and Running Instructions](#setup-and-running-instructions)
  - [Facial Recognition Attendance System](#facial-recognition-attendance-system)
  - [Main Server](#main-server)
  - [SCMS Frontend](#scms-frontend)
  - [Performance Insights](#performance-insights)
  - [Code Analysis](#code-analysis)
  - [Extra Class](#extra-class)
  - [Student/Teacher Chatbot](#studentteacher-chatbot)
  - [Knowlio](#knowlio)
- [Disclaimers](#disclaimers)
- [Contributing](#contributing)
- [License](#license)

## Prerequisites
Before setting up the project, ensure you have the following tools and services installed and configured.

### MySQL Setup
SCMS uses a MySQL database to store roll numbers (2301001 to 2301250) and other data.

1. **Install MySQL**:
   - Download and install MySQL from [mysql.com](https://dev.mysql.com/downloads/installer/) for your operating system.
   - Follow the installation instructions, setting up a root user and password.
   - Optionally, install MySQL Workbench for a graphical interface.

2. **Import Database**:
   - Open MySQL Workbench and connect to your MySQL server.
   - Click `Server` > `Data Import` in the top menu.
   - Select `Import from Self-Contained File` and browse to `scms_database_updated.sql`.
   - Choose an existing database or create a new one (e.g., `scms_db`).
   - Click `Start Import` and wait for completion.
   - Verify the database and tables under the "SCHEMAS" panel (right-click > Refresh All).

3. **Configure Database Connection**:
   - Update the database configuration in `Backend/config.py` (or equivalent) with your MySQL credentials:
     ```python
     DATABASE_CONFIG = {
         'host': 'localhost',
         'user': 'root',
         'password': 'your_password',
         'database': 'scms_db'
     }
     ```
   - Install the MySQL driver for Python:
     ```bash
     pip install mysql-connector-python
     ```

### PostgreSQL Setup
Some components may use PostgreSQL for additional data storage.

1. **Install PostgreSQL**:
   - Download and install PostgreSQL from [postgresql.org](https://www.postgresql.org/download/).
   - Install pgAdmin 4 for a graphical interface.

2. **Create and Restore Database**:
   - Open pgAdmin 4 and connect to your PostgreSQL server.
   - Right-click `Databases` in the Browser panel, select `Create` > `Database`, and name it `scms_db`.
   - Right-click the new `scms_db`, select `Restore`, and choose `Postgresql_scms_db.sql`.
   - Click `Restore` and verify that tables and objects appear under `scms_db`.

3. **Troubleshooting**:
   - For permission errors, ensure your user has create/restore privileges.
   - For large files, use the command line:
     ```bash
     psql -U username -d scms_db -f Postgresql_scms_db.sql
     ```

4. **Install PostgreSQL Driver**:
   - Install the Python driver:
     ```bash
     pip install psycopg2
     ```

### ReactJS Setup
The SCMS frontend uses ReactJS.

1. **Install Node.js and npm**:
   - Download and install Node.js from [nodejs.org](https://nodejs.org/) (includes npm).
   - Verify installation:
     ```bash
     node -v
     npm -v
     ```

2. **Install React Dependencies**:
   - Navigate to the `scms` directory and install dependencies:
     ```bash
     cd scms
     npm install
     ```

### ngrok Setup and Static Domain
ngrok exposes the local chatbot server to Dialogflow.

1. **Create an ngrok Account**:
   - Sign up at [ngrok.com](https://ngrok.com/signup) and copy your authtoken from the [dashboard](https://dashboard.ngrok.com/).

2. **Install ngrok**:
   - Download the ngrok executable from the dashboard for your platform.
   - Place it in a directory (e.g., `C:\ngrok` or `/usr/local/bin`).

3. **Authorize ngrok**:
   - Run:
     ```bash
     ./ngrok authtoken YOUR_AUTHTOKEN_HERE
     ```

4. **Claim a Static Domain**:
   - In the ngrok dashboard, reserve a static domain (e.g., `yourname.ngrok.app`).
   - Modify the ngrok command to use port 8000:
     ```bash
     ngrok http --domain=yourname.ngrok.app 8000
     ```

5. **Install ngrok for Node.js (Optional)**:
   - If needed, install the ngrok Node.js package:
     ```bash
     npm install ngrok
     ```

### Conda Environment Setup
Several components use Python and require a conda environment.

1. **Install Miniconda or Anaconda**:
   - Download from [conda.io](https://docs.conda.io/en/latest/miniconda.html) or [anaconda.com](https://www.anaconda.com/products/distribution).
   - Verify:
     ```bash
     conda -V
     ```

2. **Create and Activate Environment**:
   - Create:
     ```bash
     conda create -n face_env python=3.8
     ```
   - Activate:
     ```bash
     conda activate face_env
     ```

3. **Install Requirements**:
   - Install dependencies (adjust based on `requirements.txt`):
     ```bash
     pip install opencv-python numpy pandas mysql-connector-python psycopg2
     ```

### Ollama for Llama3.2
Knowlio uses Ollama to run Llama3.2.

1. **Install Ollama**:
   - Download from [ollama.ai](https://ollama.ai/download).
   - Verify:
     ```bash
     ollama --version
     ```

2. **Run Llama3.2**:
   - Pull and run:
     ```bash
     ollama run llama3.2
     ```

## Project Structure
```
scms/
├── Face_attendance/
│   └── main.py
├── Backend/
│   ├── chatbot/
│   │   ├── teacher/
│   │   │   └── main.py
│   │   ├── student/
│   │   │   └── main.py
│   │   └── proxy.py
├── scms/
│   ├── src/
│   │   └── app.py
├── performance_insights/
│   └── main.py
├── Code_Analysis/
│   └── app.py
├── Extra_Class/
│   └── main.py
├── scms_database_updated.sql
├── Postgresql_scms_db.sql
```

## Setup and Running Instructions

### Facial Recognition Attendance System
1. Activate the conda environment:
   ```bash
   conda activate face_env
   ```
2. Navigate to the `Face_attendance` directory:
   ```bash
   cd Face_attendance
   ```
3. Install requirements:
   ```bash
   pip install -r requirements.txt
   ```
4. Run the application:
   ```bash
   python main.py
   ```

### Main Server
1. Open a new terminal and navigate to the `Backend` directory:
   ```bash
   cd Backend
   ```
2. Install Node.js dependencies:
   ```bash
   npm install
   ```
3. Start the server:
   ```bash
   npm run dev
   ```

### SCMS Frontend
1. Open a new terminal and navigate to the `scms` directory:
   ```bash
   cd scms
   ```
2. Install dependencies:
   ```bash
   npm install
   ```
3. Start the ReactJS application:
   ```bash
   npm run dev
   ```
4. Open the localhost link in your browser (default port: 5173, e.g., `http://localhost:5173`).

### Performance Insights
1. Activate the conda environment:
   ```bash
   conda activate face_env
   ```
2. Navigate to the `performance_insights` directory:
   ```bash
   cd performance_insights
   ```
3. Run the script:
   ```bash
   python main.py
   ```

### Code Analysis
1. Activate the conda environment:
   ```bash
   conda activate face_env
   ```
2. Navigate to the `Code_Analysis` directory:
   ```bash
   cd Code_Analysis
   ```
3. Run the script:
   ```bash
   python app.py
   ```

### Extra Class
1. Activate the conda environment:
   ```bash
   conda activate face_env
   ```
2. Navigate to the `Extra_Class` directory:
   ```bash
   cd Extra_Class
   ```
3. Run the script:
   ```bash
   python main.py
   ```

### Student/Teacher Chatbot
The chatbot is hosted locally and uses ngrok for Dialogflow integration.

1. **Set Up ngrok**:
   - Run ngrok with the static domain and port 8000:
     ```bash
     ngrok http --domain=yourname.ngrok.app 8000
     ```
   - Update the Dialogflow fulfillment link with the ngrok URL (e.g., `https://yourname.ngrok.app`).

2. **Run Teacher Chatbot**:
   - Navigate to the `teacher` folder:
     ```bash
     cd Backend/chatbot/teacher
     ```
   - Run:
     ```bash
     python main.py
     ```

3. **Run Student Chatbot**:
   - Navigate to the `student` folder:
     ```bash
     cd Backend/chatbot/student
     ```
   - Run:
     ```bash
     python main.py
     ```

4. **Run Proxy**:
   - Navigate to the `chatbot` folder:
     ```bash
     cd Backend/chatbot
     ```
   - Run:
     ```bash
     python proxy.py
     ```

### Knowlio
1. Run Llama3.2:
   ```bash
   ollama run llama3.2
   ```
2. Navigate to the `scms/src` directory:
   ```bash
   cd scms/src
   ```
3. Run the application:
   ```bash
   python app.py
   ```

## Disclaimers
- **Roll Numbers**: When logging in to any component requiring authentication (e.g., chatbot, facial recognition), you can use any name, but you must use roll numbers within the range of 2301001 to 2301250, as these are stored in the database and used across various functionalities.
- **Local Hosting for Chatbot**: The chatbot is hosted locally, requiring ngrok to expose the server to Dialogflow. The Dialogflow fulfillment link must be updated with the unique ngrok URL generated for each laptop.
- **ngrok Static Domain**: The ngrok static domain command defaults to port 80. For this project, change it to port 8000 when running the ngrok command.

## Contributing
1. Fork the repository.
2. Create a branch (`git checkout -b feature/your-feature`).
3. Commit changes (`git commit -m 'Add your feature'`).
4. Push to the branch (`git push origin feature/your-feature`).
5. Create a pull request.

See [CONTRIBUTING.md](CONTRIBUTING.md) for details.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file.