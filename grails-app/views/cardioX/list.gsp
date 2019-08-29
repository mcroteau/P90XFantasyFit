
<%@ page import="org.motus.workouts.CardioX" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cardioX.label', default: 'CardioX')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-cardioX" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-cardioX" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${raw(flash.message)}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="completed" title="${message(code: 'cardioX.completed.label', default: 'Completed')}" />
					
						<g:sortableColumn property="skipped" title="${message(code: 'cardioX.skipped.label', default: 'Skipped')}" />
					
						<g:sortableColumn property="plannedWorkoutDate" title="${message(code: 'cardioX.plannedWorkoutDate.label', default: 'Planned Workout Date')}" />
					
						<g:sortableColumn property="actualWorkoutDate" title="${message(code: 'cardioX.actualWorkoutDate.label', default: 'Actual Workout Date')}" />
					
						<th><g:message code="cardioX.workoutPlan.label" default="Workout Plan" /></th>
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'cardioX.dateCreated.label', default: 'Date Created')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${cardioXInstanceList}" status="i" var="cardioXInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${cardioXInstance.id}">${fieldValue(bean: cardioXInstance, field: "completed")}</g:link></td>
					
						<td><g:formatBoolean boolean="${cardioXInstance.skipped}" /></td>
					
						<td><g:formatDate date="${cardioXInstance.plannedWorkoutDate}" /></td>
					
						<td><g:formatDate date="${cardioXInstance.actualWorkoutDate}" /></td>
					
						<td>${fieldValue(bean: cardioXInstance, field: "workoutPlan")}</td>
					
						<td><g:formatDate date="${cardioXInstance.dateCreated}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${cardioXInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
