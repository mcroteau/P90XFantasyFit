
<%@ page import="org.motus.workouts.Xstretch" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'Xstretch.label', default: 'Xstretch')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-Xstretch" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-Xstretch" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${raw(flash.message)}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="completed" title="${message(code: 'Xstretch.completed.label', default: 'Completed')}" />
					
						<g:sortableColumn property="skipped" title="${message(code: 'Xstretch.skipped.label', default: 'Skipped')}" />
					
						<g:sortableColumn property="plannedWorkoutDate" title="${message(code: 'Xstretch.plannedWorkoutDate.label', default: 'Planned Workout Date')}" />
					
						<g:sortableColumn property="actualWorkoutDate" title="${message(code: 'Xstretch.actualWorkoutDate.label', default: 'Actual Workout Date')}" />
					
						<th><g:message code="Xstretch.workoutPlan.label" default="Workout Plan" /></th>
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'Xstretch.dateCreated.label', default: 'Date Created')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${xstretchInstanceList}" status="i" var="xstretchInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${xstretchInstance.id}">${fieldValue(bean: xstretchInstance, field: "completed")}</g:link></td>
					
						<td><g:formatBoolean boolean="${xstretchInstance.skipped}" /></td>
					
						<td><g:formatDate date="${xstretchInstance.plannedWorkoutDate}" /></td>
					
						<td><g:formatDate date="${xstretchInstance.actualWorkoutDate}" /></td>
					
						<td>${fieldValue(bean: xstretchInstance, field: "workoutPlan")}</td>
					
						<td><g:formatDate date="${xstretchInstance.dateCreated}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${xstretchInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
