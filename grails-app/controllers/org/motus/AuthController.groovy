package org.motus

import org.apache.shiro.SecurityUtils
import org.apache.shiro.authc.AuthenticationException
import org.apache.shiro.authc.UsernamePasswordToken
import org.apache.shiro.web.util.SavedRequest
import org.apache.shiro.web.util.WebUtils
import grails.converters.*

import org.motus.log.LoginLog
import org.motus.Account

class AuthController {

    def shiroSecurityManager
	
    def index = { redirect(action: "login", params: params) }

    def login = {
		def view = "/auth/login"
		
		withMobileDevice { device ->
			view = "/auth/login_mobile"
		}
		
		request.username = params.username 
		request.rememberMe = (params.rememberMe != null)
		request.targetUri = params.targetUri 

		render(view : view)
    }


    def signIn () {
		
		def action = "profile"
		withMobileDevice { device ->
		      action = "dashboard"
		}
		
		
        def authToken = new UsernamePasswordToken(params.username, params.password as String)
		
        // Support for "remember me"
        if (params.rememberMe) {
            authToken.rememberMe = true
        }
        
        // If a controller redirected to this page, redirect back
        // to it. Otherwise redirect to the root URI.
        def targetUri = params.targetUri ?: "/"
        
        // Handle requests saved by Shiro filters.
        SavedRequest savedRequest = WebUtils.getSavedRequest(request)
        if (savedRequest) {
            targetUri = savedRequest.requestURI - request.contextPath
            if (savedRequest.queryString) targetUri = targetUri + '?' + savedRequest.queryString
        }
        
        try{
            // Perform the actual login. An AuthenticationException
            // will be thrown if the username is unrecognised or the
            // password is incorrect.
            SecurityUtils.subject.login(authToken)

            println "Redirecting to '${targetUri}'."
			
			
			def loginLog = new LoginLog()
			loginLog.ipAddress = request.getRemoteAddr()
			println "HEADER NAMES ${request.getHeaderNames()}"
			println "REMOTE HOST ${request.getRemoteAddr()}"
			loginLog.date = new Date()
			def account = Account.findByUsername(params.username)
			loginLog.account = account
			loginLog.save(flush:true)
			
			
			def count = LoginLog.countByAccount(account)
			account.loginCount = count
			account.save(flush:true)
			

			//http://grails.1312388.n4.nabble.com/setting-a-custom-session-timeout-using-shiro-td1692750.html
			//SecurityUtils.subject.getSession().setTimeout(7200000);
			
			redirect(controller : 'account', action: action)
			
			
			
        } catch (AuthenticationException ex){
            // Authentication failed, so display the appropriate message
            // on the login page.
            log.info "Authentication failure for user '${params.username}'."
            flash.message = message(code: "Please login to continue...")

            // Keep the username and "remember me" setting so that the
            // user doesn't have to enter them again.
            def m = [ username: params.username ]
            if (params.rememberMe) {
                m["rememberMe"] = true
            }

            // Remember the target URI too.
            if (params.targetUri) {
                m["targetUri"] = params.targetUri
            }

            // Now redirect back to the login page.
            redirect(action: "login", params: m)
        }
    }

    def signOut = {
        // Log the user out of the application.
        SecurityUtils.subject?.logout()
        webRequest.getCurrentRequest().session = null

        // For now, redirect back to the home page.
        redirect(uri: "/")
    }

    def unauthorized = {
        render "You do not have permission to access this page."
    }
	
	
	
	private def withMobileDevice(Closure c){
		if( request.currentDevice.isMobile()){
			c.call request.currentDevice
		}
	}
	
}
