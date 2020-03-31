# SQL Homework - Employee Database: A Mystery in Two Parts

![sql.png](sql.png)

## Background

It is a beautiful spring day, and it is two weeks since you have been hired as a new data engineer at Pewlett Hackard. Your first major task is a research project on employees of the corporation from the 1980s and 1990s. All that remain of the database of employees from that period are six CSV files.

In this assignment, you will design the tables to hold data in the CSVs, import the CSVs into a SQL database, and answer questions about the data. In other words, you will perform:

#### 1. Data Modeling
After inspecting the CSV files and determining appropriate relationships bestween each of the six entities the following assumptions were made regarding the data. 
## Assumptions regarding the data
1. Each Employee has only one salary.
- As the number of rows is the same in both of these CSV files and using a general rule of thumb it is reasonable to conclude each employee has only one salary.
2. An employee can work across multiple Departments (e.g. Marketing and Sales)
3. An employee can have more than one title (e.g. CEO and VP of Research)
4. An employee can only manage one department, but a department can have more than one manager. 


After inspecting the CSV Data the next task was to sketch out an ERD of the tables. 

The following tool was used to create the ERD below [http://www.quickdatabasediagrams.com](http://www.quickdatabasediagrams.com).

![EmployeeDB_ERD.png](EmployeeDB_ERD.png)


#### 2. Data Engineering
A new table schema was created for each of the six CSV files. The following shows the SQL commands were used to specify data types, primary keys, foreign keys, and other constraints for *two tables* - the SQL commands to build all six tables can be found in the file _employee.sql_.


##### DEPARTMENT TABLE
```sql
-- Department Table
-- Contains Department Number, dept_no
-- and Department Name, dept_name
-- dept_no is Primary Key
CREATE TABLE Department (
    dept_no VARCHAR(4)   NOT NULL,
    dept_name VARCHAR(100)   NOT NULL,
    CONSTRAINT pk_Department PRIMARY KEY (dept_no)
);
```

##### EMPLOYEE TABLE
```sql
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
```

##### CONSTRAINTS
The following constraints were aded to establish FOREIGN KEYS and _Referential Integrity_ of the Database. 
```sql
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
```

Each CSV file was then imported into the corresponding SQL table to populate the tables. 

#### 3. Data Analysis
SQL code for the following queries are in queries.sql  - the first 5 records returned are shown here.  NOTE: Where appropriate the results were ordered. 


1. List the following details of each employee: employee number, last name, first name, gender, and salary.
![1.png](1.png)
2. List employees who were hired in 1986.
![2.png](2.png)
3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
![3.png](3.png)
4. List the department of each employee with the following information: employee number, last name, first name, and department name.
![4.png](4.png)
5. List all employees whose first name is "Hercules" and last names begin with "B."
![5.png](5.png)
6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
![6.png](6.png)
7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
![7.png](7.png)
8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
![8.png](8.png)

## Bonus (Optional)
The data appears artificial so the further analysis was necessary

1. The SQL database was imported the into Pandas using SQLAlchemy to create and connect an engine. 


   ```sql
   from sqlalchemy import create_engine
   engine = create_engine('postgresql://localhost:5432/<your_db_name>')
   connection = engine.connect()
   ```


* If using a password, do not upload your password to your GitHub repository. See [https://www.youtube.com/watch?v=2uaTPmNvH0I](https://www.youtube.com/watch?v=2uaTPmNvH0I) and [https://martin-thoma.com/configuration-files-in-python/](https://martin-thoma.com/configuration-files-in-python/) for more information.

2. Create a histogram to visualize the most common salary ranges for employees.
![SalaryHistogram.png](SalaryHistogram.png)

#### ANALYSIS
The histogram shows that the most common salary ranges are heavily skewed toward the lower range of salaries with most salaries falling below $50,000. 

3. Create a bar chart of average salary by title.

![SalaryByTitleDF.png](SalaryByTitleDF.png)
![SaalaryByTitle.png](SalaryByTitle.png)

#### ANALYSIS
The seems to be some anomolies in the expected salaries.  Upon inpecting the graph it can be seen that 


## Epilogue

Evidence in hand, you march into your boss's office and present the visualization. With a sly grin, your boss thanks you for your work. On your way out of the office, you hear the words, "Search your ID number." You look down at your badge to see that your employee ID number is 499942.

Upon searching the employeed ID number 499942 it is revealed that the entire process was an *APRIL FOOLS* prank.

![images/9.png](8.png)


### Copyright

Ann McNamara © 2020. All Rights Reserved.
