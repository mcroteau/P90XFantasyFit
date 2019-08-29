package org.motus.workouts
import org.motus.workouts.PlannedWorkout

class ${CLASS_NAME} extends PlannedWorkout {
	
	String link = "${LINK}"
	String displayName = "${DISPLAY_NAME}"

	${FIELDS}
	
    static constraints = { 
		id generator: 'sequence', params:[sequence:'ID_${CONSTRAINTS}_PK_SEQ']
	}
	
}
