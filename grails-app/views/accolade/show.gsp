
<%@ page import="org.motus.Accolade" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'accolade.label', default: 'Accolade')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-accolade" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-accolade" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${raw(flash.message)}</div>
			</g:if>
			<ol class="property-list accolade">
			
				<g:if test="${accoladeInstance?.type}">
				<li class="fieldcontain">
					<span id="type-label" class="property-label"><g:message code="accolade.type.label" default="Type" /></span>
					
						<span class="property-value" aria-labelledby="type-label"><g:fieldValue bean="${accoladeInstance}" field="type"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${accoladeInstance?.points}">
				<li class="fieldcontain">
					<span id="points-label" class="property-label"><g:message code="accolade.points.label" default="Points" /></span>
					
						<span class="property-value" aria-labelledby="points-label"><g:fieldValue bean="${accoladeInstance}" field="points"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${accoladeInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="accolade.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${accoladeInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${accoladeInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="accolade.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${accoladeInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${accoladeInstance?.account}">
				<li class="fieldcontain">
					<span id="account-label" class="property-label"><g:message code="accolade.account.label" default="Account" /></span>
					
						<span class="property-value" aria-labelledby="account-label"><g:link controller="account" action="show" id="${accoladeInstance?.account?.id}">${accoladeInstance?.account?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${accoladeInstance?.week}">
				<li class="fieldcontain">
					<span id="week-label" class="property-label"><g:message code="accolade.week.label" default="Week" /></span>
					
						<span class="property-value" aria-labelledby="week-label"><g:link controller="week" action="show" id="${accoladeInstance?.week?.id}">${accoladeInstance?.week?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${accoladeInstance?.workoutPlan}">
				<li class="fieldcontain">
					<span id="workoutPlan-label" class="property-label"><g:message code="accolade.workoutPlan.label" default="Workout Plan" /></span>
					
						<span class="property-value" aria-labelledby="workoutPlan-label"><g:link controller="workoutPlan" action="show" id="${accoladeInstance?.workoutPlan?.id}">${accoladeInstance?.workoutPlan?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${accoladeInstance?.plannedWorkout}">
				<li class="fieldcontain">
					<span id="plannedWorkout-label" class="property-label"><g:message code="accolade.plannedWorkout.label" default="Planned Workout" /></span>
					
						<span class="property-value" aria-labelledby="plannedWorkout-label"><g:link controller="plannedWorkout" action="show" id="${accoladeInstance?.plannedWorkout?.id}">${accoladeInstance?.plannedWorkout?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${accoladeInstance?.competition}">
				<li class="fieldcontain">
					<span id="competition-label" class="property-label"><g:message code="accolade.competition.label" default="Competition" /></span>
					
						<span class="property-value" aria-labelledby="competition-label"><g:link controller="competition" action="show" id="${accoladeInstance?.competition?.id}">${accoladeInstance?.competition?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${accoladeInstance?.id}" />
					<g:link class="edit" action="edit" id="${accoladeInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
