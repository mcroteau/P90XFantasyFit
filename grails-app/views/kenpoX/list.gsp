
<%@ page import="org.motus.workouts.KenpoX" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'kenpoX.label', default: 'KenpoX')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-kenpoX" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-kenpoX" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${raw(flash.message)}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="completed" title="${message(code: 'kenpoX.completed.label', default: 'Completed')}" />
					
						<g:sortableColumn property="skipped" title="${message(code: 'kenpoX.skipped.label', default: 'Skipped')}" />
					
						<g:sortableColumn property="plannedWorkoutDate" title="${message(code: 'kenpoX.plannedWorkoutDate.label', default: 'Planned Workout Date')}" />
					
						<g:sortableColumn property="actualWorkoutDate" title="${message(code: 'kenpoX.actualWorkoutDate.label', default: 'Actual Workout Date')}" />
					
						<th><g:message code="kenpoX.workoutPlan.label" default="Workout Plan" /></th>
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'kenpoX.dateCreated.label', default: 'Date Created')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${kenpoXInstanceList}" status="i" var="kenpoXInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${kenpoXInstance.id}">${fieldValue(bean: kenpoXInstance, field: "completed")}</g:link></td>
					
						<td><g:formatBoolean boolean="${kenpoXInstance.skipped}" /></td>
					
						<td><g:formatDate date="${kenpoXInstance.plannedWorkoutDate}" /></td>
					
						<td><g:formatDate date="${kenpoXInstance.actualWorkoutDate}" /></td>
					
						<td>${fieldValue(bean: kenpoXInstance, field: "workoutPlan")}</td>
					
						<td><g:formatDate date="${kenpoXInstance.dateCreated}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${kenpoXInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
