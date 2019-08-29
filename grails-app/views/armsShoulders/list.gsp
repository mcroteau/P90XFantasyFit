
<%@ page import="org.motus.workouts.ArmsShoulders" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'armsShoulders.label', default: 'ArmsShoulders')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-armsShoulders" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-armsShoulders" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${raw(flash.message)}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="completed" title="${message(code: 'armsShoulders.completed.label', default: 'Completed')}" />
					
						<g:sortableColumn property="skipped" title="${message(code: 'armsShoulders.skipped.label', default: 'Skipped')}" />
					
						<g:sortableColumn property="plannedWorkoutDate" title="${message(code: 'armsShoulders.plannedWorkoutDate.label', default: 'Planned Workout Date')}" />
					
						<g:sortableColumn property="actualWorkoutDate" title="${message(code: 'armsShoulders.actualWorkoutDate.label', default: 'Actual Workout Date')}" />
					
						<th><g:message code="armsShoulders.workoutPlan.label" default="Workout Plan" /></th>
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'armsShoulders.dateCreated.label', default: 'Date Created')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${armsShouldersInstanceList}" status="i" var="armsShouldersInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${armsShouldersInstance.id}">${fieldValue(bean: armsShouldersInstance, field: "completed")}</g:link></td>
					
						<td><g:formatBoolean boolean="${armsShouldersInstance.skipped}" /></td>
					
						<td><g:formatDate date="${armsShouldersInstance.plannedWorkoutDate}" /></td>
					
						<td><g:formatDate date="${armsShouldersInstance.actualWorkoutDate}" /></td>
					
						<td>${fieldValue(bean: armsShouldersInstance, field: "workoutPlan")}</td>
					
						<td><g:formatDate date="${armsShouldersInstance.dateCreated}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${armsShouldersInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
