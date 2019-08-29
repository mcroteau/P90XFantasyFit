package org.motus

import org.motus.CompetitionInvite
import org.motus.common.CompetitionStatus
import org.motus.CompetitionStats

//http://ryanalberts.com/92/grails-findby-for-hasmany-relationship/

class Competition {

	Date startDate
	Date endDate
	
	String name
	boolean current
	
	String status
	Date dateCompleted
	
	
	Date dateCreated
	Date lastUpdated
	
	int memberRank
	static transients = ['memberRank']
	
	static belongsTo = [ account : Account ]
	
	static hasMany = [ members : Account, workoutPlans : WorkoutPlan, invites : CompetitionInvite, competitionStats : CompetitionStats ]



    static constraints = {
		name(nullable:false, blank:false)
		current(nullable:false, default:true)
		startDate(nullable:false)
		endDate(nullable:false)
		status(nullable:false)
		dateCompleted(nullable:true)
		memberRank(nullable:true)
		id generator: 'sequence', params:[sequence:'ID_COMPETITION_SEQ']
    }
	
	
	static Competition findCurrentCompetitionByMember(Account member){
		def c = Competition.createCriteria()
		return c.get {
			eq("current", true)
			members {
				idEq(member.id)
			}
		}
	}
	
}
