-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/0rM3e0
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE Department (
    dept_no VARCHAR(4)   NOT NULL,
    dept_name VARCHAR(100)   NOT NULL,
    CONSTRAINT pk_Department PRIMARY KEY (
        dept_no
     )
);

CREATE TABLE DepartmentManager (
    dept_no VARCHAR(4)   NOT NULL,
    emp_no INT   NOT NULL,
    from_date DATE   NOT NULL,
    to_date DATE   NOT NULL,
    CONSTRAINT pk_DepartmentManager PRIMARY KEY (
        dept_no,emp_no
     )
);

CREATE TABLE Employee (
    emp_no INT   NOT NULL,
    birth_date DATE   NOT NULL,
    first_name VARCHAR   NOT NULL,
    last_name VARCHAR   NOT NULL,
    gender VARCHAR(1)   NOT NULL,
    hire_date DATE   NOT NULL,
    CONSTRAINT pk_Employee PRIMARY KEY (
        emp_no
     )
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
SELECT d.dept_no, dp.dept_name, d.emp_no, e.last_name, e.first_name, d.from_date, d.to_date
FROM departmentmanager d, employee e, department dp
where d.emp_no = e.emp_no and d.dept_no = dp.dept_no;
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
AND last_name LIKE 'B%'

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



