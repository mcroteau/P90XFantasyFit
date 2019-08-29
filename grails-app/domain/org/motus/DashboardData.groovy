package org.motus

import org.motus.workouts.PlannedWorkout
import org.motus.WorkoutPlan

import java.util.List

class DashboardData {
	
	static mapWith = "none"
	
	String workouts
	
	WorkoutPlan currentPlan
	List<WorkoutPlan> workoutPlans
	
	PlannedWorkout todaysWorkout
	
	int totalWorkouts
	int percentComplete
	int totalCompletedSkipped
	
 	int completedWorkouts
	int incompleteWorkouts
	int skippedWorkouts
	
	List<Accolade> accolades
	int accoladesCount

}
