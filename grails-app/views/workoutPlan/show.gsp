
<%@ page import="org.motus.WorkoutPlan" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'workoutPlan.label', default: 'WorkoutPlan')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-workoutPlan" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		
		<div id="show-workoutPlan" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			
		
			<g:if test="${workoutPlanInstance?.plannedWorkouts}">
				<h3>${workoutPlanInstance?.plannedWorkouts.size()}</h3>
			</g:if>
			
			
			<g:if test="${flash.message}">
				<div class="alert alert-info" role="status">${raw(flash.message)}</div>
			</g:if>
			
			
			<ol class="property-list workoutPlan">
			
				<g:if test="${workoutPlanInstance?.status}">
					<li class="fieldcontain">
						<span id="status-label" class="property-label"><g:message code="workoutPlan.status.label" default="Status" /></span>
							<span class="property-value" aria-labelledby="status-label"><g:fieldValue bean="${workoutPlanInstance}" field="status"/></span>
					</li>
				</g:if>
			
			
				<g:if test="${workoutPlanInstance?.description}">
					<li class="fieldcontain">
						<span id="description-label" class="property-label"><g:message code="workoutPlan.description.label" default="Description" /></span>
						
							<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${workoutPlanInstance}" field="description"/></span>
						
					</li>
				</g:if>
			
			
				<g:if test="${workoutPlanInstance?.account}">
					<li class="fieldcontain">
						<span id="account-label" class="property-label"><g:message code="workoutPlan.account.label" default="Account" /></span>
						
							<span class="property-value" aria-labelledby="account-label"><g:link controller="account" action="show" id="${workoutPlanInstance?.account?.id}">${workoutPlanInstance?.account?.encodeAsHTML()}</g:link></span>
						
					</li>
				</g:if>
			
			
				<g:if test="${workoutPlanInstance?.dateCreated}">
					<li class="fieldcontain">
						<span id="dateCreated-label" class="property-label"><g:message code="workoutPlan.dateCreated.label" default="Date Created" /></span>
						
							<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${workoutPlanInstance?.dateCreated}" /></span>
						
					</li>
				</g:if>
			
			
				<g:if test="${workoutPlanInstance?.lastUpdated}">
					<li class="fieldcontain">
						<span id="lastUpdated-label" class="property-label"><g:message code="workoutPlan.lastUpdated.label" default="Last Updated" /></span>
						
							<span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate date="${workoutPlanInstance?.lastUpdated}" /></span>
						
					</li>
				</g:if>
			
			
			
				<g:if test="${workoutPlanInstance?.name}">
					<li class="fieldcontain">
						<span id="name-label" class="property-label"><g:message code="workoutPlan.name.label" default="Name" /></span>
						
							<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${workoutPlanInstance}" field="name"/></span>
						
					</li>
				</g:if>
				
				
			
				<g:if test="${workoutPlanInstance?.plannedWorkouts}">
					<li class="fieldcontain">
						<span id="plannedWorkouts-label" class="property-label"><g:message code="workoutPlan.plannedWorkouts.label" default="Planned Workouts" /></span>
						
							<g:each in="${workoutPlanInstance.plannedWorkouts}" var="p">
								<code><g:link controller="${p?.link}" action="show" id="${p.id}">${p?.displayName}</g:link></code>
							</g:each>
						
					</li>
				</g:if>
			
			</ol>
			
			
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${workoutPlanInstance?.id}" />
					<g:link class="edit" action="edit" id="${workoutPlanInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
