package org.motus.workouts

import org.springframework.dao.DataIntegrityViolationException
import org.apache.shiro.SecurityUtils
import org.motus.log.SkippedWorkoutLog
import org.motus.Account
import org.motus.BaseController
import org.motus.BasePlannedWorkoutController

import org.motus.common.AccoladeType
import org.motus.common.AccoladeDescription
import org.motus.common.AccoladePoints
import org.motus.AppConstants
import org.motus.WorkoutPlan
import org.motus.common.WorkoutPlanStatus
import org.motus.Accolade

@Mixin( BasePlannedWorkoutController )
class LegsBackController {

    static allowedMethods = [save: "POST", update: "POST", remove: "POST"]

	def emailService
	def accountService
	def accoladeService
	def workoutPlanService
	def textMessageService
	

    def index() {
        redirect(controller: 'workoutPlan', action: "history")
    }

	
	def logWorkout(){
		withBaseLogWorkout { account, workoutPlan, view ->
			def plannedWorkout = new LegsBack(params)
			plannedWorkout.includeAbRipper = true
			request.plannedWorkout = plannedWorkout

			def previous = LegsBack.findByWorkoutPlan(workoutPlan, [sort: "actualWorkoutDate", order: "desc"])
			request.previous = previous
			
			request.account = account
			render(view : view)
		}
	}
	

    def show(Long id) {
		withBaseShow { view ->
			render(view : view)
		}
    }
	

    def update(Long id, Long version) {
		withBaseUpdate { message ->
			flash.message = message
			redirect(controller: 'account',  action: 'dashboard')	
		}
	}
	
	
	def entry(Long id){
		withBaseEntry { account, plannedWorkout, view ->
			request.plannedWorkout = plannedWorkout
			request.account = account
			def previous = LegsBack.findByWorkoutPlan(plannedWorkout.workoutPlan, [sort: "actualWorkoutDate", order: "desc"])
			println "PREVIOUS : ${previous?.actualWorkoutDate}"
			request.previous = previous
			render(view : view)
		}
	}
		
		
	def changeDate(Long id){
		withPlannedWorkout { legsBackInstance, account ->
			request.plannedWorkout = legsBackInstance
			render(view : AppConstants.CHANGE_DATE_VIEW)
		}
	}	
	
	
	def confirmSkip(Long id){
		withBaseConfirmSkip { view ->
			render(view : view)
		}
	}
	
	
	def skip(Long id){
		withBaseSkip { legsBackInstance ->
			flash.message = AppConstants.SKIP_SUCCESSFUL_MESSAGE
			redirect(controller: 'account', action: 'dashboard')
		}
	}


	def confirmRecover(Long id){
		withBaseConfirmRecover { view ->
			render(view : view)
		}
	}
		
	
	def recover(Long id){
		withBaseRecover { legsBackInstance ->
			flash.message = AppConstants.RECOVERY_SUCCESSFUL_MESSAGE
			redirect(controller: 'account', action: 'dashboard')
		}
	}
	
	
	def remove(Long id){
		withBaseRemove { legsBackInstance ->
			flash.message = "Successfully removed workout from schedule"
			redirect(controller:'account',  action: 'dashboard')
		}
	}
	
	
	def save(){
		withBaseSave { account, workoutPlan ->
		
			def legsBackInstance = new LegsBack()
			
			legsBackInstance.properties = params
			legsBackInstance.includeAbRipper = true
			
			legsBackInstance.actualWorkoutDate = params.actualWorkoutDate
			legsBackInstance.plannedWorkoutDate = params.actualWorkoutDate
			legsBackInstance.originalPlannedWorkoutDate = params.actualWorkoutDate
			
			legsBackInstance.workoutPlan = workoutPlan
			legsBackInstance.account = account
			legsBackInstance.save(flush:true)
			
			workoutPlan.addToPlannedWorkouts(legsBackInstance)
			workoutPlan.save(flush:true)
        	
			accoladeService.processWorkoutLogged(account, legsBackInstance)
			accoladeService.processAbRipperLogged(account, legsBackInstance)
			
			calculateAccountStats(account, workoutPlan)
			calculateWorkoutPlanStats(account, workoutPlan)
			checkAddToCompetitionStats(legsBackInstance, account)
			updateCompetitionStatsAndStandings(account)
			sendMotivationMessages(account)
			
			def accolades = Accolade.findAllByPlannedWorkout(legsBackInstance)
			def points = calculatePoints(accolades)
			
			checkCompletedWorkoutPlan(account, legsBackInstance, legsBackInstance.workoutPlan)
			
			flash.message = '<strong>+' + points + ' points. Good Job!</strong> Successfully completed ' + legsBackInstance.displayName + '.  <a href="/bringit/' + legsBackInstance.link + '/show/' + legsBackInstance.id + '">Review Workout</a>'	
				
			redirect(controller:'account',  action: 'dashboard')
			
		}
	}	
	
}
