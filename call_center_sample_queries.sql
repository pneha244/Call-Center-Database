-- Call Center Database Sample Queries
-- Run this file after the call_center_db schema is created and seeded.

-- 1) Create Database
CREATE DATABASE IF NOT EXISTS call_center_db;
USE call_center_db;

-- 2) Create Tables (Customers, Agents, Departments, Calls, CallLogs, Feedback)
-- The schema file already creates these tables.

-- 3) Insert Customer Details
INSERT INTO customers (customer_id, customer_name, phone_number, email, address)
VALUES (104, 'Kabir Das', '555-0104', 'kabir@example.com', '15 Oak Lane');

-- 4) Insert Agent Details
INSERT INTO agents (agent_id, agent_name, department_id, phone_number, email)
VALUES (204, 'Rhea Jain', 1, '555-0204', 'rhea@callcenter.com');

-- 5) Insert Department Details
INSERT INTO departments (department_id, department_name)
VALUES (4, 'Customer Success');

-- 6) Log a New Call
INSERT INTO calls (call_id, customer_id, agent_id, call_date, call_time, call_duration, call_type, status)
VALUES (304, 101, 201, '2025-06-04', '15:30:00', 20, 'Incoming', 'Completed');

-- 7) Insert Call Resolution Remarks
INSERT INTO call_logs (log_id, call_id, remarks, resolution_status)
VALUES (403, 304, 'Agent provided troubleshooting steps', 'Resolved');

-- 8) Insert Customer Feedback
INSERT INTO feedback (feedback_id, call_id, rating, comments)
VALUES (502, 304, 4, 'Helpful service');

-- 9) View All Customers
SELECT * FROM customers;

-- 10) View All Agents
SELECT * FROM agents;

-- 11) View All Calls
SELECT * FROM calls;

-- 12) Search Customer by Customer ID
SELECT * FROM customers WHERE customer_id = 101;

-- 13) Search Customer by Phone Number
SELECT * FROM customers WHERE phone_number = '555-0102';

-- 14) Search Agent by Department
SELECT a.*
FROM agents a
JOIN departments d ON a.department_id = d.department_id
WHERE d.department_name = 'Technical Support';

-- 15) Update Customer Details
UPDATE customers
SET address = '99 Willow Street'
WHERE customer_id = 102;

-- 16) Update Agent Details
UPDATE agents
SET email = 'vikram.gupta@callcenter.com'
WHERE agent_id = 202;

-- 17) Update Call Status
UPDATE calls
SET status = 'Completed'
WHERE call_id = 302;

-- 18) Update Call Duration
UPDATE calls
SET call_duration = 10
WHERE call_id = 302;

-- 19) Delete Customer Record
DELETE FROM customers WHERE customer_id = 104;

-- 20) Delete Call Record
DELETE FROM calls WHERE call_id = 304;

-- 21) View Customer Call History
SELECT c.customer_id, c.customer_name, ca.call_id, ca.call_date, ca.call_time, ca.call_duration, ca.status
FROM customers c
JOIN calls ca ON c.customer_id = ca.customer_id
WHERE c.customer_id = 101;

-- 22) View Calls Handled by an Agent
SELECT a.agent_id, a.agent_name, ca.call_id, ca.call_date, ca.call_duration, ca.status
FROM agents a
JOIN calls ca ON a.agent_id = ca.agent_id
WHERE a.agent_id = 201;

-- 23) Count Total Calls
SELECT COUNT(*) AS total_calls FROM calls;

-- 24) Count Calls by Department
SELECT d.department_name, COUNT(c.call_id) AS total_calls
FROM departments d
JOIN agents a ON d.department_id = a.department_id
JOIN calls c ON a.agent_id = c.agent_id
GROUP BY d.department_name;

-- 25) Count Completed, Pending, and Missed Calls
SELECT status, COUNT(*) AS count_by_status
FROM calls
GROUP BY status;

-- 26) Calculate Average Call Duration
SELECT AVG(call_duration) AS average_duration FROM calls;

-- 27) Retrieve Customers with Multiple Calls
SELECT c.customer_id, c.customer_name, COUNT(ca.call_id) AS call_count
FROM customers c
JOIN calls ca ON c.customer_id = ca.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(ca.call_id) > 1;

-- 28) Display Agent Details with Department (INNER JOIN)
SELECT a.agent_id, a.agent_name, d.department_name, a.phone_number, a.email
FROM agents a
INNER JOIN departments d ON a.department_id = d.department_id;

-- 29) Create and View Call Summary (VIEW)
DROP VIEW IF EXISTS call_summary;
CREATE VIEW call_summary AS
SELECT c.call_id,
       cu.customer_name,
       a.agent_name,
       d.department_name,
       c.call_date,
       c.call_time,
       c.call_duration,
       c.call_type,
       c.status
FROM calls c
JOIN customers cu ON c.customer_id = cu.customer_id
JOIN agents a ON c.agent_id = a.agent_id
JOIN departments d ON a.department_id = d.department_id;

SELECT * FROM call_summary;

-- 30) Perform Call Record Updates Using Transactions (COMMIT/ROLLBACK)
START TRANSACTION;
UPDATE calls SET status = 'Escalated' WHERE call_id = 303;
ROLLBACK;
