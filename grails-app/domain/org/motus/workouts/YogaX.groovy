package org.motus.workouts

import org.motus.workouts.PlannedWorkout

class YogaX extends PlannedWorkout {
	
	String link = "yogaX"
	String displayName = "Yoga X"

    static constraints = {
		id generator: 'sequence', params:[sequence:'ID_YOGAX_PK_SEQ']
    }
}
