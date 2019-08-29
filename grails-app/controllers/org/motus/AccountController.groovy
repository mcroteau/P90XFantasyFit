package org.motus

import grails.plugin.springsecurity.annotation.Secured

import org.springframework.dao.DataIntegrityViolationException
import org.apache.shiro.crypto.hash.Sha256Hash
import org.apache.shiro.authc.UsernamePasswordToken
import org.apache.shiro.SecurityUtils
import grails.converters.*
import java.util.UUID
import org.motus.common.RoleName
import org.motus.log.ResetPasswordLog
import org.motus.common.WorkoutPlanStatus
import org.motus.workouts.PlannedWorkout
import org.motus.WorkoutPlan
import org.motus.Account
import groovy.text.SimpleTemplateEngine
import org.motus.BaseController
import grails.converters.*
import groovy.time.TimeCategory
import org.motus.common.CompetitionStatus
import org.motus.common.CompetitionInviteStatus
import java.awt.image.BufferedImage
import grails.util.Environment
import javax.imageio.ImageIO
import java.awt.Graphics2D
import java.util.UUID
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.motus.AppConstants

@Mixin( BaseController )
class AccountController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", register: "POST"]

	def emailService
	def accountService
	def springSecurityService

	def send(){
		emailService.send("croteau.mike+10@gmail.com", "p90xfit@mail.datatundra.com", "Test", "Test")
	}
	
	
	
    def index() {
        redirect(action: "profile")
    }
	
	
	
	def registration(){
		[accountInstance: new Account(params)]
	}

	
	def register(){
		
		def accounts = Account.count()
		if(accounts >= 10){
			flash.message = "Apologies, but we have hit our limit on new registrations for <strong>alpha</strong> version.  Please check back soon. Feel free to contact us at p90xfantasyfit@gmail.com for more information."
			redirect(action : 'registration')
			return
		}
		
		if(params.username.contains(" ")){
			flash.message = "Your username contains spaces, no spaces are allowed, sorry."
			redirect(action: "registration")
			return
		}
		
		
		if(containsSpecialCharacters(params.username)){ 
			flash.message = "No special characters allowed, only letters and numbers, no spaces either. Sorry!"
			redirect(action: "registration")
			return
		}  
		
		
		params.ipAddress = request.getRemoteHost()
		def account = new Account(params)
		
		if(params.password != "" &&
			params.password.length() >= 5 && 
				params.password == params.passwordRepeat){
			
			account.motivateText = true
			account.motivateEmail = true
			
			
			def password = springSecurityService.encodePassword(params.password)
			account.password = password
			
			if(account.save(flush: true)){
        	
				account.addToPermissions("account:edit:${account.id}")
				account.save(flush:true)
				account.createAccountRoles(false)
				
				File templateFile = grailsAttributes.getApplicationContext().getResource( File.separator + "templates" + File.separator + "email" + File.separator + "registration.html").getFile();
        	
				def binding = [ "imageLocation" : "" ]
				
				def engine = new SimpleTemplateEngine()
				def template = engine.createTemplate(templateFile).make(binding)
				def bodyString = template.toString()
				
				def to =  account.email
				def from = "p90xfit@mail.datatundra.com"
				def subject = "P90X Fantasy Fit : Successfully Registered"
				
				emailService.send(to, from, subject, bodyString)
				
				flash.message = "You have successfully registered... "
				redirect(controller : 'auth', action: 'signIn', params : [accountInstance: account, username : params.username, password : params.password, new_account : true])
				
			}else{
			
				flash.message = "There was a problem with your registration, please try again or contact the administrator"
				render(view: "registration", model: [accountInstance: account])
				return
			}
		}else{
			flash.error = "Please make sure passwords match and are at least 5 characters long"
			redirect(action:'registration', model : [accountInstance : account])
		}
		
	}
	
	
	
	
	def members(){
	
	}
	
	
	
	def profile_mobile(){
	
		def subject = SecurityUtils.getSubject();

		if(!subject.isAuthenticated()){
			flash.message = "Please sign in to continue"
			redirect(controller : 'auth', action: 'login')
			return
		}
	
		def account = Account.findByUsername(subject.principal)
		if(account){
			request.account = account
		}else{
			flash.message = "Please sign in"
			redirect(controller : 'auth', action : 'login')
		}
		
		[account: account]
	}
	
	
	
	def profile(String username){
		redirect(action : 'dashboard', params : params)
		return
	}
	
	
	
	
	
	
	
	
	//TODO : Refactor/cleanup dashboard code
	def dashboard(String username){

		def view = "/account/dashboard"
		
		withMobileDevice { device ->
			println "device : " + device
			view = "/account/dashboard_mobile"
		}
		
		if(username){
			
			println "USERNAME ${username}"
			
			def account = Account.findByUsername(username)
			if(!account){
				flash.error = "Member account cannot be found"
				redirect(action:'members')
				return
			}
    	
			def dashboardData = accountService.getDashboardData(account.username)
			if(dashboardData?.currentPlan){
			
				if(dashboardData?.currentPlan.status == WorkoutPlanStatus.COMPLETED.description()){
					redirect(controller: 'workoutPlan', action: 'completed')
					return
				}
				
				def endDateCal = dashboardData.currentPlan.plannedCompleteDate.toCalendar()
    	
				def pendingInvitesCount = CompetitionInvite.countByAccountAndStatus(account, CompetitionInviteStatus.PENDING.description())
				request.pendingInvitesCount = pendingInvitesCount
				println "*** pending invites : ${pendingInvitesCount} ***"
				
				
				
				request.account = account
				request.dashboardData = dashboardData 
				request.endDateCal = endDateCal 
				request.account = account 
				request.currentPlan = dashboardData.currentPlan
				
				def duration = TimeCategory.minus( new Date(), dashboardData.currentPlan.startDate)
				request.duration = duration
				
			}else{
				println "NO USERNAME -> DASHBOARD"
				def pendingInvitesCount = CompetitionInvite.countByAccountAndStatus(account, CompetitionInviteStatus.PENDING.description())
				request.pendingInvitesCount = pendingInvitesCount
				println "*** pending invites : ${pendingInvitesCount} ***"
			
				request.account = account
			}
			
				
		}else{
		
			def subject = SecurityUtils.getSubject();
    	
			if(!subject.isAuthenticated()){
				flash.message = "Please sign in to continue"
				redirect(controller : 'auth', action: 'login')
				return
			}
		
			def account = Account.findByUsername(subject.principal)
			if(account){
				def dashboardData = accountService.getDashboardData(account.username)
				if(dashboardData?.currentPlan){
				
					if(dashboardData?.currentPlan.status == WorkoutPlanStatus.COMPLETED.description()){
						redirect(controller: 'workoutPlan', action: 'completed')
						return
					}
				
					def endDateCal = dashboardData.currentPlan.plannedCompleteDate.toCalendar()

					def pendingInvitesCount = CompetitionInvite.countByAccountAndStatus(account, CompetitionInviteStatus.PENDING.description())
					request.pendingInvitesCount = pendingInvitesCount
					println "*** pending invites : ${pendingInvitesCount} ***"
				
				
					request.account = account
					request.dashboardData = dashboardData 
					request.endDateCal = endDateCal 
					request.account = account 
					request.currentPlan = dashboardData.currentPlan
					
					def duration = TimeCategory.minus( new Date(), dashboardData.currentPlan.startDate)
					request.duration = duration
				}else{
					def pendingInvitesCount = CompetitionInvite.countByAccountAndStatus(account, CompetitionInviteStatus.PENDING.description())
					request.pendingInvitesCount = pendingInvitesCount
					println "*** pending invites : ${pendingInvitesCount} ***"
				
					request.account = account
				}
			}else{
				flash.message = "Please sign in"
				redirect(controller : 'auth', action : 'login')
			}
			
		}
		
		render(view : view)
		
	}
	
	
	
	
	def forgot(){}
	
	
	
	def sendResetEmail(){
		
		if(params.email){

			def account = Account.findByEmail(params.email)
			
			if(account){
				
				def resetUUID = UUID.randomUUID()
				account.resetUUID = resetUUID
				account.save(flush:true)
			
				def resetLog = new ResetPasswordLog()
				resetLog.date = new Date()
				resetLog.account = account
				resetLog.originalPassword = account.password
				resetLog.completed = false
				resetLog.save(flush:true)
				
			
				//add email logic"
				println "CONTEXT ${request.getContextPath()}"
				println "URI ${request.getRequestURI()}"
				println "Query ${request.getQueryString()}"
				
				println "account ${account.resetUUID}  resetLog : ${ResetPasswordLog.count()}"
				
				def url = request.getRequestURL()
				
				def split = url.toString().split("/bringit/")
				def httpSection = split[0]
				def resetUrl = "${httpSection}/bringit/account/confirmReset?"
				def params = "username=${account.username}&uuid=${resetUUID}"
				resetUrl+= params
				
				
				sendResetPasswordEmail(account, resetUrl)
				println "resetUrl : ${resetUrl}"
				
			}else{
				flash.message = "Account not found with following email address : ${params.email}"
				redirect(action:'forgot')
			}
		
		}else{
			flash.message = "Please enter an email to continue the reset password process"
			redirect(action:'forgot')
		}
	}
	
	
	
	
	def sendResetPasswordEmail(Account accountInstance, String resetUrl){
		try { 
		
			println "\nSENDING RESET EMAIL"
		
			def fromAddress = "p90xfit@mail.datatundra.com"
			def toAddress = accountInstance.email
			def subject = "P90X Fantasy Fit : Reset password"

			
			File templateFile = grailsAttributes.getApplicationContext().getResource(  "/templates/email/password_reset.html").getFile();

			def binding = [ "supportEmail" : "p90xfantasyfit@gmail.com",
							"resetUrl": resetUrl ]
			def engine = new SimpleTemplateEngine()
			def template = engine.createTemplate(templateFile).make(binding)
			def bodyString = template.toString()
			
			
			emailService.send(toAddress, fromAddress, subject, bodyString)
			
		}catch(Exception e){
			e.printStackTrace()
		}
	}
	
	
	
	
	
	def confirmReset(){
		println "confirm reset..."
		def account = Account.findByUsernameAndResetUUID(params.username, params.uuid)
		if(!account){
			flash.message = "Something went wrong, please try again."
			redirect(action:"forgot")
		}
		[username: account.username, uuid: 	params.uuid]
	}
	
	
	
	
	def resetPassword(){
	
		if(params.password == params.passwordRepeat && (params.username)){
			def username = params.username
			def newPassword = params.password
			
			def account = Account.findByUsername(username)
			account.password = springSecurityService.encodePassword(newPassword)
			
			if(account.save(flush:true)){
			
				flash.message = "Successfully updated password, please sign in with new password"
				//redirect(controller : "auth", action : "signIn", params : [username : username, password : newPassword, reset : true])
				redirect(controller: 'auth', action: 'login' )
				
			}else{
				flash.message = "We were unable to reset your password, please try again."
				redirect(action:'confirmReset', params : [username : username, uuid : account.resetUUID ])
			}	
		}else{
		
			if(params.username && params.uuid){
				flash.error = "Passwords do not match"
				redirect(action:'confirmReset', params : [ uuid : params.uuid, username : params.username ])
			}else{
				flash.error = "Something went wrong"
				redirect(action : 'forgot')		
			}
		}
	}



	
	
    def edit(Long id) {

		authenticatedAccount { account ->	
		
			def view = "/account/edit"
			withMobileDevice { device ->
				view = "/account/edit_mobile"
			}
			
        	request.accountInstance = account
			render(view : view)
		}
		
    }
	
	
	
	
	
    def update(Long id, Long version) {

		authenticatedAccount { account ->
	
			def subject = SecurityUtils.getSubject();
			
			if(subject.isPermitted("account:edit:${account.id}") ||
				subject.hasRole(RoleName.ROLE_ADMIN.description())){
				
				println "\n\n\n >>>> UPDATE >>>> \n"
				
				account.properties = params
				
				def imageFile = request.getFile('image')
				def fileName = generateName( (('a'..'z')+('A'..'Z')+('0'..'9')).join(), 7)
				
				def existsByFileName = Account.findByProfileImageName(fileName)
				
				if(existsByFileName){
					flash.message = " :) Wow!!! Sorry! Please try again..."
					redirect(action:"edit", id: account.id)
					return
				}
				
				
				BufferedImage originalImage = null;
				
				try {
					
					originalImage = ImageIO.read(imageFile.getInputStream());
 				   	
					if(originalImage){
					
 				    	int type = originalImage.getType() == 0? BufferedImage.TYPE_INT_ARGB : originalImage.getType();
						def baseUrl = "images/profiles/"
						
						def absolutePath = grailsApplication.mainContext.servletContext.getRealPath('images')
						absolutePath = absolutePath.endsWith("/") ? absolutePath : absolutePath + "/"
						absolutePath = absolutePath + "profiles/"
						println "absolutePath : ${absolutePath}"
						def baseDirectory = "${absolutePath}"
						
						println "\n\nSAVING FILE : ${baseDirectory}\n\n"
						
						def imageFileName = "${fileName}.jpg"
						def imageUrl = "${baseUrl}${imageFileName}"
						BufferedImage imageJpg = resizeImage(originalImage, type, 200, 200);
						def imageLocation = "${baseDirectory}${imageFileName}"
						ImageIO.write(imageJpg, "jpg", new File(imageLocation));
						
						account.profileImageName = imageFileName
						account.profileImageUrl = imageUrl
						
					}
					
    			} catch (IOException e) {
    				e.printStackTrace();
					flash.message = "Something went wrong, please try again"
   				 	redirect(action: "edit", id: account.id)
    			}
		    	
		    	
        		
        		if (!account.save(flush: true)) {
					flash.error = "Problems updating account.  Please try again"
					redirect(controller: 'account', action:'profile')
        		    return
        		}
        		
        		flash.message = "You have successfully updated your profile"
        		redirect(action: "edit")
			
			}
			
		}
		
    }



	private def resizeImage(originalImage, int type, int height, int width){

		BufferedImage resizedImage = new BufferedImage(width, height, type);
		Graphics2D g = resizedImage.createGraphics();
		g.drawImage(originalImage, 0, 0, width, height, null);
		g.dispose();
 
		return resizedImage;
	}


	
	
	def member_search(){
		def currentMembers = Account.count()
		[currentMembers: currentMembers]
	}

	
	
	def search(){
		request.results = true
		request.currentMembers = Account.count()
		if(params.query){
			println "query : " + params.query
			def accountCriteria = Account.createCriteria()
			def accounts = accountCriteria.list(){
				or{
					ilike("username", "%${params.query}%")
					ilike("name", "%${params.query}%")
				}
			}

			request.accounts = accounts
			render(view : "/account/member_search")
			
			return

		}else{
			request.accounts = Account.list()
			render(view : "/account/member_search")
		}
	}
	
	
	
	
	def list(){
		def subject = SecurityUtils.getSubject();
		if(!subject.hasRole(RoleName.ROLE_ADMIN.description())){
			flash.message = "How did you get here?"
			redirect(controller : 'account', action : 'dashboard')
			return
		}
		
		def accountInstanceList = Account.findAll(params)
		def accountInstanceTotal = Account.count()
		
		[accountInstanceList : accountInstanceList, accountInstanceTotal: accountInstanceTotal] 
	}
	
	
	
	def generateName = { String alphabet, int n ->
	  new Random().with {
	    (1..n).collect { alphabet[ nextInt( alphabet.length() ) ] }.join()
	  }
	}
	
	
	def containsSpecialCharacters(String str) {
		Pattern p = Pattern.compile("[^A-Za-z0-9]", Pattern.CASE_INSENSITIVE);
		Matcher m = p.matcher(str);
		boolean b = m.find();

		if (b){
			return true
		}
		
		return false
	}
}
