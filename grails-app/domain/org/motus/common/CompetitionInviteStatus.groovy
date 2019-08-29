package org.motus.common

public enum CompetitionInviteStatus {

	PENDING('PENDING'),
	ACCEPTED('ACCEPTED'),
	DECLINED('DECLINED')
	
	private final String description
	
	CompetitionInviteStatus(String description){
		this.description = description
	}
	
	public String description(){
		return this.description
	}
	
}
