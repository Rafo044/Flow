
## Tasks to be done in the 1st week of MongoDB test preparation


```js


-- Change Database

USE patientData

-- Inserted data 

db.patient.insertOne({"firstname": "Max" ,
			 		 "lastname": "Schwarzmueller",
			 		 "age": 29,
			 		 "history": 
			 		 [{"disease": "cold"},
			 		 {"treatement": "test"}]})
			  
			  
			  
-- Data view

db.patient.find()


/*-------------------------------------------------------------------------*/

/* Task 01 .Insert 3 patient records with at least 1 history entry per patient */


db.patient.insertOne({"firstname": "Lora",
						"lastname": "Martinez",
						"history": [
						{"treatment": "test"}]})



db.patient.insertOne({"firstname": "Filipp",
						"lastname": "Colons",
						"history": [
						{"treatment": "test2"}]})
						
db.patient.insertMany([{"firstname": "Jeck",
						"lastname": "Leks",
						"history": [
						{"treatment": "bowel cancer"}]},
						
						{"firstname": "Carl",
						"lastname": "Petter",
						"history": [
						{"treatment": "ataxia"}]},
						
						{"firstname": "Lora",
						"lastname": "Martinez",
						"history": [
						{"treatment": "bone cancer"}]},
						
						
						])
						

						
/*----------------------------------------------------------------------------*/

/* Task 02 . Update patient data of 1 patient with NEW age ,name AND history entry */

db.patient.updateMany({ "_id": ObjectId("68e3f6ccf3f1b45e93ff22e4")},
				{ $set: { "firstname": "Nora",
				"lastname": "Con",
				"age": 26 }})


db.patient.updateMany({ "_id": ObjectId("68e3f6ccf3f1b45e93ff22e2")},
				{ $set: { "firstname": "Jackson",
				"lastname": "Cortes",
				"age": 23 }})

/* --------------------------------------------------------------------------*/

/* Task 03 . Find all patients who are older than 20(OR value of choice)  */

db.patient.find({"age": { $gte: 20}})
				
				
/*---------------------------------------------------------------------------*/
				
/* Task 04 .  Delete all patients who got a cold as a desease */
				
db.patient.deleteMany({"history.disease": "cold"})			




















```
