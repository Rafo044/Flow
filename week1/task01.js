

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
						

