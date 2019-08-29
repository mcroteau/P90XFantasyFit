package fit2

import org.motus.workouts.PlannedWorkout
import org.motus.Account

class BaseInterceptor {

	def springSecurityService
	
	BaseInterceptor(){
		matchAll()
	}
    
	boolean before() { true }

    boolean after() { 
		//println "after base interceptor" + springSecurityService
		//
		//def totalWorkouts = ""
		//if(springSecurityService.isLoggedIn()){
		//	def account = Account.findByUsername(springSecurityService.principal)
		//	totalWorkouts = PlannedWorkout.countByAccount(account)
		//	request.totalWorkouts = totalWorkouts
		//}
		
		true 
	}

    void afterView() {
        // no-op
    }
}
