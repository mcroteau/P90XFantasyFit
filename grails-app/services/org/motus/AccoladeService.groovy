package org.motus

import org.motus.Account
import org.motus.WorkoutPlan
import org.motus.workouts.PlannedWorkout
import org.motus.common.AccoladeType
import org.motus.common.AccoladeDescription
import org.motus.common.AccoladePoints
import org.motus.common.CompetitionStatus

class AccoladeService {
	
	static scope = "singleton"
	static transactional = true

	
	
	def getCurrentActiveCompetition(account){
		def currentCriteria = Competition.createCriteria()
		def competition = currentCriteria.get{
			and{
				eq("current", true)
				eq("status", CompetitionStatus.ACTIVE.description())
	 			members {
	 				idEq(account.id)
	 			}
			}
		}
		return competition
	}
	
	
	def checkSetCompetitionStatsAccolades(account, accolade){
		def competition = getCurrentActiveCompetition(account)
		if(competition){
			def competitionStats = CompetitionStats.findByAccountAndCompetition(account, competition)
			competitionStats.addToAccolades(accolade)
			competitionStats.save(flush:true)
			accolade.competition = competition
			accolade.save(flush:true)
		}
	}
	
	

	
	def processAbRipperLogged(account, plannedWorkout){
	
		if(plannedWorkout.includeAbRipper &&
				plannedWorkout.abRipperCompleted){
			
			def abRipperAccolade = Accolade.findByPlannedWorkoutAndType(plannedWorkout, AccoladeType.COMPLETED_AB_RIPPER.description())
			
			if(!abRipperAccolade){
				def accolade = new Accolade()
				
				accolade.account = account
				accolade.type = AccoladeType.COMPLETED_AB_RIPPER.description()
				accolade.description = AccoladeDescription.COMPLETED_AB_RIPPER.description()
				accolade.points = AccoladePoints.COMPLETED_AB_RIPPER.value()
				accolade.plannedWorkout = plannedWorkout
				accolade.workoutPlan = plannedWorkout.workoutPlan
				accolade.save(flush:true)
				
				checkSetCompetitionStatsAccolades(account, accolade)
				
				def workoutPlan = plannedWorkout.workoutPlan
				workoutPlan.addToAccolades(accolade)
				workoutPlan.save(flush:true)
			}
		}
	}
	
	
	
	def getFreeWeightsAccoladeData(plannedWorkout){
		def data = [:]
		switch(plannedWorkout.minutes){
			case 20 : 
				data.type = AccoladeType.TWENTY_MINUTE_FREEWEIGHTS.description()
				data.description = AccoladeDescription.TWENTY_MINUTE_FREEWEIGHTS.description()
				data.points = AccoladePoints.TWENTY_MINUTE_FREEWEIGHTS.value()
				break
			case 25 :
				data.type = AccoladeType.TWENTY_MINUTE_FREEWEIGHTS.description()
				data.description = AccoladeDescription.TWENTY_MINUTE_FREEWEIGHTS.description()
				data.points = AccoladePoints.TWENTY_MINUTE_FREEWEIGHTS.value()
				break
			case 30 :
				data.type = AccoladeType.THIRTY_MINUTE_FREEWEIGHTS.description()
				data.description = AccoladeDescription.THIRTY_MINUTE_FREEWEIGHTS.description()
				data.points = AccoladePoints.THIRTY_MINUTE_FREEWEIGHTS.value()
				break
			case 35 :
				data.type = AccoladeType.THIRTY_MINUTE_FREEWEIGHTS.description()
				data.description = AccoladeDescription.THIRTY_MINUTE_FREEWEIGHTS.description()
				data.points = AccoladePoints.THIRTY_MINUTE_FREEWEIGHTS.value()
				break
			case 40 : 
				data.type = AccoladeType.FORTY_MINUTE_FREEWEIGHTS.description()
				data.description = AccoladeDescription.FORTY_MINUTE_FREEWEIGHTS.description()
				data.points = AccoladePoints.FORTY_MINUTE_FREEWEIGHTS.value()
				break
			case 45 :
				data.type = AccoladeType.FORTY_MINUTE_FREEWEIGHTS.description()
				data.description = AccoladeDescription.FORTY_MINUTE_FREEWEIGHTS.description()
				data.points = AccoladePoints.FORTY_MINUTE_FREEWEIGHTS.value()
				break
			case 50 : 
				data.type = AccoladeType.FIFTY_MINUTE_FREEWEIGHTS.description()
				data.description = AccoladeDescription.FIFTY_MINUTE_FREEWEIGHTS.description()
				data.points = AccoladePoints.FIFTY_MINUTE_FREEWEIGHTS.value()
				break
			case 60 :
				data.type = AccoladeType.SIXTY_MINUTE_FREEWEIGHTS.description()
				data.description = AccoladeDescription.SIXTY_MINUTE_FREEWEIGHTS.description()
				data.points = AccoladePoints.SIXTY_MINUTE_FREEWEIGHTS.value()
				break
			case 70 :
				data.type = AccoladeType.SEVENTY_MINUTE_FREEWEIGHTS.description()
				data.description = AccoladeDescription.SEVENTY_MINUTE_FREEWEIGHTS.description()
				data.points = AccoladePoints.SEVENTY_MINUTE_FREEWEIGHTS.value()
				break
			case 80 :
				data.type = AccoladeType.EIGHTY_MINUTE_FREEWEIGHTS.description()
				data.description = AccoladeDescription.EIGHTY_MINUTE_FREEWEIGHTS.description()
				data.points = AccoladePoints.EIGHTY_MINUTE_FREEWEIGHTS.value()
				break	
			case 90 :
				data.type = AccoladeType.NINETY_MINUTE_FREEWEIGHTS.description()
				data.description = AccoladeDescription.NINETY_MINUTE_FREEWEIGHTS.description()
				data.points = AccoladePoints.NINETY_MINUTE_FREEWEIGHTS.value()
				break
		}
		return data
	}	
	
	
	
	
	def getCardioAccoladeData(plannedWorkout){
		def data = [:]
		switch(plannedWorkout.minutes){
			case 20 : 
				data.type = AccoladeType.TWENTY_MINUTE_CARDIO.description()
				data.description = AccoladeDescription.TWENTY_MINUTE_CARDIO.description()
				data.points = AccoladePoints.TWENTY_MINUTE_CARDIO.value()
				break
			case 25 :
				data.type = AccoladeType.TWENTY_MINUTE_CARDIO.description()
				data.description = AccoladeDescription.TWENTY_MINUTE_CARDIO.description()
				data.points = AccoladePoints.TWENTY_MINUTE_CARDIO.value()
				break
			case 30 :
				data.type = AccoladeType.THIRTY_MINUTE_CARDIO.description()
				data.description = AccoladeDescription.THIRTY_MINUTE_CARDIO.description()
				data.points = AccoladePoints.THIRTY_MINUTE_CARDIO.value()
				break
			case 35 :
				data.type = AccoladeType.THIRTY_MINUTE_CARDIO.description()
				data.description = AccoladeDescription.THIRTY_MINUTE_CARDIO.description()
				data.points = AccoladePoints.THIRTY_MINUTE_CARDIO.value()
				break
			case 40 : 
				data.type = AccoladeType.FORTY_MINUTE_CARDIO.description()
				data.description = AccoladeDescription.FORTY_MINUTE_CARDIO.description()
				data.points = AccoladePoints.FORTY_MINUTE_CARDIO.value()
				break
			case 45 :
				data.type = AccoladeType.FORTY_MINUTE_CARDIO.description()
				data.description = AccoladeDescription.FORTY_MINUTE_CARDIO.description()
				data.points = AccoladePoints.FORTY_MINUTE_CARDIO.value()
				break
			case 50 : 
				data.type = AccoladeType.FIFTY_MINUTE_CARDIO.description()
				data.description = AccoladeDescription.FIFTY_MINUTE_CARDIO.description()
				data.points = AccoladePoints.FIFTY_MINUTE_CARDIO.value()
				break
			case 60 :
				data.type = AccoladeType.SIXTY_MINUTE_CARDIO.description()
				data.description = AccoladeDescription.SIXTY_MINUTE_CARDIO.description()
				data.points = AccoladePoints.SIXTY_MINUTE_CARDIO.value()
				break
			case 70 :
				data.type = AccoladeType.SEVENTY_MINUTE_CARDIO.description()
				data.description = AccoladeDescription.SEVENTY_MINUTE_CARDIO.description()
				data.points = AccoladePoints.SEVENTY_MINUTE_CARDIO.value()
				break	
			case 80 :
				data.type = AccoladeType.EIGHTY_MINUTE_CARDIO.description()
				data.description = AccoladeDescription.EIGHTY_MINUTE_CARDIO.description()
				data.points = AccoladePoints.EIGHTY_MINUTE_CARDIO.value()
				break
			case 90 :
				data.type = AccoladeType.NINETY_MINUTE_CARDIO.description()
				data.description = AccoladeDescription.NINETY_MINUTE_CARDIO.description()
				data.points = AccoladePoints.NINETY_MINUTE_CARDIO.value()
				break
		}
		return data
	}




	def processWorkoutLogged(account, plannedWorkout){
		
		def existingAccolade = Accolade.findByPlannedWorkout(plannedWorkout)
		
		if(!existingAccolade){
			def accolade = new Accolade()
			
			accolade.account = account
			
			if(plannedWorkout.link == "abRipperX"){
				accolade.type = AccoladeType.COMPLETED_AB_RIPPER.description()
				accolade.description = AccoladeDescription.COMPLETED_AB_RIPPER.description()
				accolade.points = AccoladePoints.COMPLETED_AB_RIPPER.value()
			}else if(plannedWorkout.link == "cardioWorkout"){
				def cardioAccoladeData = getCardioAccoladeData(plannedWorkout)
				accolade.type = cardioAccoladeData.type
				accolade.description = cardioAccoladeData.description
				accolade.points = cardioAccoladeData.points
			}else if(plannedWorkout.link == "freeWeights"){
				def freeWeightsAccoladeData = getFreeWeightsAccoladeData(plannedWorkout)
				accolade.type = freeWeightsAccoladeData.type
				accolade.description = freeWeightsAccoladeData.description
				accolade.points = freeWeightsAccoladeData.points
			}else if(plannedWorkout.link == "xstretch"){
				accolade.type = AccoladeType.LOGGED_XSTRETCH.description()
				accolade.description = AccoladeDescription.LOGGED_XSTRETCH.description()
				accolade.points = AccoladePoints.LOGGED_XSTRETCH.value()
			}else if(plannedWorkout.link == "yogaX"){
				accolade.type = AccoladeType.LOGGED_YOGAX.description()
				accolade.description = AccoladeDescription.LOGGED_YOGAX.description()
				accolade.points = AccoladePoints.LOGGED_YOGAX.value()
			}else{
				accolade.type = AccoladeType.LOGGED_WORKOUT.description()
				accolade.description = AccoladeDescription.LOGGED_WORKOUT.description()
				accolade.points = AccoladePoints.LOGGED_WORKOUT.value()
			}
			
			accolade.plannedWorkout = plannedWorkout
			accolade.workoutPlan = plannedWorkout.workoutPlan
			accolade.save(flush:true)
			
			println "accolade saved : " + accolade
		    accolade.errors.allErrors.each {
		        println it
		    }
			
			checkSetCompetitionStatsAccolades(account, accolade)
			
			account.addToAccolades(accolade)
			account.save(flush:true)
			
			def workoutPlan = plannedWorkout.workoutPlan
			workoutPlan.addToAccolades(accolade)
			workoutPlan.save(flush:true)
		}
	}
	
	
	
	def processWeekAccolade(account, plannedWorkout, workoutPlan, week){
		
		def existingAccolade = Accolade.findAllByWeekAndType(week, AccoladeType.PERFECT_WEEK.description())
		if(!existingAccolade){
			
			//TODO: add multiplier logic when consecutive perfect weeks
			//def weekAccolades = Accolade.findAllByTypeAndWorkoutPlan(AccoladeType.PERFECT_WEEK.description(), workoutPlan)

			def perfect = true
			week.plannedWorkouts.each {
				if(!it.completed){
					perfect = false
				}
			}
			
			if(perfect){
				def accolade = new Accolade()
			
				accolade.account = account
				accolade.type = AccoladeType.PERFECT_WEEK.description()
				accolade.description = AccoladeDescription.PERFECT_WEEK.description()
				accolade.points = AccoladePoints.PERFECT_WEEK.value()
				accolade.workoutPlan = workoutPlan
				accolade.week = week
				accolade.save(flush:true)
			
				account.addToAccolades(accolade)
				account.save(flush:true)
				
				workoutPlan.addToAccolades(accolade)
				workoutPlan.save(flush:true)
			}
		}
	}



	def processWorkoutPlanCompleteAccolade(account, workoutPlan){
		def existingAccolade = Accolade.findByWorkoutPlanAndType(workoutPlan, AccoladeType.PROGRAM_COMPLETE.description())
		
		if(!existingAccolade){
			def accolade = new Accolade()
		
			accolade.account = account
			accolade.type = AccoladeType.PROGRAM_COMPLETE.description()
			accolade.description = AccoladeDescription.PROGRAM_COMPLETE.description()
			accolade.points = AccoladePoints.PROGRAM_COMPLETE.value()
			accolade.workoutPlan = workoutPlan
			accolade.save(flush:true)
		
			account.addToAccolades(accolade)
			account.save(flush:true)
			
			workoutPlan.addToAccolades(accolade)
			workoutPlan.save(flush:true)
			
			processPerfectWorkoutPlanAccolade(account, workoutPlan)
		}
		
	}



	def processPerfectWorkoutPlanAccolade(account, workoutPlan){
	
		def skippedWorkouts = PlannedWorkout.findByWorkoutPlanAndSkipped(workoutPlan, true)
		
		if(!skippedWorkouts){
			def accolade = new Accolade()
			
			accolade.account = account
			accolade.type = AccoladeType.PERFECT_PROGRAM.description()
			accolade.description = AccoladeDescription.PERFECT_PROGRAM.description()
			accolade.points = AccoladePoints.PERFECT_PROGRAM.value()
			accolade.workoutPlan = workoutPlan
			accolade.save(flush:true)
			
			account.addToAccolades(accolade)
			account.save(flush:true)
			
			workoutPlan.addToAccolades(accolade)
			workoutPlan.save(flush:true)
		}
					
	}
	
}
