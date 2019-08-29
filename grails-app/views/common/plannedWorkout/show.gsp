<%@ page import="org.apache.shiro.SecurityUtils"%>
<%@ page import="org.motus.common.WorkoutPlanStatus"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="fullscreen-menu">
	<title>${plannedWorkout.displayName}</title>
	
    <link rel="stylesheet" href="${resource(dir:'css', file:'exercises.css')}" />
</head>
<body>
		
	<div class="row">
		<div class="col-md-12">		
			<g:render template="messages"/>
		</div>
	</div>
		
	<div class="row planned-workout-show" style="text-align:center!important">		
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
				<g:render template="exercises_show"/>
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
