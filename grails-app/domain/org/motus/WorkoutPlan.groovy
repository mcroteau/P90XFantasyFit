package org.motus

import org.motus.workouts.PlannedWorkout
import org.motus.ProgressPhoto

class WorkoutPlan {

	String title
	String name
	String planVersion
	String status
	String description
	
	int totalPoints
	int totalCompleted
	int totalSkipped
	int totalRemaining
	
	Date startDate
	Date originalStartDate
	
	Date plannedCompleteDate
	Date originalPlannedCompleteDate
	
	boolean current
	boolean freestyle
	
	Date actualCompleteDate

	Date dateCreated
	Date lastUpdated
		
	Account account
	Competition competition
	static belongsTo = [Account, Competition]
	
	static hasMany = [ plannedWorkouts : PlannedWorkout, weeks : Week, accolades : Accolade, progressPhotos : ProgressPhoto ]
	
	
    static mapping = {
    	sort startDate: "desc"
		plannedWorkouts sort: "actualWorkoutDate", order: "desc"
	}
	
    static constraints = {
		title(nullable:false)
		name(nullable:true)
		planVersion(nullable:false)
		status(nullable:true)
		description(nullable:true)
		startDate(nullable:true)
		originalStartDate(nullable:true)
		plannedCompleteDate(nullable:true)
		originalPlannedCompleteDate(nullable:true)
		current(nullable:true)
		freestyle(nullable:true, default:false)
		actualCompleteDate(nullable:true)
		progressPhotos(nullable:true)
		competition(nullable:true)
		totalPoints(nullable:true, default: 0)
		totalCompleted(nullable:true, default: 0)
		totalSkipped(nullable:true, default: 0)
		totalRemaining(nullable:true, default: 0)
		id generator: 'sequence', params:[sequence:'ID_WORKOUT_PLAN_PK_SEQ']
    }

}
