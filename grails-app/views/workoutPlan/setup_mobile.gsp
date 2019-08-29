<html lang="en">
<head>
  	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
 	<meta name="layout" content="mobile" />
	<title>P90X Fantasy Fit : Select Workout Plan</title>
		
	<script type="text/javascript" src="${resource(dir:'js/lib/moment/2.4.0/moment.min.js')}"></script>
	
	
</head>
<body>
  
  	<div class="row">
		<div class="col-md-12">
			<g:if test="${flash.message}">
				<div class="alert alert-info">${raw(flash.message)}</div>
			</g:if>				
			<g:if test="${flash.error}">
				<div class="alert alert-danger">${flash.error}</div>
			</g:if>	
		</div>
	</div>
	
	
	<div class="row">
	
		<div class="col-md-12">
		
			<g:form action="start" method="post">
		
				<h2 style="margin-top:0px;"><span class="large">Setup :</span><br/> ${workoutPlan.name}
					<g:if test="${workoutPlan.popular}">
						<span class="label label-info" style="font-size:11px;">Popular</span>
					</g:if>
				</h2>
				<div class="form-group">
				  	<label for="startDate">Start Date</label>
					<g:datePicker name="startDate" value="${new Date()}"
						precision="day"/>
				</div>
				<div class="form-group">
					<label for="endDate">End Date</label>
					<span id="endDate"></span>
				</div>
				
				<p>Give your plan a title:
					<input type="text" name="title" value="" class="form-control" style="width:auto !important;"/>
				</p>
				
				<!--
				<p><strong># weeks : </strong> ${workoutPlan.weeksCount}<br/>
				   <strong># workouts : </strong> ${workoutPlan.workoutsCount}<br/>
				   <strong># active users : </strong> ${workoutPlan.plansCount}</p>
				<p>${workoutPlan.description}</p>
				-->
				
				
				<input type="hidden" name="workoutPlan" value="${workoutPlan.name}"/>
				<input type="hidden" name="planVersion" value="${planVersion}"/>


				
				<input type="submit" class="btn btn-primary btn-block" value="Start Plan"/>
			</g:form>
				
			<br class="clear"/>
			
		</div>
	
		
  	</div>
  	
<script type="text/javascript">

$(document).ready(function(){
	
	var $day = $('#startDate_day'),
		$month = $('#startDate_month'),
		$year = $('#startDate_year'),
		$endDate = $('#endDate');
		
	$day.change(updateEndDate)	
	$month.change(updateEndDate)
	$year.change(updateEndDate)
		
	var weeks = ${workoutPlan.weeksCount};
	var days = weeks * 7
	
	function updateEndDate(){
		var futureDate = new Date($year.val(), $month.val() -1, $day.val() )		
		futureDate.setDate(futureDate.getDate() + days)		
		$endDate.html(moment(futureDate).format("DD MMMM YYYY"))
	}
	
	updateEndDate()
	
});

</script>
	
</body>
</html>
