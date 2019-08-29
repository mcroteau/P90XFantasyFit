package org.motus

import org.motus.BaseController
import org.motus.common.CompetitionStatus
import org.motus.common.CompetitionInviteStatus
import groovy.time.TimeCategory
import org.apache.shiro.SecurityUtils
import org.motus.common.RoleName
import grails.converters.*
//import groovyx.gpars.GParsExecutorsPool


@Mixin( BaseController )
class CompetitionController {

	static allowedMethods = [save: "POST", update: "POST", leave: "POST"]
		

	def index(String username){
		def view = "/competition/index"
		
		withMobileDevice { device ->
			view = "/competition/index_mobile"
		}
    	
		def account
		
		if(username){
			println "USERNAME ${username}"
			account = Account.findByUsername(username)	
		}else{
		
			def subject = SecurityUtils.getSubject();
			if(!subject.isAuthenticated()){
				flash.message = "Please sign in to continue"
				redirect(controller : 'auth', action: 'login')
				return
			}
			account = Account.findByUsername(subject.principal)
		}
		
		if(!account){
			flash.error = "Member account cannot be found"
			redirect(action: 'dashboard')
			return
		}
		
		def currentCriteria = Competition.createCriteria()
		def competition = currentCriteria.get{
			and{
				eq("current", true)
	 			members {
	 				idEq(account.id)
	 			}
			}
		}
		
		if(competition){
			def competitionStats = CompetitionStats.findAllByCompetition(competition,  [ sort: "totalPoints", order: "desc" ])
			request.competitionStats = competitionStats
		
			def today = new Date()
			def duration = today - competition.startDate + 1
			request.duration = duration
		}
		
		def pendingInvitesCount = CompetitionInvite.countByAccountAndStatus(account, CompetitionInviteStatus.PENDING.description())
		request.pendingInvitesCount = pendingInvitesCount
		
		println " ** pending invites : ${pendingInvitesCount} **"
		
		request.account = account
		request.competition = competition
		
		render(view : view)
	
	}
	
	
	
	
	def results(Integer id){
		
		println " id : ${params.id}"
		
		if(!id){
			flash.message = "Unable to find Competition"
			redirect(action : 'index')
			return
		}
		
		if(!params.accountId){
			flash.message = "Unable to find Competition"
			redirect(action : 'index')
			return
		}
		
		
		def competition = Competition.get(id)
		
		if(!competition){
			flash.message = "Unable to find Competition"
			redirect(action : 'index')
			return
		}
		
		def account = Account.get(params.accountId)
		if(!account){
			flash.message = "Unable to find Competition"
			redirect(action : 'index')
			return
		}
		
		def competitionStats = CompetitionStats.findAllByCompetition(competition,  [ sort: "totalPoints", order: "desc" ])
		
		[ account : account, competition : competition, competitionStats : competitionStats ]
			
		
	}
	
	
	
	
	
	def setup(){
		authenticatedAccount { account ->
			def competition = getCurrentActiveCompetition(account)
			if(competition){
				flash.message = "You cannot create a new competition.  You currently are already participating in one."
				redirect(action : 'index')
				return
			}

			def endDate = new Date() + 14
			
			def competitionInstance = new Competition(params)
			if(competitionInstance.endDate)endDate = competitionInstance.endDate
			
			[ competition : competitionInstance, endDate : endDate ]
		}
	}
	
	

	private def getCurrentActiveCompetition(account){
		def currentCriteria = Competition.createCriteria()
		def competition = currentCriteria.get{
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

	
	
	def edit(Integer id){
		authenticatedAccount { account ->
			if(id){
				def competition = Competition.get(id)
				if(!competition){
					flash.message = "Competition cannot be found"
					redirect(action : 'index')
					return
				}
				
				if(competition.status == CompetitionStatus.STOPPED.description() ||
					competition.status == CompetitionStatus.COMPLETED.description()){
					flash.message = "Competition can no longer be edited.  It is either stopped or completed"
					redirect(action : 'index')
					return
				}
				
				
				def subject = SecurityUtils.getSubject();
				if(subject.isPermitted("competition:edit:${competition.id}") ||
					subject.hasRole(RoleName.ROLE_ADMIN.description())){

					[account : account, competition : competition]
				}else{
					flash.message = "What are you doing?  You don't have permission to do that!"
					redirect(controller : 'account', action: 'dashboard')
				}
			}else{
				flash.message = "Competition not found"
				redirect(controller : 'account', action : 'dashboard')
			}
		}
	}
	
	
	def review(Integer id){
		authenticatedAccount { account ->
			if(id){
				def competition = Competition.get(id)
				[account : account, competition : competition]
			}else{
				flash.message = "Competition not found"
				redirect(controller : 'account', action : 'dashboard')
			}
		}
	}
	
	
	
	def confirmStop(Integer id){
		authenticatedAccount { account ->
			if(id){
				def competition = Competition.get(id)
	
				def subject = SecurityUtils.getSubject();
				if(subject.isPermitted("competition:edit:${competition.id}") ||
					subject.hasRole(RoleName.ROLE_ADMIN.description())){

					[account : account, competition : competition]
				}else{
					flash.message = "What are you doing?  You don't have permission to do that!"
					redirect(controller : 'account', action: 'dashboard')
				}
			}else{
				flash.message = "Competition not found"
				redirect(controller : 'account', action : 'dashboard')
			}
		}
	}
	
	
	
	
	def stop(){
		authenticatedAccount { account ->
			if(params.id){
				def competition = Competition.get(params.id)
    	
				def subject = SecurityUtils.getSubject();
				if(subject.isPermitted("competition:edit:${competition.id}") ||
					subject.hasRole(RoleName.ROLE_ADMIN.description())){
    				
					competition.status = CompetitionStatus.STOPPED.description()
					competition.save(flush:true)

					flash.message = "Successfully Stopped Competition"
					redirect(action: 'index')
					
				}else{
					flash.message = "What are you doing?  You don't have permission to do that!"
					redirect(controller : 'account', action: 'dashboard')
				}
			}else{
				flash.message = "Competition not found"
				redirect(controller : 'account', action : 'dashboard')
			}
		}
	}
	
	
	
	
	
	
	

	
	
	
	def history(){
		def account
		
		if(params.accountId){
			account = Account.get(params.accountId)
			if(!account){
				flash.error = "Trouble finding competition history.  Please try again"
				redirect(controller : 'account', action: 'profile')
				return
			}
		}else{
			flash.error = "Trouble finding competition history.  Please try again"
			redirect(controller : 'account', action: 'profile')
			return
		}
		
		
		def criteria = Competition.createCriteria()
		def competitions = criteria{
			and{
				eq("current", false)
				members {
	 				idEq(account.id)
	 			}
			}
		}
		
		def d = Competition.findAll()
		println " ** d : ${d?.size()} -> competitions : ${competitions?.size()}"
		
		if(competitions){
			competitions.each { competition ->
				def stats = CompetitionStats.findByAccountAndCompetition(account, competition)
				println "stats rank : ${stats.rank}"
				competition.memberRank = stats.rank
			}
		}
		
		[ account : account, competitions : competitions ]
		
	}
	
	

	
	def update(Long id){
		def competition = Competition.get(id)
		if(!competition){
			flash.message = "Competition cannot be found"
			redirect(controller : 'account', action: 'dashboard')
			return
		}
		
		if(!params.name){
			flash.message = "Name cannot be blank"
	        render(view: "edit", model: [competition: competition])
			return
		}
		
		competition.properties = params
		
		def duration = competition.endDate - competition.startDate
		if(duration < 14){
			flash.message = "Competition length must be at least 2 weeks long. Please change dates"
			redirect(action : 'edit', id : competition.id)
			return
		}
		
		competition.save(flush:true)
		
		flash.message = "Successfully updated the Competition"
		redirect(action : 'index')
	
	}
	
	
	
	
	
	
	def save(){
		authenticatedAccount { account ->
		
			def currentActiveCompetition = getCurrentActiveCompetition(account)
			if(currentActiveCompetition){
				flash.message = "You cannot create a new competition.  You currently are already participating in one."
				redirect(action : 'index')
				return
			}
			
			checkUpdateCurrentCompetition(account)
			
			def competition = new Competition()
			competition.properties = params
		
			def duration = params.endDate - params.startDate
			def diff = params.startDate - new Date()
			
			if(duration < 14){
				flash.message = "Competition length must be at least 2 weeks long. Please change dates"
				redirect(action : 'setup', params: params)
				return
			}
			

			if(diff <= 0){
				competition.status = CompetitionStatus.ACTIVE.description()
			}else{
				competition.status = CompetitionStatus.UPCOMING.description()
			}

			competition.account = account
			competition.current = true
			competition.addToMembers(account)
			
			if(!competition.save(flush:true)){
	            render(view: "setup", params: params)
	            return
			}
			
			println "competition : ${competition.properties}"
			println "name :${competition.name}"
			
			account.addToPermissions("competition:edit:${competition.id}")
			account.save(flush:true)
			
			def competitionStats = new CompetitionStats()
			competitionStats.account = account
			competitionStats.competition = competition
			competitionStats.save(flush:true)
			
			
			flash.message = "Successfully setup Competition"
			redirect(action:'index')
			
		}
	}
	
	
	def checkUpdateCurrentCompetition(account){	
		def currentCriteria = Competition.createCriteria()
		def competition = currentCriteria.get{
			and{
				eq("current", true)
	 			members {
	 				idEq(account.id)
	 			}
			}
		}
		if(competition){
			competition.current = false
			competition.save(flush:true)
		}
	}
	
	
	
	
	
	def confirmLeave(){
		authenticatedAccount { account ->
			def competition = getCurrentActiveCompetition(account)
			[account : account, competition : competition]
		}
	}
	
	
	
	def leave(){
		authenticatedAccount { account ->
			def competition = getCurrentActiveCompetition(account)
			def competitionStats = CompetitionStats.findByAccountAndCompetition(account, competition)
			competitionStats.delete(flush:true)
			competition.removeFromMembers(account)
			competition.save(flush:true)
			
			flash.message = "Successfully left competition"
			redirect(controller: 'account', action : 'dashboard')
		}
	}
	
	
	
	
		
}