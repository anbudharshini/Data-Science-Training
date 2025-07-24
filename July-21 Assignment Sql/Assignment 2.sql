create database students_data;
use students_data;

create table students(student_id int primary key, 
name varchar(100), 
age int, 
gender varchar(10), 
department_id int);

create table departments(department_id int primary key, 
department_name varchar(100), 
head_of_department varchar(100));


create table courses(course_id int primary key, 
course_name varchar(100), 
department_id int, 
credit_hours int);

insert into students values 
(1, 'amit sharma', 20, 'male', 1), 
(2, 'neha reddy', 22, 'female', 2), 
(3, 'faizan ali', 21, 'male', 1), 
(4, 'divya mehta', 23, 'female', 3), 
(5, 'ravi verma', 22, 'male', 2);

insert into departments values 
(1, 'computer science', 'dr. rao'), 
(2, 'electronics', 'dr. iyer'), 
(3, 'mechanical', 'dr. khan');

insert into courses values 
(101, 'data structures', 1, 4), 
(102, 'circuits', 2, 3), 
(103, 'thermodynamics', 3, 4), 
(104, 'algorithms', 1, 3), 
(105, 'microcontrollers', 2, 2);

-- section a: basic queries

-- 1. list all students with name, age, and gender
select name, age, gender from students;

-- 2. show names of female students only
select name from students 
where gender='female';

-- 3. display all courses offered by the electronics department
select c.course_name from courses c
join departments d on c.department_id = d.department_id
where d.department_name ='electronics';

-- 4. show the department name and head for department_id = 1
select department_name, head_of_department 
from departments 
where department_id =1;

-- 5. display students older than 21 years
select * from students 
where age>21;

-- section b: intermediate joins & aggregations

-- 6. show student names along with their department names
select s.name, d.department_name from students s
join departments d on s.department_id = d.department_id;

-- 7. list all departments with number of students in each
select d.department_name, count(s.student_id) as total_students
from departments d
left join students s on d.department_id = s.department_id
group by d.department_name;

-- 8. find the average age of students per department
select d.department_name, avg(s.age) as avg_age
from departments d
join students s on d.department_id = s.department_id
group by d.department_name;

-- 9. show all courses with their respective department names
select c.course_name, d.department_name
from courses c
join departments d on c.department_id = d.department_id;

-- 10. list departments that have no students enrolled
select d.department_name
from departments d
left join students s on d.department_id = s.department_id
where s.student_id is null;

-- 11. show the department that has the highest number of courses
select d.department_name from departments d
join courses c on d.department_id = c.department_id
group by d.department_name
order by count(c.course_id) desc
limit 1;

-- section c: subqueries & advanced filters

-- 12. find names of students whose age is above the average age of all students
select name from students 
where age>(select avg(age) from students);

-- 13. show all departments that offer courses with more than 3 credit hours
select distinct d.department_name from departments d
join courses c on d.department_id = c.department_id
where c.credit_hours>3;

-- 14. display names of students who are enrolled in the department with the fewest courses
select name from students
where department_id =(select department_id from courses
group by department_id
order by count(course_id) asc
limit 1);

-- 15. list the names of students in departments where the hod's name contains 'dr.'
select s.name from students s
join departments d using(department_id)
where lower(d.head_of_department) like 'dr.%';

-- 16. find the second oldest student (using subquery)
select * from students
where age=(select distinct age from students
order by age desc
limit 1 offset 1);

-- 17. show all courses that belong to departments with more than 2 students
select c.course_name from courses c
where c.department_id in(select s.department_id
from students s
group by s.department_id
having count(s.student_id)>2);






