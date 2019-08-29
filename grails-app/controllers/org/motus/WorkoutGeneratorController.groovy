package org.motus

class WorkoutGeneratorController {

	def workoutGeneratorService
	
    def index() { }
	
	def generate(){
		println "generate ${params.name}"
		workoutGeneratorService.createWorkout("file name")
	}
	
}
