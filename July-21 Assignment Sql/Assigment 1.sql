create database empdata;
use empdata;
create table employees(emp_id int primary key, 
emp_name varchar(100), 
department varchar(50), 
salary int, 
age int);

create table departments(dept_id int primary key, 
dept_name varchar(50), 
location varchar(50)
);

insert into employees values 
(101, 'amit sharma', 'engineering', 60000, 30), 
(102, 'neha reddy', 'marketing', 45000, 28), 
(103, 'faizan ali', 'engineering', 58000, 32), 
(104, 'divya mehta', 'hr', 40000, 29), 
(105, 'ravi verma', 'sales', 35000, 26);

insert into departments values 
(1, 'engineering', 'bangalore'), 
(2, 'marketing', 'mumbai'), 
(3, 'hr', 'delhi'), 
(4, 'sales', 'chennai');

-- section a: basic sql

-- 1. display all employees
select * from employees;

-- 2. show only emp_name and salary of all employees
select emp_name, salary from employees;

-- 3. find employees with a salary greater than 40,000
select * from employees 
where salary > 40000;

-- 4. list employees between age 28 and 32 (inclusive)
select * from employees 
where age between 28 and 32;

-- 5. show employees who are not in the hr department
select * from employees 
where department!='hr';

-- 6. sort employees by salary in descending order
select * from employees 
order by salary desc;

-- 7. count the number of employees in the table
select count(*) as total_employees from employees;

-- 8. find the employee with the highest salary
select * from employees 
where salary=
(select max(salary) from employees);

-- section b: joins & aggregations

-- 1. display employee names along with their department locations (using join)
select e.emp_name, d.location 
from employees e
join departments d on e.department = d.dept_name;

-- 2. list departments and count of employees in each department
select d.dept_name, count(e.emp_id) as total_employees
from departments d
left join employees e on d.dept_name = e.department
group by d.dept_name;

-- 3. show average salary per department
select department, avg(salary) as avg_salary
from employees
group by department;

-- 4. find departments that have no employees (use left join)
select d.dept_name
from departments d
left join employees e on d.dept_name = e.department
where e.emp_id is null;

-- 5. find total salary paid by each department
select department, sum(salary) as total_salary
from employees
group by department;

-- 6. display departments with average salary > 45,000
select department, avg(salary) as avg_salary
from employees
group by department
having avg(salary)>45000;

-- 7. show employee name and department for those earning more than 50,000
select emp_name, department
from employees
where salary>50000;






