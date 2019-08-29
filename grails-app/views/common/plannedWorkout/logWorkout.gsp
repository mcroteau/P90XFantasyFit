<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="fullscreen-menu">
	<title>${plannedWorkout.displayName} Entry : <shiro:principal/></title>

    <link rel="stylesheet" href="${resource(dir:'css', file:'exercises.css')}" />
</head>
<body>

	<div class="row">
		<div class="col-md-12">		
			<g:render template="messages"/>
		</div>
	</div>
	
	<div class="row">
		<div class="col-md-12">
			<h2 style="text-align:center">${plannedWorkout.displayName}</h2>
		</div>		
	</div>
	
	
	<div style="text-align:center">
		<g:form action="save" method="post">
			
			<g:hiddenField name="completed" value="true" />
			<g:hiddenField name="extra" value="true" />
			<g:hiddenField name="updated" value="true"/>
			
			<h4 style="text-align:center">Date :<g:datePicker value="${plannedWorkout?.plannedWorkoutDate}" precision="day" name="actualWorkoutDate"/></h4>
		
			<p style="color:#777;font-size:12px"><strong>* Note :</strong> Small numbers next to inputs are previous workout results</p>
		
			<g:if test="${!plannedWorkout.skipped}">
				
				<g:render template="exercises"/>
				
				<div class="row">
					<div class="col-md-12">
    					<g:actionSubmit class="btn btn-primary" action="save" value="Log Results" />
					</div>
				</div>
    			
			</g:if>
			<g:else>
				<h5>Skipped workout on  <g:formatDate date="${plannedWorkout?.skippedDate}" format="dd MMM yyyy"/> </h5>
				<g:actionSubmit class="btn btn-warning" action="confirmRecover" value="Recover" />			
			</g:else>


		</g:form>
	</div>
	
</body>
</html>
