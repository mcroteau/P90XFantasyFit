package org.motus

import org.motus.WorkoutPlan

class ProgressPhoto {
	
	String type
	
	String imageUrl
	String imageFileName
	
	String thumbImageUrl
	String thumbImageFileName
	
	Date dateCreated
	Date lastUpdated
	
	
	WorkoutPlan workoutPlan
	static belongsTo = [ WorkoutPlan ]
	
    static constraints = {
		id generator: 'sequence', params:[sequence:'ID_PROGRESS_PHOTO_SEQ']
    }
	
}
