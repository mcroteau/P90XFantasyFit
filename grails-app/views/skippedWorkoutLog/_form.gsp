<%@ page import="org.motus.log.SkippedWorkoutLog" %>



<div class="fieldcontain ${hasErrors(bean: skippedWorkoutLogInstance, field: 'account', 'error')} required">
	<label for="account">
		<g:message code="skippedWorkoutLog.account.label" default="Account" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="account" name="account.id" from="${org.motus.Account.list()}" optionKey="id" required="" value="${skippedWorkoutLogInstance?.account?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: skippedWorkoutLogInstance, field: 'date', 'error')} required">
	<label for="date">
		<g:message code="skippedWorkoutLog.date.label" default="Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="date" precision="day"  value="${skippedWorkoutLogInstance?.date}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: skippedWorkoutLogInstance, field: 'plannedWorkout', 'error')} required">
	<label for="plannedWorkout">
		<g:message code="skippedWorkoutLog.plannedWorkout.label" default="Planned Workout" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="plannedWorkout" name="plannedWorkout.id" from="${org.motus.workouts.PlannedWorkout.list()}" optionKey="id" required="" value="${skippedWorkoutLogInstance?.plannedWorkout?.id}" class="many-to-one"/>
</div>

