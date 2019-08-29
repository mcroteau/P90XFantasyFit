package org.motus

import org.apache.shiro.crypto.hash.Sha256Hash
import org.apache.shiro.authc.UsernamePasswordToken
import org.apache.shiro.SecurityUtils
import org.motus.common.RoleName
import org.motus.log.ResetPasswordLog
import org.motus.common.WorkoutPlanStatus
import org.motus.workouts.PlannedWorkout
import org.motus.WorkoutPlan
import org.motus.Account
import grails.converters.*
import java.util.UUID

class AccountService {
	
	static scope = "singleton"
	static transactional = true

	def quickSearchService

	def search(term){
		def query = "from Account a where UPPER(a.username) like UPPER('%${term}%') or UPPER(a.name) like UPPER('%${term}%')"
	  	
		//TODO: add pagination
		def accounts = Account.findAll(query)
			  			  
		println "\n\n*****  SEARCHING ${accounts}  *****\n\n"
		return accounts
	}


	
	
	

	
	def getDashboardData(username){
	
		def account = Account.findByUsername(username)
		
		def workoutPlans = WorkoutPlan.findAllByAccount(account)
		def currentPlan = WorkoutPlan.findByAccountAndCurrent(account, true)
		
		println "CURRENT PLAN ${currentPlan}"
		
		if(currentPlan){
		
			def workouts = new JSON(getFormattedCalendarJSON(currentPlan.plannedWorkouts))
			def totalWorkouts = PlannedWorkout.countByWorkoutPlan(currentPlan)
			def totalCompletedSkipped = currentPlan.totalCompleted + currentPlan.totalSkipped
			def percentComplete = 0
			if(totalCompletedSkipped){
				percentComplete = totalCompletedSkipped/totalWorkouts
			}

			def percent = Math.round(percentComplete * 100)
		
			def today = getToday();
			def todaysWorkout = PlannedWorkout.findByWorkoutPlanAndPlannedWorkoutDateAndExtra(currentPlan, today, false)
			
			def dashboardData = new DashboardData();
			
			if(todaysWorkout)dashboardData.todaysWorkout = todaysWorkout
			
			dashboardData.workouts = workouts.toString()
			
			dashboardData.currentPlan = currentPlan
			dashboardData.workouts = workouts

			dashboardData.totalWorkouts = totalWorkouts
			dashboardData.totalCompletedSkipped = totalCompletedSkipped
			dashboardData.percentComplete = percent
			
			def accoladesCount = Accolade.countByWorkoutPlan(currentPlan)
			def accolades = Accolade.findAllByWorkoutPlan(currentPlan, [max : 5, sort: "dateCreated", order: "desc" ])
			dashboardData.accolades = accolades
			dashboardData.accoladesCount = accoladesCount
			
			println "\n\n MADE IT THIS FAR NO ERRORS \n\n"
			
			return dashboardData
			
		}else{
			return [:]
		}
	
	}
	
	def getToday(){
	
		def todayPre = new Date()
		Calendar cal = Calendar.getInstance(); // locale-specific
		cal.setTime(todayPre);
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		long time = cal.getTimeInMillis();
		
		return new Date(time)
	}
	
	

	
	def getFormattedCalendarJSON(plannedWorkouts){
		def entries = []
		
		def z = 0
		plannedWorkouts.each{ 
		
			def day   
			def month 
			def year
			def css = ''
			def action = 'show'
			
			
			if(it.completed){

				css = 'completed'
				action = 'show'
			
				day   = it.actualWorkoutDate.getAt(Calendar.DAY_OF_MONTH)
				month = it.actualWorkoutDate.getAt(Calendar.MONTH) + 1
				year  = it.actualWorkoutDate.getAt(Calendar.YEAR)	
			}else{
				day   = it.plannedWorkoutDate.getAt(Calendar.DAY_OF_MONTH)
				month = it.plannedWorkoutDate.getAt(Calendar.MONTH) + 1
				year  = it.plannedWorkoutDate.getAt(Calendar.YEAR)		
			}

			
			if(it.skipped){
				css = 'skipped'
			}
			
			if(!it.skipped && !it.completed){
				css = 'incomplete'
			}
				
				
			def entry = [
				id        : it.id,
				title     : it.displayName,
				url       : '/bringit/' + it.link + "/${action}/" + it.id,
				completed : it.completed,
				class     : css,
				start     : year + '-' + String.format("%02d", month) + '-' + String.format("%02d", day)
			]
    		
			entries.add(entry)
			z++
			
		}
		
		return entries
	}
	
	
}
