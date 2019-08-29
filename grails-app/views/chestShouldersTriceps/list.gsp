
<%@ page import="org.motus.workouts.ChestShouldersTriceps" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'chestShouldersTriceps.label', default: 'ChestShouldersTriceps')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-chestShouldersTriceps" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-chestShouldersTriceps" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${raw(flash.message)}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="completed" title="${message(code: 'chestShouldersTriceps.completed.label', default: 'Completed')}" />
					
						<g:sortableColumn property="skipped" title="${message(code: 'chestShouldersTriceps.skipped.label', default: 'Skipped')}" />
					
						<g:sortableColumn property="plannedWorkoutDate" title="${message(code: 'chestShouldersTriceps.plannedWorkoutDate.label', default: 'Planned Workout Date')}" />
					
						<g:sortableColumn property="actualWorkoutDate" title="${message(code: 'chestShouldersTriceps.actualWorkoutDate.label', default: 'Actual Workout Date')}" />
					
						<th><g:message code="chestShouldersTriceps.workoutPlan.label" default="Workout Plan" /></th>
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'chestShouldersTriceps.dateCreated.label', default: 'Date Created')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${chestShouldersTricepsInstanceList}" status="i" var="chestShouldersTricepsInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${chestShouldersTricepsInstance.id}">${fieldValue(bean: chestShouldersTricepsInstance, field: "completed")}</g:link></td>
					
						<td><g:formatBoolean boolean="${chestShouldersTricepsInstance.skipped}" /></td>
					
						<td><g:formatDate date="${chestShouldersTricepsInstance.plannedWorkoutDate}" /></td>
					
						<td><g:formatDate date="${chestShouldersTricepsInstance.actualWorkoutDate}" /></td>
					
						<td>${fieldValue(bean: chestShouldersTricepsInstance, field: "workoutPlan")}</td>
					
						<td><g:formatDate date="${chestShouldersTricepsInstance.dateCreated}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${chestShouldersTricepsInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
