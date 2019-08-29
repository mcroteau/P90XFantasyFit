package fit2

import org.apache.shiro.crypto.hash.Sha512Hash
import org.apache.shiro.crypto.hash.Sha256Hash
import org.apache.shiro.crypto.hash.Sha1Hash

import org.motus.Account
import org.motus.Role
import org.motus.common.RoleName
import org.motus.WorkoutPlan
import org.motus.Week
import org.motus.workouts.PlannedWorkout
import org.motus.Competition
import org.motus.CompetitionStats
import org.motus.common.CompetitionStatus

import grails.util.Environment
import org.motus.AppConstants


class BootStrap {

	def adminRole
	def simpleRole
	def grailsApplication
	def springSecurityService
	
    def init = { servletContext ->
		createRoles()
		createUsers()
		
		if (Environment.current == Environment.DEVELOPMENT ||
			Environment.current == Environment.TEST){
			//createMockAccounts()
			//createMockCompetition()
		}
	}
	
	
    def destroy = {}

	def createRoles = {
		if(Role.count() == 0){
			adminRole = new Role(authority : RoleName.ROLE_ADMIN.description()).save(flush:true)
			simpleRole = new Role(authority : RoleName.ROLE_SIMPLE.description()).save(flush:true)
		}else{
			adminRole = Role.findByAuthority(RoleName.ROLE_ADMIN.description())
			simpleRole = Role.findByAuthority(RoleName.ROLE_SIMPLE.description())
		}
		
		println "Roles : ${Role.count()}"
	}
	
	
	
	def createUsers = {
		
		if(Account.count() == 0){
			
			def pass = springSecurityService.encodePassword("bringit")
			
			def me = new Account(
				username : 'bringit', 
				password : pass, 
				name : 'Second Admin', 
				email : 'croteau.mike+admin2@gmail.com')

			me.save(flush:true)	
			me.createAccountRoles(true)
			//me.createAccountPermission()	
			me.addToPermissions("account:edit:${me.id}")
			me.save(flush:true)		
			
			
			
			def adminPass = springSecurityService.encodePassword("bringitadmin")
			def admin = new Account(username : 'admin', 
					password : adminPass, 
					name : 'Administrator', 
					email : 'croteau.mike+admin@gmail.com')

			admin.save(flush:true)
			admin.createAccountRoles(true)		
			//admin.createAccountPermission()	

			admin.addToPermissions("account:edit:${admin.id}")
			admin.save(flush:true)	
					
		}

		println "Accounts : ${Account.count()}"
	}
	
	
	
	
	
	def createMockAccounts(){
		
		def pass = springSecurityService.encodePassword("bringit")
		
		(1..5).each { i ->
			def mock = new Account(
				username : "mock${i}", 
				password : pass, 
				name : "Mock User ${i}", 
				email : "croteau.mike+${i}@gmail.com",
				phone : "3019564264",
				motivateText : true,
				motivateEmail : true
			)
			
			if(i == 1){
				mock.motivateText = false
				mock.motivateEmail = false
			}
			mock.save(flush:true)	
			mock.createAccountRoles(false)
			mock.createAccountPermission()	
           
			mock.addToPermissions("account:edit:${mock.id}")			
			mock.save(flush:true)
		}

	}
	
	
	
	
	def createMockCompetition(){
		def me = Account.findByUsername('bringit')
		def competition = new Competition()
		
		def startDate = new Date()
		def endDate = new Date()
		
		competition.name = "Bootstrappin this thang"
		competition.current = true
		competition.startDate = startDate
		competition.endDate = endDate
		competition.status = CompetitionStatus.ACTIVE.description()
		competition.account = me
		competition.addToMembers(me)
		competition.save(flush:true)

		
		me.addToPermissions("competition:edit:${competition.id}")
		me.save(flush:true)
		
		
		
		def stats = new CompetitionStats()
		stats.account = me
		stats.competition = competition
		stats.save(flush:true)
		
		
		
		def mock1 = Account.findByUsername('mock1')
		competition.addToMembers(mock1)
		competition.save(flush:true)
		
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
	

	private void addDynamicMethods(klass) {
		klass.metaClass.withMobileDevice = { Closure closure ->
			def device = request.currentDevice
			if (device?.isMobile()) {
				closure.call device
			}
		}

		klass.metaClass.isMobile = { -> request.currentDevice.isMobile() }

		klass.metaClass.isTablet = { -> request.currentDevice.isTablet() }

		klass.metaClass.isNormal = { -> request.currentDevice.isNormal() }
		
		klass.metaClass.withMobileDevice = { -> request.currentDevice.isMobile() }
		
	}
	
	
}
