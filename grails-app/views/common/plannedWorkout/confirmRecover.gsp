<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="fullscreen">
	<title>P90X Fantasy Fit : Confirm Recover</title>

</head>
<body>

	<div class="row" style="text-align:center !important">
	
		<h1>Confirm Recover ${plannedWorkout.displayName} Workout</h1>
		<p>Are you sure you want to recover this workout? <br/>Recovering the workout will add it back to your schedule as incomplete and will be eligle for points</p>
		<g:form action="recover" method="post">
			<input type="hidden" name="id" value="${plannedWorkout.id}"/>
			<input type="submit" class="btn btn-primary" value="Recover Workout"/>
		</g:form>
    		
	</div>

</body>
</html>
