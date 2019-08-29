<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="mobile">
	<title>P90X Fantasy Fit : Confirm Stop</title>

</head>
<body>

	<div class="row" style="text-align:center">
	
		<g:if test="${currentPlan}">
	
			<div class="col-md-12">
			
				<h3><strong>Plan : </strong>${currentPlan.title}</h3>
				<h2 style="margin-top:0px;">Confirm Stop</h2>
				
				<h5>Date Started : <g:formatDate format="dd MMM yyyy" date="${currentPlan.startDate}"/></h5>
				<p>Are you sure you want to stop the current plan? <br/>Once stopped, you will be able to start a new plan</p>
				<g:form action="stop" method="post">
					<input type="submit" class="btn btn-danger btn-lg btn-block" value="Stop Plan"/>
				</g:form>
				
			</div>
			
			
		</g:if>
		<g:else>
	
			<div class="col-md-12">
				<h2>No workout plans started<h2>
				<g:link controller="workoutPlan" action="select">Start a workout Plan</g:link>
			</div>
		</g:else>
			
	</div>


</body>
</html>
