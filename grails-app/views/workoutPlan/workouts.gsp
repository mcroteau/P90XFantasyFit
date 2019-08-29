<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="mobile">
	
	<title>P90X Fantasy Fit : Workout History</title>
	
    
</head>
<body>

	
	<g:if test="${workoutPlan}">
	
		<div class="row">
		
			<div class="col-md-12">
		
			
				<h2 style="margin-top:0px;">Workout History</h2>
        		
				<p><strong>Plan : </strong>${workoutPlan.title}</p>
	    		
				<p>
					<strong>Start : </strong><g:formatDate format="dd MMM yyyy" date="${workoutPlan.startDate}"/>
					&nbsp;&nbsp;
					<strong>End  : </strong><g:formatDate format="dd MMM yyyy" date="${workoutPlan.plannedCompleteDate}"/>
				</p>
						
				<g:if test="${plannedWorkoutList.size() > 0}">		
					<table class="table table-striped">
						<tr>
							<th>Date</th>
							<th>Workout</th>
							<th></th>		
						</tr>
						<g:each in="${plannedWorkoutList}" status="j" var="plannedWorkout">
							<tr>
								<td class="align-left"><g:formatDate format="dd MMM yyyy" date="${plannedWorkout.actualWorkoutDate}"/></td>
								<td class="align-left">${plannedWorkout.displayName}</td>
								<td class="align-center"><g:link controller="${plannedWorkout.link}" action="show" id="${plannedWorkout.id}">View Workout</g:link></td>
							</tr>
						</g:each>
					</table>
        		
				</g:if>
				<g:else>
					<div class="alert alert-info">No workouts logged for ${workoutPlan.title}</div>
				</g:else>
			
			</div>
			
		</div>
	    		
	</g:if>
	<g:else>
	
		<h2>No workouts logged yet</h2>

		<p>You currently don't have Workout Plan started</p>
		<g:link controller="workoutPlan" action="selectVersion" class="btn btn-primary">Start a new workout plan</g:link>
		
		
		<br class="clear"/>
		
	</g:else>
	
							
</body>
</html>
