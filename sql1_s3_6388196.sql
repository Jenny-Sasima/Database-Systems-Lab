/* --------------------------------------------------------------
--   Please fill in your information in this comment block --  
--   Student ID: 6388196
--   Fullname: Sasima Srijanya
--   Section: 3
------------------------------------------------------------- */
DROP DATABASE IF EXISTS tinycompany; 
CREATE DATABASE IF NOT EXISTS tinycompany;
USE tinycompany;

-- Department Table 
CREATE TABLE department(
	dnumber		INT 		 PRIMARY KEY,  -- dnumber is a primary key
	dname		VARCHAR(20)  NOT NULL,
	location	VARCHAR(100), -- location is nullable 
	CONSTRAINT chk_dnumber CHECK (dnumber >= 1 AND dnumber <=20 ) -- dnumber range from 1 to 20
);


-- Write your DDL the remaining tables here 
-- Hint: Review the CREATE sequence, i.e., which tables should be created first

-- Project Table
CREATE TABLE project(
	pnumber     INT          PRIMARY KEY,
    pname       VARCHAR(50)  NOT NULL,
    dept_no     INT,
    CONSTRAINT FK_DeptProj FOREIGN KEY (dept_no)
    REFERENCES department (dnumber)
);

-- Drop project Table
DROP TABLE project;

-- Employee Table
CREATE TABLE employee(
	fname     VARCHAR(20)     NOT NULL,
    lname     VARCHAR(20)     NOT NULL,
    ssn       CHAR(9)         PRIMARY KEY,
    bdate     DATE            NOT NULL,
    sex       CHAR(1)         NOT NULL,
    salary    DECIMAL(12, 2),
    dept_no   INT,
    CONSTRAINT CHK_Gender CHECK (sex in ('M', 'F')), -- sex need to be only M or F
    CONSTRAINT FK_EmpDept FOREIGN KEY (dept_no)
	REFERENCES department (dnumber)
);

-- Drop employee Table
DROP TABLE employee;

-- Assignment Table
CREATE TABLE assignment(
	essn         CHAR(9),
    proj_no      INT, 
    hours        DECIMAL(9, 2),
    hourly_rate  DECIMAL(9, 2),
    PRIMARY KEY (essn, proj_no), -- multiple primary key
    CONSTRAINT FK_AsmEmp FOREIGN KEY (essn)
	REFERENCES employee (ssn),
    CONSTRAINT FK_AsmPrj FOREIGN KEY (proj_no)
	REFERENCES project (pnumber)
);

-- Drop assignment Table
DROP TABLE assignment;