use employee_attendence;

db.createCollection("taskFeedbacks");
db.createCollection("employeeNotes");

db.taskFeedbacks.insertOne({
  employeeID: 2,
  taskID: 3,
  date: new Date("2025-07-01"),
  feedback: "Excellent quality!"
});

db.employeeNotes.insertOne({
  employeeID: 2,
  department: "R&D",
  noteType: "Appreciation",
  note: "Completed project ahead of time",
  createdBy: "Manager_01",
  timestamp: new Date("2025-07-01")
});

db.employeeNotes.createIndex({ employeeID: 1 });
db.taskFeedbacks.createIndex({ taskID: 1 });
