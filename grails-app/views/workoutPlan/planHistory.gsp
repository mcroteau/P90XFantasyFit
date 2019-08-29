<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="profile">
	
	<title>P90X Fantasy Fit : History</title>
	
    
</head>
<body>

	
	<ul class="nav nav-tabs" role="tablist" style="margin-top:10px;">
		<li><g:link uri="/public/history/${account.username}">Workouts</g:link></li>
		<li class="active"><g:link controller="workoutPlan" action="planHistory">Plans</g:link></li>
		<li><g:link controller="competition" action="history" params="[accountId : account.id]">Competitions</g:link></li>
	</ul>
	
		
	<style type="text/css">
		.label-Completed {
			background-color: #428bca;
  		}
	</style>
	
		
	<g:if test="${workoutPlanList}">
		
		<h2>Workout Plans</h2>

		<g:each in="${workoutPlanList}" status="i" var="workoutPlan"> 		
		
			<div class="workout-plan-container">
				<style type="text/css">
					.label-Active{
						background-color:#357bfc;
					}
				</style>
				
				<div class="workout-plan-info">
					<div class="workout-plan-info-top">
						<h3>${workoutPlan.title}</h3>
						<h6>
							<span class="label label-${workoutPlan.status}">${workoutPlan.status}</span>
							<g:if test="${workoutPlan.current}">
								<span class="label label-success">Current</span>
							</g:if>
						</h6>
						<div class="plan-points">
							<span class="points-wrapper">+${workoutPlan.totalPoints}</span> Points
						</div>
						<br class="clear"/>
					</div>
					<div class="workout-plan-info-bottom">
						
						<span class="plan-info float-left">
							<strong>Start : </strong> 
							<g:formatDate format="dd MMM yyyy" date="${workoutPlan.startDate}"/>
						</span>
						<span class="plan-info float-left">
							<strong>End : </strong> 
							<g:formatDate format="dd MMM yyyy" date="${workoutPlan.plannedCompleteDate}"/>
						</span>
						
						<span class="plan-info float-right">
							<strong>Type : </strong> ${workoutPlan.name}
						</span>
						
						<span class="plan-info float-right">
							<strong>Version : </strong> ${workoutPlan.planVersion}
						</span>
							
					</div>
				</div>
				
				<g:link action="details" class="btn btn-default" id="${workoutPlan.id}">View Details</g:link>
				
				<br class="clear"/>
			</div>
		</g:each>
		
	</g:if>
	<g:else>
	
		<h2>No Workout Plans Started</h2>

		<p>You currently don't have any Workout Plans started</p>
		<g:link controller="workoutPlan" action="selectVersion" class="btn btn-primary">Start a new workout plan</g:link>
		
	</g:else>
	
							
</body>
</html>
