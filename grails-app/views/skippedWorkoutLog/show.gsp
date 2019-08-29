
<%@ page import="org.motus.log.SkippedWorkoutLog" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'skippedWorkoutLog.label', default: 'SkippedWorkoutLog')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-skippedWorkoutLog" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-skippedWorkoutLog" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${raw(flash.message)}</div>
			</g:if>
			<ol class="property-list skippedWorkoutLog">
			
				<g:if test="${skippedWorkoutLogInstance?.account}">
				<li class="fieldcontain">
					<span id="account-label" class="property-label"><g:message code="skippedWorkoutLog.account.label" default="Account" /></span>
					
						<span class="property-value" aria-labelledby="account-label"><g:link controller="account" action="show" id="${skippedWorkoutLogInstance?.account?.id}">${skippedWorkoutLogInstance?.account?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${skippedWorkoutLogInstance?.date}">
				<li class="fieldcontain">
					<span id="date-label" class="property-label"><g:message code="skippedWorkoutLog.date.label" default="Date" /></span>
					
						<span class="property-value" aria-labelledby="date-label"><g:formatDate date="${skippedWorkoutLogInstance?.date}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${skippedWorkoutLogInstance?.plannedWorkout}">
				<li class="fieldcontain">
					<span id="plannedWorkout-label" class="property-label"><g:message code="skippedWorkoutLog.plannedWorkout.label" default="Planned Workout" /></span>
					
						<span class="property-value" aria-labelledby="plannedWorkout-label"><g:link controller="plannedWorkout" action="show" id="${skippedWorkoutLogInstance?.plannedWorkout?.id}">${skippedWorkoutLogInstance?.plannedWorkout?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${skippedWorkoutLogInstance?.id}" />
					<g:link class="edit" action="edit" id="${skippedWorkoutLogInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
