<%@ page import="org.motus.common.AccoladeType"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="profile">
	
	<title>P90X Fantasy Fit : Details</title>
	
    
</head>
<body>


		<h2 style="float:left;">${workoutPlan.title} Details</h2>
		
		<div class="dropdown" style="float:right; margin-top:20px">
			<button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown">
			  	Select Workout Plan
				<span class="caret"></span>
			</button>
			<ul class="dropdown-menu dropdown-menu-right" role="menu" aria-labelledby="dropdownMenu1">
				<g:each in="${workoutPlanList}" status="i" var="workoutPlan"> 
					<li role="presentation">
						<g:link controller="workoutPlan" action="details" id="${workoutPlan.id}">${workoutPlan.title}</g:link>
					</li>
				</g:each>
			</ul>
		</div>
		<br class="clear"/>
		
		
		<div style="height:15px;">&nbsp;</div>
			
		<div class="dashboard-column float-left">
			
			<div id="dashboard-header-stats">
						
				<div id="date-range" style="float:none !important; text-align:center !important">
					<span class="date-label">Start : </span>
					<span class="date"><g:formatDate format="dd MMM yyyy" date="${workoutPlan.startDate}"/></span>
					<span class="date-label">End : </span>
					<span class="date"><g:formatDate format="dd MMM yyyy" date="${workoutPlan.plannedCompleteDate}"/></span>
				</div>
											
				<h1 class="header-stat float-left">${workoutPlan.totalPoints}<span  class="header-stat-label">Points Earned</span></h1>			
				<h2 class="header-stat float-left">${data?.completedWorkouts}/${data.totalWorkouts}
					<span class="header-stat-label">Workouts <br/>completed</span>
				</h2>
				
				<h1 class="header-stat float-right relative">${data.percentComplete}<span class="percent-sym">%</span>
					<span class="header-stat-label">Complete</span>
				</h1>
				
				<br class="clear"/>
			</div>
			
			
		</div>
		
		
		
		<div class="dashboard-column float-right">
			
			<div id="completed-graph-container">
				<div id="chart-legend">
					<div class="legend-item">
						<span class="legend-item-box complete"></span> Completed
					</div>
					<div class="legend-item">
						<span class="legend-item-box skipped"></span> Skipped
					</div>
					<div class="legend-item">
						<span class="legend-item-box incomplete"></span> Incomplete
					</div>
				</div>
				
				<canvas id="chart" height="140px" width="140px"></canvas>

				<br class="clear"/>
			</div>
			
		</div>	
			
		<br class="clear"/>
		
		
		
		<div class="dashboard-column float-left">
			
			
			<h5>Plan Summary</h5>
			<table class="stats-table">
				<tr>
					<td class="stat-description">Version</td>
					<td class="stat-value">${workoutPlan.planVersion}</td>
				</tr>
				<tr>
					<td class="stat-description">Plan Type</td>
					<td class="stat-value">${workoutPlan.name}</td>
				</tr>
				<tr>
					<td class="stat-description">Points Earned</td>
					<td class="stat-value">${workoutPlan.totalPoints}</td>
				</tr>
				<tr>
					<td class="stat-description">Workouts Completed</td>
					<td class="stat-value">${data.completedWorkouts}</td>
				</tr>
				</tr>
				<tr>
					<td class="stat-description">Workouts Skipped</td>
					<td class="stat-value">${data.skippedWorkouts}</td>
				</tr>
				</tr>
				<tr>
					<td class="stat-description">Workouts Remaining</td>
					<td class="stat-value">${data.incompleteWorkouts}</td>
				</tr>
			</table>
			
		</div>


		
		<div class="dashboard-column float-right">
			
			<h5 style="border-bottom:solid 1px #f3f3f3; padding-bottom:8px;">Plan Accolades</h5>
			
			<g:if test="${accolades.size() > 0}">
				<ul id="recent-activity">
					<g:each in="${accolades}" var="accolade">
						<li>
							<span class="points-wrapper">+${accolade.points}</span>
							<g:formatDate format="dd MMM yyyy" date="${accolade.dateCreated}"/> : 
							<g:if test="${accolade.type == AccoladeType.LOGGED_WORKOUT.description()}">
							 	<g:link controller="${accolade.plannedWorkout.link}" action="show" id="${accolade.plannedWorkout?.id}">${accolade.plannedWorkout?.displayName}</g:link> Completed
							</g:if>
							<g:elseif test="${accolade.type == AccoladeType.COMPLETED_AB_RIPPER.description()}">
							 	<g:link controller="${accolade.plannedWorkout.link}" action="show" id="${accolade.plannedWorkout?.id}">${raw(accolade.description)}</g:link>
							</g:elseif>
							<g:else>
							 	${raw(accolade.description)}
							</g:else>
						</li>
					</g:each>
				</ul>
				<g:if test="${accoladesCount > 5}">
					<g:link controller="workoutPlan" action="accolades" id="${workoutPlan.id}">View All</g:link>	
				</g:if>
				
			</g:if>
			<g:else>
				<div class="alert alert-info">No workouts logged</div>
			</g:else>
			
		</div>
		
		<br class="clear"/>
		
		
		
	
	
	
<script type="text/javascript">	

var data = [
    {
        value: ${data.completedWorkouts},
        color:"#2871f9",
        highlight: "#0D60F6",
        label: "Completed"
    },
    {
        value: ${data.incompleteWorkouts},
        color: "#a4c4fe",
        highlight: "#99bcfd",
        label: "Incomplete"
    },
    {
        value: ${data.skippedWorkouts},
        color: "#ffdb41",
        highlight: "#ecc82e",
        label: "Skipped"
    }
]

var options = {
	
    segmentShowStroke : true,
    segmentStrokeColor : "#efefef",
    segmentStrokeWidth : 3,
    percentageInnerCutout : 30, 
    animationSteps : 10,
    animationEasing : "easeOutQuart",
    animateRotate : false,
    animateScale : false,


}


var ctx = $("#chart").get(0).getContext("2d");

var myDoughnutChart = new Chart(ctx).Doughnut(data, options);
</script>		
							
</body>
</html>
