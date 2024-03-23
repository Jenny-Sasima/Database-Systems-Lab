use tinycollege;

-- Q65
select emp_fname, emp_lname, p.dept_code, dept_name
from professor p inner join department d on p.dept_code = d.dept_code 
where p.emp_num <> 209 and p.dept_code in (
	select dept_code from professor where emp_num = 209
);

SELECT emp_fname, emp_lname, p.dept_code, dept_name
FROM professor p
JOIN department d ON p.dept_code = d.dept_code
WHERE p.emp_num != 209 AND p.dept_code IN (SELECT dept_code FROM professor WHERE EMP_NUM = 209);
-- exclude employee id 209

-- Q66
select fname, count(fname) as num_used from (
	select stu_fname as fname from student
    union all
    select emp_fname as fname from professor
) as temp
group by fname 
having num_used > 1
order by fname asc;

SELECT fname, COUNT(fname) AS num_used 
FROM (SELECT EMP_FNAME AS fname FROM professor UNION ALL SELECT STU_FNAME AS fname FROM student) temp -- All name from student and professor
GROUP BY fname
HAVING num_used >= 2
ORDER BY fname;

-- Q67
select co.course_code, course_name, count(cl.class_code) as num_class
from course co 
left outer join class cl on co.course_code = cl.course_code
group by co.course_code
having num_class = 0;

SELECT co.course_code, course_name, COUNT(cl.course_code) AS num_class
FROM course co
LEFT JOIN class cl ON co.course_code = cl.course_code -- don't have class offer
GROUP BY co.course_code
HAVING num_class = 0;

-- Q68
select emp_fname, emp_lname, year(curdate()) - year(emp_dob) as age from professor
where year(curdate()) - year(emp_dob) < (
	select avg(year(curdate()) - year(emp_dob)) from professor
)
order by age;

SELECT emp_fname, emp_lname, (YEAR(curdate()) - YEAR(EMP_DOB)) AS age
FROM professor
HAVING age < (SELECT AVG(YEAR(curdate()) - YEAR(EMP_DOB)) FROM professor) -- age below average
ORDER BY age;

-- Q69
select stu_num, stu_fname, stu_lname from student
where stu_num not in (
	select stu_num from enroll
)
order by stu_num;

SELECT s.stu_num, stu_fname, stu_lname
FROM student s
WHERE stu_num NOT IN (SELECT stu_num FROM enroll) -- student not enroll
ORDER BY stu_num;

-- Q70
select course_name from course
where course_code not in (
	select distinct course_code from class
);

SELECT course_name
FROM course 
WHERE course_code NOT IN (SELECT course_code FROM class); -- course dont have any class

-- Q71
select 
	concat(emp_fname, " ", emp_lname) as fullname,
    count(class_code) as num_classes
from professor p
left outer join class c on p.emp_num = c.emp_num
group by fullname
having num_classes < 2;

SELECT CONCAT(emp_fname, " ", emp_lname) AS fullname, COUNT(p.emp_num) AS num_class
FROM professor p
LEFT JOIN class c ON p.emp_num = c.emp_num -- professor teach less than 2 class include 0 class
HAVING num_class < 2;

-- Q72
select emp_fname, emp_lname, dept_name
from professor p
left outer join student s on p.emp_num = s.emp_num
inner join department dept on p.dept_code = dept.dept_code
group by p.emp_num
having count(s.stu_num) = 0;

SELECT emp_fname, emp_lname, dept_name
FROM professor p
JOIN department d ON p.dept_code = d.dept_code
WHERE p.emp_num NOT IN (SELECT emp_num FROM student); -- professor who don't have any advisees

-- Q73
select stu_fname as "First name", stu_lname as "Last name" from student where dept_code = "CIS"
union
select emp_fname as "First name", emp_lname as "Last name" from professor where dept_code = "CIS";

SELECT stu_fname as "First name", stu_lname as "Last name"
FROM student
WHERE dept_code = "CIS"
UNION ALL
SELECT emp_fname as "First name", emp_lname as "Last name"
FROM professor
WHERE dept_code = "CIS"; -- professor and student from CIS

-- Q74
select cl.course_code, course_name 
from class cl
inner join course co on cl.course_code = co.course_code
where cl.class_section = 1 and cl.course_code not in (
	select course_code from class where class_section = 2
)
order by cl.course_code;

SELECT co.course_code, course_name
FROM course co
JOIN class cl ON co.course_code = cl.course_code
WHERE class_section = 1 AND cl.course_code NOT IN (SELECT course_code FROM class WHERE class_section = 2) -- course provide class for sec1 but notfor sec2
ORDER BY course_code;

-- Q75
select c.emp_num, emp_fname, emp_lname, count(class_code) as num_class_teach 
from class c inner join professor p on c.emp_num = p.emp_num
group by c.emp_num
having num_class_teach > (
	select avg(num_class_teach) as avg_num_class from (
		select emp_num, count(class_code) as num_class_teach from class
		group by emp_num
	) as temp
);

SELECT p.emp_num, emp_fname, emp_lname, COUNT(class_code) AS num_class_teach
FROM professor p
JOIN class c ON p.emp_num = c.emp_num
HAVING num_class_teach > (SELECT AVG(COUNT(class_code)) AS avg_class_teach FROM class GROUP BY emp_num); -- professor teach class more than average teaching class

-- Q76
select distinct stu_fname, stu_lname from student
where length(stu_lname) < (
	select avg(lname_length) from (
		select length(stu_lname) as lname_length from student
    ) as temp
);

SELECT DISTINCT stu_fname, stu_lname
FROM student
HAVING LENGTH(stu_lname) < (SELECT AVG(LENGTH(stu_lname)) FROM student) -- stu last name less than avg stu last name
ORDER BY stu_fname;

-- Q77
select stu_fname, stu_lname from student
where length(stu_fname) > length(stu_lname)
order by stu_fname asc;

SELECT stu_fname, stu_lname
FROM student
HAVING LENGTH(stu_fname) > LENGTH(stu_lname) -- stu first name longer than last name
ORDER BY stu_fname;

-- Q78
select d.dept_code, dept_name
from department d
left join professor p on d.dept_code = p.dept_code
left join student s on d.dept_code = s.dept_code
group by d.dept_code
having count(distinct p.emp_num) = count(distinct stu_num);

SELECT d.dept_code, dept_name
FROM department d
JOIN student s ON d.dept_code = s.dept_code
JOIN professor p ON d.dept_code = p.dept_code
GROUP BY d.dept_code
HAVING COUNT(DISTINCT s.stu_num) = COUNT(DISTINCT p.emp_num) -- department that number of stu equal to number of professor
ORDER BY dept_code;


-- Q79
select stu_num, stu_fname, stu_lname, stu_gpa, s.dept_code, dept_name
from student s
inner join department d on s.dept_code = d.dept_code
inner join (select dept_code, avg(stu_gpa) as avg_dept_gpa from student group by dept_code) as t on s.dept_code = t.dept_code
where stu_gpa > avg_dept_gpa
order by dept_code asc;

SELECT stu_num, stu_fname, stu_lname, stu_gpa, s.dept_code, dept_name
FROM student s
JOIN department d On s.dept_code = d.dept_code
JOIN (SELECT dept_code,AVG(stu_gpa) AS avg_gpa FROM student GROUP BY dept_code) t ON s.dept_code = t.dept_code -- stu gpa higher than averahe gpa of each department
WHERE stu_gpa > avg_gpa
ORDER BY dept_code;

-- Q80
select stu_num, stu_fname, stu_fname, max(stu_gpa), d.dept_code, dept_name
from student s
inner join department d on s.dept_code = d.dept_code
group by dept_code
order by dept_code asc;

SELECT stu_num, stu_fname, stu_lname, MAX(stu_gpa) AS stu_gpa, s.dept_code, dept_name -- highest gpa in each department
FROM student s
JOIN department d On s.dept_code = d.dept_code
GROUP BY dept_code
ORDER BY dept_code;
