create database employee_attendance;
use employee_attendance;

create table employees (
  employeeid int auto_increment primary key,
  name varchar(50),
  department varchar(50),
  role varchar(40),
  email varchar(100),
  hiredate datetime default current_timestamp,
  status varchar(20) check (status in ('Active', 'Resigned'))
);

create table attendance (
  attendanceid int auto_increment primary key,
  employeeid int,
  date date,
  clockin datetime,
  clockout datetime,
  islate boolean,
  isabsent boolean,
  foreign key (employeeid) references employees(employeeid)
);

create table tasks (
  taskid int auto_increment primary key,
  employeeid int,
  taskname varchar(50),
  taskdate date,
  taskscompleted int,
  hoursspent decimal(5, 2),
  productivityscore decimal(5, 2),
  foreign key (employeeid) references employees(employeeid)
);

insert into employees (name, department, role, email, hiredate, status) values
('arun kumar', 'engineering', 'software engineer', 'arun.kumar@example.com', '2023-02-10', 'Active'),
('deepa rani', 'marketing', 'content writer', 'deepa.rani@example.com', '2022-12-05', 'Active'),
('vijay raj', 'hr', 'hr executive', 'vijay.raj@example.com', '2021-10-15', 'Active'),
('karthik s', 'engineering', 'devops engineer', 'karthik.s@example.com', '2023-04-20', 'Active'),
('meena p', 'finance', 'accountant', 'meena.p@example.com', '2022-07-25', 'Resigned');

insert into attendance (employeeid, date, clockin, clockout, islate, isabsent) values
(1, '2024-06-01', '2024-06-01 09:05:00', '2024-06-01 17:00:00', 1, 0),
(2, '2024-06-01', '2024-06-01 09:00:00', '2024-06-01 17:15:00', 0, 0),
(3, '2024-06-01', null, null, 0, 1),
(4, '2024-06-01', '2024-06-01 09:12:00', '2024-06-01 17:10:00', 1, 0),
(5, '2024-06-01', '2024-06-01 08:50:00', '2024-06-01 16:30:00', 0, 0);

insert into tasks (employeeid, taskname, taskdate, taskscompleted, hoursspent, productivityscore) values
(1, 'api development', '2024-06-01', 6, 6.5, 0.85),
(2, 'social media campaign', '2024-06-01', 4, 5.0, 0.7),
(3, 'employee onboarding', '2024-06-01', 1, 2.0, 0.5),
(4, 'infra setup', '2024-06-01', 5, 6.0, 0.8),
(5, 'invoice processing', '2024-06-01', 7, 8.0, 0.9);

create index idx_employeeid on employees(employeeid);

delimiter $$
create procedure workhrs()
begin
  select
    e.name,
    ifnull(sum(timestampdiff(minute, a.clockin, a.clockout))/60, 0) as totalhours
  from employees e
  left join attendance a on e.employeeid = a.employeeid
  where a.clockin is not null and a.clockout is not null
  group by e.name
  order by totalhours desc;
end $$
delimiter ;

call workhrs();

select * from employees;
select * from attendance;
select * from tasks;
