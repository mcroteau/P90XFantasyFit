
<%@ page import="org.motus.workouts.PlannedWorkout" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'plannedWorkout.label', default: 'PlannedWorkout')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-plannedWorkout" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-plannedWorkout" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${raw(flash.message)}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="completed" title="${message(code: 'plannedWorkout.completed.label', default: 'Completed')}" />
					
						<g:sortableColumn property="skipped" title="${message(code: 'plannedWorkout.skipped.label', default: 'Skipped')}" />
					
						<g:sortableColumn property="plannedWorkoutDate" title="${message(code: 'plannedWorkout.plannedWorkoutDate.label', default: 'Planned Workout Date')}" />
					
						<g:sortableColumn property="actualWorkoutDate" title="${message(code: 'plannedWorkout.actualWorkoutDate.label', default: 'Actual Workout Date')}" />
					
						<th><g:message code="plannedWorkout.workoutPlan.label" default="Workout Plan" /></th>
					
						<g:sortableColumn property="includeAbRipper" title="${message(code: 'plannedWorkout.includeAbRipper.label', default: 'Include Ab Ripper')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${plannedWorkoutInstanceList}" status="i" var="plannedWorkoutInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${plannedWorkoutInstance.id}">${fieldValue(bean: plannedWorkoutInstance, field: "completed")}</g:link></td>
					
						<td><g:formatBoolean boolean="${plannedWorkoutInstance.skipped}" /></td>
					
						<td><g:formatDate date="${plannedWorkoutInstance.plannedWorkoutDate}" /></td>
					
						<td><g:formatDate date="${plannedWorkoutInstance.actualWorkoutDate}" /></td>
					
						<td>${fieldValue(bean: plannedWorkoutInstance, field: "workoutPlan")}</td>
					
						<td><g:formatBoolean boolean="${plannedWorkoutInstance.includeAbRipper}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${plannedWorkoutInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
