package org.motus.workouts

import org.motus.workouts.PlannedWorkout

class CardioWorkout extends PlannedWorkout {
	
	String link = "cardioWorkout"
	String displayName = "Cardio Workout"

	int minutes
	
	String type
		
    static constraints = {
		minutes(nullable:true, default:0)
		type(nullable:false)
		id generator: 'sequence', params:[sequence:'ID_CARDIO_WORKOUT_PK_SEQ']
    }

}
