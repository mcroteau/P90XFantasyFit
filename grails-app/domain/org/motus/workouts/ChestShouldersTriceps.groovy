package org.motus.workouts
import org.motus.workouts.PlannedWorkout

class ChestShouldersTriceps extends PlannedWorkout {
	
	String link = "chestShouldersTriceps"
	String displayName = "Chest, Shoulders & Triceps"

	
	int slowMotionPushUps
	
	int inOutShoulderFlys
	int inOutShoulderFlysWeight


	int chairDips
	int plangePushUps
	int pikePresses
	int sideTriRises
	int floorFlys
	int scareCrows
	int scareCrowsWeight


	int overheadTricepExtensions
	int overheadTricepExtensionsWeight


	int twoTwitchSpeedPushUps
	int yPresses
	int yPressesWeight


	int lyingTricepExtension
	int lyingTricepExtensionWeight


	int sideToSidePushUps
	int oneArmPushUps
	int weightedCircles
	int weightedCirclesWeight


	int throwTheBomb
	int throwTheBombWeight


	int clapPushUps
	int slowMoThrows
	int slowMoThrowsWeight


	int frontToBackTricepExtension
	int frontToBackTricepExtensionWeight


	int oneArmBalancePushUps
	int flyRowPresses
	int flyRowPressesWeight


	int dumbbellCrossBodyBlows
	int dumbbellCrossBodyBlowsWeight


	
    static constraints = { 
		id generator: 'sequence', params:[sequence:'ID_CHEST_SHOULDERS_TRICEPS_PK_SEQ']
	}
	
}
