CREATE TABLE department(
dept_id INT PRIMARY KEY,
dept_name VARCHAR(50)
);

INSERT INTO department VALUES
(1,'HR'),
(2,'Finance'),
(3,'IT'),
(4,'Marketing');

CREATE TABLE employee (
emp_id INT PRIMARY KEY,
emp_name VARCHAR(50),
dept_id INT,
salary INT,
hire_date DATE,
city VARCHAR(50),
FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

INSERT INTO employee VALUES
(101,'Rohit', 3, 60000,'2020-04-12','Delhi'),
(102,'Sneha', 1, 45000,'2019-09-15','Mumbai'),
(103,'Amit', 2, 55000,'2021-06-20','Delhi'),
(104,'Neha', 3, 72000,'2018-11-30','Pune'),
(105,'Vikas', 4, 38000,'2022-03-05','Delhi'),
(106,'Priya', 1, 48000,'2021-07-11','Chandigarh'),
(107,'Ankit', 3, 53000,'2023-01-19','Noida'),
(108,'Kiran', 4, 41000,'2020-05-22','Pune'),
(109,'Manish', 2, 64000,'2022-12-10','Delhi'),
(110,'Deepika', 3, 58000,'2019-02-25','Chandigarh');

CREATE TABLE project (
proj_id INT PRIMARY KEY,
proj_name VARCHAR(50),
dept_id INT,
budget INT,
FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

INSERT INTO project VALUES
(201,'Payroll System', 2, 800000),
(202,'Website Revamp', 3, 600000),
(203,'Recruitment Portal', 1, 400000),
(204,'Ad Campaign', 4, 300000),
(205,'Cloud Migration', 3, 900000);

CREATE TABLE works_on (
emp_id INT,
proj_id INT,
hours_worked INT,
FOREIGN KEY (emp_id) REFERENCES employee(emp_id),
FOREIGN KEY (proj_id) REFERENCES project(proj_id)
);

INSERT INTO works_on VALUES
(101, 202, 120),
(101, 205, 100),
(102, 203, 150),
(103, 201, 80),
(104, 205, 200),
(105, 204, 90),
(106, 203, 60),
(107, 202, 70),
(108, 204, 110),
(109, 201, 130),
(110, 202, 85);

SELECT * FROM works_on;
SELECT * FROM project;

