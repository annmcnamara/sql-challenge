-- Employee Database

-- Department Table
-- Contains Department Number, dept_no
-- and Department Name, dept_name
-- dept_no is Primary Key
CREATE TABLE Department (
    dept_no VARCHAR(4)   NOT NULL,
    dept_name VARCHAR(100)   NOT NULL,
    CONSTRAINT pk_Department PRIMARY KEY (dept_no)
);

-- DepartmentManager Table
-- Contains Department Number, dept_no
-- Employee Number, emp_no
-- and from_date and to_date
-- (dept_no, emp_no )is Primary Key
CREATE TABLE DepartmentManager (
    dept_no VARCHAR(4)   NOT NULL,
    emp_no INT   NOT NULL,
    from_date DATE   NOT NULL,
    to_date DATE   NOT NULL,
    CONSTRAINT pk_DepartmentManager PRIMARY KEY (dept_no,emp_no)
);


-- DepartmentManager Table
-- Contains Department Number, dept_no
-- Employee Number, emp_no
-- Employee birth date, birth_date
-- Employee first name, first_name
-- Employee last name, last_name
-- Employee gender, gender
-- Hire date, hire_date
-- (emp_no)is Primary Key
CREATE TABLE Employee (
    emp_no INT   NOT NULL,
    birth_date DATE   NOT NULL,
    first_name VARCHAR   NOT NULL,
    last_name VARCHAR   NOT NULL,
    gender VARCHAR(1)   NOT NULL,
    hire_date DATE   NOT NULL,
    CONSTRAINT pk_Employee PRIMARY KEY (emp_no)
);

CREATE TABLE DepartmentEmployee (
    emp_no INT   NOT NULL,
    dept_no VARCHAR(4)   NOT NULL,
    from_date DATE   NOT NULL,
    to_date DATE   NOT NULL,
    CONSTRAINT pk_DepartmentEmployee PRIMARY KEY (
        emp_no,dept_no
     )
);

CREATE TABLE Salaries (
    emp_no INT   NOT NULL,
    salary INT   NOT NULL,
    from_date DATE   NOT NULL,
    to_date DATE   NOT NULL,
    CONSTRAINT pk_Salaries PRIMARY KEY (
        emp_no
     )
);

CREATE TABLE Titles (
    emp_no INT   NOT NULL,
    title VARCHAR(50)   NOT NULL,
    from_date DATE   NOT NULL,
    to_date DATE   NOT NULL
);

ALTER TABLE DepartmentManager ADD CONSTRAINT fk_DepartmentManager_dept_no FOREIGN KEY(dept_no)
REFERENCES Department (dept_no);

ALTER TABLE DepartmentManager ADD CONSTRAINT fk_DepartmentManager_emp_no FOREIGN KEY(emp_no)
REFERENCES Employee (emp_no);

ALTER TABLE DepartmentEmployee ADD CONSTRAINT fk_DepartmentEmployee_emp_no FOREIGN KEY(emp_no)
REFERENCES Employee (emp_no);

ALTER TABLE DepartmentEmployee ADD CONSTRAINT fk_DepartmentEmployee_dept_no FOREIGN KEY(dept_no)
REFERENCES Department (dept_no);

ALTER TABLE Salaries ADD CONSTRAINT fk_Salaries_emp_no FOREIGN KEY(emp_no)
REFERENCES Employee (emp_no);

ALTER TABLE Titles ADD CONSTRAINT fk_Titles_emp_no FOREIGN KEY(emp_no)
REFERENCES Employee (emp_no);

--Select * from each table
SELECT * FROM Employee;
SELECT * FROM Department;
SELECT * FROM DepartmentManager;
SELECT * FROM DepartmentEmployee;
SELECT * FROM Titles;
SELECT * FROM Salaries;

--SELECT COUNT(emp_no) FROM salaries;
--SELECT COUNT(emp_no) FROM employee;

-- QUERIES
-- 1
-- List the following details of each employee: 
-- employee number, last name, first name, gender, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM employee e, salaries s
WHERE s.emp_no = e.emp_no
ORDER BY e.emp_no;

-- 2
-- List employees who were hired in 1986.
SELECT first_name, last_name, hire_date 
FROM employee 
WHERE hire_date >= '1986-01-01' AND hire_date <= '1986-12-31'
ORDER BY hire_date;
--SELECT * FROM employee;
-- SELECT
-- 	MIN(employee.hire_date) AS "MIN_HIRE_DATE",
-- 	MAX(employee.hire_date) AS "MAX_HIRE_DATE"
-- FROM employee
-- WHERE employee.hire_date BETWEEN '1986-01-01' AND '1986-12-31'

-- 3
-- List the manager of each department with the following information:
-- department number, department name,
-- the manager's employee number, last name, first name, and start and end employment dates.
SELECT d.dept_no, dp.dept_name, d.emp_no, e.last_name, e.first_name, d.from_date, d.to_date
FROM departmentmanager d, employee e, department dp
where d.emp_no = e.emp_no and d.dept_no = dp.dept_no;
-- SELECT * FROM DepartmentManager;
-- SELECT * FROM employee;
-- Count is 24 so gives confidence query is okay

-- 4
-- List the department of each employee with the following information:
-- employee number, last name, first name, and department name.
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM departmentemployee de, employee e, department d
WHERE de.emp_no = e.emp_no AND de.dept_no = d.dept_no
ORDER BY e.emp_no;

-- SELECT
-- COUNT(employee.emp_no)
-- FROM departmentemployee 
-- JOIN department ON
-- 	department.dept_no = DepartmentEmployee.dept_no
-- JOIN employee ON
-- 	employee.emp_no = departmentemployee.emp_no
-- ;

-- 5
-- List all employees whose first name is "Hercules" and last names begin with "B."
-- returns 20 rows 
-- ordering by last_name gives us an ordered result
SELECT *
FROM employee
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%'
ORDER BY last_name;

-- 6
-- List all employees in the Sales department, 
-- including their employee number, last name, first name, and department name.
-- 52245 rows returned
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM departmentemployee de
JOIN employee e
ON (e.emp_no = de.emp_no)
JOIN department d
ON (d.dept_no = de.dept_no)
WHERE d.dept_name = 'Sales';

-- 7
-- List all employees in the Sales and Development departments, 
-- including their employee number, last name, first name, and department name.
-- Development - 85707
-- Total -- 137952
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM departmentemployee de
JOIN employee e
ON (e.emp_no = de.emp_no)
JOIN department d
ON (d.dept_no = de.dept_no)
WHERE d.dept_name = 'Development' OR d.dept_name = 'Sales';

-- 8
-- In descending order, list the frequency count of employee last names, i.e., 
-- how many employees share each last name.
SELECT last_name,
COUNT(last_name) AS "last_name_freq"
FROM employee
GROUP BY last_name
ORDER BY "last_name_freq" DESC;

-- Epilogue
-- Get data for emp_no 499942
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name, s.salary, t.title
FROM departmentemployee de
JOIN employee e
ON (e.emp_no = de.emp_no)
JOIN department d
ON (d.dept_no = de.dept_no)
JOIN salaries s
ON (s.emp_no = e.emp_no)
JOIN titles t
ON (t.emp_no = e.emp_no)
WHERE e.emp_no = 499942
