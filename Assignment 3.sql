create database bookdb;
use bookdb;

-- part 1: design the database
create table books(book_id int primary key,
title varchar(200),
author varchar(100),
genre varchar(50),
price decimal(10,2));

create table customers(customer_id int primary key,
name varchar(100),
email varchar(100),
city varchar(50));

create table orders(order_id int primary key,
customer_id int,
book_id int,
order_date date,
quantity int,
foreign key (customer_id) references customers(customer_id),
foreign key (book_id) references books(book_id));

-- part 2: insert sample data

-- insert books
insert into books values
(1,'the data engineer','amit sharma','technology',650.00),
(2,'mystery of time','neha reddy','mystery',450.00),
(3,'python basics','faizan ali','technology',800.00),
(4,'love and beyond','divya mehta','romance',300.00),
(5,'marketing 101','ravi verma','business',550.00);

-- insert customers
insert into customers values
(1, 'arun kumar', 'arun@example.com', 'hyderabad'),
(2, 'priya singh', 'priya@example.com', 'mumbai'),
(3, 'rahul reddy', 'rahul@example.com', 'chennai'),
(4, 'meena iyer', 'meena@example.com', 'delhi'),
(5, 'suresh patel', 'suresh@example.com', 'hyderabad');

-- insert orders
insert into orders values
(101, 1, 3, '2023-02-10', 2),   
(102, 2, 1, '2023-03-15', 1),   
(103, 3, 2, '2023-04-20', 3),   
(104, 4, 3, '2023-05-05', 1),   
(105, 1, 4, '2023-06-18', 2),   
(106, 5, 5, '2023-07-22', 1),   
(107, 1, 1, '2023-08-05', 1);   

-- part 3: queries
-- Basic queries
-- 1. list all books with price above 500
select * from books 
where price>500;

-- 2. show all customers from the city of 'hyderabad'
select * from customers 
where city ='hyderabad';

-- 3. find all orders placed after '2023-01-01'
select * from orders 
where order_date>'2023-01-01';

-- Joins and Aggregations
-- 4. show customer names along with book titles they purchased
select c.name, b.title from orders o
join customers c on o.customer_id=c.customer_id
join books b on o.book_id = b.book_id;

-- 5. list each genre and total number of books sold in that genre
select b.genre, sum(o.quantity) as total_books_sold
from orders o
join books b on o.book_id = b.book_id
group by b.genre;

-- 6. find the total sales amount (price × quantity) for each book
select b.title, sum(o.quantity*b.price) as total_sales
from orders o
join books b on o.book_id = b.book_id
group by b.title;

-- 7. show the customer who placed the highest number of orders
select c.name, count(o.order_id) as total_orders from orders o
join customers c on o.customer_id = c.customer_id
group by c.name
order by total_orders desc
limit 1;

-- 8. display average price of books by genre
select genre, avg(price) as avg_price from books
group by genre;

-- 9. list all books that have not been ordered
select * from books
where book_id not in(select distinct book_id from orders);

-- 10. show the name of the customer who has spent the most in total
select c.name, sum(o.quantity*b.price) as total_spent from orders o
join customers c on o.customer_id = c.customer_id
join books b on o.book_id = b.book_id
group by c.name
order by total_spent desc
limit 1;
