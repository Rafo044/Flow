/*---------------------------------------------------------------------------*/
				
/* Task 04 .  Delete all patients who got a cold as a desease */
				
db.patient.deleteMany({"history.disease": "cold"})	