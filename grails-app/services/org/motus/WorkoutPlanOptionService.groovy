package org.motus

import grails.converters.*

import grails.core.GrailsDomainClass
import java.util.GregorianCalendar
import java.io.File
import java.io.FileInputStream
import org.motus.common.WorkoutPlanStatus
import grails.util.Environment

class WorkoutPlanOptionService {
    
	def grailsApplication
	static scope = "singleton"
	static transactional = true
    
	def oneJson = null
	def oneFile = null
	
	def oneFilePath = "/resources/plans/one_plans.json"
	def oneTestFilePath = "/resources/plans/one_plans_test.json"
	def oneDevFilePath = "/resources/plans/one_plans_dev.json"
	
	def twoFilePath = "/resources/plans/two_plans.json"
	def threeFilePath = "/resources/plans/three_plans.json"
	
	InputStream oneInputStream
	
	
	def getVersionOneWorkoutPlan(name){
		checkSetJson()
		return oneJson[name]		
	}
	
	
	def getVersionOneWorkoutPlans(){
		checkSetJson()		
		return oneJson
	}
	
	
	def refresh(){
		oneJson = null
		checkSetJson()
	}
	

	def checkSetJson(){
		if(!oneJson){
			if (Environment.current == Environment.TEST) {
				oneFile = grailsApplication.mainContext.getResource(oneTestFilePath).file
			} else if (Environment.current == Environment.DEVELOPMENT){
				oneFile = grailsApplication.mainContext.getResource(oneDevFilePath).file
			}else {
				oneFile = grailsApplication.mainContext.getResource(oneFilePath).file
			}
			oneInputStream = new FileInputStream(oneFile);
			oneJson = JSON.parse(oneInputStream, "UTF-8")
			addMetaData(oneJson)
		}
	}
	
	
	def addMetaData(json){
		json.each { plan ->
			def weeksCount = plan.value.workoutPlan.size()
			def workoutsCount = 0
			plan.value.workoutPlan.each { weeks -> 
				weeks.each{
					workoutsCount++
				}
			}
			plan.value["weeksCount"] = weeksCount
			plan.value["workoutsCount"] = workoutsCount
			def plansCount = WorkoutPlan.countByNameAndCurrent(plan.value.name, true)
			plan.value["plansCount"] = plansCount
		}
		
	}
	
	
}
