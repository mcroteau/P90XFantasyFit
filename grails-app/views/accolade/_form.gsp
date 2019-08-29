<%@ page import="org.motus.Accolade" %>



<div class="fieldcontain ${hasErrors(bean: accoladeInstance, field: 'type', 'error')} ">
	<label for="type">
		<g:message code="accolade.type.label" default="Type" />
		
	</label>
	<g:textField name="type" value="${accoladeInstance?.type}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: accoladeInstance, field: 'points', 'error')} required">
	<label for="points">
		<g:message code="accolade.points.label" default="Points" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="points" type="number" value="${accoladeInstance.points}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: accoladeInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="accolade.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${accoladeInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: accoladeInstance, field: 'account', 'error')} required">
	<label for="account">
		<g:message code="accolade.account.label" default="Account" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="account" name="account.id" from="${org.motus.Account.list()}" optionKey="id" required="" value="${accoladeInstance?.account?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: accoladeInstance, field: 'week', 'error')} ">
	<label for="week">
		<g:message code="accolade.week.label" default="Week" />
		
	</label>
	<g:select id="week" name="week.id" from="${org.motus.Week.list()}" optionKey="id" value="${accoladeInstance?.week?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: accoladeInstance, field: 'workoutPlan', 'error')} ">
	<label for="workoutPlan">
		<g:message code="accolade.workoutPlan.label" default="Workout Plan" />
		
	</label>
	<g:select id="workoutPlan" name="workoutPlan.id" from="${org.motus.WorkoutPlan.list()}" optionKey="id" value="${accoladeInstance?.workoutPlan?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: accoladeInstance, field: 'plannedWorkout', 'error')} ">
	<label for="plannedWorkout">
		<g:message code="accolade.plannedWorkout.label" default="Planned Workout" />
		
	</label>
	<g:select id="plannedWorkout" name="plannedWorkout.id" from="${org.motus.workouts.PlannedWorkout.list()}" optionKey="id" value="${accoladeInstance?.plannedWorkout?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: accoladeInstance, field: 'competition', 'error')} ">
	<label for="competition">
		<g:message code="accolade.competition.label" default="Competition" />
		
	</label>
	<g:select id="competition" name="competition.id" from="${org.motus.Competition.list()}" optionKey="id" value="${accoladeInstance?.competition?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

