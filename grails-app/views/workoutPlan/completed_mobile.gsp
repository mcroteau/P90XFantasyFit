<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="mobile">
	<title>P90X Fantasy Fit : Confirm Stop</title>

</head>
<body>
		
	<style type="text/css">
		h2 .large{
			display:block;
			font-size:30px;
			font-family:Roboto-Thin;
		}
	
		h1.black{
			font-size:40px;
			font-family:Roboto-Black;
		}
	
		.points-label{
			font-family:Roboto-Regular;
		}
	</style>
	
			
	<div class="row" style="text-align:center">
		
		<div class="col-md-12">
	
			<div style="text-align:center">
	
				<h2><span class="large">Congratulations!!!</span></h2>
		
				<h1 class="black" style="margin-top:5px;">+${totalPoints} <span class="points-label">Points</span></h1>
		
				<p>You have successfully completed the workout plan : ${workoutPlan.title}</p>
    	
		
				<g:link controller="workoutPlan" action="selectVersion" class="btn btn-primary">Start a New Plan</g:link>
	
			</div>
			
		</div>
	
	</div>


</body>
</html>
