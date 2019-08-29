package org.motus.workouts

import org.motus.workouts.PlannedWorkout

class Plyometrics extends PlannedWorkout {
	
	String link = "plyometrics"
	String displayName = "Plyometrics"

    static constraints = {
		id generator: 'sequence', params:[sequence:'ID_PLYOMETRICS_PK_SEQ']
    }
}
