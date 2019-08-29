<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="fullscreen">
	<title>P90X Fantasy Fit : Adjust Schedule</title>

</head>
<body>

	<div class="row">
		<div class="col-md-12">
			
			<div class="alert alert-warning"><strong>Warning</strong> Off Schedule</div>
			
			<p>We noticed you the date entered when logging workout was different from the date originally planned.</p>
			
			<p><strong>${plannedWorkout.displayName}</strong> was scheduled for <strong><g:formatDate date="${plannedWorkout?.plannedWorkoutDate}" format="dd MMM yyyy"/></strong> and completed on <strong><g:formatDate date="${plannedWorkout?.actualWorkoutDate}" format="dd MMM yyyy"/></strong></p>
			
			<p>How would you like to proceed?</p>

		</div>
	</div>
	
	
	<div class="row">
		<div class="col-md-3 col-sm-3">
			<div class="well">
				<h2>Keep Schedule</h2>
				<p>Keep <strong>${plannedWorkout?.displayName}</strong> entry date of <strong><g:formatDate date="${plannedWorkout?.actualWorkoutDate}" format="dd MMM yyyy"/></strong> and maintain program schedule</p>
				<g:link controller="account" action="dashboard" class="btn btn-primary">Keep Schedule</g:link>
			</div>
		</div>
		
		
		<div class="col-md-3 col-sm-3">
			<div class="well">
				<h2>Change Entry Date</h2>
				<p>Update <strong>${plannedWorkout?.displayName}</strong> with new date and maintain program schedule</p>
				<g:link controller="${plannedWorkout?.link}" action="changeDate" class="btn btn-primary" params="[id : plannedWorkout?.id]">Chage Date</g:link>
			</div>
		</div>
		
		
		<div class="col-md-3 col-sm-3">
			<div class="well">
				<h2>Adjust schedule</h2>
				<p>Adjust schedule and push all workouts back or forward to accomodate the <strong>${plannedWorkout.displayName}</strong> workout.</p>
				<g:link action="confirmAdjustment" class="btn btn-primary" params="[ workoutPlanId : workoutPlan.id, plannedWorkoutId : plannedWorkout.id ]">Adjust Schedule</g:link>
			</div>
		</div>
		
		
	</div>
	

</body>
</html>
