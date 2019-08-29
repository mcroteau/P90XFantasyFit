package org.motus.workouts
import org.motus.workouts.PlannedWorkout

class ChestBack extends PlannedWorkout {
	
	String link = "chestBack"
	String displayName = "Chest & Back"
	
	int standardPushUps1
	int standardPushUps2
	
	int wideFrontPullUps1
	int wideFrontPullUps2
	
	int militaryPushUps1
	int militaryPushUps2
	
	int reverseGripPullUps1
	int reverseGripPullUps2
	
	int wideFlyPushUps1
	int wideFlyPushUps2
	
	int closedGripPullUps1
	int closedGripPullUps2
	
	int declinedPushUps1
	int declinedPushUps2
	
	int heavyPantsReps1
	int heavyPantsWeight1
	
	int heavyPantsReps2
	int heavyPantsWeight2
	
	int diamondPushUps1
	int diamondPushUps2
	
	int lawnmowersReps1
	int lawnmowersWeight1
	
	int lawnmowersReps2
	int lawnmowersWeight2
	
	int diveBomberPushUps1
	int diveBomberPushUps2
	
	int backFlysReps1
	int backFlysWeight1
	
	int backFlysReps2
	int backFlysWeight2
	
    static constraints = {
		id generator: 'sequence', params:[sequence:'ID_CHEST_BACK_PK_SEQ']
    }
}
