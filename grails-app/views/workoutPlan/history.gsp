<%@ page import="org.apache.shiro.SecurityUtils"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="profile">
	<title>P90X Fantasy Fit : Workout History</title>
</head>
<body>
	
	<g:if test="${workoutPlan}">
	
		<ul class="nav nav-tabs" role="tablist" style="margin-top:10px;">
			<li class="active"><g:link uri="/public/history/${account.username}">Workouts</g:link></li>
			<li><g:link controller="workoutPlan" action="planHistory" params="[accountId : account.id]">Plans</g:link></li>
			<li><g:link controller="competition" action="history" params="[accountId : account.id]">Competitions</g:link></li>
		</ul>
	
		<h2 class="float-left">${workoutPlan.title} Workouts</h2>
		<h6 style="float:left; margin:25px 0px 0px 15px;">
			<span class="label label-danger label-${workoutPlan.status}">${workoutPlan.status}</span>
		</h6>
		
		
		
		<div class="dropdown" style="float:right; margin-top:20px">
			<button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown">
			  	Select Workout Plan
				<span class="caret"></span>
			</button>
			<ul class="dropdown-menu dropdown-menu-right" role="menu" aria-labelledby="dropdownMenu1">
				<g:each in="${workoutPlanList}" status="i" var="workoutPlan"> 
					<li role="presentation">
						<g:link controller="workoutPlan" action="history" id="${workoutPlan.id}">${workoutPlan.title}</g:link>
					</li>
				</g:each>
			</ul>
		</div>
		
		
		<br class="clear"/>
		 
		<p>
			<strong>Start : </strong><g:formatDate format="dd MMM yyyy" date="${workoutPlan.startDate}"/>
			&nbsp;&nbsp;
			<strong>End  : </strong><g:formatDate format="dd MMM yyyy" date="${workoutPlan.plannedCompleteDate}"/>
		</p>
				
		<g:if test="${plannedWorkoutList.size() > 0}">		
			<table class="table table-striped">
				<tr>
					<th>Id</th>
					<th>Date</th>
					<th>Workout</th>
					<th></th>		
				</tr>
				<g:each in="${plannedWorkoutList}" status="j" var="plannedWorkout">
					<tr>
						<td>${plannedWorkout.id}</td>
						<td class="align-left"><g:formatDate format="dd MMM yyyy" date="${plannedWorkout.actualWorkoutDate}"/></td>
						<td class="align-left">
							<g:link controller="${plannedWorkout.link}" action="show" id="${plannedWorkout?.id}">		
								<g:if test="${plannedWorkout.link == "cardioWorkout"}">
									${plannedWorkout.minutes} Min 
									${plannedWorkout.type}
								</g:if>
								<g:elseif test="${plannedWorkout.link == "freeWeights"}">
									${plannedWorkout.minutes} Min Free Weights
								</g:elseif>
								<g:else>
									${plannedWorkout.displayName}
								</g:else>
							</g:link>
						</td>
						<td class="align-center"><g:link controller="${plannedWorkout.link}" action="show" id="${plannedWorkout.id}">View Workout</g:link></td>
					</tr>
				</g:each>
			</table>

			<div class="pagination">
				<g:paginate total="${plannedWorkoutTotal}" params="[username : account.username]"/>
			</div>
			
		</g:if>
		<g:else>
			<div class="alert alert-info">No workouts logged for ${workoutPlan.title}</div>
		</g:else>
	
	</g:if>
	
	
	<g:elseif test="${workoutPlanList}">
	
		<ul class="nav nav-tabs" role="tablist">
			<li class="active"><g:link uri="/public/history/${account.username}">Workouts</g:link></li>
			<li><g:link action="history" id="${account.id}">Plans</g:link></li>
		</ul>
	
		<h2 class="float-left">No Current Workout Plan</h2>

		
		<div class="dropdown" style="float:right; margin-top:20px">
			<button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown">
			  	Select Workout Plan
				<span class="caret"></span>
			</button>
			<ul class="dropdown-menu dropdown-menu-right" role="menu" aria-labelledby="dropdownMenu1">
				<g:each in="${workoutPlanList}" status="i" var="workoutPlan"> 
					<li role="presentation">
						<g:link controller="workoutPlan" action="history" id="${workoutPlan.id}">${workoutPlan.title}</g:link>
					</li>
				</g:each>
			</ul>
		</div>
		
		<br class="clear"/>
		
		
		<p>Select a workout plan on the right to view workout history</p>
		
			
		<g:if test="${SecurityUtils.getSubject().isPermitted('account:edit:' + account?.id)}">
			<p>You currently don't have Workout Plan started</p>
			<g:link controller="workoutPlan" action="selectVersion" class="btn btn-primary">Start a new workout plan</g:link>
		</g:if>
		<g:else>
			<p>${account.username} is not currently in a workout plan</p>
		</g:else>
		
			
	</g:elseif>
	
	
	
	<g:else>
	
		<div id="start-something">
			<h2>No workouts logged yet</h2>
        	
        	
			<g:if test="${SecurityUtils.getSubject().isPermitted('account:edit:' + account?.id)}">
				<p>You currently don't have Workout Plan started</p>
				<g:link controller="workoutPlan" action="selectVersion" class="btn btn-primary">Start a new workout plan</g:link>
			</g:if>
			<g:else>
				<p>${account.username} is not currently in a workout plan</p>
			</g:else>
			
			
			<g:if test="${workoutPlanList}">
				<div class="dropdown pull-right">
					<button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown">
					  	Select Workout Plan
						<span class="caret"></span>
					</button>
					<ul class="dropdown-menu dropdown-menu-right" role="menu" aria-labelledby="dropdownMenu1">
						<g:each in="${workoutPlanList}" status="i" var="workoutPlanInstance"> 
							<li role="presentation">
								<a role="menuitem" tabindex="-1" href="#">${workoutPlanInstance.title}</a>
							</li>
						</g:each>
					</ul>
				</div>
			</g:if>
			
			<br class="clear"/>
			
		</div>
	
	</g:else>
	
							
</body>
</html>
