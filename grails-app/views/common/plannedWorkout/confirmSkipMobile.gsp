<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="mobile">
	<title>P90X Fantasy Fit : Confirm Skip</title>

</head>
<body>

	<div class="row" style="text-align:center">
		<div class="col-md-12">
		
			<h1>Confirm Skip ${plannedWorkout.displayName} Workout</h1>
			<p>Are you sure you want to skip this workout today? You will not gain any points but skipping the work out but it will count as completed on the plan schedule</p>
			<g:form action="skip" method="post">
				<input type="hidden" name="id" value="${plannedWorkout.id}"/>
				<g:link controller="${plannedWorkout.link}" action="entry" id="${plannedWorkout.id}" class="btn btn-default">Forget it, I'll Workout</g:link>
				<input type="submit" class="btn btn-danger" value="Yes, Skip It"/>
			</g:form>
			
		</div>
    		
	</div>

</body>
</html>
