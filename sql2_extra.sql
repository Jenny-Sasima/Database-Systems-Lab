use tinycollege;

-- Q1
select * from professor;

-- Q2
select * from department;

-- Q3
select stu_fname, stu_lname from student;

-- Q4
select stu_fname as Firstname, stu_lname as Lastname from student;

-- Q5
select distinct course_code from class;

-- Q6
select distinct course_code, class_room from class;

-- Q7
select course_code, crs_credit from course;

-- Q8
select class_code, course_code, class_room, class_time from class;

-- Q9
select distinct class_room, course_code from class
limit 5;

-- Q10
select distinct emp_num, course_code from class;

-- Q11
select emp_fname as Firstname, emp_lname as Lastname, emp_dob as DoB
from professor
limit 10;

-- Q12
select emp_fname as Firstname, emp_lname as Lastname, year(emp_dob) as Birthyear
from professor
limit 10;

-- Q13
select emp_fname as Firstname, emp_lname as Lastname, 2021 - year(emp_dob) as DoB
from professor
limit 10;

-- Q14
select * from course
order by crs_credit asc;

-- Q15
select stu_fname, stu_lname, stu_gpa from student
order by stu_gpa desc
limit 3;

-- Q16
select stu_fname, stu_lname, stu_gpa from student
where stu_gpa >= 3.50;

-- Q17
select stu_fname, stu_lname, stu_gpa from student
where stu_gpa >= 3.25 and stu_gpa < 3.5;

-- Q18
select stu_fname, stu_lname, stu_gpa from student
where stu_gpa >= 1.50 and stu_gpa < 1.8;

-- Q19
select stu_fname, stu_lname, stu_gpa from student
where stu_gpa >= 1.80 and stu_gpa < 2.00;

-- Q20
select stu_fname, stu_lname from student
where stu_gpa is null;

-- Q21
select stu_fname, stu_lname from student
where year(stu_dob) between 1970 and 1979;

-- Q22
select distinct dept_code from professor
order by dept_code asc;

-- Q23
select * from student
where emp_num = 209;

-- Q24
select emp_fname, emp_lname, dept_code from professor
where dept_code in ("CIS", "MATH")
order by dept_code asc;

-- Q25
select * from student 
where dept_code = "CIS" and stu_fname like "A%";

-- Q26
select * from student
where stu_lname like "%son";

-- Q27
select * from course
where course_name like "Intro%";

-- Q28
select * from course
where course_name not like "Intro%";

-- Q29
select * from course
where dept_code in ("ACCT", "ECON/FIN", "MKT/MGT");

-- Q30
select * from course
where course_code like "%3__"
order by dept_code asc;

-- Q31
select class_code, course_code, class_time from class
where class_section = 2 and class_time like "MWF%";

-- Q32
select class_code, course_code, class_time from class
where class_section = 1 and class_time like "%10:00-10:50 a.m.%";

-- Q33
select class_code, course_code, class_time from class
where class_section = 3 and class_time like "%p.m.";

-- Q34
select * from class
where emp_num like "1_5"
order by emp_num asc;

-- Q35
select course_code, course_name, dept_code from course
where dept_code in ("CIS", "MATH", "ENG")
order by dept_code asc;

-- Q36
select course_code, course_name, dept_code from course
where course_name like "%Application%";

-- Q37
select dept_name, dept_address from department
where dept_address like "BBG%";

-- Q38
select dept_name, dept_address from department
where dept_address not like "BBG%" and dept_address not like "KLR%";

-- Q39
select class_code, course_code, emp_num from class
where emp_num in (104, 105, 106, 155)
order by emp_num asc;

-- Q40
select emp_num, course_code, class_time from class
where class_time like "MWF%" and class_room like "KLR%" and course_code like "%3__";



