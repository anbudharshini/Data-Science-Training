--  Personal Fitness Tracker
create database fitness_tracker;
use fitness_tracker;
-- Table 1: Exercises
create table exercises(
exercise_id int primary key,
exercise_name varchar(50),
category varchar(20),
calories_burn_per_min int
);
-- Table 2: WorkoutLog
create table workoutlog(
log_id int primary key,
exercise_id int,
date date,
duration_min int,
mood varchar(20),
foreign key(exercise_id) references exercises(exercise_id)
);
-- Insert data
insert into exercises values
(1,'running','cardio',12),
(2,'cycling','cardio',10),
(3,'pushups','strength',8),
(4,'yoga','flexibility',5),
(5,'plank','strength',7);

insert into workoutlog values
(1,1,'2025-03-01',30,'energized'),
(2,1,'2025-03-03',25,'tired'),
(3,2,'2025-03-02',45,'normal'),
(4,2,'2025-03-05',40,'tired'),
(5,3,'2025-03-01',20,'energized'),
(6,3,'2025-03-04',25,'normal'),
(7,4,'2025-03-02',30,'normal'),
(8,4,'2025-03-06',20,'tired'),
(9,5,'2025-03-03',15,'normal'),
(10,5,'2025-03-07',20,'energized');

-- Basic Queries
-- 1. show all exercises under the “cardio” category
select * from exercises 
where category='cardio';

-- 2. show workouts done in the month of march 2025
select * from workoutlog 
where month(date)=3 and year(date)=2025;
-- or
select * from workoutlog 
where date>= '2025-03-01' and date<'2025-03-31';

-- Calculations
-- 3. calculate total calories burned per workout (duration × calories_burn_per_min)
select w.log_id, w.exercise_id, w.duration_min, w.duration_min * e.calories_burn_per_min 
as total_calories from workoutlog w 
join exercises e on w.exercise_id=e.exercise_id;

-- 4. calculate average workout duration per category
select e.category,avg(w.duration_min) as avg_duration
from workoutlog w join exercises e on w.exercise_id=e.exercise_id
group by e.category;

-- Join + Aggregation
-- 5. list exercise name, date, duration, and calories burned using a join
select e.exercise_name,w.date,w.duration_min,w.duration_min * e.calories_burn_per_min 
as calories_burned from workoutlog w 
join exercises e on w.exercise_id=e.exercise_id;

-- 6. show total calories burned per day
select w.date,sum(w.duration_min*e.calories_burn_per_min) 
as total_calories from workoutlog w 
join exercises e on w.exercise_id=e.exercise_id
group by w.date;

-- Subqueries
-- 7. find the exercise that burned the most calories in total
select e.exercise_name,sum(w.duration_min*e.calories_burn_per_min) 
as total_calories from workoutlog w 
join exercises e on w.exercise_id=e.exercise_id
group by e.exercise_name
order by total_calories desc
limit 1;

-- 8. list exercises never logged in the workout log
select * from exercises
where exercise_id not in(select distinct exercise_id from workoutlog);

-- Conditional + Text Filters
-- 9. show workouts where mood was “tired” and duration > 30 mins
select * from workoutlog 
where mood='tired' and duration_min>30;

-- 10. update a workout log to correct a wrongly entered mood
update workoutlog set mood='normal' 
where log_id=2;

-- Update and Delete
-- 11. update the calories per minute for “running”
update exercises set calories_burn_per_min=14 
where exercise_name='running';

-- 12. delete all logs from february 2024
delete from workoutlog 
where month(date)=2 and year(date)=2024;








