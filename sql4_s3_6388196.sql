-- Name: Sasima Srijanya
-- Student ID: 6388196
-- Section: 3

-- Assignment 4
USE tinycollege;

-- Q1)
SELECT cl.CLASS_CODE AS class_code, COURSE_NAME AS course_name, EMP_FNAME AS emp_fname, EMP_LNAME AS emp_lname, COUNT(e.class_code)
FROM class cl
JOIN course co ON cl.COURSE_CODE = co.COURSE_CODE
JOIN professor p ON cl.EMP_NUM = p.EMP_NUM
JOIN enroll e ON cl.CLASS_CODE = e.CLASS_CODE
WHERE CLASS_SECTION = 3
GROUP BY e.class_code;

-- Q2)
SELECT CLASS_CODE AS class_code, COURSE_NAME AS course_name
FROM class cl
JOIN course co ON cl.COURSE_CODE = co.COURSE_CODE
WHERE class_code NOT IN (SELECT DISTINCT CLASS_CODE FROM enroll)
ORDER BY class_code ASC;

-- Q3)
SELECT STU_FNAME AS "first name", STU_LNAME AS "last name", STU_NUM AS ID FROM student
WHERE STU_FNAME LIKE "C%"
UNION
SELECT EMP_FNAME AS "first name", EMP_LNAME AS "last name", EMP_NUM AS ID FROM professor
WHERE EMP_FNAME LIKE "C%";

-- Q4)
SELECT DISTINCT COURSE_CODE AS course_code
FROM class c1
WHERE CLASS_SECTION = 1 AND course_code NOT IN (SELECT COURSE_CODE AS course_code FROM class WHERE CLASS_SECTION = 2) 
ORDER BY course_code;

-- Q5)
SELECT DISTINCT STU_FNAME AS stu_fname
FROM student
WHERE STU_FNAME IN (SELECT EMP_FNAME FROM professor)
ORDER BY stu_fname;

-- Q6)
SELECT STU_FNAME AS stu_fname, STU_LNAME AS stu_lname, STU_GPA AS stu_gpa
FROM student
WHERE stu_gpa > (SELECT AVG(STU_GPA) FROM student WHERE DEPT_CODE = "MATH")
ORDER BY stu_gpa DESC;

-- Q7)
CREATE VIEW vw_topstudents AS
SELECT STU_NUM AS stu_num, STU_FNAME AS stu_fname, STU_LNAME AS stu_lname, STU_GPA AS stu_gpa, DEPT_CODE AS dept_code
FROM student s1
WHERE stu_gpa = (SELECT MAX(STU_GPA) FROM student s2 WHERE s1.STU_NUM = s2.STU_NUM)
GROUP BY dept_code
ORDER BY DEPT_CODE;

-- Delete view
DROP VIEW vw_topstudents;

-- Call view
SELECT * FROM vw_topstudents;




