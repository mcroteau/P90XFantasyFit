package org.motus.common

public enum CompetitionStatus {

	ACTIVE('Active'),
	UPCOMING('Upcoming'),
	COMPLETED('Completed'),
	STOPPED('Stopped'),
	INACTIVE('Inactive')
	
	private final String description
	
	CompetitionStatus(String description){
		this.description = description
	}
	
	public String description(){
		return this.description
	}
	
}
