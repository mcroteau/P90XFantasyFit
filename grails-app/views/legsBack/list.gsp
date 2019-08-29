
<%@ page import="org.motus.workouts.LegsBack" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'legsBack.label', default: 'LegsBack')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-legsBack" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-legsBack" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${raw(flash.message)}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="completed" title="${message(code: 'legsBack.completed.label', default: 'Completed')}" />
					
						<g:sortableColumn property="skipped" title="${message(code: 'legsBack.skipped.label', default: 'Skipped')}" />
					
						<g:sortableColumn property="plannedWorkoutDate" title="${message(code: 'legsBack.plannedWorkoutDate.label', default: 'Planned Workout Date')}" />
					
						<g:sortableColumn property="actualWorkoutDate" title="${message(code: 'legsBack.actualWorkoutDate.label', default: 'Actual Workout Date')}" />
					
						<th><g:message code="legsBack.workoutPlan.label" default="Workout Plan" /></th>
					
						<g:sortableColumn property="alternatingSideLungesReps" title="${message(code: 'legsBack.alternatingSideLungesReps.label', default: 'Alternating Side Lunges Reps')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${legsBackInstanceList}" status="i" var="legsBackInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${legsBackInstance.id}">${fieldValue(bean: legsBackInstance, field: "completed")}</g:link></td>
					
						<td><g:formatBoolean boolean="${legsBackInstance.skipped}" /></td>
					
						<td><g:formatDate date="${legsBackInstance.plannedWorkoutDate}" /></td>
					
						<td><g:formatDate date="${legsBackInstance.actualWorkoutDate}" /></td>
					
						<td>${fieldValue(bean: legsBackInstance, field: "workoutPlan")}</td>
					
						<td>${fieldValue(bean: legsBackInstance, field: "alternatingSideLungesReps")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${legsBackInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
