package org.motus.workouts
import org.motus.workouts.PlannedWorkout

class ArmsShoulders extends PlannedWorkout {
	
	String link = "ArmsShoulders"
	String displayName = "Arms & Shoulders"

	
	int alternatingShoulderPresses
	int alternatingShoulderPressesWeight


	int inOutBicepCurls
	int inOutBicepCurlsWeight


	int twoArmTricepKickbacks
	int twoArmTricepKickbacksWeight


	int deepSwimmerPresses
	int deepSwimmerPressesWeight


	int fullSupinationConcentrationCurls
	int fullSupinationConcentrationCurlsWeight


	int chairDips
	int uprightRows
	int uprightRowsWeight


	int staticArmCurls
	int staticArmCurlsWeight


	int flipGripTwistTricepKickbacks
	int flipGripTwistTricepKickbacksWeight


	int twoAngleShoulderFlys
	int twoAngleShoulderFlysWeight


	int crouchingCohenCurls
	int crouchingCohenCurlsWeight


	int lyingDownTricepExtensions
	int lyingDownTricepExtensionsWeight


	int inOutStraightArmFlys
	int inOutStraightArmFlysWeight


	int congdonCurls
	int congdonCurlsWeight


	int sideTriRises
	
    static constraints = { 
		id generator: 'sequence', params:[sequence:'ID_ARMS_SHOULDERS_PK_SEQ']
	}
	
}
