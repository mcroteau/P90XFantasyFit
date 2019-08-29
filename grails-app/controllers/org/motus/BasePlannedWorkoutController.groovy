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
import org.motus.common.CompetitionStatus
import groovy.text.SimpleTemplateEngine
import static grails.async.Promises.*

//import groovyx.gpars.GParsExecutorsPool


//http://mrpaulwoods.wordpress.com/2011/01/23/a-pattern-to-simplify-grails-controllers/
//http://www.ibm.com/developerworks/library/j-gpars/
class BasePlannedWorkoutController {

	def accoladeService
	def textMessageService
	def emailService
	
	BasePlannedWorkoutController(){
		accoladeService = grailsApplication.classLoader.loadClass("org.motus.AccoladeService").newInstance()
		textMessageService = grailsApplication.classLoader.loadClass("org.motus.TextMessageService").newInstance()
		emailService = grailsApplication.classLoader.loadClass("org.motus.EmailService").newInstance()
	}

	private def withBaseLogWorkout(Closure c){

		def subject = SecurityUtils.getSubject();
		def account = getAuthenticatedAccount(subject)
		def workoutPlan = WorkoutPlan.findByAccountAndCurrent(account, true)
		
		def view = "/common/plannedWorkout/logWorkout"
		withMobileDevice { device ->
		      view = "/common/plannedWorkout/logWorkoutMobile"
		}
		
		c.call account, workoutPlan, view
		
	}

	
	
	private def withBaseEntry(Closure c) {
		
		def view = AppConstants.ENTRY_VIEW
		withMobileDevice { device ->
		      view = "/common/plannedWorkout/entry_mobile"
		}
			
		def subject = SecurityUtils.getSubject()
		def account = getAuthenticatedAccount(subject)
		def plannedWorkout = getPlannedWorkoutById(params.id)

		if(subject.isPermitted("workoutPlan:edit:${plannedWorkout?.workoutPlan?.id}") ||
			subject.hasRole(RoleName.ROLE_ADMIN.description())){
			
			if(!plannedWorkout.extra){
				def extraWorkout = PlannedWorkout.findByActualWorkoutDateAndWorkoutPlanAndExtra(plannedWorkout.plannedWorkoutDate, plannedWorkout.workoutPlan, true)
				
				request.extraWorkout = extraWorkout
			}
			
			c.call account, plannedWorkout, view
		}else{
			flash.message = "Unauthorized to access workout"
			redirect(controller : 'account', action: 'dashboard')
		    return
		}
		
    }
	
	
	
	
	private def withBaseShow(Closure c){
		
		def view = "/common/plannedWorkout/show"
		def action = "dashboard"
		withMobileDevice { device ->
		      view = "/common/plannedWorkout/show_mobile"
			  action = "dashboard"
		}
		
		if(params.id){
		
			def plannedWorkout = PlannedWorkout.get(params.id)

			if(plannedWorkout){

				def account = plannedWorkout.workoutPlan.account
				
				if(!plannedWorkout.extra){
					def extraWorkout = PlannedWorkout.findByActualWorkoutDateAndWorkoutPlanAndExtra(plannedWorkout.plannedWorkoutDate, plannedWorkout.workoutPlan, true)
			    	
					request.extraWorkout = extraWorkout
				}
			
				def accolades = Accolade.findAllByPlannedWorkout(plannedWorkout)
				def points = calculatePoints(accolades)
				
				request.points = points
				request.plannedWorkout = plannedWorkout
				request.account = account
				
				c.call view
				
			}else{
				flash.message = "Workout cannot be found"
				redirect(controller : 'account', action: action)
		    	return
			}
			
		}else{
			flash.message = "Workout cannot be found"
			redirect(controller: 'account', action : action)
		    return
		}		
		
	}
	
	
	
	private def withBaseSave(Closure c){
		
		def subject = SecurityUtils.getSubject();
		def account = getAuthenticatedAccount(subject)
		
		def currentPlan = WorkoutPlan.findByAccountAndCurrent(account, true)
		
		if(!currentPlan){
			flash.message = "Problem saving workout.  Please try again"
			redirect(controller: 'account', action : action)
			return
		}
		
		c.call account, currentPlan
	}
	
	
	
	
	//TODO : Refactor/cleanup 
	private def withBaseUpdate(Closure c) {
			
		def message = ""
        
		def subject = SecurityUtils.getSubject()
		def account = getAuthenticatedAccount(subject)
		def plannedWorkout = getPlannedWorkoutById(params.id)
		println "account : " + account
		
		if(subject.isPermitted("workoutPlan:edit:${plannedWorkout?.workoutPlan?.id}") ||
			subject.hasRole(RoleName.ROLE_ADMIN.description())){
			
			plannedWorkout.properties = params
			plannedWorkout.save(flush:true)
					
			//first update, used later if entry date is different from planned date
			def firstUpdate = false
			if(!plannedWorkout.updated){
				firstUpdate = true

				accoladeService = grailsApplication.classLoader.loadClass("org.motus.AccoladeService").newInstance()
				
				accoladeService.processWorkoutLogged(account, plannedWorkout)
				accoladeService.processAbRipperLogged(account, plannedWorkout)
			}
			
		
			if(params.notes){
				plannedWorkout.notes = params.notes
			}
		
			if(params.abRipperCompleted)
				plannedWorkout.abRipperCompleted = params.abRipperCompleted
		
		
			plannedWorkout.completed = true
			plannedWorkout.skipped = false
				
		
			if(!plannedWorkout.actualWorkoutDate){
				//TODO:why did I clear time?
				//def actualWorkoutDate = new Date().clearTime()
				def actualWorkoutDate = new Date()
				plannedWorkout.actualWorkoutDate = actualWorkoutDate
			}
			
			if(params.actualWorkoutDate){
				//TODO:why did I clear time?
				//def actualWorkoutDate = params.actualWorkoutDate.clearTime()
				def actualWorkoutDate = params.actualWorkoutDate
				println "actual workout date : ${actualWorkoutDate}"
				plannedWorkout.actualWorkoutDate = actualWorkoutDate
			}
		
		
			if (plannedWorkout.save(flush: true)) {
				
				def workoutPlan = plannedWorkout.workoutPlan
				checkCompletedWeek(account, plannedWorkout, workoutPlan)
				checkCompletedWorkoutPlan(account, plannedWorkout, workoutPlan)
				checkAddToCompetitionStats(plannedWorkout, account)
				calculateAccountStats(account, workoutPlan)
				calculateWorkoutPlanStats(account, workoutPlan)
				updateCompetitionStatsAndStandings(account)
				
				
				if(firstUpdate && differenceInEntryDate(plannedWorkout)){
					sendMotivationMessages(account)
					redirect(controller: 'workoutPlan', action: 'adjustmentSelect', params:[ workoutPlanId : plannedWorkout.workoutPlan.id, plannedWorkoutId : plannedWorkout.id ])
					return
				}
			
				if(workoutPlan.status == WorkoutPlanStatus.COMPLETED.description()){
					redirect(controller: 'workoutPlan', action: 'completed', params:[ workoutPlanId : workoutPlan.id])
					return
				}
				
				def accolades = Accolade.findAllByPlannedWorkout(plannedWorkout)
				def points = calculatePoints(accolades)
				
				if(firstUpdate){
			
					plannedWorkout.updated = true
					plannedWorkout.save(flush:true)
					
					message = '<strong>+' + points + ' points. Good Job!</strong> Successfully completed ' + plannedWorkout.displayName + '.  <a href="/bringit/' + plannedWorkout.link + '/show/' + plannedWorkout.id + '">Review Workout</a>'	
					sendMotivationMessages(account)
					sendGoodJobMessage(account)
				}else{
					message = 'Successfully updated Workout Results for ' + plannedWorkout.displayName + '. <a href="/bringit/' + plannedWorkout.link + '/show/' + plannedWorkout.id + '">Review Workout</a>'
				}
				
				request.account = account
				request.plannedWorkout = plannedWorkout
				
				c.call message
				
			}else{
			    render(view: AppConstants.ENTRY_VIEW, model: [plannedWorkout: plannedWorkout])
			    return
			}
				
		}else{
			flash.message = "Unauthorized to access workout"
			redirect(controller : 'account', action: 'dashboard')
		}
	
	}
	
	
	
	
	
	private def withBaseConfirmSkip(Closure c) {

		def view = AppConstants.CONFIRM_SKIP_VIEW
		withMobileDevice { device ->
		      view = "/common/plannedWorkout/confirmSkipMobile"
		}
		
		def subject = SecurityUtils.getSubject()
		def account = getAuthenticatedAccount(subject)
		def plannedWorkout = getPlannedWorkoutById(params.id)
				
		if(subject.isPermitted("workoutPlan:edit:${plannedWorkout?.workoutPlan?.id}") ||
			subject.hasRole(RoleName.ROLE_ADMIN.description())){
			
			request.plannedWorkout = plannedWorkout
			request.account = account
		
			c.call view
			
		}else{
			flash.message = "Unauthorized to access workout"
			redirect(controller : 'account', action: 'dashboard')
			return
		}		
	}
	
	


	
	private def withBaseSkip(Closure c){

		def subject = SecurityUtils.getSubject()
		def account = getAuthenticatedAccount(subject)
		def plannedWorkout = getPlannedWorkoutById(params.id)
		
		if(subject.isPermitted("workoutPlan:edit:${plannedWorkout?.workoutPlan?.id}") ||
			subject.hasRole(RoleName.ROLE_ADMIN.description())){
				
			plannedWorkout.skipped = true
			plannedWorkout.skippedDate = new Date()
			if(!plannedWorkout.save(flush:true)){
				flash.message = "Something went wrong, please try again."
				redirect(controller:'account', action:'dashboard')
			}
		
			checkCompletedWeek(account, plannedWorkout, plannedWorkout.workoutPlan)
			checkCompletedWorkoutPlan(account, plannedWorkout, plannedWorkout.workoutPlan)
			calculateAccountStats(account, plannedWorkout.workoutPlan)
			calculateWorkoutPlanStats(account, plannedWorkout.workoutPlan)
			
			c.call plannedWorkout
			
		}else{
			flash.message = "Unauthorized to access workout"
			redirect(controller : 'account', action: 'dashboard')
			return
		}
		
	}
	
	
	
	
	
	private def withBaseConfirmRecover(Closure c) {
		def view = AppConstants.CONFIRM_RECOVER_VIEW
		withMobileDevice { device ->
		      view = "/common/plannedWorkout/confirmRecoverMobile"
		}
		
		def subject = SecurityUtils.getSubject()
		def account = getAuthenticatedAccount(subject)
		def plannedWorkout = getPlannedWorkoutById(params.id)
		
		
		if(subject.isPermitted("workoutPlan:edit:${plannedWorkout?.workoutPlan?.id}") ||
			subject.hasRole(RoleName.ROLE_ADMIN.description())){
			
			request.plannedWorkout = plannedWorkout
			request.account = account
			
			c.call view
			
		}else{
			flash.message = "Unauthorized to access workout"
			redirect(controller : 'account', action: 'dashboard')
			return
		}
	}
	
	
	
	
	
	private def withBaseRecover(Closure c){
		
		def subject = SecurityUtils.getSubject()
		def account = getAuthenticatedAccount(subject)
		def plannedWorkout = getPlannedWorkoutById(params.id)
		
		if(subject.isPermitted("workoutPlan:edit:${plannedWorkout?.workoutPlan?.id}") ||
			subject.hasRole(RoleName.ROLE_ADMIN.description())){
		
			plannedWorkout.skipped = false
			if(!plannedWorkout.save(flush:true)){
				flash.message = "Something went wrong, please try again."
				redirect(controller:'account', action:'dashboard')
			}
		
			c.call plannedWorkout
			
		}else{
			flash.message = "Unauthorized to access workout"
			redirect(controller : 'account', action: action)
			return
		}
	}
	

	
	
	
	
	private def withBaseRemove(Closure c){
	
		def subject = SecurityUtils.getSubject()
		def account = getAuthenticatedAccount(subject)
		def plannedWorkout = getPlannedWorkoutById(params.id)
	
		if(subject.isPermitted("workoutPlan:edit:${plannedWorkout?.workoutPlan.id}") ||
			subject.hasRole(RoleName.ROLE_ADMIN.description())){

			checkRemoveAccoladeData(account, plannedWorkout)
			checkRemoveFromCompetitionStats(plannedWorkout, account)
			
			plannedWorkout.delete(flush:true)
			
			checkCompletedWeek(account, plannedWorkout, plannedWorkout.workoutPlan)
			checkCompletedWorkoutPlan(account, plannedWorkout, plannedWorkout.workoutPlan)
			calculateAccountStats(account, plannedWorkout.workoutPlan)
			calculateWorkoutPlanStats(account, plannedWorkout.workoutPlan)
			updateCompetitionStatsAndStandings(account)
			
			c.call plannedWorkout
			
		}else{
			flash.message = "Unauthorized to access workout"
			redirect(controller : 'account', action: action)
			return
		}
	}
	
	
	
	
	
	private def checkRemoveAccoladeData(account, plannedWorkout){
		def accolades = Accolade.findAllByPlannedWorkout(plannedWorkout)
		if(accolades){
			accolades.each { accolade ->
				def competitionStats = getCompetitionStatsByAccolade(accolade)
				if(competitionStats){
					competitionStats.removeFromAccolades(accolade)
					competitionStats.save(flush:true)
				}
			
				accolade.delete(flush:true)
			}
		}
	}
	



	private def getCompetitionStatsByAccolade(accolade){
		def criteria = CompetitionStats.createCriteria()
		def competitionStats = criteria.get{
		     and{
			    accolades {
			    	idEq(accolade.id)
			   	}
		     }
		}
		return competitionStats
	}
	
	
	
	
	private def getCompetitionStatsByPlannedWorkout(plannedWorkout){
		def criteria = CompetitionStats.createCriteria()
		def competitionStats = criteria.get{
		     and{
			    plannedWorkouts {
			    	idEq(plannedWorkout.id)
			   	}
		     }
		}
		return competitionStats
	}
	
	
	
	
	private def checkRemoveFromCompetitionStats(plannedWorkout, account){
		def competition = getCurrentActiveCompetition(account)
		if(competition){
			def stats = getCompetitionStatsByPlannedWorkout(plannedWorkout)
			if(stats){
				stats.removeFromPlannedWorkouts(plannedWorkout)
				stats.save(flush:true)
			}
		}
	}
	
	
	
	
	private def checkAddToCompetitionStats(plannedWorkout, account){
		def competition = getCurrentActiveCompetition(account)
		if(competition){
			def stats = getCompetitionStatsByPlannedWorkout(plannedWorkout)
			if(!stats){
				def competitionStats = CompetitionStats.findByAccountAndCompetition(account, competition)
				competitionStats.addToPlannedWorkouts(plannedWorkout)
				competitionStats.save(flush:true)
			}
		}
	}
	
	
	
	
	def updateCompetitionStatsAndStandings(account){
		def competition = getCurrentActiveCompetition(account)
		if(competition){
			updateAccountCompetitionStats(account, competition)
			updateCompetitionStandings(competition)
		}
	}
	
	
	
	
	private def updateCompetitionStandings(competition){	
		
		def rank = 0
		def previousTotalPoints = 0
		
		def competitionStats = CompetitionStats.findAllByCompetition(competition, [ sort: "totalPoints", order: "desc" ])
		
		competitionStats.each { stats ->			
			if(previousTotalPoints != stats.totalPoints){
				rank++
			}
			stats.rank = rank
			stats.save(flush:true)
			previousTotalPoints = stats.totalPoints
		}
	}
	
	
	
	
	private def updateAccountCompetitionStats(account, competition){
		
		def totalPoints = 0
		def competitionStats = CompetitionStats.findByAccountAndCompetition(account, competition)
		
		competitionStats.accolades.each{ accolade ->
			totalPoints += accolade.points
		}
		
		competitionStats.totalCompleted = competitionStats.plannedWorkouts?.size()
		competitionStats.totalPoints = totalPoints
		competitionStats.save(flush:true)
		
	}
	
	
	
	
	def sendMotivationMessages(account){
		def competition = getCurrentActiveCompetition(account)
		if(competition){
			
			def phones = []
			def emails = ""
			
			def username = account.username
			def competitionUrl = getCompetitionUrl(account)
			
			competition.members.each { member ->
				if(member.phone && member.motivateText){
					phones.add(member.phone)
				}
				if(member.motivateEmail){
					emails += member.email
					emails += ","
				}
			}

			def body = getMotivationEmailBody(username, competitionUrl)
			
			
			/**TODO:currently throwing an exception
			def thread = Thread.start {
				println "*** sending motivation emails ***"
				println "*** ${emails} ***"
				println "email service ${emailService}"
				sendMotivationEmails(username, emails, body)
				println "*** sending motivation texts ***"
				sendMotivationTexts(username, phones, competitionUrl)
			}
			**/
			
			def messages = task {
				println "*** sending motivation emails ***"
				println "*** ${emails} ***"
				println "email service ${emailService}"
				//sendMotivationEmails(username, emails, body)
				def from = "p90xfit@mail.datatundra.com"
				def subject = "P90X Fantasy Fit : Mixin Soup"
				if(emails){
					println "** email list : ${emails} **"
					try { 
						println "\n** sending motivation emails **"
						println "email service : ${emailService}, ${emails}"
						emailService.send(emails, from, subject, body)
				
					}catch(Exception e){
						e.printStackTrace()
					}
				}
				
				println "*** sending motivation texts ***"
				//sendMotivationTexts(username, phones, competitionUrl)
				
				phones.each { phone ->
					def message = "P90X Fantasy Fit : ${username} brought it to the people... did you? ${competitionUrl}"
					//textMessageService.send("+1" + phone, message)
				}
				
			}
			onError([messages]) { Throwable t ->
				println "**** errored sending messages ****"
				t.properties.each{ println "${it.key} : ${it.value}"}
			}
			onComplete([messages]){
				println "everything was sent...."
			}
		}
	}
	
	
	def sendGoodJobMessage(account){
		def username = account.username
		def dashboardUrl = getDashboardUrl(account)
		def body = getGoodJobEmailBody(username, dashboardUrl)
	
		def to = account.email
		def from = "p90xfit@mail.datatundra.com"
		def subject = "P90X Fantasy Fit : Good Job!!!"
		emailService.send(to, from, subject, body)
	}
	
	
	
	def sendMotivationTexts(username, phones, competitionUrl){
		phones.each { phone ->
			def message = "P90X Fantasy Fit : ${username} brought it to the people... did you? ${competitionUrl}"
			textMessageService.send("+1" + phone, message)
		}
	}
	
	
	
	def sendMotivationEmails(username, emails, body){
		println "if emails..."
		if(emails){
			println "** email list : ${emails} **"
			try { 
				println "\n** sending motivation emails **"
				def from = "p90xfit@mail.datatundra.com"
				def subject = "P90X Fantasy Fit : Mixin Soup"
				println "email service : ${emailService}, ${emails}"
				emailService.send(emails, from, subject, body)
				
			}catch(Exception e){
				e.printStackTrace()
			}
		}
	}
	
	
	
	
	
	def getMotivationEmailBody(username, competitionUrl){
		File templateFile = grailsAttributes.getApplicationContext().getResource( File.separator + "templates" + File.separator + "email" + File.separator + "motivation.html").getFile();
		def binding = [ 
			"username" : username,
			"competitionUrl" : competitionUrl
		]
		def engine = new SimpleTemplateEngine()
		def template = engine.createTemplate(templateFile).make(binding)
		return template.toString()
	}
	
	
	def getGoodJobEmailBody(username, dashboardUrl){
		File templateFile = grailsAttributes.getApplicationContext().getResource( File.separator + "templates" + File.separator + "email" + File.separator + "good_job.html").getFile();
		def binding = [ 
			"username" : username,
			"dashboardUrl" : dashboardUrl
		]
		def engine = new SimpleTemplateEngine()
		def template = engine.createTemplate(templateFile).make(binding)
		return template.toString()
	}
	
	
	def getCurrentActiveCompetition(account){
		def activeCriteria = Competition.createCriteria()
		def competition = activeCriteria.get{
		     and{
		     	eq("status", CompetitionStatus.ACTIVE.description())
			 	eq("current", true)
			   	members {
			    	idEq(account.id)
			   	}
		     }
		}
		return competition
	}
	
	
	
	private def getCompetitionUrl(account){
		def url = request.getRequestURL()
		def split = url.toString().split("/bringit/")
		def httpSection = split[0]
		def competitionUrl = "${httpSection}/bringit/public/competition/${account.username}"
		return competitionUrl
	}
	
	private def getDashboardUrl(account){
		def url = request.getRequestURL()
		def split = url.toString().split("/bringit/")
		def httpSection = split[0]
		def dashboardUrl = "${httpSection}/bringit/public/dashboard/${account.username}"
		println "dashboardUrl " + url
		return dashboardUrl
	}
	
	
	
	
	
	private def calculateWorkoutPlanStats(account, workoutPlan){
		
		def workoutsCompleted = PlannedWorkout.countByAccountAndWorkoutPlanAndCompleted(account, workoutPlan, true)
		def workoutsSkipped = PlannedWorkout.countByAccountAndWorkoutPlanAndSkipped(account, workoutPlan, true)
		def workoutsRemaining = PlannedWorkout.countByAccountAndWorkoutPlanAndCompletedAndSkipped(account, workoutPlan, false, false)
		
		workoutPlan.totalCompleted = workoutsCompleted
		workoutPlan.totalSkipped = workoutsSkipped
		workoutPlan.totalRemaining = workoutsRemaining
		
		workoutPlan.save(flush:true)
	}
	
	
	
	
	
	private def calculateAccountStats(account, workoutPlan){
		def totalPoints = tallyAccountAccolades(account)
		def workoutPlanPoints = tallyWorkoutPlanAccolades(workoutPlan)
		
		def workoutsCompleted = PlannedWorkout.countByAccountAndCompleted(account, true)
		def workoutsSkipped = PlannedWorkout.countByAccountAndSkipped(account, true)
		def plansCompleted = WorkoutPlan.countByAccountAndStatus(account, WorkoutPlanStatus.COMPLETED.description())
		
		account.totalPoints = totalPoints
		account.workoutsCompleted = workoutsCompleted
		account.workoutsSkipped = workoutsSkipped
		account.plansCompleted = plansCompleted
		
		account.save(flush:true)
		
		workoutPlan.totalPoints = workoutPlanPoints
		workoutPlan.save(flush:true)
	}
	
	
	
	
	def tallyAccountAccolades(account){
		def accolades = Accolade.findAllByAccount(account)
		def total = 0
		accolades.each{ accolade ->
			total+= accolade.points
		}
		return total
	}
	
	
	private def tallyWorkoutPlanAccolades(workoutPlan){
		def total = 0
		workoutPlan.accolades.each { accolade ->
			total+= accolade.points
		}
		return total
	}
	
	
		
	private def checkCompletedWeek(account, plannedWorkout, workoutPlan){
		def week = Week.findByPlannedWorkout(plannedWorkout)
		if(week && !week.completed){
			accoladeService.processWeekAccolade(account, plannedWorkout, workoutPlan, week)
		}
	}

	
	
	//TODO : Add logic for freestyle workout plan
	private def checkCompletedWorkoutPlan(account, plannedWorkout, workoutPlan){
		if(!workoutPlan.freestyle){
			def incompleteWorkouts = PlannedWorkout.findAllByWorkoutPlanAndCompletedAndSkipped(workoutPlan, false, false)
			
			if(!incompleteWorkouts && 
					workoutPlan.status != WorkoutPlanStatus.COMPLETED.description()){
				workoutPlan.actualCompleteDate = plannedWorkout.actualWorkoutDate
				workoutPlan.status = WorkoutPlanStatus.COMPLETED.description()
				workoutPlan.save(flush:true)
				accoladeService.processWorkoutPlanCompleteAccolade(account, workoutPlan)
			}
		}
	}
	
	
	
	
	private def PlannedWorkout getPlannedWorkoutById(id){
		if(!id){
			flash.message = "Invalid workout id. Workout not found with"
			redirect(controller : 'account', action: 'dashboard')
			return
		}
		
		def plannedWorkout = PlannedWorkout.findById(id)
		if (!plannedWorkout) {
			println "redirect !!!!!!"
		    flash.message = "Workout not found"
		    redirect(controller: "account", action: "dashboard")
		}
		
		return plannedWorkout
	}
	
	
	
	
	private def Account getAuthenticatedAccount(subject){
    	
		if(!subject.isAuthenticated()){
			flash.message = "Please sign in to continue"
			redirect(controller : 'auth', action: 'login')
		}
			
		def account = Account.findByUsername(subject.principal)
		
		if(!account){
			flash.message = "Something went wrong, please sign in to continue"
			redirect(controller : 'auth', action: 'login')
		}
		
		return account
	}
	
	
	
	private def differenceInEntryDate(plannedWorkout){
		return (plannedWorkout.plannedWorkoutDate > plannedWorkout.actualWorkoutDate || plannedWorkout.plannedWorkoutDate < plannedWorkout.actualWorkoutDate)
	}
	
	
	private def getDifference(plannedWorkout, entryDate){
		def diff = plannedWorkout.plannedWorkoutDate - entryDate
		return diff
	}
	
	
	private def calculatePoints(accolades){
		def total = 0
		accolades.each { accolade -> 
			total += accolade.points
		}
		return total
	}
	
	
	
	private def withMobileDevice(Closure c){
		if( request.currentDevice.isMobile()){
			c.call request.currentDevice
		}
	}
	
	
	
}