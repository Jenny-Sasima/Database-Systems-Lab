use tinycollege;

-- Q41
select emp_num, lower(concat(emp_fname, ".", substring(emp_lname, 1, 3), "@tinycollege.edu")) as email
from professor
where dept_code = "ACCT";

-- Q42
select * from student
where monthname(stu_dob) = "November"
order by dept_code asc;

-- Q43
select * from student
where dayofweek(stu_dob) = 5
order by dept_code asc;

-- Q44
select emp_fname, emp_lname, year(curdate()) - year(emp_dob) as age
from professor
group by emp_num
having age > 75;

-- Q45
select year(curdate()) - year(stu_dob) as age
from student
order by age desc
limit 1;

-- Q46
select round(avg(stu_gpa), 2) as AvgGPA from student
where stu_class = 2;

-- Q47
select stu_class, round(avg(stu_gpa), 2) as avgGPA
from student
group by stu_class
order by stu_class asc;

-- Q48
select dept_code, round(avg(stu_gpa), 2) as avgGPA
from student
group by dept_code
order by dept_code;

-- Q49
select stu_class, count(stu_num) as num_stu
from student
group by stu_class
order by stu_class;

-- Q50
select stu_class, concat("[", min(stu_gpa), ", ", max(stu_gpa), "]") as gpa_range
from student
group by stu_class
order by stu_class;

-- Q51
select dept_code, count(stu_num) as num_stu
from student
group by dept_code
order by dept_code;

-- Q52
select dept_code, count(emp_num) as num_prof
from professor
group by dept_code
having num_prof >= 2
order by num_prof asc;

-- Q53
select dept_code, count(stu_num) as num_stu
from student
where stu_gpa >= 3.00
group by dept_code
having num_stu > 1;

-- Q54
select course_code, count(class_code) as num_class
from class
group by course_code
having num_class > 2;

-- Q55
select dept_code, count(course_code) as num_course
from course
group by dept_code
having num_course = 1;

-- Q56
select emp_fname, emp_lname, p.dept_code, dept_name, dept_address
from professor as p inner join department as d on p.dept_code = d.dept_code
limit 8;

-- Q57
select stu_fname, stu_lname, class_code
from student as s inner join enroll as e on s.stu_num = e.stu_num
where grade = "A" and dept_code = "CIS"
order by stu_fname asc;

-- Q58
select stu_fname, stu_lname, count(class_code) as num_gradeA
from student as s inner join enroll as e on s.stu_num = e.stu_num
where grade = "A" and dept_code = "CIS"
group by s.stu_num
order by stu_fname;

-- Q59
select emp_fname, emp_lname, count(stu_num) as num_advisee
from professor as p inner join student as s on p.emp_num = s.emp_num
group by p.emp_num
having num_advisee > 3
order by emp_fname;

-- Q60
select emp_fname, emp_lname, count(cl.class_code) as num_class
from professor as p 
inner join class as cl on p.emp_num = cl.emp_num
inner join course as co on cl.course_code = co.course_code
where crs_credit = 3
group by p.emp_num
having num_class > 3;

-- Q61
select class_code, cl.course_code, course_name, class_time
from class as cl inner join course as co on cl.course_code = co.course_code
where course_name like "Intro%" and class_section = 1 and dept_code = "CIS";

-- Q62
select 
	d.dept_code,
    dept_name,
    count(distinct p.emp_num) as num_prof,
    count(distinct stu_num) as num_stu,
	round(count(distinct stu_num) / count(distinct p.emp_num), 2) as stuprof_ratio
from department as d
inner join student as s on d.dept_code = s.dept_code
inner join professor as p on d.dept_code = p.dept_code
group by d.dept_code
order by d.dept_code;
    
-- Q63
select d.dept_code, dept_name, concat(emp_fname, " ", emp_lname) as head_dept
from department as d inner join professor as p on d.emp_num = p.emp_num;

-- Q64
select 
	s.stu_num, 
	stu_fname, 
	stu_lname, 
	count(class_code) as total_class, 
	sum(credit) as total_credit
from student as s inner join enroll as e on s.stu_num = e.stu_num
group by s.stu_num
having total_class >= 6 or total_credit >= 18
order by stu_num asc;