
<%@ page import="org.motus.workouts.ChestBack" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'chestBack.label', default: 'ChestBack')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-chestBack" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-chestBack" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${raw(flash.message)}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="completed" title="${message(code: 'chestBack.completed.label', default: 'Completed')}" />
					
						<g:sortableColumn property="skipped" title="${message(code: 'chestBack.skipped.label', default: 'Skipped')}" />
					
						<g:sortableColumn property="plannedWorkoutDate" title="${message(code: 'chestBack.plannedWorkoutDate.label', default: 'Planned Workout Date')}" />
					
						<g:sortableColumn property="actualWorkoutDate" title="${message(code: 'chestBack.actualWorkoutDate.label', default: 'Actual Workout Date')}" />
					
						<th><g:message code="chestBack.workoutPlan.label" default="Workout Plan" /></th>
					
						<g:sortableColumn property="backFlysReps1" title="${message(code: 'chestBack.backFlysReps1.label', default: 'Back Flys Reps1')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${chestBackInstanceList}" status="i" var="chestBackInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${chestBackInstance.id}">${fieldValue(bean: chestBackInstance, field: "completed")}</g:link></td>
					
						<td><g:formatBoolean boolean="${chestBackInstance.skipped}" /></td>
					
						<td><g:formatDate date="${chestBackInstance.plannedWorkoutDate}" /></td>
					
						<td><g:formatDate date="${chestBackInstance.actualWorkoutDate}" /></td>
					
						<td>${fieldValue(bean: chestBackInstance, field: "workoutPlan")}</td>
					
						<td>${fieldValue(bean: chestBackInstance, field: "backFlysReps1")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${chestBackInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
