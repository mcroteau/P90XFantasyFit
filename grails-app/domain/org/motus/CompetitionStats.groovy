package org.motus

import org.motus.workouts.PlannedWorkout

class CompetitionStats {

	int rank
	int totalPoints
	int totalCompleted
	boolean finished
	
	Date dateCreated
	Date lastUpdated

	Account account
	Competition competition
	static belongsTo = [ Account, Competition ]
	
	static hasMany = [ accolades : Accolade, plannedWorkouts : PlannedWorkout ]
	
    static constraints = {
		rank nullable:true, default:1
		totalPoints nullable:true, default: 0
		totalCompleted nullable:true, default: 0
		finished nullable:true, default:false
		id generator: 'sequence', params:[sequence:'ID_COMPETITION_STATS_SEQ']
    }
	
}
