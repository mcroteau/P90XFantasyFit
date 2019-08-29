<html lang="en">
<head>
  	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
 	<meta name="layout" content="fullscreen" />
	<title>P90X Fantasy Fit : Select Workout Plan</title>
		
	<script type="text/javascript" src="${resource(dir:'js/lib/moment/2.4.0/moment.min.js')}"></script>
	
	
</head>
<body>
  
	
	<style type="text/css">
		h2 .label{
			margin-top:8px;
			font-size:11px;
		}
	</style>
	
	<div style="text-align:center">
	
		<div style="margin:auto; width:370px;" class="well">
			
			<g:if test="${flash.message}">
				<div class="alert alert-info">${raw(flash.message)}</div>
			</g:if>				
			<g:if test="${flash.error}">
				<div class="alert alert-danger">${flash.error}</div>
			</g:if>
			
			<g:form action="start" method="post">
			
				<h4>Configure Plan : ${planName}</h4>
				<h2 style="margin-top:0px">${workoutPlan.name}
					<g:if test="${workoutPlan.popular}">
						<span class="label label-default">Popular</span>
					</g:if>
				</h2>
							
							
				<!--			
				<p>${workoutPlan.description}</p>
				<p><strong>Active Users : </strong> ${workoutPlan.plansCount}</p>
				-->
				
				
				<p>Give your plan a title:<br/>
					<input type="text" name="title" value="" class="form-control" style="width:300px; margin:10px auto 20px auto;" placeholder="e.g. Fit for Summer"/>
				</p>
				
				<!--
				<p><strong># weeks : </strong> ${workoutPlan.weeksCount}</p>
				<p><strong># workouts : </strong> ${workoutPlan.workoutsCount}</p>
				-->
				
			
				<input type="hidden" name="workoutPlan" value="${workoutPlan.name}"/>
				<input type="hidden" name="planVersion" value="${planVersion}"/>

				<table style="margin:10px auto 30px auto">
					<tr>
						<td style="text-align:right; margin-right:10px;"><label>Start Date :&nbsp;</label></td>
						<td style="text-align:left"><g:datePicker name="startDate" value="${new Date()}"
							precision="day"/>
						</td>
					</tr>
					<tr><td colspan="2" style="height:10px"></td></tr>
					<tr>
						<td style="text-align:right; margin-right:10px;"><label>End Date :&nbsp;</label></td>
						<td style="text-align:left"><span id="endDate"></span></td>
					</tr>
				</table>
				
				<input type="submit" class="btn btn-primary btn-block" value="Start Plan"/>
			</g:form>
			
		</div>
	
		<div class="col-md-6">
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
