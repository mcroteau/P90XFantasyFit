package org.motus

import grails.plugin.springsecurity.shiro.ShiroPermissionResolver

class ApplicationShiroPermissionResolver implements ShiroPermissionResolver {
	
	ApplicationShiroPermissionResolver(){
		println "ApplicationShiroPermissionResolver Initialized..."
	}
	
	
	@Override
	public Set<String> resolvePermissions(String username){
		StackTraceElement[] stackTraceElements = Thread.currentThread().getStackTrace()
		//stackTraceElements.class.properties.each{
		//	println "${it.key} -> ${it.value}"
		//}
		//println "username : " + username
		def account = Account.findByUsername(username)
		if(!account){
			return ""
		}
		def permissions = account.permissions
		return permissions
	}
}