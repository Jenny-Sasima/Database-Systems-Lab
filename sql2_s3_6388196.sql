-- 6388196 Sasima Srijanya Sec3 --

-- Part 2 (DML): insert, update, delete
USE tinycollege;
-- Q1
INSERT INTO Professor(EMP_NUM, EMP_FNAME, EMP_LNAME, EMP_DOB, DEPT_CODE)
VALUES (101, "Charles", "Xavier", "1975-05-04", "CIS");

-- Q2
INSERT INTO Professor
VALUES (702, "Stephen", "Strange", "1988-07-04", "BIOL", "7702");

-- Q3
INSERT INTO student
VALUES (773355, "Sasima", "Srijanya", "2002-05-25", "3", 3.53, "CIS", 702);

-- Q4
UPDATE student
SET EMP_NUM = 101
WHERE STU_NUM = 773355;

-- Q5
UPDATE professor
SET PROF_EXTENSION = "0077"
WHERE EMP_NUM = 101;

-- Q6
DELETE FROM professor 
WHERE EMP_NUM = 702;

-- Part 3 (DQL): select
-- Q7
SELECT *
FROM student;

-- Q8
SELECT EMP_FNAME AS emp_fname, EMP_LNAME AS emp_lname, DEPT_CODE AS dept_code
FROM professor
WHERE DEPT_CODE = "CIS";

-- Q9
SELECT EMP_FNAME AS emp_fname, EMP_LNAME AS emp_lname
FROM professor
WHERE EMP_FNAME LIKE "%M%" AND EMP_LNAME LIKE "%M%";

-- Q10
SELECT STU_FNAME AS stu_fname, STU_LNAME AS stu_lname, DEPT_CODE AS dept_code
FROM student
WHERE DEPT_CODE = "ENG" OR DEPT_CODE = "ART" OR DEPT_CODE = "SOC" OR DEPT_CODE = "HIST"
ORDER BY DEPT_CODE ASC;

-- Q11
SELECT COURSE_CODE AS course_code, COURSE_NAME AS course_name, CRS_CREDIT*250 AS "tuition fee", DEPT_CODE AS dept_code
FROM course
WHERE COURSE_NAME LIKE "%Intro%"
ORDER BY DEPT_CODE ASC;

-- Q12
SELECT DISTINCT COURSE_CODE AS course_code, CLASS_ROOM AS class_room
FROM class 
WHERE CLASS_ROOM LIKE "%KLR%" AND (CLASS_CODE BETWEEN "20000" AND "30000");
