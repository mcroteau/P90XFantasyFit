package org.motus

import org.motus.workouts.PlannedWorkout

class Week {

	boolean completed
	boolean perfect
	
	Date firstDay
	Date lastDay
	
	int weekNumber

	WorkoutPlan workoutPlan
	static belongsTo = [WorkoutPlan]
	
	static hasMany = [ plannedWorkouts : PlannedWorkout ]

    static Week findByPlannedWorkout(PlannedWorkout plannedWorkout){
    	def c = Week.createCriteria()
    	def result = c.get {
    	   plannedWorkouts {
    	      idEq(plannedWorkout.id)
    	   }
    	}
    	return result;
	}
	
	static mapping = {
   	 	sort "weekNumber"
	}
	
    static constraints = {
		completed(nullable:true)
		perfect(nullable:true)
		firstDay(nullable:true)
		lastDay(nullable:true)
		weekNumber(nullable:true)
		id generator: 'sequence', params:[sequence:'ID_WEEK_PK_SEQ']
    }
}
