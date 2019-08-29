<%@ page import="org.apache.shiro.SecurityUtils"%>
<%@ page import="org.motus.common.WorkoutPlanStatus"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="mobile">
	<title>${plannedWorkout.displayName}</title>
	
    <link rel="stylesheet" href="${resource(dir:'css', file:'exercises.css')}" />
</head>
<body>

	<style type="text/css">
	
		.workout-entry{
			background:inherit !important;
		}
	
		.workout-entry input[type="text"]{
			width:45px;
			margin-left:3px;
			display:inline-block;
		}
	
		.workout-entry td{
			border:none !important;
		}
		.col-xs-1, .col-sm-1, .col-md-1, .col-lg-1, .col-xs-2, .col-sm-2, .col-md-2, .col-lg-2, .col-xs-3, .col-sm-3, .col-md-3, .col-lg-3, .col-xs-4, .col-sm-4, .col-md-4, .col-lg-4, .col-xs-5, .col-sm-5, .col-md-5, .col-lg-5, .col-xs-6, .col-sm-6, .col-md-6, .col-lg-6, .col-xs-7, .col-sm-7, .col-md-7, .col-lg-7, .col-xs-8, .col-sm-8, .col-md-8, .col-lg-8, .col-xs-9, .col-sm-9, .col-md-9, .col-lg-9, .col-xs-10, .col-sm-10, .col-md-10, .col-lg-10, .col-xs-11, .col-sm-11, .col-md-11, .col-lg-11, .col-xs-12, .col-sm-12, .col-md-12, .col-lg-12 {
			padding-left:3px;
			padding-right:3px;
	
		}	
		.previous{
			color:#777;
			font-size:10px;
		}
	
	</style>
		
	<div class="row">
		<div class="col-md-12">		
			<g:render template="messages"/>
		</div>
	</div>
		
	<div class="row" style="text-align:center!important">		
		<div class="col-md-12">
		
			<h2>${plannedWorkout.displayName}
				<g:if test="${!plannedWorkout?.completed}">
					<g:if test="${!plannedWorkout.skipped}">
						<code>Incomplete</code>
					</g:if>
					<g:else>
						<code>Skipped</code>
					</g:else>
				</g:if>
				<g:else>
					<code class="completed">Completed</code>
					<br/>
					<p style="margin-top:10px; display:inline-block"><span style="font-family:Roboto-Black;">+${points}</span> Points</p>
				</g:else>
			</h2>
			
			<g:if test="${plannedWorkout.completed}">
				<h4>Workout Date :
					<g:formatDate date="${plannedWorkout?.actualWorkoutDate}" format="dd MMM yyyy"/>
				</h4>
				<g:render template="exercises_show_mobile"/>
			</g:if>
			<g:else>
				<h4>Planned Workout Date : 
				<g:formatDate date="${plannedWorkout?.plannedWorkoutDate}" format="dd MMM yyyy"/></h4>

			</g:else>
		</div>	
	</div>		
		
		
	
	<g:if test="${plannedWorkout.completed}">	
		<div class="row" style="text-align:center!important">
			<div class="col-md-12">
		
				<g:if test="${plannedWorkout.includeAbRipper}">
					<g:if test="${plannedWorkout?.abRipperCompleted}">
						<br/>
						<p>Ab Ripper X Completed</p>
					</g:if>
				</g:if>
				
				<g:if test="${plannedWorkout.notes}">
					<p>Notes : ${plannedWorkout.notes}</p>
				</g:if>
				
			</div>
		</div>	
	</g:if>
		
	<g:if test="${SecurityUtils.getSubject().isPermitted('workoutPlan:edit:' + plannedWorkout.workoutPlan.id)}">
	
		<div class="row" style="text-align:center!important">
			<div class="col-md-12">
				<g:form>
					<g:hiddenField name="id" value="${plannedWorkout?.id}" />
					
					<g:if test="${plannedWorkout.workoutPlan.status == WorkoutPlanStatus.ACTIVE.description()}">
						<g:if test="${plannedWorkout.completed}">
							<br/>
							<g:link class="btn btn-primary" action="entry" id="${plannedWorkout?.id}">Update Workout Results</g:link>
						</g:if>
						<g:else>					
							<g:link class="btn btn-primary" action="entry" id="${plannedWorkout?.id}">Log Workout</g:link>
						</g:else>
						
						<g:if test="${extraWorkout}">
						
							<p class="alert alert-info" style="margin:20px auto 100px auto">Congratulations on completing an extra workout. Would you like to remove this workout from the schedule without penalty?<br/>
								
								<g:actionSubmit class="btn btn-danger" action="remove" value="Remove from Schedule" id="${plannedWorkout.id}" style="margin-top:20px;"/>
							</p>
							
						</g:if>
					</g:if>
					
					
				</g:form>
			</div>
		</div>
	</g:if>
	

</body>
</html>
