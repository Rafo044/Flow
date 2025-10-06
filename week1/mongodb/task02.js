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
