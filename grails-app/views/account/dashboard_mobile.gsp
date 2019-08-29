<%@ page import="org.apache.shiro.SecurityUtils"%>
<%@ page import="org.motus.common.AccoladeType"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="mobile">
	<title></title>

</head>
<body>
				
	<g:if test="${flash.message}">
		<div class="alert alert-info">${raw(flash.message)}</div>
	</g:if>
	<g:if test="${flash.error}">
		<div class="alert alert-warning">${flash.error}</div>
	</g:if>
			
				
	<g:if test="${dashboardData?.currentPlan}">
	
		<div class="row">
		
			<div class="col-md-12">
				
				<h1 style="margin-top:0px;">${dashboardData?.currentPlan?.title} Overview <span class="label label-info">Day ${duration?.days + 1}</span></h1>
		    	
				
			</div>
		</div>
		
		<div class="row">
			<div class="col-md-12">
				<span class="date-label">Start : </span>
				<span class="date"><g:formatDate format="dd MMM yyyy" date="${dashboardData?.currentPlan?.startDate}"/></span>
				<span class="date-label">End : </span>
				<span class="date"><g:formatDate format="dd MMM yyyy" date="${dashboardData?.currentPlan?.plannedCompleteDate}"/></span>
					
			</div>
			
		</div>
		
		
		
		<div class="row">
		
			<div id="col-md-12">
										
				<h1 class="header-stat float-left">${dashboardData?.currentPlan?.totalPoints}<span  class="header-stat-label">Points Earned</span></h1>			
				<h2 class="header-stat float-left">${dashboardData?.totalCompletedSkipped}/${dashboardData?.totalWorkouts}
					<span class="header-stat-label">Workouts <br/>completed</span>
				</h2>
			
				<h1 class="header-stat float-right relative">${dashboardData?.percentComplete}<span class="percent-sym">%</span>
					<span class="header-stat-label">Complete</span>
				</h1>
			
				<br class="clear"/>
				
			</div>
		</div>
		
		
		<div class="row">
			<div class="col-md-12">
			
				<div id="todays-workout-container">
				
					<g:if test="${dashboardData.todaysWorkout}">
						<g:if test="${dashboardData?.todaysWorkout?.completed}">
							<div class="alert alert-info"><strong>Nice Work!</strong> Today's Workout Completed</div>
							<g:link controller="workoutPlan" action="pickWorkout" class="btn btn-default"  style="margin-right:10px">Pick a Workout</g:link>
						</g:if>
						<g:else>
						
							<div id="todays-workout">
								<span id="todays-workout-label">Todays Workout : </span>
								<span>${dashboardData?.todaysWorkout?.displayName}</span>
							</div>
							
							<g:if test="${SecurityUtils.getSubject().isPermitted('workoutPlan:edit:' + dashboardData?.currentPlan?.id)}">
								
								<g:link controller="workoutPlan" action="pickWorkout" class="btn btn-default"  style="margin-right:10px">Pick Any Workout</g:link>
								<br/>
								<br/>
								
								<g:link controller="${dashboardData?.todaysWorkout?.link}" action="entry" params="[id:dashboardData?.todaysWorkout?.id]" class="btn btn-primary">Log Todays Workout</g:link>
							</g:if>
							
						</g:else>
						
					</g:if>
					<g:else>
							<div id="todays-workout">
								<span id="todays-workout-label">Todays Workout : </span>
								<span>No Workout Today</span>

								<g:if test="${SecurityUtils.getSubject().isPermitted('workoutPlan:edit:' + dashboardData?.currentPlan?.id)}">
								<g:link controller="workoutPlan" action="pickWorkout" class="btn btn-default"  style="margin-top:10px">Pick a Workout</g:link>
								</g:if>
								
							</div>
					</g:else>
					
				</div>
			
			</div>
			
		</div>
		
		
		
		<div class="row">
			
			<div class="col-md-12">
			
				<h5 style="border-bottom:solid 1px #f3f3f3; padding-bottom:8px;">Recent Activity</h5>
		
				<g:if test="${dashboardData?.accolades}">
			
					<ul id="recent-activity">
						<g:each in="${dashboardData.accolades}" status="i" var="accolade">
							<li>
								<span class="points-wrapper">+${accolade.points}</span>
								<g:formatDate format="dd MMM yyyy" date="${accolade.dateCreated}"/> : 
								<g:if test="${accolade.type == AccoladeType.LOGGED_WORKOUT.description()}">
								 	<g:link controller="${accolade.plannedWorkout.link}" action="show" id="${accolade.plannedWorkout?.id}">${accolade.plannedWorkout?.displayName}</g:link> Completed
								</g:if>
								<g:elseif test="${accolade.type == AccoladeType.COMPLETED_AB_RIPPER.description()}">
								 	<g:link controller="${accolade.plannedWorkout.link}" action="show" id="${accolade.plannedWorkout?.id}">${accolade.description}</g:link>
								</g:elseif>
								<g:else>
								 	${accolade.description}
								</g:else>
							</li>
						</g:each>
					</ul>
				
					
				</g:if>
				<g:else>
					<span class="alert alert-info">Start logging workouts to earn points</span>
				</g:else>
				
			</div>
			
		</div>	
		
	</g:if>
	
	<g:else>
		
		<div class="row">
		
			<div class="col-md-12">

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
		</div>
	
	</g:else>	
	
	
	
	
	
	
	
	
	
	