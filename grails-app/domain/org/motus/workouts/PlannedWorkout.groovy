package org.motus.workouts

import org.motus.Week
import org.motus.Account
import org.motus.WorkoutPlan

abstract class PlannedWorkout {

	Date dateCreated
	Date lastUpdated
	
	Date plannedWorkoutDate
	Date originalPlannedWorkoutDate
	Date actualWorkoutDate
	
	boolean completed
	boolean extra
	
	boolean skipped
	Date skippedDate
	
	boolean updated
	
	boolean includeAbRipper
	boolean abRipperCompleted
	
	String notes
	int time //add javascript timer on all workouts
	
	Week week
	Account account
	WorkoutPlan workoutPlan
	static belongsTo = [WorkoutPlan, Account]
	
	static mapping = {
   	 	sort "plannedWorkoutDate"	
        tablePerHierarchy false
	}
	
    static constraints = {
		completed nullable:false 
		extra nullable:true, default:false
		skipped nullable:true
		updated nullable:true, default:false
		notes nullable:true
		time nullable:true
		plannedWorkoutDate nullable:true, blank:true 	
		actualWorkoutDate nullable:true, blank:true 
		skippedDate nullable:true
		week nullable:true
		workoutPlan nullable:false
		includeAbRipper nullable: true
		abRipperCompleted nullable: true
		id generator: 'sequence', params:[sequence:'ID_PLANNED_WORKOUT_PK_SEQ']
	}

}
