<%@ page import="org.apache.shiro.SecurityUtils"%>
<%@ page import="org.motus.common.AccoladeType"%>
<%@ page import="org.motus.common.WorkoutPlanStatus" %>

<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="profile">
	
	<title>${((duration?.days) ? "Day " + (duration?.days + 1) : "")} Dashboard</title>
	
</head>
<body>

	<g:if test="${flash.message}">
		<div class="alert alert-info">${raw(flash.message)}</div>
	</g:if>
	<g:if test="${flash.error}">
		<div class="alert alert-warning">${flash.error}</div>
	</g:if>
	
	
	<g:if test="${dashboardData?.currentPlan}">
	
		<div id="dashboard-header">
		
			<h1 class="float-left">${dashboardData?.currentPlan?.title} Overview 
			
				<g:if test="${dashboardData?.currentPlan?.status == WorkoutPlanStatus.ACTIVE.description()}">
					<span class="label label-default">Day ${duration?.days + 1}</span>
				</g:if>
				<g:else>
					<span class="label label-default">${dashboardData?.currentPlan?.status}</span>
				</g:else>
				
			</h1>
		
			<div id="date-range">
				<span class="date-label">Start : </span>
				<span class="date"><g:formatDate format="dd MMM yyyy" date="${dashboardData?.currentPlan?.startDate}"/></span>
				<span class="date-label">End : </span>
				<span class="date"><g:formatDate format="dd MMM yyyy" date="${dashboardData?.currentPlan?.plannedCompleteDate}"/></span>
			</div>
			<br class="clear"/>
		</div>
		
		
		
		<div class="dashboard-column float-left">
			
			<div id="dashboard-header-stats">
										
				<h1 class="header-stat float-left">${dashboardData?.currentPlan?.totalPoints}<span  class="header-stat-label">Points Earned</span></h1>			
				<h2 class="header-stat float-left">${dashboardData?.totalCompletedSkipped}/${dashboardData?.totalWorkouts}
					<span class="header-stat-label">Workouts <br/>completed</span>
				</h2>
			
				<h1 class="header-stat float-right relative">${dashboardData?.percentComplete}<span class="percent-sym">%</span>
					<span class="header-stat-label">Complete</span>
				</h1>
			
				<br class="clear"/>
			</div>
		
		
			<div id="todays-workout-container">
			
				<g:if test="${dashboardData.currentPlan.status != WorkoutPlanStatus.ACTIVE.description()}">
					<g:link controller="workoutPlan" action="selectVersion" class="btn btn-primary">Start a New Plan</g:link>
					
					
					
				</g:if>
				<g:else>
					<g:if test="${dashboardData?.todaysWorkout}">
						<g:if test="${dashboardData?.todaysWorkout?.completed}">
							
							<g:if test="${SecurityUtils.getSubject().isPermitted('workoutPlan:edit:' + dashboardData?.currentPlan?.id)}">	
								<div class="alert alert-info"><strong>Nice Work!</strong> Today's Workout Completed</div>
								<g:link controller="workoutPlan" action="pickWorkout" class="btn btn-default"  style="margin-right:10px">Pick a Workout</g:link>
							</g:if>
							<g:else>
								<div class="alert alert-info"><strong>${account.username}</strong> brought it today, did you?  <strong>Go Bring It!</strong></div>
							</g:else>
						</g:if>
						<g:else>
							<div id="todays-workout">
								<span id="todays-workout-label">Todays Workout : </span>
								<span>${dashboardData?.todaysWorkout?.displayName}</span>
							</div>
							<g:if test="${SecurityUtils.getSubject().isPermitted('account:edit:' + account?.id)}">
								<g:link controller="workoutPlan" action="pickWorkout" class="btn btn-default"  style="margin-right:10px">Pick Any Workout</g:link>
								<g:link controller="${dashboardData?.todaysWorkout?.link}" action="entry" params="[id:dashboardData?.todaysWorkout?.id]" class="btn btn-primary">Log Todays Workout</g:link>
							</g:if>
						</g:else>
					</g:if>
					<g:else>
							<div id="todays-workout">
								<span id="todays-workout-label">Todays Workout : </span>
								<span>No Workout Today</span>
								<g:if test="${SecurityUtils.getSubject().isPermitted('account:edit:' + account.id)}">
									<g:link controller="workoutPlan" action="pickWorkout" class="btn btn-default"  style="margin-top:10px">Pick a Workout</g:link>
								</g:if>
							</div>
					</g:else>
				</g:else>
			</div>
		
		</div>
		
		
	
		<g:if test="${!dashboardData?.currentPlan?.freestyle}">
			<div class="dashboard-column float-right">
			
				<g:if test="${dashboardData?.currentPlan?.totalRemaining != dashboardData?.currentPlan?.plannedWorkouts?.size()}">
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
					
						<canvas id="chart" height="170px" width="170px" style="margin-bottom:20px;"></canvas>
			    	
						<br class="clear"/>
					</div>
				</g:if>
				<g:else>
					<span class="alert alert-warning" style="display:block; word-wrap: break-word">Your dashboard may look a little empty at first, start bringing it to see your dashboard come to life</span>
				</g:else>
				
			</div>	
		
		</g:if>
		
		
		<br class="clear"/>	
		
		
		
		<div class="dashboard-column float-left">
		
		
			<h5>Plan Summary</h5>
			<table class="stats-table">
				<tr>
					<td class="stat-description">Version</td>
					<td class="stat-value">${dashboardData.currentPlan.planVersion}</td>
				</tr>
				<tr>
					<td class="stat-description">Plan Type</td>
					<td class="stat-value">${dashboardData.currentPlan.name}</td>
				</tr>
				<tr>
					<td class="stat-description">Points Earned</td>
					<td class="stat-value">${dashboardData.currentPlan.totalPoints}</td>
				</tr>
				<tr>
					<td class="stat-description">Workouts Completed</td>
					<td class="stat-value">${dashboardData.currentPlan.totalCompleted}</td>
				</tr>
				</tr>
				<tr>
					<td class="stat-description">Workouts Skipped</td>
					<td class="stat-value">${dashboardData.currentPlan.totalSkipped}</td>
				</tr>
				</tr>
				<tr>
					<td class="stat-description">Workouts Remaining</td>
					<td class="stat-value">${dashboardData.currentPlan.totalRemaining}</td>
				</tr>
			</table>
		
		</div>
		
		
		
		<div class="dashboard-column float-right">
		
			<h5 style="border-bottom:solid 1px #f3f3f3; padding-bottom:8px;">Recent Activity</h5>
		
			<g:if test="${dashboardData?.accolades}">
			
				<ul id="recent-activity">
					<g:each in="${dashboardData.accolades}" status="i" var="accolade">
						<li>
							<span class="points-wrapper">+${accolade.points}</span>
							<g:formatDate format="hh:mm a dd MMM" date="${accolade.dateCreated}"/> : 
							<g:if test="${accolade.type == AccoladeType.LOGGED_WORKOUT.description()}">
							 	<g:link controller="${accolade.plannedWorkout.link}" action="show" id="${accolade.plannedWorkout?.id}">${accolade.plannedWorkout?.displayName}</g:link> Completed
							</g:if>
							<g:elseif test="${accolade.type == AccoladeType.COMPLETED_AB_RIPPER.description()}">
							 	<g:link controller="${accolade.plannedWorkout.link}" action="show" id="${accolade.plannedWorkout?.id}">${accolade.description}</g:link>
							</g:elseif>
							<g:elseif test="${accolade.plannedWorkout}">
								<g:link controller="${accolade.plannedWorkout.link}" action="show" id="${accolade.plannedWorkout?.id}">${accolade.description}</g:link>
							</g:elseif>
							<g:else>
							 	${accolade.description}
							</g:else>
						</li>
					</g:each>
				</ul>
				
				<g:if test="${dashboardData.accoladesCount > 5}">
					<g:link controller="workoutPlan" action="accolades" id="${dashboardData.currentPlan.id}">View All</g:link>	
				</g:if>
			</g:if>
			<g:else>
				<span class="alert alert-info">Start logging workouts to earn points</span>
			</g:else>
		
		</div>
		
		<br class="clear"/>
		
		
		<div id="social-media">
	
		</div>
	
	</g:if>
	
	<g:else>
		
		<div style="margin-top:40px;">
			
			<g:if test="${SecurityUtils.getSubject().isPermitted('account:edit:' + account.id)}">
				<h2>Start something...</h2>
            	
				<p>You currently don't have Workout Program started</p>
				<g:link controller="workoutPlan" action="selectVersion" class="btn btn-primary">Start a new workout plan</g:link>
			</g:if>
			<g:else>
				<div class="alert alert-warning" style="margin-top:20px;">${account.name} is not currently in a plan</div>
				<br class="clear"/>
			</g:else>
			
		</div>
	
	</g:else>
	
	

	
	
	
	
<script type="text/javascript">	
	
<g:if test="${dashboardData?.currentPlan?.totalCompleted > 0 || 
				dashboardData?.currentPlan?.totalSkipped > 0}">
	
var data = [
    {
        value: ${dashboardData.currentPlan.totalCompleted},
        color:"#2871f9",
        highlight: "#0D60F6",
        label: "Completed"
    },
    {
        value: ${dashboardData.currentPlan.totalRemaining},
        color: "#a4c4fe",
        highlight: "#99bcfd",
        label: "Incomplete"
    },
    {
        value: ${dashboardData.currentPlan.totalSkipped},
        color: "#D2322D",
        highlight: "#b3140f",
        label: "Skipped"
    }
]


//background: #D2322D !important;
//border:solid 1px #b3140f;

var options = {
	
    segmentShowStroke : true,
    segmentStrokeColor : "#f2f2f2",
    segmentStrokeWidth : 3,
    percentageInnerCutout : 30, 
    animationSteps : 20,
    animationEasing : "easeOutQuart",
    animateRotate : false,
    animateScale : false,

	onAnimationComplete: function(){ },
 

}


var ctx = $("#chart").get(0).getContext("2d");

var myDoughnutChart = new Chart(ctx).Doughnut(data, options);
</script>		
	
</g:if>
				
</body>
</html>
