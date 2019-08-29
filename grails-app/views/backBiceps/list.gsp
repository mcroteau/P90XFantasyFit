
<%@ page import="org.motus.workouts.BackBiceps" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'backBiceps.label', default: 'BackBiceps')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-backBiceps" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-backBiceps" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${raw(flash.message)}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="completed" title="${message(code: 'backBiceps.completed.label', default: 'Completed')}" />
					
						<g:sortableColumn property="skipped" title="${message(code: 'backBiceps.skipped.label', default: 'Skipped')}" />
					
						<g:sortableColumn property="notes" title="${message(code: 'backBiceps.notes.label', default: 'Notes')}" />
					
						<g:sortableColumn property="time" title="${message(code: 'backBiceps.time.label', default: 'Time')}" />
					
						<g:sortableColumn property="plannedWorkoutDate" title="${message(code: 'backBiceps.plannedWorkoutDate.label', default: 'Planned Workout Date')}" />
					
						<g:sortableColumn property="actualWorkoutDate" title="${message(code: 'backBiceps.actualWorkoutDate.label', default: 'Actual Workout Date')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${backBicepsInstanceList}" status="i" var="backBicepsInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${backBicepsInstance.id}">${fieldValue(bean: backBicepsInstance, field: "completed")}</g:link></td>
					
						<td><g:formatBoolean boolean="${backBicepsInstance.skipped}" /></td>
					
						<td>${fieldValue(bean: backBicepsInstance, field: "notes")}</td>
					
						<td>${fieldValue(bean: backBicepsInstance, field: "time")}</td>
					
						<td><g:formatDate date="${backBicepsInstance.plannedWorkoutDate}" /></td>
					
						<td><g:formatDate date="${backBicepsInstance.actualWorkoutDate}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${backBicepsInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
