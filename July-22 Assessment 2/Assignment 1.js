// MongoDB Practical Assignment – Bookstore Management
use bookstoredb

// PART 1: Create Collections
db.createCollection("books")
db.createCollection("customers")
db.createCollection("orders")

// PART 2: Insert Sample Data
// Insert Books
db.books.insertMany([
 {book_id:101,title:"the ai revolution",author:"ray kurzweil",genre:"technology",price:799,stock:20},
 {book_id:102,title:"mystery of time",author:"neha reddy",genre:"mystery",price:450,stock:15},
 {book_id:103,title:"python basics",author:"amit sharma",genre:"technology",price:650,stock:25},
 {book_id:104,title:"love and beyond",author:"divya mehta",genre:"romance",price:300,stock:10},
 {book_id:105,title:"business growth",author:"ravi verma",genre:"business",price:550,stock:18}
])

// Insert Customers
db.customers.insertMany([
 {customer_id:201,name:"amit sharma",email:"amit@example.com",city:"delhi"},
 {customer_id:202,name:"neha reddy",email:"neha@example.com",city:"hyderabad"},
 {customer_id:203,name:"faizan ali",email:"faizan@example.com",city:"mumbai"},
 {customer_id:204,name:"divya mehta",email:"divya@example.com",city:"bangalore"},
 {customer_id:205,name:"ravi verma",email:"ravi@example.com",city:"hyderabad"}
])

// Insert Orders
db.orders.insertMany([
 {order_id:301,customer_id:201,book_id:101,order_date:ISODate("2023-02-10"),quantity:2},
 {order_id:302,customer_id:202,book_id:103,order_date:ISODate("2023-03-15"),quantity:1},
 {order_id:303,customer_id:203,book_id:102,order_date:ISODate("2023-01-20"),quantity:3},
 {order_id:304,customer_id:204,book_id:104,order_date:ISODate("2023-04-25"),quantity:2},
 {order_id:305,customer_id:205,book_id:105,order_date:ISODate("2023-05-05"),quantity:1},
 {order_id:306,customer_id:202,book_id:101,order_date:ISODate("2023-06-18"),quantity:2},
 {order_id:307,customer_id:203,book_id:105,order_date:ISODate("2023-07-01"),quantity:4}
])

// PART 3: Queries
// Basic Queries
// 1. List all books priced above 500
db.books.find({price:{$gt:500}})

// 2. Show all customers from 'Hyderabad'
db.customers.find({city:"hyderabad"})

// 3. Find all orders placed after January 1, 2023
db.orders.find({order_date:{$gt:ISODate("2023-01-01")}})

// Joins using $lookup
// 4. Display order details with customer name and book title
db.orders.aggregate([
 {$lookup:{from:"customers",localField:"customer_id",foreignField:"customer_id",as:"customer_info"}},
 {$unwind:"$customer_info"},
 {$lookup:{from:"books",localField:"book_id",foreignField:"book_id",as:"book_info"}},
 {$unwind:"$book_info"},
 {$project:{order_id:1,"customer_info.name":1,"book_info.title":1,quantity:1,order_date:1}}
])

// 5. Show total quantity ordered for each book
db.orders.aggregate([
 {$group:{_id:"$book_id",total_quantity:{$sum:"$quantity"}}},
 {$lookup:{from:"books",localField:"_id",foreignField:"book_id",as:"book_info"}},
 {$unwind:"$book_info"},
 {$project:{_id:0,book_id:"$_id",title:"$book_info.title",total_quantity:1}}
])

// 6. Show the total number of orders placed by each customer
db.orders.aggregate([
 {$group:{_id:"$customer_id",total_orders:{$sum:1}}},
 {$lookup:{from:"customers",localField:"_id",foreignField:"customer_id",as:"customer_info"}},
 {$unwind:"$customer_info"},
 {$project:{_id:0,customer_id:"$_id",customer_name:"$customer_info.name",total_orders:1}}
])

// Aggregation Queries
// 7. Calculate total revenue generated per book
db.orders.aggregate([
 {$lookup:{from:"books",localField:"book_id",foreignField:"book_id",as:"book_info"}},
 {$unwind:"$book_info"},
 {$group:{_id:"$book_id",total_revenue:{$sum:{$multiply:["$quantity","$book_info.price"]}}}}
])

// 8. Find the book with the highest total revenue
db.orders.aggregate([
 {$lookup:{from:"books",localField:"book_id",foreignField:"book_id",as:"book_info"}},
 {$unwind:"$book_info"},
 {$group:{_id:"$book_info.title",total_revenue:{$sum:{$multiply:["$quantity","$book_info.price"]}}}},
 {$sort:{total_revenue:-1}},
 {$limit:1}
])

// 9. List genres and total books sold in each genre
db.orders.aggregate([
 {$lookup:{from:"books",localField:"book_id",foreignField:"book_id",as:"book_info"}},
 {$unwind:"$book_info"},
 {$group:{_id:"$book_info.genre",total_sold:{$sum:"$quantity"}}}
])

// 10. Show customers who ordered more than 2 different books
db.orders.aggregate([
 {$group:{_id:"$customer_id",unique_books:{$addToSet:"$book_id"}}},
 {$project:{total_books:{$size:"$unique_books"}}},
 {$match:{total_books:{$gt:2}}}
])
