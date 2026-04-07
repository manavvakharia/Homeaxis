-- HomeAxis: Database for 50 potential Indian customers (broker-ready)
-- All data required for broker matching and customer login

CREATE DATABASE IF NOT EXISTS people_db;
USE people_db;

DROP TABLE IF EXISTS customer_preferences;
DROP TABLE IF EXISTS people;

-- Main customers table (login + profile)
CREATE TABLE people (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    gender ENUM('Male','Female','Other') NOT NULL,
    profession VARCHAR(80) NOT NULL,
    marital_status ENUM('Single','Married','Divorced','Widowed') NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    contact_no VARCHAR(15) NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Property preferences (broker matching criteria)
CREATE TABLE customer_preferences (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    location_preference VARCHAR(80) NOT NULL,
    property_type ENUM('Apartment','Villa','Commercial','Plot') NOT NULL,
    bhk VARCHAR(20) NOT NULL,
    budget_lakhs DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES people(id) ON DELETE CASCADE
);

-- Insert 50 Indian customers with login credentials and broker-relevant data
-- Default password: 'demo123' (hashed in production)
INSERT INTO people (name, age, gender, profession, marital_status, email, contact_no, password) VALUES
('Amit Sharma', 24, 'Male', 'IT Professional', 'Single', 'amit24@gmail.com', '9876543210', 'demo123'),
('Riya Mehta', 22, 'Female', 'Student', 'Single', 'riya22@gmail.com', '9876543211', 'demo123'),
('Rahul Verma', 28, 'Male', 'IT Professional', 'Single', 'rahul28@gmail.com', '9876543212', 'demo123'),
('Sneha Iyer', 26, 'Female', 'Engineer', 'Single', 'sneha26@gmail.com', '9876543213', 'demo123'),
('Karan Patel', 32, 'Male', 'Business Owner', 'Married', 'karan32@gmail.com', '9876543214', 'demo123'),
('Neha Singh', 29, 'Female', 'Government Employee', 'Married', 'neha29@gmail.com', '9876543215', 'demo123'),
('Arjun Nair', 35, 'Male', 'IT Professional', 'Married', 'arjun35@gmail.com', '9876543216', 'demo123'),
('Pooja Kulkarni', 27, 'Female', 'Other', 'Single', 'pooja27@gmail.com', '9876543217', 'demo123'),
('Rohit Malhotra', 31, 'Male', 'Business Owner', 'Married', 'rohit31@gmail.com', '9876543218', 'demo123'),
('Ananya Bose', 23, 'Female', 'Student', 'Single', 'ananya23@gmail.com', '9876543219', 'demo123'),
('Vikas Jain', 36, 'Male', 'Business Owner', 'Married', 'vikas36@gmail.com', '9876543220', 'demo123'),
('Simran Kaur', 25, 'Female', 'IT Professional', 'Single', 'simran25@gmail.com', '9876543221', 'demo123'),
('Nikhil Gupta', 34, 'Male', 'Other', 'Married', 'nikhil34@gmail.com', '9876543222', 'demo123'),
('Ayesha Khan', 28, 'Female', 'Other', 'Single', 'ayesha28@gmail.com', '9876543223', 'demo123'),
('Siddharth Roy', 30, 'Male', 'IT Professional', 'Single', 'sid30@gmail.com', '9876543224', 'demo123'),
('Mehul Shah', 41, 'Male', 'Business Owner', 'Married', 'mehul41@gmail.com', '9876543225', 'demo123'),
('Divya Agarwal', 33, 'Female', 'Engineer', 'Married', 'divya33@gmail.com', '9876543226', 'demo123'),
('Aditya Rao', 26, 'Male', 'IT Professional', 'Single', 'aditya26@gmail.com', '9876543227', 'demo123'),
('Tanvi Joshi', 24, 'Female', 'Student', 'Single', 'tanvi24@gmail.com', '9876543228', 'demo123'),
('Manish Pandey', 38, 'Male', 'Government Employee', 'Married', 'manish38@gmail.com', '9876543229', 'demo123'),
('Kriti Malhotra', 29, 'Female', 'Other', 'Single', 'kriti29@gmail.com', '9876543230', 'demo123'),
('Akash Yadav', 27, 'Male', 'Engineer', 'Single', 'akash27@gmail.com', '9876543231', 'demo123'),
('Nandini Sen', 34, 'Female', 'Teacher', 'Married', 'nandini34@gmail.com', '9876543232', 'demo123'),
('Pratik Desai', 31, 'Male', 'Engineer', 'Married', 'pratik31@gmail.com', '9876543233', 'demo123'),
('Shreya Kapoor', 25, 'Female', 'Other', 'Single', 'shreya25@gmail.com', '9876543234', 'demo123'),
('Ramesh Pillai', 45, 'Male', 'Business Owner', 'Married', 'ramesh45@gmail.com', '9876543235', 'demo123'),
('Ishita Banerjee', 28, 'Female', 'Doctor', 'Single', 'ishita28@gmail.com', '9876543236', 'demo123'),
('Harsh Vardhan', 33, 'Male', 'IT Professional', 'Married', 'harsh33@gmail.com', '9876543237', 'demo123'),
('Sonal Mittal', 37, 'Female', 'Other', 'Married', 'sonal37@gmail.com', '9876543238', 'demo123'),
('Yash Choudhary', 22, 'Male', 'Student', 'Single', 'yash22@gmail.com', '9876543239', 'demo123'),
('Bhavna Arora', 40, 'Female', 'Teacher', 'Married', 'bhavna40@gmail.com', '9876543240', 'demo123'),
('Ankit Bansal', 35, 'Male', 'IT Professional', 'Married', 'ankit35@gmail.com', '9876543241', 'demo123'),
('Lavanya Reddy', 26, 'Female', 'Doctor', 'Single', 'lavanya26@gmail.com', '9876543242', 'demo123'),
('Suresh Naidu', 48, 'Male', 'Business Owner', 'Married', 'suresh48@gmail.com', '9876543243', 'demo123'),
('Mitali Ghosh', 31, 'Female', 'IT Professional', 'Single', 'mitali31@gmail.com', '9876543244', 'demo123'),
('Kunal Saxena', 29, 'Male', 'IT Professional', 'Single', 'kunal29@gmail.com', '9876543245', 'demo123'),
('Farah Sheikh', 34, 'Female', 'Other', 'Married', 'farah34@gmail.com', '9876543246', 'demo123'),
('Abhishek Tiwari', 27, 'Male', 'IT Professional', 'Single', 'abhishek27@gmail.com', '9876543247', 'demo123'),
('Ritu Chawla', 42, 'Female', 'Business Owner', 'Married', 'ritu42@gmail.com', '9876543248', 'demo123'),
('Sameer Kulkarni', 39, 'Male', 'Engineer', 'Married', 'sameer39@gmail.com', '9876543249', 'demo123'),
('Aarav Kulkarni', 21, 'Male', 'Student', 'Single', 'aarav21@gmail.com', '9876543250', 'demo123'),
('Diya Shah', 23, 'Female', 'Student', 'Single', 'diya23@gmail.com', '9876543251', 'demo123'),
('Mohit Arora', 34, 'Male', 'IT Professional', 'Married', 'mohit34@gmail.com', '9876543252', 'demo123'),
('Pallavi Deshpande', 28, 'Female', 'Doctor', 'Single', 'pallavi28@gmail.com', '9876543253', 'demo123'),
('Naveen Joshi', 46, 'Male', 'Business Owner', 'Married', 'naveen46@gmail.com', '9876543254', 'demo123'),
('Rachel Dsouza', 31, 'Female', 'IT Professional', 'Married', 'rachel31@gmail.com', '9876543255', 'demo123'),
('Shubham Patil', 26, 'Male', 'IT Professional', 'Single', 'shubham26@gmail.com', '9876543256', 'demo123'),
('Kavita Menon', 44, 'Female', 'Government Employee', 'Married', 'kavita44@gmail.com', '9876543257', 'demo123'),
('Rohan Sethi', 29, 'Male', 'IT Professional', 'Single', 'rohan29@gmail.com', '9876543258', 'demo123'),
('Meera Kulkarni', 36, 'Female', 'Other', 'Married', 'meera36@gmail.com', '9876543259', 'demo123');

-- Insert property preferences for each customer (broker matching criteria)
INSERT INTO customer_preferences (customer_id, location_preference, property_type, bhk, budget_lakhs) VALUES
(1,'Mumbai','Apartment','2 BHK',85),(2,'Bangalore','Apartment','2 BHK',55),(3,'Pune','Apartment','3 BHK',95),(4,'Delhi','Apartment','2 BHK',75),
(5,'Mumbai','Villa','4+ BHK',160),(6,'Gurgaon','Apartment','3 BHK',90),(7,'Bangalore','Apartment','3 BHK',120),(8,'Pune','Apartment','2 BHK',65),
(9,'Mumbai','Commercial','Office Space',200),(10,'Chennai','Apartment','2 BHK',50),(11,'Delhi','Villa','4+ BHK',250),(12,'Hyderabad','Apartment','2 BHK',70),
(13,'Mumbai','Apartment','3 BHK',150),(14,'Bangalore','Apartment','2 BHK',60),(15,'Pune','Apartment','3 BHK',85),(16,'Surat','Villa','4+ BHK',180),
(17,'Delhi','Apartment','3 BHK',110),(18,'Mumbai','Apartment','2 BHK',80),(19,'Bangalore','Apartment','2 BHK',55),(20,'Noida','Apartment','3 BHK',95),
(21,'Pune','Apartment','2 BHK',70),(22,'Mumbai','Apartment','3 BHK',100),(23,'Chennai','Apartment','3 BHK',85),(24,'Gurgaon','Apartment','3 BHK',115),
(25,'Bangalore','Apartment','2 BHK',65),(26,'Mumbai','Commercial','Office Space',180),(27,'Delhi','Apartment','3 BHK',130),(28,'Pune','Apartment','3 BHK',105),
(29,'Mumbai','Apartment','3 BHK',120),(30,'Bangalore','Apartment','2 BHK',50),(31,'Gurgaon','Apartment','3 BHK',140),(32,'Hyderabad','Apartment','3 BHK',90),
(33,'Mumbai','Villa','4+ BHK',220),(34,'Pune','Apartment','2 BHK',75),(35,'Delhi','Apartment','3 BHK',125),(36,'Bangalore','Apartment','3 BHK',95),
(37,'Mumbai','Apartment','2 BHK',85),(38,'Noida','Commercial','Office Space',160),(39,'Pune','Villa','3 BHK',150),(40,'Chennai','Apartment','2 BHK',55),
(41,'Bangalore','Apartment','2 BHK',60),(42,'Mumbai','Apartment','3 BHK',115),(43,'Delhi','Apartment','3 BHK',135),(44,'Gurgaon','Apartment','4+ BHK',180),
(45,'Pune','Apartment','2 BHK',70),(46,'Mumbai','Apartment','3 BHK',100),(47,'Bangalore','Apartment','3 BHK',110),(48,'Delhi','Apartment','3 BHK',140),
(49,'Mumbai','Apartment','3 BHK',125),(50,'Pune','Apartment','3 BHK',90);
