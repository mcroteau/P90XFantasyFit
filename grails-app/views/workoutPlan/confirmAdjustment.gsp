<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="fullscreen">
	<title>P90X Fantasy Fit : Adjust Schedule</title>
	
	<link rel="stylesheet" href="${resource(dir:'js/lib/fullcalendar/1.6.4/',file:'fullcalendar.css')}" />
	
	<script type="text/javascript" src="${resource(dir:'js/lib/fullcalendar/1.6.4/fullcalendar.min.js')}"></script>
		
	<script type="text/javascript" src="${resource(dir:'js/lib/moment/2.4.0/moment.min.js')}"></script>
	
</head>
<body>

	<style type="text/css">
		.confirmAdjustmentContainer{
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
	
	
	<div class="row">
		<div class="confirmAdjustmentContainer">
		
			<p>Before we continue, below is a preview of the changes that will occur if you continue</p>

			<h3><strong>New End Date : </strong> <span id="completeDate"></span></h3>
				
			<g:form action="adjust" method="post">
				<input type="hidden" name="workoutPlanId" value="${workoutPlan.id}"/>
				<input type="hidden" name="plannedWorkoutId" value="${plannedWorkout.id}"/>
				<g:link controller="account" action="dashboard" class="btn btn-default">Cancel</g:link>
				<input type="submit" value="Continue" class="btn btn-primary"/>
				
			</g:form>
				
		</div>
	</div>


<script type="text/javascript">

$(document).ready(function(){

	var $completeDate = $('#completeDate'),
		$fromNow = $('#fromNow');
	
	<g:if test="${completeDateCal}">
		var day = ${completeDateCal.get(Calendar.DAY_OF_MONTH)}
		var month = ${completeDateCal.get(Calendar.MONTH)}
		var year = ${completeDateCal.get(Calendar.YEAR)}
		
		var date = new Date(year, month, day)

		var fromNow = moment([year, month, day]).fromNow(true)
		
		console.info(day, month, year, date)
		var completeDateFormatted = moment(date).format("DD MMMM YYYY")
		
		$completeDate.html(completeDateFormatted)
		$fromNow.html(fromNow)
		
	</g:if>
	
});


</script>

</body>
</html>
