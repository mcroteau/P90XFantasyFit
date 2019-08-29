package org.motus

import org.apache.shiro.SecurityUtils
import org.motus.common.CompetitionStatus
import org.motus.common.RoleName
import org.springframework.dao.DataIntegrityViolationException
import grails.core.GrailsDomainClass
import java.util.GregorianCalendar
import org.apache.shiro.SecurityUtils
import org.motus.common.WorkoutPlanStatus
import org.motus.Account
import org.motus.workouts.PlannedWorkout
import org.motus.BaseController
import grails.converters.*
import org.motus.log.AdjustmentLog
import org.motus.ProgressPhoto
import org.motus.common.PhotoType
import org.motus.common.AccoladeType
//import groovyx.gpars.GParsExecutorsPool
import java.util.concurrent.atomic.AtomicInteger


@Mixin( [BaseController, BasePlannedWorkoutController] )
class MockDataController {

	def textMessageService
	def springSecurityService
	
	def fix(){	
		def subject = SecurityUtils.getSubject();
		if(!subject.hasRole(RoleName.ROLE_ADMIN.description())){
			flash.message = "How did you get here?"
			redirect(controller : 'account', action : 'dashboard')
			return
		}
	
		def accounts = Account.findAll()
		accounts.each{ account ->
			def workoutPlan = WorkoutPlan.findByAccountAndCurrentAndStatus(account, true, WorkoutPlanStatus.ACTIVE.description())
			if(workoutPlan){
				calculateAccountStats(account, workoutPlan)
				calculateWorkoutPlanStats(account, workoutPlan)
				updateCompetitionStatsAndStandings(account)
			}
		}
	}



	def threads(){
		//def counter = new AtomicInteger()

		def th = Thread.start {
		    for( i in 1..3 ) {
		        println "thread loop $i"
				textMessageService.send("+13019564264", "Test" + 1)
		        //counter.incrementAndGet()
		    }
		}

		for( j in 1..4 ) {
		    println "main loop $j"
		}
		
		def d = [:]
		render d as JSON
	}
	

	def gpars(){
		/**
		GParsExecutorsPool.withPool {
			def sendTextMessage = { number, message ->
				textMessageService.send(number, message)
			}
			
			def d = [:]
			render d as JSON
			
			sendTextMessage.callAsync("+13019564264", "Test 1")
			sendTextMessage.callAsync("+13019564264", "Test 2")
			sendTextMessage.callAsync("+13019564264", "Test 3")
		}
		**/
	}
	


	def create_competition(){
		
		def subject = SecurityUtils.getSubject();
		if(!subject.hasRole(RoleName.ROLE_ADMIN.description())){
			flash.message = "How did you get here?"
			redirect(controller : 'account', action : 'dashboard')
			return
		}	
			
		def mock1 = Account.findByUsername('mock1')
		
		def competition = new Competition()		
		
		def startDate = new Date()
		def endDate = new Date() + 14
		
		competition.name = "Bootstrappin this thang"
		competition.current = true
		competition.startDate = startDate
		competition.endDate = endDate
		competition.status = CompetitionStatus.ACTIVE.description()
		competition.account = mock1
		competition.addToMembers(mock1)
		competition.save(flush:true)
		
		mock1.addToPermissions("competition:edit:${competition.id}")
		mock1.save(flush:true)
		
		
		
		def stats = new CompetitionStats()
		stats.account = mock1
		stats.competition = competition
		stats.save(flush:true)
		
		
		
		def stats1 = new CompetitionStats()
		stats1.account = mock1
		stats1.competition = competition
		stats1.save(flush:true)
		
		
		
		def mock2 = Account.findByUsername('mock2')
		competition.addToMembers(mock2)
		competition.save(flush:true)
		
		def stats2 = new CompetitionStats()
		stats2.account = mock2
		stats2.competition = competition
		stats2.save(flush:true)
		
		
		def mock3 = Account.findByUsername('mock3')
		competition.addToMembers(mock3)
		competition.save(flush:true)
		
		def stats3 = new CompetitionStats()
		stats3.account = mock3
		stats3.competition = competition
		stats3.save(flush:true)
		
		println "** competition : ${Competition.count()}"
		println "** members : ${competition.members?.size()} **"

	}

}