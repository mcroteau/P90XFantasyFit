package org.motus.log

import org.motus.Account
import org.motus.WorkoutPlan

class AdjustmentLog {

	Account account
	WorkoutPlan workoutPlan
	int adjustment
	
	Date startDate
	Date adjustedStartDate
	
	Date plannedCompleteDate
	Date adjustedPlannedCompleteDate
	
    static constraints = {
		id generator: 'sequence', params:[sequence:'ID_ADJUSTMENT_LOG_PK_SEQ']
    }
}
