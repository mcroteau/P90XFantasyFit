package org.motus.workouts

import org.motus.workouts.PlannedWorkout

class KenpoX extends PlannedWorkout {
	
	String link = "kenpoX"
	String displayName = "Kenpo X"

    static constraints = {
		id generator: 'sequence', params:[sequence:'ID_KENPOX_PK_SEQ']
    }
}
