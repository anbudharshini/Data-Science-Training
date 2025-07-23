create database retailstore;
use retailstore;

create table products (
  productid int auto_increment primary key,
  name varchar(50),
  category varchar(20),
  price decimal(10, 2),
  cost decimal(10, 2),
  discountpercentage decimal(10, 2),
  createdat datetime
);

create table stores (
  storeid int auto_increment primary key,
  name varchar(50),
  region varchar(200),
  address varchar(200),
  createdat datetime
);

create table employees (
  employeeid int auto_increment primary key,
  name varchar(50),
  storeid int,
  role varchar(20),
  hiredate datetime,
  foreign key (storeid) references stores(storeid)
);

create table sales (
  saleid int auto_increment primary key,
  productid int,
  storeid int,
  employeeid int,
  quantity int,
  saledate datetime,
  foreign key (productid) references products(productid),
  foreign key (storeid) references stores(storeid),
  foreign key (employeeid) references employees(employeeid)
);

create index product_name on products(name);
create index sales_region on stores(region);

insert into stores (name, region, address, createdat) values
('city mart - ny', 'northeast', '123 Madison Ave, New York, NY', now()),
('budget shop - la', 'west coast', '456 Sunset Blvd, Los Angeles, CA', now()),
('fresh bodega - tx', 'south', '789 Lakeview Dr, Houston, TX', now()),
('super saver - il', 'midwest', '101 River Rd, Chicago, IL', now()),
('sunny store - fl', 'southeast', '202 Ocean Dr, Miami, FL', now());

insert into products (name, category, price, cost, discountpercentage, createdat) values
('gaming laptop 16', 'electronics', 1500.00, 1200.00, 8.00, now()),
('organic bananas', 'grocery', 2.50, 1.50, 3.00, now()),
('denim jeans', 'apparel', 40.00, 20.00, 12.00, now()),
('wireless earbuds', 'electronics', 80.00, 55.00, 15.00, now()),
('led desk lamp', 'home goods', 22.00, 12.00, 0.00, now());

insert into employees (name, storeid, role, hiredate) values
('michael reed', 1, 'cashier', now()),
('susan lee', 2, 'manager', now()),
('david park', 3, 'sales associate', now()),
('emma thomas', 4, 'supervisor', now()),
('lisa nguyen', 5, 'stock clerk', now());

insert into sales (productid, storeid, employeeid, quantity, saledate) values
(1, 1, 1, 3, now()),
(2, 2, 2, 120, now()),
(3, 3, 3, 25, now()),
(4, 4, 4, 8, now()),
(5, 5, 5, 15, now());

delimiter //
create procedure dailysale()
begin
  select 
    s1.name, 
    s2.saledate, 
    sum(s2.quantity * p1.price) as dailysales 
  from stores s1
  inner join sales s2 on s1.storeid = s2.storeid 
  inner join products p1 on s2.productid = p1.productid
  group by s2.saledate, s1.name;
end //
delimiter ;

call dailysale();

select * from products;
select * from sales;
select * from stores;
select * from employees;
