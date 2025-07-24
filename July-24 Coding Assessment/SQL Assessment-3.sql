-- Pet Clinic Management
create database pet_clinicdb;
use pet_clinicdb;

--  Table 1: Pets
create table pets(
pet_id int primary key,
name varchar(50),
type varchar(20),
breed varchar(50),
age int,
owner_name varchar(50)
);

insert into pets values
(1,'buddy','dog','golden retriever',5,'ayesha'),
(2,'mittens','cat','persian',3,'rahul'),
(3,'rocky','dog','bulldog',6,'sneha'),
(4,'whiskers','cat','siamese',2,'john'),
(5,'coco','parrot','macaw',4,'divya'),
(6,'shadow','dog','labrador',8,'karan');

-- Table 2: Visits 
create table visits(
visit_id int primary key,
pet_id int,
visit_date date,
issue varchar(100),
fee decimal(8,2),
foreign key(pet_id) references pets(pet_id)
);

insert into visits values
(101,1,'2024-01-15','regular checkup',500.00),
(102,2,'2024-02-10','fever',750.00),
(103,3,'2024-03-01','vaccination',1200.00),
(104,4,'2024-03-10','injury',1800.00),
(105,5,'2024-04-05','beak trimming',300.00),
(106,6,'2024-05-20','dental cleaning',950.00),
(107,1,'2024-06-10','ear infection',600.00);

--  Basics
-- 1. list all pets who are dogs
select * from pets 
where type='dog';

-- 2. show all visit records with a fee above 800
select * from visits 
where fee>800;

-- Joins
-- 3. list pet name, type, and their visit issues
select p.name,p.type,v.issue from pets p 
join visits v on p.pet_id=v.pet_id;

-- 4. show the total number of visits per pet
select p.name,count(v.visit_id) as total_visits
from pets p join visits v on p.pet_id=v.pet_id
group by p.name;

-- Aggregation
-- 5. find the total revenue collected from all visits
select sum(fee) as total_revenue from visits;

-- 6. show the average age of pets by type
select type,avg(age) as average_age from pets
group by type;

-- Date & Filtering
-- 7. list all visits made in the month of march
select * from visits
where month(visit_date)=3;

-- 8. show pet names who visited more than once
select p.name,count(v.visit_id) as visit_count
from pets p join visits v on p.pet_id=v.pet_id
group by p.name
having count(v.visit_id)>1;

--  Subqueries
-- 9. show the pet(s) who had the costliest visit
select p.name,v.fee
from visits v join pets p on v.pet_id=p.pet_id
where v.fee=(select max(fee) from visits);

-- 10. list pets who haven’t visited the clinic yet
select * from pets
where pet_id not in(select distinct pet_id from visits);

-- Update & Delete
-- 11. update the fee for visit_id 105 to 350
update visits set fee=350 where visit_id=105;

-- 12. delete all visits made before feb 2024
delete from visits where visit_date<'2024-02-01';


