<html lang="en">
<head>
  	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
 	<meta name="layout" content="mobile" />
	<title>P90X Fantasy Fit : Select Workout Plan</title>
</head>
<body>
  
  	<div class="row">
		<div class="col-md-12">
			<g:if test="${flash.message}">
				<div class="alert alert-info">${raw(flash.message)}</div>
			</g:if>	
		</div>
	</div>
	
	
	<div class="row">
	
		<div class="col-md-12">
			
			<h2 style="margin-top:0px;">Select Program Type</h2>
			
			<g:each in="${workoutPlans}" status="i" var="workoutPlan">
				<div class="well">
	    			<h2 style="margin-top:0px;">${workoutPlan.value.name}
						<g:if test="${workoutPlan.value.popular}">
							<span class="glyphicon glyphicon-star">Popular</span>
						</g:if>
					</h2>
					<p><strong># weeks : </strong> ${workoutPlan.value.weeksCount}<br/>
						<strong># workouts : </strong> ${workoutPlan.value.workoutsCount}<br/>
						<strong># active users : </strong> ${workoutPlan.value.plansCount}</p>
					<p>${workoutPlan.value.description}</p>
					<g:link action="setup" params="[workoutPlan: workoutPlan.value.name, planVersion : planVersion]" class="btn btn-primary" id="${workoutPlan.value.name}">Select</g:link>
				</div>
			</g:each>
			
		</div>
		
  	</div>
  	
</body>
</html>
