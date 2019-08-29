package org.motus


import org.motus.common.RoleName
import org.apache.shiro.SecurityUtils
import org.motus.workouts.PlannedWorkout
import org.motus.Account
import org.motus.log.SkippedWorkoutLog
import org.motus.common.AccoladeType
import org.motus.common.AccoladeDescription
import org.motus.common.AccoladePoints
import org.motus.AppConstants
import org.motus.common.WorkoutPlanStatus


//http://mrpaulwoods.wordpress.com/2011/01/23/a-pattern-to-simplify-grails-controllers/

class BaseController {
	
	private def authenticated(Closure c){
	
		def subject = SecurityUtils.getSubject();
	
		if(!subject.isAuthenticated()){
			flash.message = "Please sign in to continue"
			redirect(controller : 'auth', action: 'login')
			return
		}
		
		c.call subject
	}
	
	
	
	private def authenticatedAccount(Closure c){
		def subject = SecurityUtils.getSubject();
	
		if(!subject.isAuthenticated()){
			flash.message = "Please sign in to continue"
			redirect(controller : 'auth', action: 'login')
			return
		}
		
		def account = Account.findByUsername(subject.principal)
		
		if(!account){
			flash.message = "Please login to continue"
			redirect(controller: 'auth', action: 'login')
			return
		}else{
			c.call account
		}
		
	}
	



	private def withWorkoutPlan(Closure c) {
	
		def subject = SecurityUtils.getSubject();
	
		if(!subject.isAuthenticated()){
			flash.message = "Please sign in to continue"
			redirect(controller : 'auth', action: 'login')
			return
		}
			
		if(!params.id){
			flash.message = "Workout plan not found"
			redirect(controller : 'account', action: 'dashboard')
			return
		}	
			
		if(subject.isPermitted("workoutPlan:edit:${params.id}") ||
			subject.hasRole(RoleName.ROLE_ADMIN.description())){
			def workoutPlan = WorkoutPlan.findById(params.id)
			c.call workoutPlan
		}else{
			flash.message = "Unauthorized to access workout"
			redirect(controller : 'account', action: 'dashboard')
		}
    }
	
	
	
	
	
	
	private def withWorkoutPlanAndPlannedWorkout(Closure c){
	
		def subject = SecurityUtils.getSubject();
    	
		if(!subject.isAuthenticated()){
			flash.message = "Please sign in to continue"
			redirect(controller : 'auth', action: 'login')
			return
		}
			
		if(!params.workoutPlanId){
			println "\n\n REDIRECT FROM ADJUST SELECT : ${params}"
			flash.message = "Workout Plan not found"
			//redirect(controller : 'account', action: 'dashboard')
			redirect(controller : 'account', action: 'dashboard')
			return
		}	
			
		if(!params.plannedWorkoutId){
			flash.message = "Workout not found"
			redirect(controller : 'account', action: 'dashboard')
			return
		}	
			
		if(subject.isPermitted("workoutPlan:edit:${params.workoutPlanId}") ||
			subject.hasRole(RoleName.ROLE_ADMIN.description())){
			
			def workoutPlan = WorkoutPlan.findById(params.workoutPlanId)
			def plannedWorkout = PlannedWorkout.get(params.plannedWorkoutId)	
			
			if(!workoutPlan){
				flash.message = "Workout Plan not found"
				redirect(controller : 'account', action: 'dashboard')
				return
			}
			
			if(!plannedWorkout){
				flash.message = "Workout not found"
				redirect(controller : 'account', action: 'dashboard')
			}
			
			c.call workoutPlan, plannedWorkout
		}else{
			flash.message = "Unauthorized to access workout"
			redirect(controller : 'account', action: 'dashboard')
			return
		}
	}
	
	
	private def withMobileDevice(Closure c){
		if( request.currentDevice.isMobile()){
			c.call request.currentDevice
		}
	}
	
	
}