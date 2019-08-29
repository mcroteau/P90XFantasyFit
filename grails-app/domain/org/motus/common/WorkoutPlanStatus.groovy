package org.motus.common

public enum WorkoutPlanStatus {

	ACTIVE('Active'),
	COMPLETED('Completed'),
	INCOMPLETE('Incomplete'),
	STOPPED('Stopped')
	
	private final String description
	
	WorkoutPlanStatus(String description){
		this.description = description
	}
	
	public String description(){
		return this.description
	}
	
}
