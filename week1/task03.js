/* Task 03 . Find all patients who are older than 20(OR value of choice)  */

db.patient.find({"age": { $gte: 20}})