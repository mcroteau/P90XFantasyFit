<%@ page import="org.motus.workouts.PlannedWorkout" %>



<div class="fieldcontain ${hasErrors(bean: plannedWorkoutInstance, field: 'completed', 'error')} ">
	<label for="completed">
		<g:message code="plannedWorkout.completed.label" default="Completed" />
		
	</label>
	<g:checkBox name="completed" value="${plannedWorkoutInstance?.completed}" />
</div>

<div class="fieldcontain ${hasErrors(bean: plannedWorkoutInstance, field: 'skipped', 'error')} ">
	<label for="skipped">
		<g:message code="plannedWorkout.skipped.label" default="Skipped" />
		
	</label>
	<g:checkBox name="skipped" value="${plannedWorkoutInstance?.skipped}" />
</div>

<div class="fieldcontain ${hasErrors(bean: plannedWorkoutInstance, field: 'plannedWorkoutDate', 'error')} ">
	<label for="plannedWorkoutDate">
		<g:message code="plannedWorkout.plannedWorkoutDate.label" default="Planned Workout Date" />
		
	</label>
	<g:datePicker name="plannedWorkoutDate" precision="day"  value="${plannedWorkoutInstance?.plannedWorkoutDate}" default="none" noSelection="['': '']" />
</div>

<div class="fieldcontain ${hasErrors(bean: plannedWorkoutInstance, field: 'actualWorkoutDate', 'error')} ">
	<label for="actualWorkoutDate">
		<g:message code="plannedWorkout.actualWorkoutDate.label" default="Actual Workout Date" />
		
	</label>
	<g:datePicker name="actualWorkoutDate" precision="day"  value="${plannedWorkoutInstance?.actualWorkoutDate}" default="none" noSelection="['': '']" />
</div>

<div class="fieldcontain ${hasErrors(bean: plannedWorkoutInstance, field: 'workoutPlan', 'error')} required">
	<label for="workoutPlan">
		<g:message code="plannedWorkout.workoutPlan.label" default="Workout Plan" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="workoutPlan" name="workoutPlan.id" from="${org.motus.WorkoutPlan.list()}" optionKey="id" required="" value="${plannedWorkoutInstance?.workoutPlan?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: plannedWorkoutInstance, field: 'includeAbRipper', 'error')} ">
	<label for="includeAbRipper">
		<g:message code="plannedWorkout.includeAbRipper.label" default="Include Ab Ripper" />
		
	</label>
	<g:checkBox name="includeAbRipper" value="${plannedWorkoutInstance?.includeAbRipper}" />
</div>

<div class="fieldcontain ${hasErrors(bean: plannedWorkoutInstance, field: 'abRipperCompleted', 'error')} ">
	<label for="abRipperCompleted">
		<g:message code="plannedWorkout.abRipperCompleted.label" default="Ab Ripper Completed" />
		
	</label>
	<g:checkBox name="abRipperCompleted" value="${plannedWorkoutInstance?.abRipperCompleted}" />
</div>

