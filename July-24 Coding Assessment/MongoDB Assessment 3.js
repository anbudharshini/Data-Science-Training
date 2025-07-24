// Design & Query Challenge
// Jobs Collection
db.jobs.insertMany([{job_id:1,title:"Software Engineer",company:"TechCorp",location:"Bangalore",salary:1200000,job_type:"remote",posted_on:new Date("2025-07-01")},
{job_id:2,title:"Data Analyst",company:"DataWorks",location:"Hyderabad",salary:800000,job_type:"on-site",posted_on:new Date("2025-07-10")},
{job_id:3,title:"DevOps Engineer",company:"CloudNet",location:"Chennai",salary:1100000,job_type:"hybrid",posted_on:new Date("2025-07-12")},
{job_id:4,title:"Frontend Developer",company:"TechCorp",location:"Remote",salary:950000,job_type:"remote",posted_on:new Date("2025-06-20")},
{job_id:5,title:"Backend Developer",company:"BuildApps",location:"Pune",salary:1050000,job_type:"on-site",posted_on:new Date("2025-07-05")}
]);

// Applicants Collection
db.applicants.insertMany([{applicant_id:1,name:"Anjali",skills:["MongoDB","Node.js","React"],experience:3,city:"Bangalore",applied_on:new Date("2025-07-15")},
{applicant_id:2,name:"Rahul",skills:["Python","SQL","MongoDB"],experience:4,city:"Hyderabad",applied_on:new Date("2025-07-16")},
{applicant_id:3,name:"Priya",skills:["Java","Spring"],experience:2,city:"Chennai",applied_on:new Date("2025-07-13")},
{applicant_id:4,name:"Karan",skills:["MongoDB","Express"],experience:5,city:"Delhi",applied_on:new Date("2025-07-10")},
{applicant_id:5,name:"Sneha",skills:["HTML","CSS","JavaScript"],experience:1,city:"Hyderabad",applied_on:new Date("2025-07-12")}
]);

// Applications Collection
db.applications.insertMany([{application_id:1,applicant_id:1,job_id:1,application_status:"interview scheduled",interview_scheduled:true,feedback:"Positive"},
{application_id:2,applicant_id:2,job_id:2,application_status:"applied",interview_scheduled:false,feedback:"Pending"},
{application_id:3,applicant_id:1,job_id:3,application_status:"interview scheduled",interview_scheduled:true,feedback:"Good"},
{application_id:4,applicant_id:4,job_id:1,application_status:"applied",interview_scheduled:false,feedback:"Pending"},
{application_id:5,applicant_id:5,job_id:4,application_status:"interview scheduled",interview_scheduled:true,feedback:"Average"}
]);


// 1. Find all remote jobs with a salary greater than 10,00,000.
db.jobs.find({job_type:"remote",salary:{$gt:1000000}})

// 2. Get all applicants who know MongoDB.
db.applicants.find({skills:"MongoDB"})

// 3. Show the number of jobs posted in the last 30 days.
db.jobs.find({posted_on:{$gte:new Date(Date.now()-1000*60*60*24*30)}}).count()

// 4. List all job applications that are in ‘interview scheduled’ status.
db.applications.find({application_status:"interview scheduled"})

// 5. Find companies that have posted more than 2 jobs.
db.jobs.aggregate([{$group:{_id:"$company",job_count:{$sum:1}}},
{$match:{job_count:{$gt:2}}}
])

// 6. Join applications with jobs to show job title along with the applicant’s name.
db.applications.aggregate([{$lookup:{from:"jobs",localField:"job_id",foreignField:"_id",as:"job"}},
{$unwind:"$job"},
{$lookup:{from:"applicants",localField:"applicant_id",foreignField:"_id",as:"applicant"}},
{$unwind:"$applicant"},
{$project:{_id:0,applicant_name:"$applicant.name",job_title:"$job.job_title"}}
])

// 7. Find how many applications each job has received.
db.applications.aggregate([{$group:{_id:"$job_id",application_count:{$sum:1}}}
])

// 8. List applicants who have applied for more than one job.
db.applications.aggregate([{$group:{_id:"$applicant_id",count:{$sum:1}}},
{$match:{count:{$gt:1}}}
])

// 9. Show the top 3 cities with the most applicants.
db.applicants.aggregate([{$group:{_id:"$city",count:{$sum:1}}},
{$sort:{count:-1}},
{$limit:3}
])

// 10. Get the average salary for each job type (remote, hybrid, on-site).
db.jobs.aggregate([{$group:{_id:"$job_type",avg_salary:{$avg:"$salary"}}}
])

// 11. Update the status of one application to "offer made".
db.applications.updateOne({},{$set:{application_status:"offer made"}})

// 12. Delete a job that has not received any applications.
db.jobs.find().forEach(job=>{
  if(db.applications.countDocuments({job_id:job._id})===0){
    db.jobs.deleteOne({_id:job._id})
  }
})

// 13. Add a new field shortlisted to all applications and set it to false.
db.applications.updateMany({},{$set:{shortlisted:false}})

// 14. Increment experience of all applicants from "Hyderabad" by 1 year.
db.applicants.updateMany({city:"Hyderabad"},{$inc:{experience:1}})

// 15. Remove all applicants who haven’t applied to any job.
db.applicants.find().forEach(applicant=>{
  if(db.applications.countDocuments({applicant_id:applicant._id})===0){
    db.applicants.deleteOne({_id:applicant._id})
  }
})
