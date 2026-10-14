# Call Center Database

This project contains SQL scripts for a call center database with customers, agents, departments, calls, call logs, and feedback.

## Files
- `call_center_database.sql` - schema and sample seed data
- `call_center_sample_queries.sql` - 30 sample CRUD and reporting queries

## How to run

### MySQL
1. Open MySQL command line and create the database:
   ```sql
   CREATE DATABASE call_center_db;
   USE call_center_db;
   ```
2. Run schema and seed data:
   ```bash
   mysql -u your_user -p call_center_db < "C:/Users/Neha/Desktop/Projects - Topmentor/Project 21 - Call Center Database/call_center_database.sql"
   ```
3. Run the sample queries:
   ```bash
   mysql -u your_user -p call_center_db < "C:/Users/Neha/Desktop/Projects - Topmentor/Project 21 - Call Center Database/call_center_sample_queries.sql"
   ```

### Notes
- The schema uses `InnoDB` for referential integrity.
- `call_center_sample_queries.sql` includes examples for insert, update, delete, search, joins, views, and transactions.
