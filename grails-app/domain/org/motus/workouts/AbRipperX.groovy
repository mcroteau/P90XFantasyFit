package org.motus.workouts

class AbRipperX extends PlannedWorkout {
	
	String link = "abRipperX"
	String displayName = "Ab Ripper X"
	
    static constraints = {
		id generator: 'sequence', params:[sequence:'ID_AB_RIPPER_X_PK_SEQ']
    }
}
