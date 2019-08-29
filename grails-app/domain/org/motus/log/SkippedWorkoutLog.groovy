package org.motus.log

import org.motus.Account
import org.motus.workouts.PlannedWorkout

class SkippedWorkoutLog {

	Date date
	Account account
	PlannedWorkout plannedWorkout
	boolean recovered

    static constraints = {
		recovered(nullable:true)
		id generator: 'sequence', params:[sequence:'ID_SKIPPED_WORKOUT_LOG_PK_SEQ']
    }
	
}
