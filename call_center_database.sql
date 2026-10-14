-- Call Center Database Schema and Seed Data
-- Use a database named call_center_db

DROP TABLE IF EXISTS feedback;
DROP TABLE IF EXISTS call_logs;
DROP TABLE IF EXISTS calls;
DROP TABLE IF EXISTS agents;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    email VARCHAR(100),
    address VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE agents (
    agent_id INT PRIMARY KEY,
    agent_name VARCHAR(100) NOT NULL,
    department_id INT NOT NULL,
    phone_number VARCHAR(15),
    email VARCHAR(100),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE calls (
    call_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    agent_id INT NOT NULL,
    call_date DATE NOT NULL,
    call_time TIME NOT NULL,
    call_duration INT NOT NULL,
    call_type VARCHAR(20) NOT NULL,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (agent_id) REFERENCES agents(agent_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE call_logs (
    log_id INT PRIMARY KEY,
    call_id INT NOT NULL,
    remarks VARCHAR(255),
    resolution_status VARCHAR(50),
    FOREIGN KEY (call_id) REFERENCES calls(call_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE feedback (
    feedback_id INT PRIMARY KEY,
    call_id INT NOT NULL,
    rating INT,
    comments VARCHAR(255),
    FOREIGN KEY (call_id) REFERENCES calls(call_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO departments (department_id, department_name) VALUES
(1, 'Technical Support'),
(2, 'Billing'),
(3, 'Sales');

INSERT INTO customers (customer_id, customer_name, phone_number, email, address) VALUES
(101, 'Asha Mehra', '555-0101', 'asha@example.com', '22 Palm Avenue'),
(102, 'Rajat Singh', '555-0102', 'rajat@example.com', '44 Cedar Road'),
(103, 'Maya Roy', '555-0103', 'maya@example.com', '71 Pine Street');

INSERT INTO agents (agent_id, agent_name, department_id, phone_number, email) VALUES
(201, 'Nina Sharma', 1, '555-0201', 'nina@callcenter.com'),
(202, 'Vikram Gupta', 2, '555-0202', 'vikram@callcenter.com'),
(203, 'Priya Kapoor', 3, '555-0203', 'priya@callcenter.com');

INSERT INTO calls (call_id, customer_id, agent_id, call_date, call_time, call_duration, call_type, status) VALUES
(301, 101, 201, '2025-06-01', '10:15:00', 12, 'Incoming', 'Completed'),
(302, 102, 202, '2025-06-02', '11:20:00', 8, 'Outgoing', 'Pending'),
(303, 103, 203, '2025-06-03', '14:05:00', 15, 'Incoming', 'Missed');

INSERT INTO call_logs (log_id, call_id, remarks, resolution_status) VALUES
(401, 301, 'Password reset completed', 'Resolved'),
(402, 302, 'Billing details requested', 'In Progress');

INSERT INTO feedback (feedback_id, call_id, rating, comments) VALUES
(501, 301, 5, 'Excellent support');
