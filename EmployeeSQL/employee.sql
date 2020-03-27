﻿-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/0rM3e0
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- Homework 9
-- Employee SQL
-- ER Diagram

SET XACT_ABORT ON

BEGIN TRANSACTION QUICKDBD

CREATE TABLE [Department] (
    [dept_no] VARCHAR(4)  NOT NULL ,
    [dept_name] VARCHAR(100)  NOT NULL ,
    CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED (
        [dept_no] ASC
    )
)

CREATE TABLE [DepartmentManager] (
    [dept_no] VARCHAR(4)  NOT NULL ,
    [emp_no] INT  NOT NULL ,
    [from_date] DATE  NOT NULL ,
    [to_date] DATE  NOT NULL 
)

CREATE TABLE [Employee] (
    [emp_no] INT  NOT NULL ,
    [birth_date] DATE  NOT NULL ,
    [first_name] VARCHAR  NOT NULL ,
    [last_name] VARCHAR  NOT NULL ,
    [gender] VARCHAR(1)  NOT NULL ,
    [hire_date] DATE  NOT NULL ,
    CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED (
        [emp_no] ASC
    )
)

CREATE TABLE [DepartmentEmployee] (
    [emp_no] INT  NOT NULL ,
    [dept_no] VARCHAR(4)  NOT NULL ,
    [from_date] DATE  NOT NULL ,
    [to_date] DATE  NOT NULL 
)

CREATE TABLE [Salaries] (
    [emp_no] INT  NOT NULL ,
    [salary] INT  NOT NULL ,
    [from_date] DATE  NOT NULL ,
    [to_date] DATE  NOT NULL 
)

CREATE TABLE [Titles] (
    [emp_no] INT  NOT NULL ,
    [title] VARCHAR(50)  NOT NULL ,
    [from_date] DATE  NOT NULL ,
    [to_date] DATE  NOT NULL 
)

ALTER TABLE [DepartmentManager] WITH CHECK ADD CONSTRAINT [FK_DepartmentManager_dept_no] FOREIGN KEY([dept_no])
REFERENCES [Department] ([dept_no])

ALTER TABLE [DepartmentManager] CHECK CONSTRAINT [FK_DepartmentManager_dept_no]

ALTER TABLE [DepartmentManager] WITH CHECK ADD CONSTRAINT [FK_DepartmentManager_emp_no] FOREIGN KEY([emp_no])
REFERENCES [Employee] ([emp_no])

ALTER TABLE [DepartmentManager] CHECK CONSTRAINT [FK_DepartmentManager_emp_no]

ALTER TABLE [DepartmentEmployee] WITH CHECK ADD CONSTRAINT [FK_DepartmentEmployee_emp_no] FOREIGN KEY([emp_no])
REFERENCES [Employee] ([emp_no])

ALTER TABLE [DepartmentEmployee] CHECK CONSTRAINT [FK_DepartmentEmployee_emp_no]

ALTER TABLE [DepartmentEmployee] WITH CHECK ADD CONSTRAINT [FK_DepartmentEmployee_dept_no] FOREIGN KEY([dept_no])
REFERENCES [Department] ([dept_no])

ALTER TABLE [DepartmentEmployee] CHECK CONSTRAINT [FK_DepartmentEmployee_dept_no]

ALTER TABLE [Salaries] WITH CHECK ADD CONSTRAINT [FK_Salaries_emp_no] FOREIGN KEY([emp_no])
REFERENCES [Employee] ([emp_no])

ALTER TABLE [Salaries] CHECK CONSTRAINT [FK_Salaries_emp_no]

ALTER TABLE [Titles] WITH CHECK ADD CONSTRAINT [FK_Titles_emp_no] FOREIGN KEY([emp_no])
REFERENCES [Employee] ([emp_no])

ALTER TABLE [Titles] CHECK CONSTRAINT [FK_Titles_emp_no]

COMMIT TRANSACTION QUICKDBD