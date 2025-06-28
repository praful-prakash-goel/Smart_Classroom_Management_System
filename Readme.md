# SMART CLASSROOM MANAGEMENT SYSTEM

## Problem Statement
Traditional classroom management is manual, error-prone, and inefficient. This project proposes a Smart Classroom Management Software (SCMS) to automate attendance, resource scheduling, and provide data-driven insights, enhancing learning experiences and operational efficiency.

## Solution
This Smart Classroom Management Software is a sophisticated solution designed to revolutionize the educational environment by harmonizing technology with teaching.
This platform creates a dynamic and adaptable ecosystem, responding to the unique needs of each student. With automation, real-time analysis and AI tools both students and educators can be greatly benefitted. 
Educators can prioritize what truly matters by regularly checking insights of students and providing necessary help. This software suite leverages interactive tools, digital resources, and collaborative spaces, all designed to enhance student engagement and creativity.
Key features include facial recognition, providing real-time attendance reports to both educators and students. Additionally, the platform provides resource management, to detect any overlaps of resource usage which may exist while scheduling lectures, checking availability status of various resources.

## How to Import scms_db in MySQL Workbench
#### Prerequisites
- MySQL Server installed
- MySQL Workbench installed
- Database dump file (typically .sql, .zip, or .dump format)

##### Step 1: Open MySQL Workbench
Launch MySQL Workbench and connect to your MySQL server.

##### Step 2: Access the Data Import Tool
1. Click on `Server` in the top menu
2. Select `Data Import` from the dropdown

##### Step 3: Configure Import Settings
1. In the Data Import window, select:
   - `Import from Self-Contained File`
   - Click the `...` button to browse and select your database dump file

2. Choose the target schema:
   - `Import to Existing Database`: Select from dropdown
   OR
   - `Create New Database`: Enter a new database name

3. Under "Default Schema to be Imported To", select your target database

##### Step 4: Start the Import
1. Click `Start Import` button
2. Wait for the process to complete (progress will be shown in the bottom panel)

##### Step 5: Verify Import
1. In the Navigator panel, under "SCHEMAS", refresh (right-click > Refresh All)
2. Verify your database and tables appear
.
## Setting up postgresql database
- download and open pgAdmin 4 then create a new database named scms_db now right click on it and click on restore then select the .sql file and hit enter 
