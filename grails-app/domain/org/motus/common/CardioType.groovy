package org.motus.common

public enum CardioType {

	JOGGING('Jogging'),
	INTERVALS('Intervals'),
	WALKING('Walking'),
	ELLIPTICAL('Elliptical'),
	BIKING('Biking'),
	HIKING('Hiking'),
	SWIMMING('Swimming')
	
	private final String description
	
	CardioType(String description){
		this.description = description
	}
	
	public String description(){
		return this.description
	}
	
}
