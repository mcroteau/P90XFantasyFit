
<%@ page import="org.motus.workouts.YogaX" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'yogaX.label', default: 'YogaX')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-yogaX" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-yogaX" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${raw(flash.message)}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="completed" title="${message(code: 'yogaX.completed.label', default: 'Completed')}" />
					
						<g:sortableColumn property="skipped" title="${message(code: 'yogaX.skipped.label', default: 'Skipped')}" />
					
						<g:sortableColumn property="plannedWorkoutDate" title="${message(code: 'yogaX.plannedWorkoutDate.label', default: 'Planned Workout Date')}" />
					
						<g:sortableColumn property="actualWorkoutDate" title="${message(code: 'yogaX.actualWorkoutDate.label', default: 'Actual Workout Date')}" />
					
						<th><g:message code="yogaX.workoutPlan.label" default="Workout Plan" /></th>
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'yogaX.dateCreated.label', default: 'Date Created')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${yogaXInstanceList}" status="i" var="yogaXInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${yogaXInstance.id}">${fieldValue(bean: yogaXInstance, field: "completed")}</g:link></td>
					
						<td><g:formatBoolean boolean="${yogaXInstance.skipped}" /></td>
					
						<td><g:formatDate date="${yogaXInstance.plannedWorkoutDate}" /></td>
					
						<td><g:formatDate date="${yogaXInstance.actualWorkoutDate}" /></td>
					
						<td>${fieldValue(bean: yogaXInstance, field: "workoutPlan")}</td>
					
						<td><g:formatDate date="${yogaXInstance.dateCreated}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${yogaXInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
