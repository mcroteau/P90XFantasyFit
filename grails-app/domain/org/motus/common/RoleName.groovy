package org.motus.common

public enum RoleName {

	ROLE_ADMIN('ROLE_ADMIN'),
	ROLE_SIMPLE('ROLE_SIMPLE'),
	ROLE_PAYING('ROLE_PAYING')
	
	private final String description
	
	RoleName(String description){
		this.description = description
	}
	
	public String description(){
		return this.description
	}
	
}
