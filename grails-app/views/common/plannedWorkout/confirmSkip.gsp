<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="fullscreen">
	<title>P90X Fantasy Fit : Confirm Skip</title>

</head>
<body>
	
	<style type="text/css">
		#confirm-skip-container{
			width:450px;
			margin:auto;
			text-align:left;
			padding:30px;
			background:#f2f2f2;
			border:1px solid #e8e8e8;
			-webkit-border-radius: 3px;
			-moz-border-radius: 3px;
			border-radius: 3px;
		}
	</style>

	<div class="row" style="text-align:center">
		<div id="confirm-skip-container">
			<h1 style="margin-top:0px;">Confirm Skip ${plannedWorkout.displayName} Workout</h1>
			<p style="margin-bottom:30px">Are you sure you want to skip this workout today? <br/>You will not gain any points but skipping the work out but it will count as completed on the plan schedule</p>
			
			<div style="text-align:center">
				<g:form action="skip" method="post">
					<input type="hidden" name="id" value="${plannedWorkout.id}"/>
					<g:link controller="${plannedWorkout.link}" action="entry" id="${plannedWorkout.id}" class="btn btn-default">Forget it, I'll Workout</g:link>
					<input type="submit" class="btn btn-danger" value="Yes, Skip It"/>
				</g:form>
			</div>
    	</div>
	</div>

</body>
</html>
