package org.motus

import grails.plugin.springsecurity.annotation.Secured
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

@Mixin( BaseController )
class WorkoutPlanController {

	def accountService
	def workoutPlanService
	def workoutPlanOptionService
	
	def springSecurityService
	
	
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]


	
	
	
	def adjustmentSelect(){
		withWorkoutPlanAndPlannedWorkout { workoutPlan, plannedWorkout ->
			[workoutPlan : workoutPlan, plannedWorkout : plannedWorkout]
		}
	}

	
	
	def confirmAdjustment(){
		withWorkoutPlanAndPlannedWorkout { workoutPlan, plannedWorkout ->
		
			def adjustment = plannedWorkout.actualWorkoutDate - plannedWorkout.plannedWorkoutDate
			def completeDate = workoutPlan.plannedCompleteDate + adjustment
			def completeDateCal = completeDate.toCalendar()
			
			[ workoutPlan : workoutPlan, plannedWorkout : plannedWorkout, completeDateCal : completeDateCal ]
		}	
	}


	
	
	def adjust(){
		withWorkoutPlanAndPlannedWorkout { workoutPlan, plannedWorkout ->
			def adjustment = plannedWorkout.actualWorkoutDate - plannedWorkout.plannedWorkoutDate
			workoutPlan.plannedCompleteDate = workoutPlan.plannedCompleteDate + adjustment
			
			adjustWorkouts(adjustment, workoutPlan)
			
			def adjustmentLog = new AdjustmentLog()
			adjustmentLog.account = workoutPlan.account
			adjustmentLog.workoutPlan = workoutPlan
			
			adjustmentLog.startDate = workoutPlan.startDate
			workoutPlan.startDate = workoutPlan.startDate + adjustment
			adjustmentLog.adjustedStartDate = workoutPlan.startDate
			
			adjustmentLog.plannedCompleteDate = workoutPlan.plannedCompleteDate
			workoutPlan.plannedCompleteDate = workoutPlan.plannedCompleteDate + adjustment
			adjustmentLog.adjustedPlannedCompleteDate = workoutPlan.plannedCompleteDate
			
			adjustmentLog.adjustment = adjustment
			
			adjustmentLog.save(flush:true)
			workoutPlan.save(flush:true)
			
			flash.message = "Successfully adjusted schedule"
			redirect(controller:'account', action:'dashboard')
		}
	}
	
	

	
	
	def adjustWorkouts(adjustment, workoutPlan){
		workoutPlan.plannedWorkouts.each { workout ->
			if(!workout.completed && !workout.skipped){
				def date = workout.plannedWorkoutDate + adjustment
				println "${workout.plannedWorkoutDate} : ${adjustment} : ${date}"
				workout.plannedWorkoutDate = date
				workout.save(flush:true)
			}
		}		
	}
	
	
	
	
	def revert(workoutPlan){
		workoutPlan.plannedWorkouts.each { workout ->
			workout.originalPlannedWorkoutDate = workout.plannedWorkoutDate
			workout.save(flush:true)
			flash.message = "Something went wrong"
			redirect(controller : 'account', action: 'dashboard')
		}
	}
	
	
	
	
	
	def refresh(){
		workoutPlanOptionService.refresh()
		flash.message = "Successfully refreshed plans"
	}
	
	
	
	
	def selectVersion(){
		authenticated { subject ->
			def view = "/workoutPlan/selectVersion"
		
			withMobileDevice { device ->
				view = "/workoutPlan/selectVersionMobile"
			}
			
			render(view : view)
			
		}
	}
	
	
	
	def selectPlan(){
		authenticatedAccount { account ->	
		
			def currentPlan = WorkoutPlan.findByAccountAndCurrentAndStatus(account, true, WorkoutPlanStatus.ACTIVE.description())
			if(currentPlan){
				flash.message = "You must stop your current plan before creating a new one."
				redirect(controller : 'account', action: 'dashboard')
				return
			}
			
			def view = "/workoutPlan/selectPlan"
	
			withMobileDevice { device ->
				view = "/workoutPlan/selectPlanMobile"
			}
			
			
			def workoutPlans
			workoutPlanOptionService.refresh()
			
			if(params.planVersion){
				switch(params.planVersion){
					case 'one' : 
						request.planVersion = 'one'
						workoutPlans = workoutPlanOptionService.getVersionOneWorkoutPlans()
						break
					case 'two' : 
						request.planVersion = 'two'
						break
					case 'three' :
						request.planVersion = 'three'
						break
				}
				
				request.planName = params.planName
				request.workoutPlans = workoutPlans 

				render(view : view)
				
			}
		}
	}

	
	

	
	
	def setup(){
		authenticatedAccount { account ->
		
			def currentPlan = WorkoutPlan.findByAccountAndCurrentAndStatus(account, true, WorkoutPlanStatus.ACTIVE.description())
			if(currentPlan){
				flash.message = "You must stop your current plan before creating a new one."
				redirect(controller : 'account', action: 'dashboard')
				return
			}
			
			
			if(params.planVersion && params.workoutPlan){
				
				def view = "/workoutPlan/setup"
	
				withMobileDevice { device ->
					view = "/workoutPlan/setup_mobile"
				}
				
				
				def workoutPlan
				switch(params.planVersion){
					case 'one' : 
						workoutPlan = workoutPlanOptionService.getVersionOneWorkoutPlan(params.workoutPlan)
						request.planVersion = 'one'
						break
					case 'two' : 
						request.planVersion = 'two'
						break
					case 'three' :
						request.planVersion = 'three'
						break
				}
				
				println "here..."
				workoutPlan.properties.each {
					println "${it.key} -> ${it.value}"
				}
				
				
				request.planName = params.planName
				request.workoutPlan = workoutPlan
				
				render(view: view)	
	
			}else{
				flash.message = ""
				redirect(controller:'account', action:'dashboard')
			}
		}
	}
	
	

	
	private def getCurrentCompleteStoppedPlan(account){
		def criteria = WorkoutPlan.createCriteria()
		def plan = criteria.get{
		     and{
			 	eq("account", account)
			 	eq("current", true)
			 	or{
			     	eq("status", WorkoutPlanStatus.COMPLETED.description())
			     	eq("status", WorkoutPlanStatus.STOPPED.description())
				}
		     }
		}
		return plan
	}
	
	
	
	
	def freestyle(){
		authenticatedAccount { account ->
				
			def currentPlan = WorkoutPlan.findByAccountAndCurrentAndStatus(account, true, WorkoutPlanStatus.ACTIVE.description())
			if(currentPlan){
				flash.message = "You must stop your current plan before creating a new one."
				redirect(controller : 'account', action: 'dashboard')
			}
			
			
			def completeStoppedPlan = getCurrentCompleteStoppedPlan(account)
			if(completeStoppedPlan){
				completeStoppedPlan.current = false
				completeStoppedPlan.save(flush:true)
			}
		}
	}
	
	
	
	
	
	def save_freestyle(){
		authenticatedAccount { account ->
				
			def currentPlan = WorkoutPlan.findByAccountAndCurrentAndStatus(account, true, WorkoutPlanStatus.ACTIVE.description())
			if(currentPlan){
				flash.message = "You must stop your current plan before creating a new one."
				redirect(controller : 'account', action: 'dashboard')
			}
			
			
			def completeStoppedPlan = getCurrentCompleteStoppedPlan(account)
			if(completeStoppedPlan){
				completeStoppedPlan.current = false
				completeStoppedPlan.save(flush:true)
			}
			
			
			if(!params.title){
				flash.message = "Please give your freestyle plan a name"
				redirect(action : 'freestyle')
				return
			}
				
				
			def workoutPlan = new WorkoutPlan()
			workoutPlan.status = WorkoutPlanStatus.ACTIVE.description()
			workoutPlan.freestyle = true
			workoutPlan.current = true
			workoutPlan.account = account	
			workoutPlan.title = params.title
			workoutPlan.name = "Freestyle"
			workoutPlan.planVersion = "Freestyle"
			workoutPlan.startDate = new Date()
			workoutPlan.originalStartDate = new Date() 
			workoutPlan.plannedCompleteDate = new Date() + 90
			workoutPlan.originalPlannedCompleteDate = new Date() + 90
			workoutPlan.description = "No Schedule, Pick and choose workouts as you go..."
			workoutPlan.save(flush:true)
			
			account.addToPermissions("workoutPlan:edit:${workoutPlan.id}")
			account.save(flush:true)
			
			flash.message = "Congratulations on new beginnings"
			redirect controller:'account', action:'dashboard'
		}
	}
	
	
	
	
	
	def start(){

		authenticatedAccount { account ->
			
			
			def currentPlan = WorkoutPlan.findByAccountAndCurrentAndStatus(account, true, WorkoutPlanStatus.ACTIVE.description())
			if(currentPlan){
				flash.message = "You must stop your current plan before creating a new one."
				redirect(controller : 'account', action: 'dashboard')
				return
			}
			
			
			def completeStoppedPlan = getCurrentCompleteStoppedPlan(account)
			if(completeStoppedPlan){
				completeStoppedPlan.current = false
				completeStoppedPlan.save(flush:true)
			}
			
			
			def plan
			switch(params.planVersion){
				case 'one' : 
					plan = workoutPlanOptionService.getVersionOneWorkoutPlan(params.workoutPlan)
					break
				case 'two' : 
					break
				case 'three' :
					break
			}
			
			println "TITLE : ${params.title}"
			
			if(params.startDate && params.title){
				def workoutPlan = workoutPlanService.createWorkoutPlan( account, params.title, plan, params.startDate )
				if(workoutPlan){
					flash.message = "Congratulations on new beginnings"
					redirect controller:'account', action:'dashboard'
				}
			}else{
				flash.error = "Please make sure you give your workout plan a title"
				redirect(action:'setup', params : [ planVersion : params.planVersion, workoutPlan : params.workoutPlan ])
			}
			
		}
		
	}
	
	
	
	
	def current(){
		def subject = SecurityUtils.getSubject();
		
		if(subject.isAuthenticated()){
			
			def account = Account.findByUsername(subject?.getPrincipal())
			
			def currentPlan = WorkoutPlan.findByAccountAndCurrent(account, true)
			
			if(currentPlan){		
				[ currentPlan : currentPlan ]
			}else{
				flash.message = "You currently have no plan started"
				redirect action:'select'
			}
		}
	}
	
	
	
	
	def confirmStop(){
		authenticatedAccount { account ->
			
			def currentPlan = WorkoutPlan.findByAccountAndCurrentAndStatus(account, true, WorkoutPlanStatus.ACTIVE.description())
			
			if(currentPlan){		
			
				def view = "confirmStop"
				withMobileDevice { device ->
					view = "confirmStopMobile"
				}	

				request.currentPlan = currentPlan
				
				render(view : view)
				return 
				
			}else{
				flash.message = "You currently have no plan started"
				redirect action:'selectVersion'
			}
		}
	}
	
	
	
	
	def stop(){

		authenticatedAccount { account ->
			
			def currentPlan = WorkoutPlan.findByAccountAndCurrent(account, true)
			
			if(currentPlan){		
				currentPlan.status = WorkoutPlanStatus.STOPPED.description()
				currentPlan.save(flush:true)
				flash.message = "Successfully stopped workout plan. start a new one?"
				redirect action: 'selectVersion'
			}else{
				flash.message = "You currently have no plan started"
				redirect action:'select'
			}
		}
	}
	
	
	
    def index() {
        redirect(action: "list", params: params)
    }

	
	
	def planHistory(){
		def	workoutPlan
		def account
		
		if(params.accountId){
			account = Account.get(params.accountId)
			if(!account){
				flash.error = "Trouble finding plan history.  Please try again"
				redirect(controller : 'account', action: 'profile')
				return
			}
		}else{
			flash.error = "Trouble finding plan history.  Please try again"
			redirect(controller : 'account', action: 'profile')
			return
		}
		
		params.max = 10
		def workoutPlanList = WorkoutPlan.findAllByAccount(account, [ max : 10, sort: "id", order: "desc"])
		def workoutPlanCount = WorkoutPlan.countByAccount(account)
		
		[ account: account, workoutPlanList : workoutPlanList, workoutPlanCount: workoutPlanCount ]
	}
	
	
	
	def photos(String username){
		
		def	workoutPlan
		def account
		
		if(username){
			account = Account.findByUsername(username)
			workoutPlan = WorkoutPlan.findByAccountAndCurrent(account, true)
		}else if(params.id){
			workoutPlan = WorkoutPlan.get(params.id)
			account = workoutPlan.account
		}
		
		if(workoutPlan){
			def data = [:]

			def beforePhotos = ProgressPhoto.findAllByWorkoutPlanAndType(workoutPlan, PhotoType.BEFORE.description())
			def thirtyDayPhotos = ProgressPhoto.findAllByWorkoutPlanAndType(workoutPlan, PhotoType.THIRTY_DAY.description())
			def sixtyDayPhotos = ProgressPhoto.findAllByWorkoutPlanAndType(workoutPlan, PhotoType.SIXTY_DAY.description())
			def ninetyDayPhotos = ProgressPhoto.findAllByWorkoutPlanAndType(workoutPlan, PhotoType.NINETY_DAY.description())
			def workoutPlanList = WorkoutPlan.findAllByAccount(account)
			
			data.beforePhotos =  beforePhotos
			data.thirtyDayPhotos = thirtyDayPhotos
			data.sixtyDayPhotos = sixtyDayPhotos 
			data.ninetyDayPhotos = ninetyDayPhotos
			
			[ account : account, workoutPlan : workoutPlan, workoutPlanList: workoutPlanList, beforePhotos : beforePhotos, thirtyDayPhotos : thirtyDayPhotos, sixtyDayPhotos : sixtyDayPhotos, ninetyDayPhotos : ninetyDayPhotos ]
			
		}else{
			
			if(account){
				def workoutPlanList = WorkoutPlan.findAllByAccount(account)
				[ account : account, workoutPlanList : workoutPlanList ]
			}else{
				flash.error = "No photos can be found.  "
				redirect(controller:'account', action:'profile')
			}
		}
		
	}
	
	
	
	
	
	
	def details(Integer id){
		authenticatedAccount { account ->
			def	workoutPlan = WorkoutPlan.get(id)
			
			def completedWorkouts = PlannedWorkout.countByWorkoutPlanAndCompleted(workoutPlan, true)
			def incompleteWorkouts = PlannedWorkout.countByWorkoutPlanAndCompletedAndSkipped(workoutPlan, false, false)		
			def skippedWorkouts = PlannedWorkout.countByWorkoutPlanAndCompletedAndSkipped(workoutPlan, false, true)
			def totalWorkouts = PlannedWorkout.countByWorkoutPlan(workoutPlan)
			
			def percentComplete = (completedWorkouts + skippedWorkouts)/totalWorkouts
			def percent = Math.round(percentComplete * 100)
			
			
			def data = [:]
			data.percentComplete = percent
			data.totalWorkouts = totalWorkouts
			data.incompleteWorkouts = incompleteWorkouts
			data.completedWorkouts = completedWorkouts
			data.skippedWorkouts = skippedWorkouts
			
			def workoutPlanList = WorkoutPlan.findAllByAccount(account)

			def accolades = Accolade.findAllByWorkoutPlan(workoutPlan, [ max : 5, sort: "id", order: "desc" ])
			def accoladesCount = Accolade.countByWorkoutPlan(workoutPlan)
			
			[ account : account, workoutPlan : workoutPlan, workoutPlanList : workoutPlanList, data : data, accolades : accolades, accoladesCount: accoladesCount ]
		}
	}
	
	
	
	
	
	def history(String username){
	
		def	workoutPlan
		def account
		
		if(username){
			account = Account.findByUsername(username)
			workoutPlan = WorkoutPlan.findByAccountAndCurrent(account, true)
		}else if(params.id){
			workoutPlan = WorkoutPlan.get(params.id)
			account = workoutPlan.account
		}
		
		
		if(workoutPlan){
		
			params.max = 10
				
			def plannedWorkoutList = PlannedWorkout.findAllByWorkoutPlanAndCompleted(workoutPlan, true, [ max: 10, offset: params.offset, sort: "actualWorkoutDate", order: "desc" ])
			def plannedWorkoutTotal = PlannedWorkout.countByWorkoutPlanAndCompleted(workoutPlan, true);
			def workoutPlanList = WorkoutPlan.findAllByAccount(account)
			
    		[account : account, workoutPlan : workoutPlan, plannedWorkoutList: plannedWorkoutList, plannedWorkoutTotal: plannedWorkoutTotal, workoutPlanList : workoutPlanList]
			
		}else{
			println "\n\n NO WORKOUT PLAN FOUND \n\n"
			if(account){	
				def workoutPlanList = WorkoutPlan.findAllByAccount(account)
				[ account : account, workoutPlanList : workoutPlanList  ]
			}else{
				flash.error = "Problems accessing workout history."
				redirect(controller : 'account', action : 'profile')
			}
		}
		
	}
	
	
	
	
	
	
	def pickWorkout(){
		authenticatedAccount { account ->
			def view = "/workoutPlan/pickWorkout"
	
			withMobileDevice { device ->
				view = "/workoutPlan/pickWorkoutMobile"
			}
			request.account = account
			render(view : view)
		}
	}
	





	
	
    def update(Long id, Long version) {
		withWorkoutPlan {  workoutPlan ->
        	workoutPlan.properties = params        	
        	if (!workoutPlan.save(flush: true)) {
        	    render(view: "edit", model: [workoutPlanInstance: workoutPlan])
        	    return
        	}
        	
        	flash.message = "Workout Plan Successfully Updated"
        	redirect(action: "show", id: workoutPlan.id)
		}
    }
	
	
	
	
    def delete(Long id) {
		withWorkoutPlan {  workoutPlanInstance ->
        	try {
        	    workoutPlanInstance.delete(flush: true)
        	    flash.message = "Successfully Deleted workout plan"
        	    redirect(action: "list")
        	
			}catch (DataIntegrityViolationException e) {
        	    flash.message = "Something went wrong, please try again"
        	    redirect(action: "show", id: id)
        	}
		}
    }
	
	
	
	
	
	
	
	def workouts(){
		authenticatedAccount { account ->
			def workoutPlan = WorkoutPlan.findByAccountAndCurrent(account, true)	
			def plannedWorkoutList = PlannedWorkout.findAllByWorkoutPlanAndCompleted(workoutPlan, true)
			
    		[ account : account, workoutPlan : workoutPlan, plannedWorkoutList: plannedWorkoutList ]
		}
	}
	
	
	
	
	def plan(){
		authenticatedAccount { account ->
			def workoutPlan = WorkoutPlan.findByAccountAndCurrent(account, true)		
			
			def completedWorkouts = PlannedWorkout.countByWorkoutPlanAndCompleted(workoutPlan, true)
			def incompleteWorkouts = PlannedWorkout.countByWorkoutPlanAndCompletedAndSkipped(workoutPlan, false, false)		
			def skippedWorkouts = PlannedWorkout.countByWorkoutPlanAndCompletedAndSkipped(workoutPlan, false, true)
			
			
			def data = [:]
			data.incompleteWorkouts = incompleteWorkouts
			data.completedWorkouts = completedWorkouts
			data.skippedWorkouts = skippedWorkouts
			
		
			[ account : account, workoutPlan : workoutPlan, data : data ]
			
		}
	}
	
	
	
	
	
	def completed(){
		println "\n\n BEFORE BULLSHIT \n\n"
		authenticatedAccount { account ->
		
			try{
				def view = "completed"
            	
				withMobileDevice { device ->
					view = "completed_mobile"
				}
				
				def workoutPlan = WorkoutPlan.findByAccountAndCurrent(account, true)	
            	
				request.account = account
				request.workoutPlan = workoutPlan
				request.totalPoints = workoutPlan.totalPoints
				
				render(view : view)
				
			}catch(Exception e){
				println "\n Caught that shit \n"
			}
		}
	}
	
	
	
	
	
	def schedule(String username){
		def account
		
		if(username){
			account = Account.findByUsername(username)
		}else{
			def subject = SecurityUtils.getSubject();
			if(!subject.isAuthenticated()){
				flash.message = "Please sign in to continue"
				forward(controller : 'auth', action: 'login')
			}
			account = Account.findByUsername(subject.principal)			
		}
	
		if(!account){
			flash.error = "Member account cannot be found"
			redirect(action:'members')
			return
		}
		
		def workoutPlan = WorkoutPlan.findByAccountAndCurrent(account, true)
		
		[ workoutPlan : workoutPlan, account : account ]	
	}
	
	
	
	
	
	def workout_data(Integer id){
		if(params.id){
			def account = Account.get(params.id)
			def data = accountService.getDashboardData(account.username)
			render data.workouts
		}
	}
	
	
	
	
	def schedule_mobile(){
		println "here...."
		authenticatedAccount { account ->
			println "wp account : " + account
			def workoutPlan = WorkoutPlan.findByAccountAndCurrent(account, true)
			def plannedWorkoutList = PlannedWorkout.findAllByWorkoutPlan( workoutPlan, false, false)
			
			println "schedule moble..."		
		
			[account : account, workoutPlan: workoutPlan, plannedWorkoutList: plannedWorkoutList]
		}
		
	}
	
	
	
	def schedule_list(){
		authenticatedAccount { account ->
    	
			def workoutPlan = WorkoutPlan.findByAccountAndCurrent(account, true)
			def plannedWorkoutList = PlannedWorkout.findAllByWorkoutPlan( workoutPlan, false, false)
		
			[account : account, workoutPlan: workoutPlan, plannedWorkoutList: plannedWorkoutList]		
		}
	}
	
	
	
	
	def accolades(String username){
		def	workoutPlan
		def account
		
		if(username){
			account = Account.findByUsername(username)
			workoutPlan = WorkoutPlan.findByAccountAndCurrent(account, true)
		}else if(params.id){
			workoutPlan = WorkoutPlan.get(params.id)
			account = workoutPlan.account
		}
		
		if(workoutPlan){
			
			def accolades = Accolade.findAllByWorkoutPlan(workoutPlan, [ sort: "id", order: "desc" ])
			def workoutPlanList = WorkoutPlan.findAllByAccount(account)
			
			[ account : account, workoutPlan : workoutPlan, accolades : accolades, workoutPlanList : workoutPlanList ]
			
		}else{
			
			if(account){
				def workoutPlanList = WorkoutPlan.findAllByAccount(account)
				[ account : account, workoutPlanList : workoutPlanList ]
			}else{
				flash.error = "No accolades yet.  Start logging workouts to earn points"
				redirect(controller:'account', action:'profile')
			}
		}
	}
	
	
}
