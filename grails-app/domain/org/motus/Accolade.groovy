package org.motus

import org.motus.workouts.PlannedWorkout

class Accolade {
	
	String type
	int points
	String description
	
	Date dateCreated
	
	Account account
	Week week
	WorkoutPlan workoutPlan
	PlannedWorkout plannedWorkout
	Competition competition
	
	
    static constraints = {
		type(nullable:false)
		points(nullable:false)
		description(nullable:false)
		account(nullable:false)
		week(nullable:true)
		workoutPlan(nullable:true)
		plannedWorkout(nullable:true)
		competition(nullable:true)
		id generator: 'sequence', params:[sequence:'ID_ACCOLADE_SEQ']
    }
	
}
