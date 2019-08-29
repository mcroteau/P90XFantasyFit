<html lang="en">
<head>
  	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
 	<meta name="layout" content="main" />
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
	
		<g:each in="${workoutPlans}" status="i" var="workoutPlan">
			<div class="col-md-3 col-sm-3">
				<div class="well">
	    			<h2>${workoutPlan.value.name}
						<g:if test="${workoutPlan.value.popular}">
							<span class="glyphicon glyphicon-star">Popular</span>
						</g:if>
					</h2>
					<p><strong># weeks : </strong> ${workoutPlan.value.weeksCount}</p>
					<p><strong># workouts : </strong> ${workoutPlan.value.workoutsCount}</p>
					<p><strong># active users : </strong> ${workoutPlan.value.plansCount}</p>
					<p>${workoutPlan.value.description}</p>
					<g:link action="setup" params="[workoutPlan: workoutPlan.value.name]" class="btn btn-primary" id="${workoutPlan.value.name}">Select</g:link>
				</div>
			</div>
		</g:each>
		
		
		<div class="col-md-3 col-sm-3">
			<div class="well">
    			<h2>Freestyle</h2>
				<p>12 week program allowing you to go at your own pace, select workouts and duration based on preference</p>
				<g:link action="setup" params="[type:'Freestyle']" class="btn btn-primary">Select</g:link>
			</div>
		</div>
		
  	</div>
  	
</body>
</html>
