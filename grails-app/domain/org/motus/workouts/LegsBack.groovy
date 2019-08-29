package org.motus.workouts
import org.motus.workouts.PlannedWorkout

class LegsBack extends PlannedWorkout {
	
	String link = "LegsBack"
	String displayName = "Legs & Back"

	
	int balanceLunges
	int balanceLungesWeight


	int calfRaiseSquats
	int calfRaiseSquatsWeight


	int reverseGripPullUps1
	int superSkaters
	int wallSquats
	int wideFrontPullUps
	int stepBackLunge
	int stepBackLungeWeight


	int alternatingSideLunge
	int alternatingSideLungeWeight


	int closedGripPullUps
	int singleLegWallSquats
	int deadLiftSquats
	int deadLiftSquatsWeight


	int switchGripPullUps
	int threeWayLunges
	int threeWayLungesWeight


	int sneakyLunges
	int sneakyLungesWeight


	int reverseGripChinUps2
	int chairSalutations
	int toeRollIsoLunge
	int toeRollIsoLungeWeight


	int wideFrontPullUps2
	int grouchoWalk
	int calfRaises
	int calfRaisesWeight


	int closedGripPullUps2
	int sieberSpeedSquats
	int switchGripPullUps2
	
    static constraints = { 
		id generator: 'sequence', params:[sequence:'ID_LEGS_BACK_PK_SEQ']
	}
	
}