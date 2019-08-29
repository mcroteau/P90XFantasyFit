package org.motus

import grails.converters.*

import grails.core.GrailsDomainClass
import groovy.text.SimpleTemplateEngine
import java.util.GregorianCalendar
import java.io.File
import java.io.FileInputStream
import org.apache.commons.io.IOUtils
	
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;


class WorkoutGeneratorService {

	static scope = "singleton"
	static transactional = false
    def grailsApplication
	
	def TAB = "\t"
	def DOUBLE_TAB = "\t\t"
	
	def baseFilePath = "/resources/workouts/"
	def baseOutputPath = "/resources/workouts/output/"
	
	def exerciseTemplatePath = "/templates/generator/_exercises.gtpl"
	def controllerTemplatePath = "/templates/generator/_controller.gtpl"
	def seleniumTemplatePath = "/templates/generator/_selenium_entry.gtpl"
	def domainTemplatePath = "/templates/generator/_domain.gtpl"
				
	def TYPE = "\n${DOUBLE_TAB}<span class=\"type\">TYPE</span>"
	def INPUT = "\n${DOUBLE_TAB}<input type=\"text\"  name=\"FIELD\" value=\"\${plannedWorkout?.FIELD}\"/>"
	def PREVIOUS = "\n${DOUBLE_TAB}<span class=\"previous\">\${previous?.FIELD}</span>"
	
	def abSection = "<p>Ab Ripper X Completed : <g:checkBox name=\"abRipperCompleted\" value=\"\${plannedWorkout?.abRipperCompleted}\"  /></p>"
	
	
	
	def SHOW_LINE_HEADER = "\n${TAB}<td>EXERCISE_NAME</td>\n"

	def SHOW_LINE = "\
${TAB}<td>\n\
${DOUBLE_TAB}<span class=\"type\">TYPE</span>\n\
${DOUBLE_TAB}\${plannedWorkout?.FIELD}\n\
${DOUBLE_TAB}<span class=\"previous\">\${previous?.FIELD}</span>\n\
${TAB}</td>\n"

	

	def createWorkout(name){
		def filePath = baseFilePath + "armsShoulders.json"
		def file = grailsApplication.mainContext.getResource(filePath).file
		InputStream jsonFileInput = new FileInputStream(file);
		def json = JSON.parse(jsonFileInput, "UTF-8")
		
		//createDomainClass(json)
		//createExerciseFiles(json)
		createExerciseMobileFile(json)
		//createControllerClass(json)
		//createSeleniumEntryTest(json)
	}
	

	
	
	def createDomainClass(json){

		def fields
		def multipleSets = json.sets.size() > 1
			
		json.sets.eachWithIndex() { set, i ->
			
			def inc = ""
			if(multipleSets)inc = i
	
			set.each{ exercise ->	
				def domainLine = "\n${TAB}${exercise.type} ${exercise.field}${inc}"	
				if(exercise.weight){
					domainLine += "\n${TAB}${exercise.type} ${exercise.field}Weight${inc}\n\n"
				}
				println "domain : ${domainLine}, inc : ${inc} "
				fields+=domainLine
			}
		}

		fields = fields.replace("null", "")

		def binding = [ "CLASS_NAME" : json.className,
						"DISPLAY_NAME" : json.displayName,
						"LINK" : json.className,
			 			"FIELDS" : fields,
						"CONSTRAINTS" : json.sequence ]
		
		def domainFile = grailsApplication.mainContext.getResource(domainTemplatePath).file
		def engine = new SimpleTemplateEngine()
		def template = engine.createTemplate(domainFile).make(binding)
		def bodyString = template.toString()
		
		println bodyString		
		writeToFile( "domain.txt", bodyString )
	
	}
	
	
	
	
	def createExerciseMobileFile(json){

		def exercisesFile = grailsApplication.mainContext.getResource(exerciseTemplatePath).file
		InputStream exerciseInput = new FileInputStream(exercisesFile);
	
		StringWriter writer = new StringWriter();
		IOUtils.copy(exerciseInput, writer, "UTF-8");
		String exerciseFileString = writer.toString();
		
		def exercises 
		
		def multipleSets = json.sets.size() > 1
		
		if(json.includeAbRipper){
			abSection = abSection.replace("plannedWorkout", json.instanceName)
			exerciseFileString = exerciseFileString.replace("AB_SECTION", abSection)
		}
		
		def header
		json.sets.eachWithIndex() { set, i ->
		
			def inc = ""
			if(multipleSets)inc = i
				
			set.each{ exercise ->
			
			}
			
		}
		
		/**
		<tr>
			<td>
				<table class="table workout-entry">	
					<tr>
						<td colspan="4" class="exercise">Standard Push Ups</td>
					</tr>
					<tr>
						<td colspan="2">Set 1</td>
						<td colspan="2">Set 2</td>
					</tr>
					<tr>
						<td>R<input type="text" name="standardPushUps1" class="form-control" value="${plannedWorkout?.standardPushUps1}" >
							<span class="previous">${previous?.standardPushUps1}</span>
						</td>
						<td></td>
						<td>R<input type="text" name="standardPushUps2" class="form-control" value="${plannedWorkout?.standardPushUps2}" >
							<span class="previous">${previous?.standardPushUps2}</span>
						</td>
						<td></td>
					</tr>
				</table>
			</td>
		</tr>
		**/
		
		
		
		
		
		
	}
	
	
	
	
	
	def createExerciseFiles(json){
	
		def exercisesFile = grailsApplication.mainContext.getResource(exerciseTemplatePath).file
		InputStream exerciseInput = new FileInputStream(exercisesFile);
		
		StringWriter writer = new StringWriter();
		IOUtils.copy(exerciseInput, writer, "UTF-8");
		String exerciseFileString = writer.toString();
		
		
		def exercises
		def exercises_show
		
		def multipleSets = json.sets.size() > 1
		
		if(json.includeAbRipper){
			abSection = abSection.replace("plannedWorkout", json.instanceName)
			exerciseFileString = exerciseFileString.replace("AB_SECTION", abSection)
		}	
		
		
		def header
		json.sets.eachWithIndex() { set, i ->
			
			if(i > 0)header+="<th></th>"	
			if(i==0)i=1		
			header+= "<th colspan=\"2\">Set ${i}</th>"
				
			def inc = ""
			if(multipleSets)inc = i
				
			set.each{ exercise ->
				
				def row = "\n<tr>"
				row += "\n${TAB}<td>${exercise.name}</td>\n"
				
				
				def showRow = "<tr>"
				showRow += SHOW_LINE_HEADER
				showRow = showRow.replace("EXERCISE_NAME", exercise.name)
				
				def weightLine = "\n${TAB}<td></td>"
				def weightShowLine = "\n${TAB}<td></td>"
				if(exercise.weight){

					def field = exercise.field + "Weight"
					field+=inc
					
					weightLine = "${TAB}<td>"
					weightLine+= TYPE.replace("TYPE", "W")
					weightLine+= INPUT.replace("FIELD", field)
					weightLine+= PREVIOUS.replace("FIELD", field)
					weightLine+= "\n${TAB}</td>"
					
					weightShowLine = SHOW_LINE
					weightShowLine = weightShowLine.replace("FIELD", field)
					weightShowLine = weightShowLine.replace("TYPE", "W")
					weightShowLine = weightShowLine.replace("EXERCISE_NAME", exercise.name)
				}
				
				
				
				def repsField = exercise.field + inc
				
				def repsShowLine = SHOW_LINE.replace("FIELD", repsField)
				repsShowLine = repsShowLine.replace("TYPE", "R")
				repsShowLine = repsShowLine.replace("EXERCISE_NAME", exercise.name)
				
				showRow+=repsShowLine
				showRow+=weightShowLine
				showRow+="\n</tr>\n"
				
				
				def repsLine = "\n${TAB}<td>"
				repsLine+= TYPE.replace("TYPE", "R")
				repsLine+= INPUT.replace("FIELD", repsField)
				repsLine+= PREVIOUS.replace("FIELD", repsField)
				repsLine+= "\n${TAB}</td>"
				
				
				row += "\n" + repsLine
				row += "\n" + weightLine
				row += "\n</tr>\n"
				exercises+= row
					
					
				exercises_show+= showRow
			}
		}
		
	
		exerciseFileString = exerciseFileString.replace("HEADER", header)
		exerciseFileString = exerciseFileString.replace("EXERCISES", exercises)
		exerciseFileString = exerciseFileString.replace("INSTANCE_NAME", "plannedWorkout")
		exerciseFileString = exerciseFileString.replace("null", "")
		
		println exerciseFileString
		writeToFile( "exercises.txt", exerciseFileString )
	
	
			
		exercises_show = exercises_show.replace("null", "")
		//println exercises_show

		writeToFile( "exercises_show.txt", exercises_show )
	}
	
	
	
	
	
	def createControllerClass(json){

		def controllerFile = grailsApplication.mainContext.getResource(controllerTemplatePath).file

		def binding = [ "CLASS_NAME" : json.className, "INSTANCE_NAME" : json.instanceName ]
		def engine = new SimpleTemplateEngine()
		def template = engine.createTemplate(controllerFile).make(binding)
		def bodyString = template.toString()
		
		println bodyString

		writeToFile( "controller.txt", bodyString )
	}
	
	
	
	def createSeleniumEntryTest(json){

		def entryData
		def assertValues		
		
		json.sets.each() { set ->
				
			set.eachWithIndex{ exercise, z ->
			
				entryData+="\n<tr>\
\n${TAB}<td>type</td>\
\n${TAB}<td>name=${exercise.field}</td>\
\n${TAB}<td>${z}</td>\
\n</tr>"

				assertValues+="\n<tr>\
\n${TAB}<td>assertValue</td>\
\n${TAB}<td>//input[@name=&quot;${exercise.field}&quot;]</td>\
\n${TAB}<td>${z}</td>\
\n</tr>"
			
			}
			
		}
		
		
		entryData+="\n<tr>\
\n${TAB}<td>click</td>\
\n${TAB}<td>id=abRipperCompleted</td>\
\n${TAB}<td></td>\
\n</tr>"

		entryData+="\n<tr>\
\n${TAB}<td>type</td>\
\n${TAB}<td>name=notes</td>\
\n${TAB}<td>completed ${json.displayName}</td>\
\n</tr>"
		
		assertValues+= "\n<tr>\
\n${TAB}<td>assertValue</td>\
\n${TAB}<td>//input[@name=&quot;abRipperCompleted&quot;]</td>\
\n${TAB}<td>on</td>\
\n</tr>"
		
		assertValues+= "\n<tr>\
\n${TAB}<td>assertValue</td>\
\n${TAB}<td>//textarea[@name=&quot;notes&quot;]</td>\
\n${TAB}<td>completed ${json.displayName}</td>\
\n</tr>"


		def seleniumFile = grailsApplication.mainContext.getResource(seleniumTemplatePath).file

		entryData = entryData.replace("null","")
		assertValues = assertValues.replace("null","")
		
		def binding = [ "DISPLAY_NAME" : json.displayName, "ENTRY_DATA" : entryData, "ASSERT_VALUES" : assertValues ]
		def engine = new SimpleTemplateEngine()
		def template = engine.createTemplate(seleniumFile).make(binding)
		def bodyString = template.toString()


		println bodyString 
		writeToFile( "selenium.txt", bodyString )
		
	}	
	
	
 
	public void writeToFile(def fileName, def content) {
		try {
 
			File file = new File(fileName);
 
			if (!file.exists()) {
				file.createNewFile();
			}
 
			FileWriter fw = new FileWriter(file.getAbsoluteFile());
			BufferedWriter bw = new BufferedWriter(fw);
			bw.write(content);
			bw.close();
 
			System.out.println("Done");
 
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
