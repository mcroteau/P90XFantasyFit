<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="mobile">
	<title>Workout Entry : <shiro:principal/></title>

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
		
	
	
	<div class="row">
		<div class="col-md-12" style="text-align:center">
			
			<h2 style="margin-top:0px;">${plannedWorkout.displayName}
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

			<g:form action="update" method="post">
			
				<g:hiddenField name="id" value="${plannedWorkout?.id}" />
				
				<g:hiddenField name="completed" value="true" />
				
				
			
				<g:if test="${!plannedWorkout.skipped}">
				
					<h4><g:datePicker value="${plannedWorkout?.plannedWorkoutDate}" precision="day" name="actualWorkoutDate"/></h4>
					
					<p style="color:#777;font-size:12px"><strong>* Note :</strong> Small numbers underneath the inputs are previous workout results</p>
					
					
					<g:render template="exercises_mobile"/>
						
					<br/>
						
					<g:if test="${!plannedWorkout?.completed}">
						<g:actionSubmit class="btn btn-danger" action="confirmSkip" value="Skip Workout"/>
						<g:actionSubmit class="btn btn-primary" action="update" value="Log Workout" />
					</g:if>
					<g:else>
						<g:actionSubmit class="btn btn-primary" action="update" value="Update Results" />
					</g:else>
						
					<br class="clear"/>	
					

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
					
					
				</g:if>

				<g:else>
					<h5>Skipped workout on  <g:formatDate date="${plannedWorkout?.skippedDate}" format="dd MMM yyyy"/> </h5>
					<p>Would you like to recover this workout and add it back to your schedule?</p>	

					<g:link controller="account" action="dashboard" class="btn btn-default">Cancel</g:link>
					
					<g:actionSubmit class="btn btn-primary" action="confirmRecover" value="Recover Workout" />			

					<g:if test="${plannedWorkout?.extra}">
						<p class="alert alert-info" style="margin:20px auto 100px auto">You can delete this workout because it is an extra workout<br/> Warning, you will lose points on delete.<br/> 
							<g:actionSubmit class="btn btn-danger" action="remove" value="Delete Workout" id="${plannedWorkout.id}" style="margin-top:20px;"/>
						</p>
					</g:if>
					
				</g:else>
				
			</g:form>
			
		</div>
	</div>
	
	
	<div class="row" style="height:100px;"></div>
	
</body>
</html>
