
<%@ page import="org.motus.workouts.PlannedWorkout" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'plannedWorkout.label', default: 'PlannedWorkout')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-plannedWorkout" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-plannedWorkout" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${raw(flash.message)}</div>
			</g:if>
			<ol class="property-list plannedWorkout">
			
				<g:if test="${plannedWorkoutInstance?.completed}">
				<li class="fieldcontain">
					<span id="completed-label" class="property-label"><g:message code="plannedWorkout.completed.label" default="Completed" /></span>
					
						<span class="property-value" aria-labelledby="completed-label"><g:formatBoolean boolean="${plannedWorkoutInstance?.completed}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${plannedWorkoutInstance?.skipped}">
				<li class="fieldcontain">
					<span id="skipped-label" class="property-label"><g:message code="plannedWorkout.skipped.label" default="Skipped" /></span>
					
						<span class="property-value" aria-labelledby="skipped-label"><g:formatBoolean boolean="${plannedWorkoutInstance?.skipped}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${plannedWorkoutInstance?.plannedWorkoutDate}">
				<li class="fieldcontain">
					<span id="plannedWorkoutDate-label" class="property-label"><g:message code="plannedWorkout.plannedWorkoutDate.label" default="Planned Workout Date" /></span>
					
						<span class="property-value" aria-labelledby="plannedWorkoutDate-label"><g:formatDate date="${plannedWorkoutInstance?.plannedWorkoutDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${plannedWorkoutInstance?.actualWorkoutDate}">
				<li class="fieldcontain">
					<span id="actualWorkoutDate-label" class="property-label"><g:message code="plannedWorkout.actualWorkoutDate.label" default="Actual Workout Date" /></span>
					
						<span class="property-value" aria-labelledby="actualWorkoutDate-label"><g:formatDate date="${plannedWorkoutInstance?.actualWorkoutDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${plannedWorkoutInstance?.workoutPlan}">
				<li class="fieldcontain">
					<span id="workoutPlan-label" class="property-label"><g:message code="plannedWorkout.workoutPlan.label" default="Workout Plan" /></span>
					
						<span class="property-value" aria-labelledby="workoutPlan-label"><g:link controller="workoutPlan" action="show" id="${plannedWorkoutInstance?.workoutPlan?.id}">${plannedWorkoutInstance?.workoutPlan?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${plannedWorkoutInstance?.includeAbRipper}">
				<li class="fieldcontain">
					<span id="includeAbRipper-label" class="property-label"><g:message code="plannedWorkout.includeAbRipper.label" default="Include Ab Ripper" /></span>
					
						<span class="property-value" aria-labelledby="includeAbRipper-label"><g:formatBoolean boolean="${plannedWorkoutInstance?.includeAbRipper}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${plannedWorkoutInstance?.abRipperCompleted}">
				<li class="fieldcontain">
					<span id="abRipperCompleted-label" class="property-label"><g:message code="plannedWorkout.abRipperCompleted.label" default="Ab Ripper Completed" /></span>
					
						<span class="property-value" aria-labelledby="abRipperCompleted-label"><g:formatBoolean boolean="${plannedWorkoutInstance?.abRipperCompleted}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${plannedWorkoutInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="plannedWorkout.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${plannedWorkoutInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${plannedWorkoutInstance?.lastUpdated}">
				<li class="fieldcontain">
					<span id="lastUpdated-label" class="property-label"><g:message code="plannedWorkout.lastUpdated.label" default="Last Updated" /></span>
					
						<span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate date="${plannedWorkoutInstance?.lastUpdated}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${plannedWorkoutInstance?.id}" />
					<g:link class="edit" action="edit" id="${plannedWorkoutInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
