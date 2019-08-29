package org.motus.workouts

import org.motus.workouts.PlannedWorkout

class CoreSynergistics extends PlannedWorkout {
	
	String link = "coreSynergistics"
	String displayName = "Core Synergistics"

    static constraints = {
		id generator: 'sequence', params:[sequence:'ID_CORE_SYNERGISTICS_PK_SEQ']
    }
}
