<%@ page import="org.apache.shiro.SecurityUtils"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="mobile">
	<title>P90X Fantasy Fit : Schedule</title>
</head>
<body>

			
	<div class="row" style="text-align:center">
		
		<div class="col-md-12">
	
			<div style="text-align:center">
	
				<g:if test="${workoutPlan}">
					<h2 style="margin-top:0px;">Schedule</h2>
		        	
					<g:if test="${plannedWorkoutList.size() > 0}">		
						<table class="table table-striped">
							<tr>
								<th>Date</th>
								<th>Workout</th>
								<th>Status</th>
								<th></th>		
							</tr>
							<g:each in="${plannedWorkoutList}" status="j" var="plannedWorkout">
								<tr>
									<td class="align-left"><g:formatDate format="dd MMM yyyy" date="${plannedWorkout.plannedWorkoutDate}"/></td>
									<td class="align-left">${plannedWorkout.displayName}</td>
									<td class="align-left">
										<g:if test="${plannedWorkout.completed}">
											Completed
										</g:if>
										<g:elseif test="${plannedWorkout.skipped}">
											Skipped
										</g:elseif>
										<g:else>
											Incomplete
										</g:else>
									</td>
									<td class="align-center">
										<g:if test="${!plannedWorkout.completed}">
											<g:link controller="${plannedWorkout.link}" action="entry" id="${plannedWorkout.id}">Log Workout</g:link>
										</g:if>
									</td>
										
								</tr>
							</g:each>
						</table>
        			
					</g:if>
					<g:else>
						No workouts scheduled...
					</g:else>
					
				</g:if>

				<g:else>
					<g:if test="${SecurityUtils.getSubject().isPermitted('account:edit:' + account.id)}">
						<h2>Start something...</h2>
        		
						<p>You currently don't have Workout Program started</p>
						<g:link controller="workoutPlan" action="selectVersion" class="btn btn-primary">Start a new workout plan</g:link>
					</g:if>
					<g:else>
						<div class="alert alert-warning" style="margin-top:20px;">${account.name} is not currently in a plan</div>
						<br class="clear"/>
					</g:else>
					
				</g:else>

				
	
			</div>
			
		</div>
	
	</div>


</body>
</html>
