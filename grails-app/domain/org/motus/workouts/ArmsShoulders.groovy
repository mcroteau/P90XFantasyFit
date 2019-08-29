package org.motus.workouts
import org.motus.workouts.PlannedWorkout

class ArmsShoulders extends PlannedWorkout {
	
	String link = "armsShoulders"
	String displayName = "Arms & Shoulders"


	int alternatingShoulderPresses
	int alternatingShoulderPressesWeight
	int alternatingShoulderPresses2
	int alternatingShoulderPressesWeight2



	int inOutBicepCurls
	int inOutBicepCurlsWeight
	int inOutBicepCurls2
	int inOutBicepCurlsWeight2



	int twoArmTricepKickbacks
	int twoArmTricepKickbacksWeight
	int twoArmTricepKickbacks2
	int twoArmTricepKickbacksWeight2



	int deepSwimmerPresses
	int deepSwimmerPressesWeight
	int deepSwimmerPresses2
	int deepSwimmerPressesWeight2



	int fullSupinationConcentrationCurls
	int fullSupinationConcentrationCurlsWeight
	int fullSupinationConcentrationCurls2
	int fullSupinationConcentrationCurlsWeight2



	int chairDips
	int chairDips2

	
	int uprightRows
	int uprightRowsWeight
	int uprightRows2
	int uprightRowsWeight2



	int staticArmCurls
	int staticArmCurlsWeight
	int staticArmCurls2
	int staticArmCurlsWeight2



	int flipGripTwistTricepKickbacks
	int flipGripTwistTricepKickbacksWeight
	int flipGripTwistTricepKickbacks2
	int flipGripTwistTricepKickbacksWeight2



	int twoAngleShoulderFlys
	int twoAngleShoulderFlysWeight
	int twoAngleShoulderFlys2
	int twoAngleShoulderFlysWeight2



	int crouchingCohenCurls
	int crouchingCohenCurlsWeight
	int crouchingCohenCurls2
	int crouchingCohenCurlsWeight2



	int lyingDownTricepExtensions
	int lyingDownTricepExtensionsWeight
	int lyingDownTricepExtensions2
	int lyingDownTricepExtensionsWeight2



	int inOutStraightArmFlys
	int inOutStraightArmFlysWeight
	int inOutStraightArmFlys2
	int inOutStraightArmFlysWeight2



	int congdonCurls
	int congdonCurlsWeight
	int congdonCurls2
	int congdonCurlsWeight2



	int sideTriRises
	int sideTriRises2

	
    static constraints = { 
		alternatingShoulderPresses(nullable:true)
		alternatingShoulderPressesWeight(nullable:true)
		alternatingShoulderPresses2(nullable:true)
		alternatingShoulderPressesWeight2(nullable:true)
		inOutBicepCurls(nullable:true)
		inOutBicepCurlsWeight(nullable:true)
		inOutBicepCurls2(nullable:true)
		inOutBicepCurlsWeight2(nullable:true)
		twoArmTricepKickbacks(nullable:true)
		twoArmTricepKickbacksWeight(nullable:true)
		twoArmTricepKickbacks2(nullable:true)
		twoArmTricepKickbacksWeight2(nullable:true)
		deepSwimmerPresses(nullable:true)
		deepSwimmerPressesWeight(nullable:true)
		deepSwimmerPresses2(nullable:true)
		deepSwimmerPressesWeight2(nullable:true)
		fullSupinationConcentrationCurls(nullable:true)
		fullSupinationConcentrationCurlsWeight(nullable:true)
		fullSupinationConcentrationCurls2(nullable:true)
		fullSupinationConcentrationCurlsWeight2(nullable:true)
		chairDips(nullable:true)
		chairDips2(nullable:true)
		uprightRows(nullable:true)
		uprightRowsWeight(nullable:true)
		uprightRows2(nullable:true)
		uprightRowsWeight2(nullable:true)
		staticArmCurls(nullable:true)
		staticArmCurlsWeight(nullable:true)
		staticArmCurls2(nullable:true)
		staticArmCurlsWeight2(nullable:true)
		flipGripTwistTricepKickbacks(nullable:true)
		flipGripTwistTricepKickbacksWeight(nullable:true)
		flipGripTwistTricepKickbacks2(nullable:true)
		flipGripTwistTricepKickbacksWeight2(nullable:true)
		twoAngleShoulderFlys(nullable:true)
		twoAngleShoulderFlysWeight(nullable:true)
		twoAngleShoulderFlys2(nullable:true)
		twoAngleShoulderFlysWeight2(nullable:true)
		crouchingCohenCurls(nullable:true)
		crouchingCohenCurlsWeight(nullable:true)
		crouchingCohenCurls2(nullable:true)
		crouchingCohenCurlsWeight2(nullable:true)
		lyingDownTricepExtensions(nullable:true)
		lyingDownTricepExtensionsWeight(nullable:true)
		lyingDownTricepExtensions2(nullable:true)
		lyingDownTricepExtensionsWeight2(nullable:true)
		inOutStraightArmFlys(nullable:true)
		inOutStraightArmFlysWeight(nullable:true)
		inOutStraightArmFlys2(nullable:true)
		inOutStraightArmFlysWeight2(nullable:true)
		congdonCurls(nullable:true)
		congdonCurlsWeight(nullable:true)
		congdonCurls2(nullable:true)
		congdonCurlsWeight2(nullable:true)
		sideTriRises(nullable:true)
		sideTriRises2(nullable:true)
		id generator: 'sequence', params:[sequence:'ID_ARMS_SHOULDERS_PK_SEQ']
	}
	
}
