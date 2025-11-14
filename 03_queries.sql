-- 1. Display all employees along with their department names.
SELECT emp_id, emp_name,dept_name,salary 
FROM employee 
LEFT JOIN department 
ON employee.dept_id = department.dept_id;

-- 2. List employees who work in IT department and have salary > 55000.
SELECT * FROM employee
WHERE dept_id = (SELECT dept_id FROM department WHERE dept_name = 'IT') AND salary > 55000;

SELECT emp_id,emp_name,salary,dept_name 
FROM employee 
JOIN department 
ON employee.dept_id = department.dept_id 
WHERE salary > 55000 AND dept_name = 'IT';

-- 3. Show all projects handled by the Finance department.
SELECT * FROM project WHERE dept_id = (SELECT dept_id FROM department WHERE dept_name = 'Finance');

SELECT proj_name,dept_name 
FROM project 
JOIN department 
ON department.dept_id = project.dept_id 
WHERE dept_name = 'Finance';

-- 4. Find total salary paid in each department.
SELECT SUM(salary) AS Total_salary FROM employee WHERE dept_id = (SELECT dept_id FROM department WHERE dept_id = employee.dept_id) GROUP BY dept_id;

SELECT dept_name, SUM(salary) AS Total_salary
FROM employee 
JOIN department 
ON employee.dept_id = department.dept_id 
GROUP BY dept_name; 

-- 5. Show employee names and number of projects each employee is working on.
SELECT COUNT(proj_id) FROM project WHERE dept_id IN (SELECT dept_id FROM employee WHERE dept_id = project.dept_id) GROUP BY dept_id;

SELECT emp_name, COUNT(proj_name) 
FROM project 
JOIN employee 
ON employee.dept_id = project.dept_id 
GROUP BY emp_name;

-- 6. Find the average salary of employees in each department.
SELECT dept_id, AVG(salary) AS Avg_salary FROM employee e WHERE dept_id = (SELECT dept_id FROM department WHERE dept_id = e.dept_id) GROUP BY dept_id;

SELECT dept_name, AVG(salary) AS Avg_salary
FROM employee 
JOIN department 
ON employee.dept_id = department.dept_id 
GROUP BY dept_name;

-- 7. Display department names having average salary > 50000.
SELECT AVG(salary)AS Avg_salary FROM employee WHERE dept_id = (SELECT dept_id FROM department WHERE dept_id = employee.dept_id) GROUP BY dept_id HAVING AVG(salary)>50000;

SELECT dept_name, AVG(salary) AS Avg_salary
FROM employee 
JOIN department 
ON employee.dept_id = department.dept_id 
GROUP BY dept_name 
HAVING AVG(salary)>50000;

-- 8. Show employees who joined after year 2020.
SELECT emp_name, hire_date 
FROM employee 
WHERE hire_date >= '2020-01-01';

-- 9. List all employees from Delhi working on any project.
SELECT emp_name FROM employee WHERE dept_id = (SELECT dept_id FROM project WHERE dept_id = employee.dept_id AND city = 'Delhi');

SELECT emp_name,city,project.proj_name 
FROM employee 
JOIN project 
ON employee.dept_id = project.dept_id 
WHERE city = 'Delhi';

-- 10. Display employees who are not assigned to any project.
SELECT emp_name 
FROM employee
WHERE emp_id 
NOT IN (SELECT emp_id FROM project);

-- 11. Find employees who earn more than the average salary of the company.
SELECT emp_id,emp_name,salary 
FROM employee 
WHERE salary >(SELECT AVG(salary) FROM employee);

-- 12. Show the highest-paid employee in each department.
SELECT emp_name,salary, dept_name 
FROM employee 
JOIN department 
WHERE salary = (SELECT MAX(salary) 
FROM employee 
WHERE employee.dept_id = department.dept_id);

SELECT department.dept_name, MAX(employee.salary) AS Maximum
FROM employee 
JOIN department
ON employee.dept_id = department.dept_id
GROUP BY dept_name;

-- 13. Display employees working on projects with budget > 700000.
SELECT  emp_name, proj_name, budget
FROM employee
JOIN project 
ON employee.dept_id = project.dept_id
WHERE budget > 700000;

-- 14. Show project names where at least 2 employees are working.
SELECT proj_name, COUNT(emp_id)
FROM works_on
JOIN project
ON project.proj_id = works_on.proj_id
GROUP BY proj_name
HAVING COUNT(emp_id)>=2;

-- 15. Display employee(s) who have worked the maximum hours overall.
SELECT emp_id,MAX(hours_worked) FROM works_on WHERE emp_id = (SELECT emp_id FROM employee WHERE emp_id = works_on.emp_id)GROUP BY emp_id;

SELECT emp_id, hours_worked FROM works_on WHERE hours_worked = (SELECT MAX(hours_worked) FROM works_on );

SELECT MAX(hours_worked) FROM works_on JOIN employee ON employee.emp_id = works_on.emp_id;

-- 16. Show all employees whose salary is greater than Rohit’s salary.
SELECT * FROM employee WHERE salary > (SELECT salary FROM employee WHERE emp_name = 'Rohit');

-- 17. Find departments that have no projects assigned.
SELECT * FROM department WHERE dept_id NOT IN (SELECT dept_id FROM employee) ;

-- 18. Show the second-highest salary in each department.
SELECT dept_id, MAX(salary) AS second_highest_salary
FROM employee
WHERE salary < (SELECT MAX(salary) FROM employee)
GROUP BY dept_id;

-- 19. Display employees who work on the same project as ‘Amit’.
SELECT e.emp_id, e.emp_name, w.proj_id
FROM employee e
JOIN works_on w ON e.emp_id = w.emp_id
WHERE w.proj_id IN (SELECT proj_id FROM works_on WHERE emp_id = 103)
AND e.emp_id <> 103;

-- 20. List employees who work on both project 202 and 205.
SELECT * FROM works_on WHERE proj_id IN (202,205);

SELECT emp_name,proj_id, hours_worked FROM works_on JOIN employee ON employee.emp_id = works_on.emp_id WHERE proj_id IN (202,205);

-- 21. Find total hours worked by each employee on all projects.
SELECT emp_id,SUM(hours_worked) FROM works_on GROUP BY proj_id,emp_id;

SELECT emp_name, SUM(hours_worked) FROM works_ON
JOIN employee
ON employee.emp_id = works_on.emp_id
GROUP BY proj_id,emp_name;

-- 22. Display project names and total hours spent by employees.
SELECT proj_name,SUM(hours_worked) 
FROM project 
JOIN works_on
ON project.proj_id = works_on.proj_id 
GROUP BY proj_name;

-- 23. Show departments with more than 2 employees.
SELECT dept_id,COUNT(emp_id) FROM employee GROUP BY dept_id HAVING COUNT(emp_id)>2;

-- 24. Find employees who have worked more than 100 hours in total.
SELECT emp_id, SUM(hours_worked) FROM works_on GROUP BY emp_id HAVING SUM(hours_worked)>100;

-- 25. Show department name and total project budget handled by it.
SELECT dept_name, SUM(budget) FROM project RIGHT JOIN department ON department.dept_id = project.dept_id GROUP BY dept_name;

-- 26. Find employees who work on projects of their own department only.
SELECT e.emp_id, e.emp_name, e.dept_id
FROM employee e
JOIN works_on w ON e.emp_id = w.emp_id
JOIN project p ON w.proj_id = p.proj_id
WHERE e.dept_id = p.dept_id;

-- 27. List employees whose department has budget > 600000 in total.
SELECT dept_id ,budget FROM project WHERE dept_id IN (SELECT dept_id FROM department WHERE budget >600000);

-- 28. Display department name, total salary, and total hours worked (combine data from all 3 tables).
SELECT dept_name, hours_worked, SUM(salary) AS Total_hours FROM department, works_on, employee GROUP BY dept_name; 

-- 29. Find the top 3 highest-paid employees along with department names.
SELECT emp_name,dept_name,salary
FROM employee
JOIN department
ON department.dept_id = employee.dept_id
ORDER BY salary
DESC LIMIT 3;

-- 30. Display employees grouped by city, showing average salary per city.
SELECT city,AVG(salary)AS Avg_salary from employee GROUP BY city HAVING AVG(salary)>50000;



SELECT city,COUNT(emp_name) FROM employee GROUP BY city;





