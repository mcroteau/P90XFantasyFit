<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="fullscreen">
	<title>P90X Fantasy Fit : Confirm Stop</title>

</head>
<body>
	
	<style type="text/css">
		.confirmStopContainer{
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
	
		<g:if test="${currentPlan}">
	
			<div class="confirmStopContainer">
			
				<h2 style="margin-top:0px">Confirm Stop</h2>
				<h3><strong>Plan : </strong>${currentPlan.title}</h3>
				<h5>Date Started : <g:formatDate format="dd MMM yyyy" date="${currentPlan.startDate}"/></h5>
				<p>Are you sure you want to stop the current plan? <br/>Once stopped, you will be able to start a new plan</p>
				<g:form action="stop" method="post">
					<input type="submit" class="btn btn-danger" value="Stop Plan"/>
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
