-- QUERIES

-- List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT e.emp_no, e.last_name, e.first_name, s.salary 
FROM employee e, salaries s
WHERE s.emp_no = e.emp_no;

-- List employees who were hired in 1986.
SELECT first_name, last_name FROM employee WHERE hire_date >= '1986-01-01' and hire_date <= '1986-12-31';
--SELECT * FROM employee;

-- List the manager of each department with the following information: 
--department number, department name, 
--the manager's employee number, last name, first name, and start and end employment dates.
SELECT d.emp_no, e.last_name, e.first_name, d.from_date, d.to_date
FROM departmentmanager d, employee e
where d.emp_no = e.emp_no;
-- SELECT * FROM DepartmentManager;
-- SELECT * FROM employee;

-- List the department of each employee with the following information: 
-- employee number, last name, first name, and department name.
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM departmentemployee de, employee e, department d
WHERE de.emp_no = e.emp_no AND de.dept_no = d.dept_no;

-- List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * 
FROM employee
WHERE first_name = 'Hercules' 
AND last_name = 'B%'

-- List all employees in the Sales department,
-- including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employee e, department d
WHERE d.dept_name = 'Sales';

-- List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employee e, department d
WHERE d.dept_name = 'Sales' OR d.dept_name ='Development';

-- In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, 
COUNT(last_name) AS "last_name_freq" 
FROM employee
GROUP BY last_name 
ORDER BY "last_name_freq" DESC;


-- Testing Query for Average Salary by Title
SELECT * FROM titles;
SELECT * FROM salaries;

SELECT title, 
AVG(salary) AS "ave_salary" 
FROM titles t, salaries s
WHERE t.emp_no = s.emp_no
GROUP BY title
ORDER BY "ave_salary" DESC;

