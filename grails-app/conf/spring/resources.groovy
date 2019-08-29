import org.motus.exceptions.BaseBringitException
import org.motus.ApplicationShiroPermissionResolver
import org.motus.handlers.BringitAuthenticationSuccessHandler

beans = {	
	exceptionHandler(org.motus.exceptions.BaseBringitException) {
	    exceptionMappings = ['java.lang.Exception': '/error']
	}
    shiroPermissionResolver(ApplicationShiroPermissionResolver)
	authenticationSuccessHandler(BringitAuthenticationSuccessHandler) {
		//https://groggyman.com/2015/04/05/custom-authentication-success-handler-with-grails-and-spring-security/
	       requestCache = ref('requestCache')
	       redirectStrategy = ref('redirectStrategy')
		   sessionFactory = ref('sessionFactory')
	}
}
