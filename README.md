📚 Library Management System — CS27 Project
This project implements a complete relational database for library management. It covers the design phase (entities, relationships, 3NF normalization), the MySQL implementation (5 tables: `authors`, `members`, `book`, `borrowing_records`, `fines`), and reporting through advanced SQL queries (JOINs, GROUP BY, HAVING).

Group Members (Group 13)

Ouedraogo Landry — Group Leader
Birba WendRabo Casimir
Diallo Maimata
Yameogo Leonne
Sanfo Madi
Zongo Sadeck

Database Structure
The system is built on 5 main entities normalized to 3NF to ensure no redundancy and full data integrity:

AUTHORS — Stores information about writers.
BOOKS — Manages the book catalogue and availability.
MEMBERS — Registry of library members.
BORROWING_RECORDS — Tracks loans and return dates.
FINES — Manages fines related to late returns.


 Repository Contents
The project is divided into SQL scripts to be executed in the following order:

crebas_corrected.sql — Creates the library_db database and all tables with constraints (PK, FK, UNIQUE).
insert_data.sql — Populates the database with more than 10 realistic rows per table.
update_delete.sql — Tests updates, deletions, and demonstrates referential integrity violations.
select_queries.sql — Selection queries (JOIN, WHERE, LIKE, BETWEEN).
aggregate_queries.sql — Aggregate functions, GROUP BY, HAVING, and summary reports.
normalization.sql — Documents the transition from the unnormalized table (UNF) to 3NF.


 How to Use

Clone this repository.
Open MySQL Workbench (version 8.0 recommended).
Execute the scripts in the numbered order shown in the folder to rebuild the database.


 Additional Deliverables

PowerPoint Presentation — Available in the /docs folder.
Demo Video — [YouTube link to your video] (Each group member explains their part.)
