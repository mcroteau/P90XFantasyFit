<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="mobile">
	<title>P90X Fantasy Fit : Confirm Recover</title>

</head>
<body>

	<div class="row" style="text-align:center !important">
		<div class="col-md-12">
		
			<h1>Confirm Recover  <br/>${plannedWorkout.displayName} Workout</h1>
			<p>Are you sure you want to recover this workout? <br/>Recovering the workout will add it back to your schedule as incomplete and will be eligle for points</p>
			<g:form action="recover" method="post">
				<input type="hidden" name="id" value="${plannedWorkout.id}"/>
				<g:link controller="account" action="dashboard" class="btn btn-default">Cancel</g:link>
				<input type="submit" class="btn btn-primary" value="Recover Workout"/>
			</g:form>
			
    	</div>	
	</div>

</body>
</html>
