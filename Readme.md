# SMART CLASSROOM MANAGEMENT SYSTEM

## Problem Statement
Traditional classroom management is manual, error-prone, and inefficient. This project proposes a Smart Classroom Management Software (SCMS) to automate attendance, resource scheduling, and provide data-driven insights, enhancing learning experiences and operational efficiency.

## Solution
This Smart Classroom Management Software is a sophisticated solution designed to revolutionize the educational environment by harmonizing technology with teaching.
This platform creates a dynamic and adaptable ecosystem, responding to the unique needs of each student. With automation, real-time analysis and AI tools both students and educators can be greatly benefitted. 
Educators can prioritize what truly matters by regularly checking insights of students and providing necessary help. This software suite leverages interactive tools, digital resources, and collaborative spaces, all designed to enhance student engagement and creativity.
Key features include facial recognition, providing real-time attendance reports to both educators and students. Additionally, the platform provides resource management, to detect any overlaps of resource usage which may exist while scheduling lectures, checking availability status of various resources.

## How to Import database in MySQL Workbench (scms_database_updated.sql)
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
# PostgreSQL Database Setup Guide

## Prerequisites
- PostgreSQL installed
- pgAdmin 4 installed
- Database backup file (.sql format)

## Steps to Create and Restore Postgresql Database (Postgresql_scms_db.sql)

##### Step 1: Launch pgAdmin 4
1. Open pgAdmin from your applications menu
2. Connect to your PostgreSQL server by entering your password

##### Step 2: Create a New Database
1. Right-click on "Databases" in the Browser panel
2. Select `Create` > `Database...`
3. In the dialog:
   - Enter database name: `scms_db`
   - Click `Save`

##### Step 3: Restore Database from Backup
1. Right-click on the newly created `scms_db` database
2. Select `Restore...`
3. In the Restore dialog:
   - Under "Filename", click the folder icon
   - Browse and select your `.sql` backup file
   - Click `Select`
4. Click the `Restore` button to begin the process

##### Step 4: Verify Restoration
1. Expand `scms_db` in the Browser panel
2. Check that all expected tables and objects are present

##### Troubleshooting
- **Permission errors**: Ensure your user has create/restore privileges
- **Large files**: For very large backups, consider using command line:
  ```bash
  psql -U username -d scms_db -f backupfile.sql
