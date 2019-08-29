<html lang="en">
<head>
  	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
 	<meta name="layout" content="fullscreen" />
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

	<style type="text/css">
		.plan-option{
			width:230px;
			float:left;
			margin:10px 20px;
		}
		.plan-option .well{
		
		}
		.plan-option h2{
			margin-top:0px;
		}

		h2 .label{
			margin-top:8px;
			display:block;
			font-size:11px;
		}
	</style>
	
	
	<div style="text-align:center">
	
		<div style="width:850px; margin:auto;">
			
			<h2 style="margin-top:0px">Select a ${planName} Plan</h2>
			
			<g:if test="${flash.message}">
				<div class="alert alert-info">${raw(flash.message)}</div>
			</g:if>
			
			<g:each in="${workoutPlans}" status="i" var="workoutPlan">
				<div class="plan-option">
					<div class="well">
	    				<h2>${workoutPlan.value.name}
							<g:if test="${workoutPlan.value.popular}">
								<span class="label label-default">Popular</span>
							</g:if>
						</h2>
						<p>${workoutPlan.value.description}</p>
						
						<!--
						<p><strong># weeks : </strong> ${workoutPlan.value.weeksCount}</p>
						<p><strong># workouts : </strong> ${workoutPlan.value.workoutsCount}</p>
						-->
						
						<p>Active Users : <strong>${workoutPlan.value.plansCount}</strong> </p>
						
						<!--
						<g:link action="setup" params="[workoutPlan: workoutPlan.value.name, planVersion : planVersion,  planName: planName ]" class="btn btn-primary" id="${workoutPlan.value.name}">Select Plan &nbsp;&#xBB;</g:link>
						-->
					
						<a href="${g.createLink(action:'setup', params : [workoutPlan: workoutPlan.value.name, planVersion : planVersion,  planName: planName ])}" id="${workoutPlan.value.name}" class="btn btn-primary">Select Plan &nbsp;&#xBB;</a>
						
						
						
					</div>
				</div>
			</g:each>
		
		</div>
		
  	</div>
  	
</body>
</html>
