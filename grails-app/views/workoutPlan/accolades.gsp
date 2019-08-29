<%@ page import="org.apache.shiro.SecurityUtils"%>
<%@ page import="org.motus.common.AccoladeType"%>
<!DOCTYPE html>
<html>
<head>
	
	<meta name="layout" content="profile">
	<title>P90X Fantasy Fit : Workout Accolades</title>
	
</head>
<body>

	<g:if test="${flash.message}">
		<div class="alert alert-info">${raw(flash.message)}</div>
	</g:if>
	<g:if test="${flash.error}">
		<div class="alert alert-warning">${flash.error}</div>
	</g:if>

	
	
	<g:if test="${accolades}">
	
		<h2 style="float:left;">${workoutPlan.title} Accolades</h2>
		
		<div class="dropdown" style="float:right; margin-top:20px">
			<button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown">
			  	Select Workout Plan
				<span class="caret"></span>
			</button>
			<ul class="dropdown-menu dropdown-menu-right" role="menu" aria-labelledby="dropdownMenu1">
				<g:each in="${workoutPlanList}" status="i" var="workoutPlan"> 
					<li role="presentation">
						<g:link controller="workoutPlan" action="accolades" id="${workoutPlan.id}">${workoutPlan.title}</g:link>
					</li>
				</g:each>
			</ul>
		</div>
		<br class="clear"/>
		
		
		<ul id="recent-activity">
			<g:each in="${accolades}" status="i" var="accolade">
				<li>
					<span class="points-wrapper">+${accolade.points}</span>
					<g:formatDate format="dd MMM yyyy hh:MM a" date="${accolade.dateCreated}"/> : 
					<g:if test="${accolade.type == AccoladeType.LOGGED_WORKOUT.description()}">
					 	<g:link controller="${accolade.plannedWorkout.link}" action="show" id="${accolade.plannedWorkout?.id}">${accolade.plannedWorkout?.displayName}</g:link> Completed
					</g:if>
					<g:elseif test="${accolade.type == AccoladeType.COMPLETED_AB_RIPPER.description()}">
					 	<g:link controller="${accolade.plannedWorkout.link}" action="show" id="${accolade.plannedWorkout?.id}">${accolade.description}</g:link>
					</g:elseif>
					<g:elseif test="${accolade.plannedWorkout}">
						<g:link controller="${accolade.plannedWorkout.link}" action="show" id="${accolade.plannedWorkout?.id}">${accolade.description}</g:link>
					</g:elseif>
					<g:else>
					 	${accolade.description}
					</g:else>
				</li>
			</g:each>
		</ul>
	</g:if>
	<g:else>
		<h2>No Accolades earned yet</h2>
		<g:if test="${SecurityUtils.getSubject().isPermitted('account:edit:' + account?.id)}">
			<p>You currently don't have Workout Plan started</p>
			<g:link controller="workoutPlan" action="selectVersion" class="btn btn-primary">Start a new workout plan</g:link>
		</g:if>
		<g:else>
			<p>${account.username} is not currently in a workout plan</p>
		</g:else>
		
	</g:else>
	
</body>
</html>