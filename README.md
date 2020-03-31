# SQL Homework - Employee Database: A Mystery in Two Parts

## Background
This assignment designs the tables to hold data in six CSV files, imports the CSVs into a SQL database, and answer questions about the data.

#### 1. Data Modeling
##### Data Inspection
After inspecting the CSV files and determining appropriate relationships bestween each of the six entities the following assumptions were made regarding the data. 
## Assumptions regarding the data
1. Each Employee has only one salary.
- As the number of rows is the same in both of these CSV files and using a general rule of thumb it is reasonable to conclude each employee has only one salary.
2. An employee can work across multiple Departments (e.g. Marketing and Sales)
3. An employee can have more than one title (e.g. CEO and VP of Research)
4. An employee can only manage one department, but a department can have more than one manager. 

##### Entity Relationship Diagram
After inspecting the CSV Data the next task was to sketch out an ERD of the tables. 

The following tool was used to create the ERD below [http://www.quickdatabasediagrams.com](http://www.quickdatabasediagrams.com).

![EmployeeDB_ERD.png](EmployeeDB_ERD.png)

#### 2. Data Engineering
A new table schema was created for each of the six CSV files. The following shows the SQL commands were used to specify data types, primary keys, foreign keys, and other constraints for *two tables* - the SQL commands to build all six tables can be found in the file _EmployeeSQL/employee.sql_.

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
SQL code for the following queries are in in the file EmployeeSQL/employee.sql  - the first five records returned are shown here.  NOTE: Where appropriate the results were ordered. 

1. List the following details of each employee: employee number, last name, first name, gender, and salary.

<img src="./images/1.png" alt="drawing" width="700"/>

2. List employees who were hired in 1986.

<img src="./images/2.png" alt="drawing" width="500"/>

3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.

<img src="./images/3.png" alt="drawing" width="900"/>

4. List the department of each employee with the following information: employee number, last name, first name, and department name.

<img src="./images/4.png" alt="drawing" width="600"/>

5. List all employees whose first name is "Hercules" and last names begin with "B."

<img src="./images/5.png" alt="drawing" width="800"/>

6. List all employees in the Sales department, including their employee number, last name, first name, and department name.

<img src="./images/6.png" alt="drawing" width="700"/>

7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

<img src="./images/7.png" alt="drawing" width="700"/>

8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

<img src="./images/8.png" alt="drawing" width="300"/>

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
![SalaryHistogram.png](images/salaryRanges.png)

#### ANALYSIS
The histogram shows that the most common salary ranges are heavily skewed toward the lower range of salaries with most salaries falling below $50,000. 

3. Create a bar chart of average salary by title.

![SalaryByTitledf.png](images/SalaryByTitledf.png)
![SalaryByTitle.png](images/SalaryByTitle.png)

#### ANALYSIS
The seems to be some anomolies in the expected salaries.  Upon inpecting the graph it can be seen that 


## Epilogue
Suspecting the data is artifical the visualization is presented to the boss, who tells you to search your ID number (49942) 

Upon searching the employeed ID number 499942 it is revealed that the entire process was an *APRIL FOOLS* prank.  This explains the salary distribution. 

![images/9.png](images/9.png)


### Copyright

Ann McNamara © 2020. All Rights Reserved.
