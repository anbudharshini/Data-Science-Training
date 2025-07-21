create database movie_rental_system;
use movie_rental_system;
-- section 1
create table movies(movie_id int primary key,
title varchar(100),
genre varchar(50),
release_year int,
rental_rate decimal(10,2));

create table customers(customer_id int primary key,
name varchar(100),
email varchar(100),
city varchar(50));

create table rentals(rental_id int primary key,
customer_id int,
movie_id int,
rental_date date,
return_date date,
foreign key (customer_id) references customers(customer_id),
foreign key (movie_id) references movies(movie_id));

-- section 2
-- insert movies
insert into movies values
(1, 'the silent forest', 'thriller', 2021, 120.00),
(2, 'love beyond time', 'romance', 2019, 100.00),
(3, 'python rising', 'action', 2022, 150.00),
(4, 'the mystery code', 'mystery', 2020, 130.00),
(5, 'data dreams', 'sci-fi', 2023, 200.00);

-- insert customers
insert into customers values
(1, 'amit sharma', 'amit@example.com', 'delhi'),
(2, 'neha reddy', 'neha@example.com', 'bangalore'),
(3, 'faizan ali', 'faizan@example.com', 'hyderabad'),
(4, 'divya mehta', 'divya@example.com', 'bangalore'),
(5, 'ravi verma', 'ravi@example.com', 'chennai');

-- insert rentals
insert into rentals values
(101, 1, 1, '2023-02-10', '2023-02-15'),
(102, 1, 3, '2023-03-05', '2023-03-08'),
(103, 2, 2, '2023-04-01', '2023-04-04'),
(104, 2, 5, '2023-04-10', '2023-04-14'),
(105, 3, 1, '2023-05-01', '2023-05-03'),
(106, 4, 4, '2023-05-15', null),
(107, 4, 5, '2023-05-20', '2023-05-22'),
(108, 1, 5, '2023-06-01', null);

-- section 3
-- Basic queries
-- 1. retrieve all movies rented by a customer named 'amit sharma'
select m.title from rentals r
join movies m on r.movie_id = m.movie_id
join customers c on r.customer_id = c.customer_id
where c.name = 'amit sharma';

-- 2. show the details of customers from 'bangalore'
select * from customers
where city = 'bangalore';

-- 3. list all movies released after the year 2020
select * from movies
where release_year > 2020;

-- Aggregate queries
-- 4. count how many movies each customer has rented
select c.name, count(r.rental_id) as total_rentals
from customers c
left join rentals r on c.customer_id = r.customer_id
group by c.name;

-- 5. find the most rented movie title
select m.title, count(r.rental_id) as rental_count
from rentals r
join movies m on r.movie_id = m.movie_id
group by m.title
order by rental_count desc
limit 1;

-- 6. calculate total revenue earned from all rentals
select sum(m.rental_rate) as total_revenue
from rentals r
join movies m on r.movie_id = m.movie_id;

-- Advanced queries
-- 7. list all customers who have never rented a movie
select c.name from customers c
left join rentals r on c.customer_id = r.customer_id
where r.rental_id is null;

-- 8. show each genre and the total revenue from that genre
select m.genre, sum(m.rental_rate) as genre_revenue
from rentals r
join movies m on r.movie_id = m.movie_id
group by m.genre;

-- 9. find the customer who spent the most money on rentals
select c.name, sum(m.rental_rate) as total_spent
from rentals r
join customers c on r.customer_id = c.customer_id
join movies m on r.movie_id = m.movie_id
group by c.name
order by total_spent desc
limit 1;

-- 10. display movie titles that were rented and not yet returned
select distinct m.title
from rentals r
join movies m on r.movie_id = m.movie_id
where r.return_date is null;













