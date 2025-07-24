-- Travel Planner
create database travel_planner;
use travel_planner;

--  Table 1: Destinations
create table destinations(
destination_id int primary key,
city varchar(50),
country varchar(50),
category varchar(20),
avg_cost_per_day decimal(10,2)
);
-- Table 2: Trips
create table trips(
trip_id int primary key,
destination_id int,
traveler_name varchar(50),
start_date date,
end_date date,
budget decimal(10,2),
foreign key(destination_id) references destinations(destination_id)
);

-- Insert data
insert into destinations values
(1,'goa','india','beach',2500),
(2,'agra','india','historical',1800),
(3,'bali','indonesia','beach',3200),
(4,'paris','france','historical',4500),
(5,'zurich','switzerland','nature',5000),
(6,'manali','india','adventure',2200);

insert into trips values
(1,1,'arjun','2025-03-01','2025-03-05',13000),
(2,2,'meera','2025-03-10','2025-03-15',10000),
(3,3,'john','2025-01-05','2025-01-12',25000),
(4,4,'emily','2022-12-01','2022-12-10',40000),
(5,5,'daniel','2023-04-10','2023-04-20',52000),
(6,6,'raj','2024-05-01','2024-05-06',12000),
(7,2,'meera','2023-06-01','2023-06-05',9000),
(8,4,'emily','2024-08-01','2024-08-12',55000),
(9,1,'arjun','2025-06-01','2025-06-03',7500),
(10,5,'sara','2023-11-01','2023-11-07',28000);

--  Basic Queries
-- 1. show all trips to destinations in “india”
select * from trips t 
join destinations d on t.destination_id=d.destination_id
where d.country='india';

-- 2. list all destinations with an average cost below 3000
select * from destinations 
where avg_cost_per_day<3000;

-- Date & Duration
-- 3. calculate the number of days for each trip
select trip_id,datediff(end_date,start_date)+1 as duration_days from trips;

-- 4. list all trips that last more than 7 days
select * from trips 
where datediff(end_date,start_date)+1>7;

--  Join + Aggregation
-- 5. list traveler name, destination city, and total trip cost (duration × avg_cost_per_day)
select t.traveler_name,d.city,(datediff(t.end_date,t.start_date)+1) * d.avg_cost_per_day 
as total_trip_cost from trips t 
join destinations d on t.destination_id=d.destination_id;

-- 6. find the total number of trips per country
select d.country,count(*) as total_trips from trips t 
join destinations d on t.destination_id=d.destination_id
group by d.country;

--  Grouping & Filtering
-- 7. show average budget per country
select d.country,avg(t.budget) as avg_budget
from trips t join destinations d on t.destination_id=d.destination_id
group by d.country;

-- 8. find which traveler has taken the most trips
select traveler_name,count(*) as trip_count from trips
group by traveler_name
order by trip_count desc
limit 1;

-- Subqueries
-- 9. show destinations that haven’t been visited yet
select * from destinations
where destination_id not in (select distinct destination_id from trips);

-- 10. find the trip with the highest cost per day
select trip_id,traveler_name,budget/(datediff(end_date,start_date)+1) as cost_per_day
from trips
order by cost_per_day desc
limit 1;

-- Update & Delete
-- 11. update the budget for a trip that was extended by 3 days (e.g., trip_id=1)
update trips set budget=
budget+(select avg_cost_per_day*3 from destinations where destination_id=trips.destination_id)
where trip_id=1;
-- 12. delete all trips that were completed before jan 1, 2023
delete from trips 
where end_date<'2023-01-01';
