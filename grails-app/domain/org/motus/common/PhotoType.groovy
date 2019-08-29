package org.motus.common

public enum PhotoType {

	BEFORE('Day 1'),
	THIRTY_DAY('30 Day'),
	SIXTY_DAY('60 Day'),
	NINETY_DAY('90 Day')
	
	private final String description
	
	PhotoType(String description){
		this.description = description
	}
	
	public String description(){
		return this.description
	}
	
}
