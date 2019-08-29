package org.motus.workouts

import org.motus.workouts.PlannedWorkout

class Xstretch extends PlannedWorkout {
	
	String link = "xstretch"
	String displayName = "X Stretch"

    static constraints = {
		id generator: 'sequence', params:[sequence:'ID_XSTRETCH_PK_SEQ']
    }
}
