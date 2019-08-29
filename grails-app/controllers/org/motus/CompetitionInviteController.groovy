package org.motus

import org.motus.BaseController
import org.motus.common.CompetitionStatus
import org.motus.common.CompetitionInviteStatus
import org.apache.shiro.SecurityUtils
import groovy.text.SimpleTemplateEngine


@Mixin( BaseController )
class CompetitionInviteController {

	static allowedMethods = [ invite: "POST", accept : "POST", decline : "POST" ]
	
	def emailService
	
	def invite(Integer id){
		println "*** invite ***"
		if(!id){
			flash.message = "Problems accessing competition, please try again"
			redirect(controller:'competition', action:'index')
			return
		}
		
		def subject = SecurityUtils.getSubject();
		if(!subject.isAuthenticated()){
			flash.message = "Please sign in to continue"
			redirect(controller : 'auth', action: 'login')
			return
		}
		

		def organizer = Account.findByUsername(subject.principal)
		if(!organizer){
			flash.message = "Problems accessing competition, please try again"
			redirect(controller:'competition', action:'index')
			return
		}
		

		def competition = getCurrentActiveOrPendingCompetition(organizer)
		if(!competition){
			flash.message = "Competition not found"
			redirect(controller: 'competition', action: 'index')
			return
		}	
		
		
		if(!subject.isPermitted("competition:edit:${competition.id}")){
			flash.message = "You do not have permission to send invites for this Competition"
			redirect(controller : 'competition', action : 'index')
			return
		}
		
		
		if(!params.memberId){
			flash.message = "Something went wrong, unable to send invite"
			redirect(controller : 'competition', action: 'index')
			return
		}
		def account = Account.get(params.memberId)
		
		if(!params.message){
			flash.message = "Message cannot be blank"
			redirect(action : 'prepare', params: [id : competition.id, accountId : organizer.id, memberId : account.id ])
			return
		}
		
		
		def existing = CompetitionInvite.findByAccountAndCompetition(account, competition)
		if(existing){
			flash.message = "You already sent this member an invite"
			redirect(action : 'search', params: [id : competition.id, accountId : organizer.id, memberId : account.id ])
			return
		}
		
		
		
		def competitionInvite = new CompetitionInvite()
		competitionInvite.dateInvited = new Date()
		competitionInvite.message = params.message
		competitionInvite.competition = competition
		competitionInvite.account = account
		competitionInvite.organizer = organizer
		competitionInvite.status = CompetitionInviteStatus.PENDING.description()
		if(!competitionInvite.save(flush:true)){
			request.competition = competition
			request.account = organizer
			request.member = account
            render(view: "prepare", model: [ competitionInvite : competitionInvite])
            return
		}
		
		
		//TODO : Send invite email
		sendCompetitionInvite(organizer, account, params.message)
		
		redirect(action : 'search', params : [ id : competition.id, accountId : params.accountId ])
			
	}
	
	
	
	def sendCompetitionInvite(organizer, account, message){
		
		def url = request.getRequestURL()
		def split = url.toString().split("/bringit/")
		def httpSection = split[0]
		def competitionUrl = "${httpSection}/bringit/public/competition/${organizer.username}"
		
		File templateFile = grailsAttributes.getApplicationContext().getResource( File.separator + "templates" + File.separator + "email" + File.separator + "competition_invite.html").getFile();
    	
		def binding = [ 
			"username" : organizer.username,
			"competitionUrl" : competitionUrl, 
			"message" : message
		]
		def engine = new SimpleTemplateEngine()
		def template = engine.createTemplate(templateFile).make(binding)
		def bodyString = template.toString()
		
		try { 
			println "\n** sending motivation emails **"
		
			def fromAddress = "p90xfit@mail.datatundra.com"
			def toAddress = account.email
			def subject = "P90X Fantasy Fit  : Invitation to Join Competition!"
    	
			emailService.send(toAddress, fromAddress, subject, bodyString)
			
		}catch(Exception e){
			e.printStackTrace()
		}
	
	}
	
	
	
	
	
	
	def invites(){
		
		def subject = SecurityUtils.getSubject();
		if(!subject.isAuthenticated()){
			flash.message = "Please sign in to continue"
			redirect(controller : 'auth', action: 'login')
			return
		}
		
		def account = Account.findByUsername(subject.principal)		
		def pendingInvites = CompetitionInvite.findAllByAccountAndStatus(account, CompetitionInviteStatus.PENDING.description())
				
		[ account : account, pendingInvites : pendingInvites ]
		
	}
	
	
	
	
	
	
	def manage(Integer id){
		def subject = SecurityUtils.getSubject();
		if(!subject.isAuthenticated()){
			flash.message = "Please sign in to continue"
			redirect(controller : 'auth', action: 'login')
			return
		}
		if(!id){
			flash.message = "Problems accessing invite, please try again"
			redirect(controller:'competition', action:'index')
			return
		}
		
		def competitionInvite = CompetitionInvite.get(id)
		if(!competitionInvite){
			flash.message = "Problems accessing invite, please try again"
			redirect(controller:'competition', action:'index')
			return
		}
		
		[ competitionInvite : competitionInvite ]
		
	}
	
	
	
	
	
	def accept(Integer id){
	
		println "*** accepting invite ***"
		def subject = SecurityUtils.getSubject();
		if(!subject.isAuthenticated()){
			flash.message = "Please sign in to continue"
			redirect(controller : 'auth', action: 'login')
			return
		}
		
		def account = Account.findByUsername(subject.principal)
		if(!account){
			flash.message = "Account not found. Please try again"
			redirect(controller : 'competition', action: 'index')
			return
		}
		
		
		if(!params.id){
			println " *** SOMETHING WENT WRONG 161*** "
			flash.message = "Problems accessing invite, please try again"
			redirect(controller:'competition', action:'index')
			return
		}
		
		def competitionInvite = CompetitionInvite.get(params.id)
		if(!competitionInvite){
			flash.message = "Problems accessing invite, please try again"
			redirect(controller:'competition', action:'index')
			return
		}
		
		
		if(competitionInvite.competition.status == CompetitionStatus.STOPPED.description() ||
			competitionInvite.competition.status == CompetitionStatus.COMPLETED.description()){
			println "** competition has ended or stopped **"
			flash.message = "You can no longer join this competition, it has either ended or been stopped by the organizer."
			redirect(controller : 'competition', action : 'index')
			return
		}
		
		
		def existingCompetition = getCurrentActiveCompetition(competitionInvite.account)
		if(existingCompetition){
			flash.message = "You are already participating in a competition, quit or stop current competition to continue"
			redirect(controller: 'competition', action: 'index')
			return
		}
		
		
		//clean up current old competiton
		def oldCurrentCompetition = Competition.findByAccountAndCurrent(account, true)
		if(oldCurrentCompetition && 
			(oldCurrentCompetition?.status ==  CompetitionStatus.COMPLETED.description() ||
			oldCurrentCompetition?.status ==  CompetitionStatus.STOPPED.description())){
			
			println "** found old competition, change current to false **"
			oldCurrentCompetition.current = false
			oldCurrentCompetition.save(flush:true)
		}
		
		
		competitionInvite.status = CompetitionInviteStatus.ACCEPTED.description()
		competitionInvite.dateAcknowledged = new Date()
		competitionInvite.dateAccepted = new Date()
		competitionInvite.save(flush:true)
		
		def competition = competitionInvite.competition
		competition.addToMembers(competitionInvite.account)
		competition.save(flush:true)
		
		
		def competitionStats = new CompetitionStats()
		competitionStats.competition = competition
		competitionStats.account = account
		competitionStats.save(flush:true)
		
	
		println "*** accepted invite 191 ***"
		
		flash.message = "Successfully accepted invite.  Good Luck!"
		redirect( controller : 'competition', action: 'index')		
	}
	
	

	
	
	
	def decline(Integer id){
		def subject = SecurityUtils.getSubject();
		if(!subject.isAuthenticated()){
			flash.message = "Please sign in to continue"
			redirect(controller : 'auth', action: 'login')
			return
		}
		if(!id){
			flash.message = "Problems accessing invite, please try again"
			redirect(controller:'competition', action:'index')
			return
		}
		
		def competitionInvite = CompetitionInvite.get(id)
		if(!competitionInvite){
			flash.message = "Problems accessing invite, please try again"
			redirect(controller:'competition', action:'index')
			return
		}
		
		competitionInvite.status = CompetitionInviteStatus.DECLINED.description()
		competitionInvite.dateAcknowledged = new Date()
		competitionInvite.dateDeclined = new Date()
		if(!competitionInvite.save(flush:true)){
		
		}
		
		flash.message = "Successfully declined invitation."
		redirect(controller: 'account', action : 'dashboard')
	}
	
	
	
	
	
	
	
	
	def prepare(Integer id){
	
		if(!id){
			flash.message = "Problems accessing competition, please try again"
			redirect(controller:'competition', action:'index')
			return
		}
		
		def subject = SecurityUtils.getSubject();
		if(!subject.isAuthenticated()){
			flash.message = "Please sign in to continue"
			redirect(controller : 'auth', action: 'login')
			return
		}
		

		def account = Account.findByUsername(subject.principal)
		if(!account){
			flash.message = "Problems accessing competition, please try again"
			redirect(controller:'competition', action:'index')
			return
		}
		

		def competition = getCurrentActiveOrPendingCompetition(account)
		if(!competition){
			flash.message = "Competition not found"
			redirect(controller: 'competition', action: 'index')
			return
		}	
		
		
		if(!subject.isPermitted("competition:edit:${competition.id}")){
			flash.message = "You do not have permission to send invites for this Competition"
			redirect(controller : 'competition', action : 'index')
			return
		}
		
		
		if(!params.memberId){
			flash.message = "Something went wrong, unable to send invite"
			redirect(controller : 'competition', action: 'index')
			return
		}
		
		def member = Account.get(params.memberId)
		
		
		
		[ account : account, competition : competition, member : member ]	
		
	}
	
	
	
	
	
	def search(Integer id){
		println "*** search ***"
		if(!id){
			flash.message = "Problems accessing competition, please try again"
			redirect(controller:'competition', action:'index')
			return
		}
		
		def subject = SecurityUtils.getSubject();
		if(!subject.isAuthenticated()){
			flash.message = "Please sign in to continue"
			redirect(controller : 'auth', action: 'login')
			return
		}
		

		def account = Account.findByUsername(subject.principal)
		if(!account){
			flash.message = "Problems accessing competition, please try again"
			redirect(controller:'competition', action:'index')
			return
		}
		

		def competition = getCurrentActiveOrPendingCompetition(account)
		if(!competition){
			flash.message = "Competition not found"
			redirect(controller: 'competition', action: 'index')
			return
		}	
		
		
		if(!subject.isPermitted("competition:edit:${competition.id}")){
			flash.message = "You do not have permission to send invites for this Competition"
			redirect(controller : 'competition', action : 'index')
			return
		}
		
		println "*** query ${params.query}***"
		if(params.query){
			if(params.query.length() <= 3){
				flash.message = "Search must be at least 4 characters long"
				redirect(action : 'search', params : [id : id])
				return
			}
			def accounts = searchMembers(params.query)
			request.accounts = accounts
		}
		
		def invites = CompetitionInvite.findAllByCompetition(competition)
		def i = CompetitionInvite.findAll()
		println "*** all invites : ${i?.size()} ***"
		
		[ account : account, competition : competition, invites : invites ]
		
	}
	
	
	
	
	
	def searchMembers(query){
		def accountCriteria = Account.createCriteria()
		def accounts = accountCriteria.list(){
			or{
				ilike("username", "%${params.query}%")
				ilike("name", "%${params.query}%")
			}
		}
		return accounts
	}
	
	
	private def getCurrentActiveCompetition(account){
		def currentCriteria = Competition.createCriteria()
		def competition = currentCriteria.get{
			and{
				eq("current", true)
				eq("status", CompetitionStatus.ACTIVE.description())
	 			members {
	 				idEq(account.id)
	 			}
			}
		}
		return competition
	}
	
	
	
	def getCurrentActiveOrPendingCompetition(account){
		def currentCriteria = Competition.createCriteria()
		def competition = currentCriteria.get{
			and{
				eq("current", true)
	 			members {
	 				idEq(account.id)
	 			}
				or{
					eq("status", CompetitionStatus.UPCOMING.description())
					eq("status", CompetitionStatus.ACTIVE.description())
				}
			}
		}
		return competition
	}
	
	
}