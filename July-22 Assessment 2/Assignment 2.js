// MongoDB Assignment – Movie Streaming App
use moviestreamingdb

// PART 1: Create Collections
db.createCollection("users")
db.createCollection("movies")
db.createCollection("watch_history")

// PART 2: Insert Sample Data
// Insert Users
db.users.insertMany([
 {user_id:1,name:"amit sharma",email:"amit@example.com",country:"india"},
 {user_id:2,name:"neha reddy",email:"neha@example.com",country:"usa"},
 {user_id:3,name:"faizan ali",email:"faizan@example.com",country:"uk"},
 {user_id:4,name:"divya mehta",email:"divya@example.com",country:"india"},
 {user_id:5,name:"ravi verma",email:"ravi@example.com",country:"australia"}
])

// Insert Movies
db.movies.insertMany([
 {movie_id:101,title:"dream beyond code",genre:"sci-fi",release_year:2022,duration:120},
 {movie_id:102,title:"mystery of shadows",genre:"mystery",release_year:2021,duration:110},
 {movie_id:103,title:"love in paris",genre:"romance",release_year:2019,duration:95},
 {movie_id:104,title:"python unleashed",genre:"technology",release_year:2023,duration:140},
 {movie_id:105,title:"business empire",genre:"drama",release_year:2020,duration:100},
 {movie_id:106,title:"future world",genre:"sci-fi",release_year:2024,duration:130}
])

// Insert Watch History
db.watch_history.insertMany([
 {watch_id:1001,user_id:1,movie_id:101,watched_on:ISODate("2023-05-01"),watch_time:120},
 {watch_id:1002,user_id:2,movie_id:103,watched_on:ISODate("2023-05-03"),watch_time:95},
 {watch_id:1003,user_id:3,movie_id:102,watched_on:ISODate("2023-05-05"),watch_time:100},
 {watch_id:1004,user_id:4,movie_id:104,watched_on:ISODate("2023-05-06"),watch_time:130},
 {watch_id:1005,user_id:5,movie_id:105,watched_on:ISODate("2023-05-07"),watch_time:100},
 {watch_id:1006,user_id:1,movie_id:106,watched_on:ISODate("2023-05-08"),watch_time:120},
 {watch_id:1007,user_id:2,movie_id:101,watched_on:ISODate("2023-05-09"),watch_time:110},
 {watch_id:1008,user_id:3,movie_id:106,watched_on:ISODate("2023-05-10"),watch_time:130}
])

// PART 3: Queries
// Basic Queries
// 1. Find all movies with duration > 100 minutes
db.movies.find({duration:{$gt:100}})

// 2. List users from 'india'
db.users.find({country:"india"})

// 3. Get all movies released after 2020
db.movies.find({release_year:{$gt:2020}})

// Intermediate Queries
// 4. Show full watch history: user name, movie title, watch time
db.watch_history.aggregate([
 {$lookup:{from:"users",localField:"user_id",foreignField:"user_id",as:"user_info"}},
 {$unwind:"$user_info"},
 {$lookup:{from:"movies",localField:"movie_id",foreignField:"movie_id",as:"movie_info"}},
 {$unwind:"$movie_info"},
 {$project:{watch_id:1,"user_info.name":1,"movie_info.title":1,watch_time:1,watched_on:1}}
])

// 5. List each genre and number of times movies in that genre were watched
db.watch_history.aggregate([
 {$lookup:{from:"movies",localField:"movie_id",foreignField:"movie_id",as:"movie_info"}},
 {$unwind:"$movie_info"},
 {$group:{_id:"$movie_info.genre",watch_count:{$sum:1}}}
])

// 6. Display total watch time per user
db.watch_history.aggregate([
 {$group:{_id:"$user_id",total_watch_time:{$sum:"$watch_time"}}},
 {$lookup:{from:"users",localField:"_id",foreignField:"user_id",as:"user_info"}},
 {$unwind:"$user_info"},
 {$project:{_id:0,user_id:"$_id",user_name:"$user_info.name",total_watch_time:1}}
])

// Advanced Queries
// 7. Find which movie has been watched the most (by count)
db.watch_history.aggregate([
 {$group:{_id:"$movie_id",watch_count:{$sum:1}}},
 {$sort:{watch_count:-1}},
 {$limit:1},
 {$lookup:{from:"movies",localField:"_id",foreignField:"movie_id",as:"movie_info"}},
 {$unwind:"$movie_info"},
 {$project:{_id:0,movie:"$movie_info.title",watch_count:1}}
])

// 8. Identify users who have watched more than 2 movies
db.watch_history.aggregate([
 {$group:{_id:"$user_id",unique_movies:{$addToSet:"$movie_id"}}},
 {$project:{movie_count:{$size:"$unique_movies"}}},
 {$match:{movie_count:{$gt:2}}},
 {$lookup:{from:"users",localField:"_id",foreignField:"user_id",as:"user_info"}},
 {$unwind:"$user_info"},
 {$project:{_id:0,user_name:"$user_info.name",movie_count:1}}
])

// 9. Show users who watched the same movie more than once
db.watch_history.aggregate([
 {$group:{_id:{user_id:"$user_id",movie_id:"$movie_id"},watch_times:{$sum:1}}},
 {$match:{watch_times:{$gt:1}}},
 {$lookup:{from:"users",localField:"_id.user_id",foreignField:"user_id",as:"user_info"}},
 {$unwind:"$user_info"},
 {$lookup:{from:"movies",localField:"_id.movie_id",foreignField:"movie_id",as:"movie_info"}},
 {$unwind:"$movie_info"},
 {$project:{_id:0,user_name:"$user_info.name",movie_title:"$movie_info.title",watch_times:1}}
])

// 10. Calculate percentage of each movie watched compared to its full duration
db.watch_history.aggregate([
 {$lookup:{from:"movies",localField:"movie_id",foreignField:"movie_id",as:"movie_info"}},
 {$unwind:"$movie_info"},
 {$project:{movie_id:1,user_id:1,percentage_watched:{$multiply:[{$divide:["$watch_time","$movie_info.duration"]},100]}}}
])
