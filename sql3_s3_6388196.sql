-- Name: Sasima Srijanya
-- Student ID: 6388196
-- Section: 3

-- Assignment SQL Part 3
USE tinycollege;

-- Q1
SELECT CONCAT(EMP_FNAME, " ", EMP_LNAME) AS Name, (YEAR(CURRENT_DATE()) - YEAR(EMP_DOB)) AS Age
FROM professor
ORDER BY Age Desc
LIMIT 10;

-- Q2
SELECT ROUND(AVG(STU_GPA), 2) AS "Average CIS GPA"
FROM student
WHERE DEPT_CODE = "CIS";

-- Q3
SELECT COUNT(COURSE_NAME) AS "# of Courses"
FROM course
WHERE CRS_CREDIT = 3 AND DEPT_CODE in ("CIS", "MATH", "BIOL", "ENG");

-- Q4
SELECT DEPT_CODE AS dept_code, COUNT(DEPT_CODE) AS "Total # of Students"
FROM student
WHERE DEPT_CODE in ("CIS", "MATH", "BIOL", "ENG")
GROUP BY DEPT_CODE;

-- Q5
SELECT d.DEPT_CODE AS dept_code, ROUND(AVG(s.STU_GPA), 2) AS "Average GPA"
FROM department d
INNER JOIN student s on d.DEPT_CODE = s.DEPT_CODE
GROUP BY DEPT_CODE
ORDER BY ROUND(AVG(s.STU_GPA), 2) DESC;

-- Q6
SELECT d.DEPT_CODE AS dept_code, ROUND(AVG(s.STU_GPA), 2) AS "Average GPA"
FROM department d
INNER JOIN student s on d.DEPT_CODE = s.DEPT_CODE
GROUP BY DEPT_CODE
HAVING ROUND(AVG(s.STU_GPA), 2) > 3.00
ORDER BY ROUND(AVG(s.STU_GPA), 2) DESC;

-- Q7
SELECT STU_CLASS AS stu_class, COUNT(STU_GPA) AS "Total students with GPA", ROUND(AVG(STU_GPA), 2) AS "Average class GPA"
FROM student 
GROUP BY STU_CLASS
ORDER BY STU_CLASS ASC;

-- Q8
SELECT STU_NUM AS stu_num, CONCAT(STU_FNAME, " ", STU_LNAME) AS student, CONCAT(EMP_FNAME, " ", EMP_LNAME) AS advisor
FROM student s
INNER JOIN professor p on s.EMP_NUM = p.EMP_NUM
WHERE EMP_FNAME like "A%" OR EMP_FNAME like "P%"
ORDER BY advisor ASC;

-- Q9
SELECT p.EMP_NUM AS emp_num, DEPT_CODE AS dept_code, CONCAT(EMP_FNAME, " ", EMP_LNAME) AS professor, COUNT(COURSE_CODE) AS "Total classes"
FROM professor p
INNER JOIN class c on p.emp_num = c.emp_num
WHERE p.DEPT_CODE in ("CIS")
GROUP BY professor
HAVING COUNT(COURSE_CODE) >= 3;

-- Q10
SELECT DISTINCT STU_FNAME AS stu_fname, STU_LNAME AS stu_lname, c.CLASS_CODE AS class_code, e.GRADE AS grade, c.COURSE_CODE AS course_code
FROM class c
INNER JOIN enroll e on c.CLASS_CODE = e.CLASS_CODE
INNER JOIN student s on e.STU_NUM = s.STU_NUM
WHERE c.COURSE_CODE like "CIS-___"
ORDER BY c.COURSE_CODE, GRADE ASC;
