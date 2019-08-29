<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="fullscreen">
	<title>P90X Fantasy Fit : Confirm Leave</title>

</head>
<body>
	
	<style type="text/css">
		.confirmLeaveContainer{
			width:450px;
			margin:auto;
			padding:30px;
			background:#f2f2f2;
			border:1px solid #e8e8e8;
			-webkit-border-radius: 3px;
			-moz-border-radius: 3px;
			border-radius: 3px;
		}
	</style>

	<div class="row" style="text-align:center">
	
		<g:if test="${competition}">
	
			<div class="confirmLeaveContainer">
			
				<h2 style="margin-top:0px">Confirm Leave Competition</h2>
				
				<p>Are you sure you want to leave <strong>${competition.name}</strong> competition?</p>
				
				<p>This cannot be undone!</p>
				
				<p>Once you leave, you will be able to start or join a new competition</p>
				
				<br/>
				
				<g:form controller="competition" action="leave" method="post">
					<input type="hidden" name="id" value="${competition.id}"/>
					<g:link action="index" class="btn btn-default">Cancel</g:link>
					<input type="submit" class="btn btn-danger" value="Ya, Leave Competition"/>
				</g:form>
			</div>

		</g:if>
		<g:else>
	
			<div class="confirmStopContainer">
				<h2>No workout plans started<h2>
				<g:link controller="workoutPlan" action="select">Start a workout Plan</g:link>
			</div>
			
		</g:else>
			
	</div>


</body>
</html>
