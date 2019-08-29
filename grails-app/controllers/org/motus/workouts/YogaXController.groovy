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
class YogaXController {

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
			def plannedWorkout = new YogaX(params)
			plannedWorkout.includeAbRipper = true
			request.plannedWorkout = plannedWorkout

			def previous = YogaX.findByWorkoutPlan(workoutPlan, [sort: "actualWorkoutDate", order: "desc"])
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
			def previous = YogaX.findByWorkoutPlan(plannedWorkout.workoutPlan, [sort: "actualWorkoutDate", order: "desc"])
			println "PREVIOUS : ${previous?.actualWorkoutDate}"
			request.previous = previous
			render(view : view)
		}
	}
		
		
	def changeDate(Long id){
		withPlannedWorkout { yogaXInstance, account ->
			request.plannedWorkout = yogaXInstance
			render(view : AppConstants.CHANGE_DATE_VIEW)
		}
	}	
	
	
	def confirmSkip(Long id){
		withBaseConfirmSkip { view ->
			render(view : view)
		}
	}
	
	
	def skip(Long id){
		withBaseSkip { yogaXInstance ->
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
		withBaseRecover { yogaXInstance ->
			flash.message = AppConstants.RECOVERY_SUCCESSFUL_MESSAGE
			redirect(controller: 'account', action: 'dashboard')
		}
	}
	
	
	def remove(Long id){
		withBaseRemove { yogaXInstance ->
			flash.message = "Successfully removed workout from schedule"
			redirect(controller:'account',  action: 'dashboard')
		}
	}
	
	
	def save(){
		withBaseSave { account, workoutPlan ->
		
			def yogaXInstance = new YogaX()
			
			yogaXInstance.properties = params
			yogaXInstance.includeAbRipper = true
			
			yogaXInstance.actualWorkoutDate = params.actualWorkoutDate
			yogaXInstance.plannedWorkoutDate = params.actualWorkoutDate
			yogaXInstance.originalPlannedWorkoutDate = params.actualWorkoutDate
			
			yogaXInstance.workoutPlan = workoutPlan
			yogaXInstance.account = account
			yogaXInstance.save(flush:true)
			
			workoutPlan.addToPlannedWorkouts(yogaXInstance)
			workoutPlan.save(flush:true)
        	
			accoladeService.processWorkoutLogged(account, yogaXInstance)
			accoladeService.processAbRipperLogged(account, yogaXInstance)
			
			calculateAccountStats(account, workoutPlan)
			calculateWorkoutPlanStats(account, workoutPlan)
			checkAddToCompetitionStats(yogaXInstance, account)
			updateCompetitionStatsAndStandings(account)
			sendMotivationMessages(account)
			
			def accolades = Accolade.findAllByPlannedWorkout(yogaXInstance)
			def points = calculatePoints(accolades)
			
			checkCompletedWorkoutPlan(account, yogaXInstance, yogaXInstance.workoutPlan)
			
			flash.message = '<strong>+' + points + ' points. Good Job!</strong> Successfully completed ' + yogaXInstance.displayName + '.  <a href="/bringit/' + yogaXInstance.link + '/show/' + yogaXInstance.id + '">Review Workout</a>'	
				
			redirect(controller:'account',  action: 'dashboard')
			
		}
	}	
	
}
