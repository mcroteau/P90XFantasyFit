package org.motus.workouts

import org.motus.workouts.PlannedWorkout

class BackBiceps extends PlannedWorkout {
	
	String link = "backBiceps"
	String displayName = "Back & Biceps"
	
	String maxRepPullUpsType
	
	int wideFrontPullUps
	
	int lawnMowersReps
	int lawnMowersWeight
	
	int twentyOnesReps
	int twentyOnesWeight
	
	int crossBodyCurlsReps
	int crossBodyCurlsWeight
	
	int switchGripPullUps
	
	int elbowsOutLawnMowersReps
	int elbowsOutLawnMowersWeight
	
	int standingBicepCurlsReps
	int standingBicepCurlsWeight
	
	int concentrationCurlsReps
	int concentrationCurlsWeight
	
	int cornCobPullUps
	
	int reverseGripBentoverRowsReps
	int reverseGripBentoverRowsWeight
	
	int openArmCurlsReps
	int openArmCurlsWeight

	int staticArmCurlsReps
	int staticArmCurlsWeight
	
	int towelPullUps
	
	int congdonLocomotivesReps
	int congdonLocomotivesWeight
	
	int crouchingCohenCurlsReps
	int crouchingCohenCurlsWeight
	
	int oneArmCorkscrewCurlsReps
	int oneArmCorkscrewCurlsWeight
	
	int chinUps

	int seatedBentOverBackFlysReps
	int seatedBentOverBackFlysWeight

	int curlUpHammerDownsReps
	int curlUpHammerDownsWeight
	
	int hammerCurlsReps
	int hammerCurlsWeight

	int maxRepPullUps
	
	int supermans
	
	int inOutHammerCurlsReps
	int inOutHammerCurlsWeight
	
	int stripSetCurls1Reps
	int stripSetCurls1Weight
	
	int stripSetCurls2Reps
	int stripSetCurls2Weight
	
	int stripSetCurls3Reps
	int stripSetCurls3Weight
	
    static constraints = {
		maxRepPullUpsType(nullable:true)
		id generator: 'sequence', params:[sequence:'ID_BACK_BICEPS_PK_SEQ']
    }
}
