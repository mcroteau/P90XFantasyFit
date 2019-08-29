
<%@ page import="org.motus.log.SkippedWorkoutLog" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'skippedWorkoutLog.label', default: 'SkippedWorkoutLog')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-skippedWorkoutLog" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-skippedWorkoutLog" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${raw(flash.message)}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="skippedWorkoutLog.account.label" default="Account" /></th>
					
						<g:sortableColumn property="date" title="${message(code: 'skippedWorkoutLog.date.label', default: 'Date')}" />
					
						<th><g:message code="skippedWorkoutLog.plannedWorkout.label" default="Planned Workout" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${skippedWorkoutLogInstanceList}" status="i" var="skippedWorkoutLogInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${skippedWorkoutLogInstance.id}">${fieldValue(bean: skippedWorkoutLogInstance, field: "account")}</g:link></td>
					
						<td><g:formatDate date="${skippedWorkoutLogInstance.date}" /></td>
					
						<td>${fieldValue(bean: skippedWorkoutLogInstance, field: "plannedWorkout")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${skippedWorkoutLogInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
