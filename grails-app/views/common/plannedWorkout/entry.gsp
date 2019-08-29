<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="fullscreen-menu">
	<title>Log Workout : <shiro:principal/></title>

    <link rel="stylesheet" href="${resource(dir:'css', file:'exercises.css')}" />
</head>
<body>

	<div class="row planned-workout-entry">
		<div class="col-md-12">		
			<g:render template="messages"/>
		</div>
	</div>
	
	<div class="row" style="text-align:center!important">
		<div class="col-md-12" >
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
				</g:else>
			</h2>
		</div>
	</div>
	
	
	<div style="text-align:center!important">
			<g:form method="post" action="update">
			
				<g:hiddenField name="id" value="${plannedWorkout?.id}" />
				
				<g:hiddenField name="completed" value="true" />
				
			
				<g:if test="${!plannedWorkout.skipped}">
				
					<h4><g:datePicker value="${plannedWorkout?.plannedWorkoutDate}" precision="day" name="actualWorkoutDate"/></h4>
					
					<p style="color:#777;font-size:12px"><strong>* Note :</strong> Small numbers next to inputs are previous workout results</p>
					
					
					<g:render template="exercises"/>
					
					<div class="row">
						<div class="col-md-12">
    				
							<g:if test="${!plannedWorkout?.completed}">
								<g:actionSubmit class="btn btn-danger" action="confirmSkip" value="Skip Workout"/>
								<g:actionSubmit class="btn btn-primary" action="update" value="Log Workout" />
							</g:if>
							<g:else>
								<g:actionSubmit class="btn btn-primary" action="update" value="Update Results" />
							</g:else>
							
							
							<g:if test="${extraWorkout}">
								<p class="alert alert-info" style="margin:20px auto 100px auto">Congratulations on completing an extra workout. Would you like to remove this workout from the schedule without penalty?<br/>
									<g:actionSubmit class="btn btn-danger" action="remove" value="Remove from Schedule" id="${plannedWorkout.id}" style="margin-top:20px;"/>
								</p>
							</g:if>
							<g:elseif test="${plannedWorkout?.extra}">
								<p class="alert alert-info" style="margin:20px auto 100px auto">You can delete this workout because it is an extra workout<br/> Warning, you will lose points on delete.<br/> 
									<g:actionSubmit class="btn btn-danger" action="remove" value="Delete Workout" id="${plannedWorkout.id}" style="margin-top:20px;"/>
								</p>
							</g:elseif>
							
						</div>
					</div>
    				
				</g:if>
				<g:else>
					<h5>Skipped workout on  <g:formatDate date="${plannedWorkout?.skippedDate}" format="dd MMM yyyy"/> </h5>
					<p>Would you like to recover this workout and add it back to your schedule?</p>	
					<g:actionSubmit class="btn btn-primary" action="confirmRecover" value="Recover Workout" />			



					<g:if test="${extraWorkout}">
						<p class="alert alert-info" style="margin:20px auto 100px auto">Congratulations on completing an extra workout. Would you like to remove this workout from the schedule without penalty?<br/>
							<g:actionSubmit class="btn btn-danger" action="remove" value="Remove from Schedule" id="${plannedWorkout.id}" style="margin-top:20px;"/>
						</p>
					</g:if>
					<g:elseif test="${plannedWorkout?.extra}">
						<p class="alert alert-info" style="margin:20px auto 100px auto">You can delete this workout because it is an extra workout<br/> Warning, you will lose points on delete.<br/> 
							<g:actionSubmit class="btn btn-danger" action="remove" value="Delete Workout" id="${plannedWorkout.id}" style="margin-top:20px;"/>
						</p>
					</g:elseif>
					
				</g:else>
				
			</g:form>
			
	</div>
	
</body>
</html>
