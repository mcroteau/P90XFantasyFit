
<%@ page import="org.motus.workouts.CoreSynergistics" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'coreSynergistics.label', default: 'CoreSynergistics')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-coreSynergistics" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-coreSynergistics" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${raw(flash.message)}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="completed" title="${message(code: 'coreSynergistics.completed.label', default: 'Completed')}" />
					
						<g:sortableColumn property="skipped" title="${message(code: 'coreSynergistics.skipped.label', default: 'Skipped')}" />
					
						<g:sortableColumn property="plannedWorkoutDate" title="${message(code: 'coreSynergistics.plannedWorkoutDate.label', default: 'Planned Workout Date')}" />
					
						<g:sortableColumn property="actualWorkoutDate" title="${message(code: 'coreSynergistics.actualWorkoutDate.label', default: 'Actual Workout Date')}" />
					
						<th><g:message code="coreSynergistics.workoutPlan.label" default="Workout Plan" /></th>
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'coreSynergistics.dateCreated.label', default: 'Date Created')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${coreSynergisticsInstanceList}" status="i" var="coreSynergisticsInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${coreSynergisticsInstance.id}">${fieldValue(bean: coreSynergisticsInstance, field: "completed")}</g:link></td>
					
						<td><g:formatBoolean boolean="${coreSynergisticsInstance.skipped}" /></td>
					
						<td><g:formatDate date="${coreSynergisticsInstance.plannedWorkoutDate}" /></td>
					
						<td><g:formatDate date="${coreSynergisticsInstance.actualWorkoutDate}" /></td>
					
						<td>${fieldValue(bean: coreSynergisticsInstance, field: "workoutPlan")}</td>
					
						<td><g:formatDate date="${coreSynergisticsInstance.dateCreated}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${coreSynergisticsInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
