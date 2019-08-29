package org.motus.workouts

import org.motus.workouts.PlannedWorkout

class FreeWeights extends PlannedWorkout {
	
	String link = "freeWeights"
	String displayName = "Free Weights"
	
	int minutes	
		
    static constraints = {
		id generator: 'sequence', params:[sequence:'ID_FREE_WEIGHTS_PK_SEQ']
    }

}
