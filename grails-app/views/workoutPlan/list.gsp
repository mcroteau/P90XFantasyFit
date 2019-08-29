
<%@ page import="org.motus.WorkoutPlan" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'workoutPlan.label', default: 'WorkoutPlan')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-workoutPlan" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-workoutPlan" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${raw(flash.message)}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="status" title="${message(code: 'workoutPlan.status.label', default: 'Status')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'workoutPlan.description.label', default: 'Description')}" />
					
						<th><g:message code="workoutPlan.account.label" default="Account" /></th>
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'workoutPlan.dateCreated.label', default: 'Date Created')}" />
					
						<g:sortableColumn property="lastUpdated" title="${message(code: 'workoutPlan.lastUpdated.label', default: 'Last Updated')}" />
					
						<g:sortableColumn property="name" title="${message(code: 'workoutPlan.name.label', default: 'Name')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${workoutPlanInstanceList}" status="i" var="workoutPlanInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${workoutPlanInstance.id}">${fieldValue(bean: workoutPlanInstance, field: "status")}</g:link></td>
					
						<td>${fieldValue(bean: workoutPlanInstance, field: "description")}</td>
					
						<td>${fieldValue(bean: workoutPlanInstance, field: "account")}</td>
					
						<td><g:formatDate date="${workoutPlanInstance.dateCreated}" /></td>
					
						<td><g:formatDate date="${workoutPlanInstance.lastUpdated}" /></td>
					
						<td>${fieldValue(bean: workoutPlanInstance, field: "name")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${workoutPlanInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
