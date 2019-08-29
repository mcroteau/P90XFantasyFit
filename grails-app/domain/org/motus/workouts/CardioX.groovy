package org.motus.workouts
import org.motus.workouts.PlannedWorkout

class CardioX extends PlannedWorkout{
	
	String link = "cardioX"
	String displayName = "Cardio X"
	
    static constraints = {
		id generator: 'sequence', params:[sequence:'ID_CARDIO_X_PK_SEQ']
    }
}
