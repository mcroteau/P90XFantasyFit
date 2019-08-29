<%@ page import="org.motus.WorkoutPlan" %>



<div class="fieldcontain ${hasErrors(bean: workoutPlanInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="workoutPlan.status.label" default="Status" />
		
	</label>
	<g:textField name="status" value="${workoutPlanInstance?.status}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: workoutPlanInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="workoutPlan.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${workoutPlanInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: workoutPlanInstance, field: 'account', 'error')} required">
	<label for="account">
		<g:message code="workoutPlan.account.label" default="Account" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="account" name="account.id" from="${org.motus.Account.list()}" optionKey="id" required="" value="${workoutPlanInstance?.account?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: workoutPlanInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="workoutPlan.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${workoutPlanInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: workoutPlanInstance, field: 'plannedWorkouts', 'error')} ">
	<label for="plannedWorkouts">
		<g:message code="workoutPlan.plannedWorkouts.label" default="Planned Workouts" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${workoutPlanInstance?.plannedWorkouts?}" var="p">
    <li><g:link controller="plannedWorkout" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="plannedWorkout" action="create" params="['workoutPlan.id': workoutPlanInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'plannedWorkout.label', default: 'PlannedWorkout')])}</g:link>
</li>
</ul>

</div>

