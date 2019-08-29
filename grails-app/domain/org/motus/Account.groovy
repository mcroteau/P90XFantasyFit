package org.motus

import org.motus.Competition
import org.motus.CompetitionInvite

class Account {

    String username
	String email
    String password
    
	String name
	Integer age
	String location 
	String ipAddress
	String phone
	
	int totalPoints
	int workoutsCompleted
	int workoutsSkipped
	int plansCompleted
	int competitionsCompleted
	int competitionsWon
	
	String profileImageUrl
	String profileImageName
	
	boolean active
	boolean privateProfile
	
	boolean motivateEmail
	boolean motivateText
	
	int loginCount
	
	Date dateCreated
	Date lastUpdated
	
	String resetUUID
	
	boolean enabled = true
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired

	boolean hasAdminRole
	
		
	static hasMany = [ accolades : Accolade, permissions: String ]


	Set<Role> getAuthorities() {
		AccountRole.findAllByAccount(this)*.role
	}
	
	def createAccountPermission(){
		createPermission(AppConstants.ACCOUNT_PERMISSION + this.id)
	}

	def createAdminAccountRole(){
		def adminRole = Role.findByAuthority(AppConstants.ROLE_ADMIN)
		createAccountRole(adminRole)
	}

	def createAccountRoles(includeAdminRole){
		this.hasAdminRole = false
		this.save(flush:true)

		def role = Role.findByAuthority(AppConstants.ROLE_SIMPLE)
		createAccountRole(role)
		println "createAccountRoles : " + this + " " + role
	
		if(includeAdminRole){
			def adminRole = Role.findByAuthority(AppConstants.ROLE_ADMIN)
			createAccountRole(adminRole)
			this.hasAdminRole = true
		}

		this.save(flush:true)
	}

	def createAccountRole(role){
		println "createAccountRole : " + this + " " + role
		if(!this)throw new Exception("Account didn't save correctly")
		def accountRole = new AccountRole()
		accountRole.account = this
		accountRole.role = role
		accountRole.save(flush:true)	
	}

	def createPermission(permissionString){
		def permission = new Permission()
		permission.account = this
		permission.permission = permissionString
		permission.save(flush:true)

		this.addToPermissions(permission)
		this.save(flush:true)
	}
    
	
    static constraints = {
		active(nullable:true, default:true)
		name(blank:true, nullable:true)
		age(blank:true, nullable:true)
		phone(blank:true, nullable:true)
        email(email:true, nullable: false, blank: false, unique: true)
		location(blank:true, nullable:true)
		ipAddress(blank:true, nullable:true)
		resetUUID(nullable:true)
		totalPoints(nullable:true)
		workoutsCompleted(nullable:true)
		workoutsSkipped(nullable:true)
		plansCompleted(nullable:true)
		competitionsCompleted(nullable:true, default:0)
		competitionsWon(nullable:true, default:0)
		profileImageUrl(nullable:true)
		profileImageName(nullable:true)
        username(nullable: false, blank: false, unique: true)
		password(nullable:false, blank:false, column: '`password`')
		privateProfile(nullable:true, default:false)
		motivateEmail(nullable:true, default:true)
		motivateText(nullable:true, default:true)
		loginCount(nullable:true, default:0)		
		enabled(nullable:true, default:true)
		accountExpired(nullable:true)
		accountLocked(nullable:true)
		passwordExpired(nullable:true)
		hasAdminRole(nullable:true, default:false)
		id generator: 'sequence', params:[sequence:'ID_ACCOUNT_PK_SEQ']
    }
	
}
