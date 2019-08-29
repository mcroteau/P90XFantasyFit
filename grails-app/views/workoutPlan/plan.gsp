<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="mobile">
	
	<title>P90X Fantasy Fit : Workout Plan</title>
	
    
</head>
<body>

	
	<g:if test="${workoutPlan}">
	
		<div class="row">
		
			<div class="col-md-12">
		
				<h2 style="text-align:left; margin-top:0px;">Plan Summary</h2>
				
				
				<table class="table table-condensed stats-table">
					<tr>
						<td class="stat-description">Name</td>
						<td class="stat-value">${workoutPlan.title}</td>
					</tr>
					<tr>
						<td class="stat-description">Version</td>
						<td class="stat-value">${workoutPlan.planVersion}</td>
					</tr>
					<tr>
						<td class="stat-description">Plan Type</td>
						<td class="stat-value">${workoutPlan.name}</td>
					</tr>
					<tr>
						<td class="stat-description">Points Earned</td>
						<td class="stat-value">${workoutPlan.totalPoints}</td>
					</tr>
					<tr>
						<td class="stat-description">Workouts Completed</td>
						<td class="stat-value">${data.completedWorkouts}</td>
					</tr>
					</tr>
					<tr>
						<td class="stat-description">Workouts Skipped</td>
						<td class="stat-value">${data.skippedWorkouts}</td>
					</tr>
					</tr>
					<tr>
						<td class="stat-description">Workouts Remaining</td>
						<td class="stat-value">${data.incompleteWorkouts}</td>
					</tr>
				</table>
				
				
				
				<g:link controller="workoutPlan" action="confirmStop" class="btn btn-danger btn-lg btn-block" style="margin:20px auto">Stop Plan</g:link>
				
				
			</div>
			
		</div>
	    		
	</g:if>
	<g:else>
	
		<h2>No Workout Plan</h2>

		<p>You currently don't have Workout Plan started</p>
		<g:link controller="workoutPlan" action="selectVersion" class="btn btn-primary">Start a new workout plan</g:link>
		
		
		<br class="clear"/>
		
	</g:else>
	
							
</body>
</html>
