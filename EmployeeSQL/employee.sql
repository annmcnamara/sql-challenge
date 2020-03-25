-- Homework 9
-- Employee SQL

CREATE TABLE Department (
    dept_no VARCHAR  NOT NULL,
    dept_name VARCHAR(30)   NOT NULL,
	 CONSTRAINT pk_Department PRIMARY KEY (
        dept_no
     )
);

CREATE TABLE DepartmentManager (
    dept_no VARCHAR   NOT NULL,
    emp_no int   NOT NULL,
    from_date DATE   NOT NULL,
    to_date DATE   NOT NULL
);

CREATE TABLE Employee (
    emp_no int   NOT NULL,
    birth_date DATE   NOT NULL,
    first_name VARCHAR(30)   NOT NULL,
    last_name VARCHAR(30)   NOT NULL,
    gender VARCHAR(1)   NOT NULL,
    hire_date DATE   NOT NULL,
    CONSTRAINT pk_Employee PRIMARY KEY (
        emp_no
     )
);

CREATE TABLE DepartmentEmployee (
    emp_no int   NOT NULL,
    dept_no VARCHAR   NOT NULL,
    from_date DATE   NOT NULL,
    to_date DATE   NOT NULL
);

CREATE TABLE Salaries (
    emp_no int   NOT NULL,
    salary int   NOT NULL,
    from_date DATE   NOT NULL,
    to_date DATE   NOT NULL
);

CREATE TABLE Titles (
    emp_no int   NOT NULL,
    title VARCHAR(30)   NOT NULL,
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

CREATE INDEX idx_Department_dept_no
ON Department (dept_no);

CREATE INDEX idx_DepartmentManager_dept_no
ON DepartmentManager (dept_no);

CREATE INDEX idx_DepartmentManager_emp_no
ON DepartmentManager (emp_no);

CREATE INDEX idx_DepartmentEmployee_emp_no
ON DepartmentEmployee (emp_no);

CREATE INDEX idx_DepartmentEmployee_dept_no
ON DepartmentEmployee (dept_no);

CREATE INDEX idx_Salaries_emp_no
ON Salaries (emp_no);

CREATE INDEX idx_Titles_emp_no
ON Titles (emp_no);

SELECT * FROM Department;
SELECT * FROM Employee;
SELECT * FROM Titles;
SELECT * FROM Salaries;
SELECT * FROM DepartmentManager;
SELECT * FROM DepartmentEmployee;

--List the following details of each employee: employee number, last name, first name, gender, and salary.
-- Perform an INNER JOIN on the two tables
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM employee AS e
INNER JOIN salaries AS s ON
e.emp_no = s.emp_no

--List employees who were hired in 1986.
SELECT e.emp_no, e.last_name, e.first_name, e.hire_date
FROM employee as e
WHERE e.hire_date >= '1986-01-01' and e.hire_date < '1986-12-31'

--List the manager of each department with the following information: 
--department number, department name, the manager's employee number,
--last name, first name, and start and end employment dates.
SELECT * FROM DepartmentManager;
SELECT m.dept_no, d.dept_name, m.emp_no, e.last_name, e.first_name, m.from_date, m.to_date
FROM DepartmentManager as m, employee as e, department as d
WHERE m.emp_no = e.emp_no and m.dept_no = d.dept_no

--List the department of each employee with the following information:
-- employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employee as e, department as d, DepartmentEmployee as de
WHERE de.dept_no = d.dept_no and de.emp_no = e.emp_no