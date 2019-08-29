<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="mobile">
	<title>Chest & Back Entry : <shiro:principal/></title>
</head>
<body>


	<div class="row">
		<div class="col-md-12">		
			<g:render template="messages"/>
		</div>
	</div>
	
	
	<div class="row">
		<div class="col-md-12">
			<h2>Update ${plannedWorkout.displayName} Date</h2>
		</div>		
	</div>
	
	
	<g:form method="post" >
	
		<g:hiddenField name="id" value="${plannedWorkout?.id}" />
		<g:hiddenField name="version" value="${plannedWorkout?.version}" />
		
		<h4><g:datePicker value="${plannedWorkout?.plannedWorkoutDate}" precision="day" name="actualWorkoutDate"/></h4>
	
		<g:render template="exercises_show"/>
		
		<div class="row">
			<div class="col-md-12">
    			<g:actionSubmit class="btn btn-primary" action="update" value="Update" />
			</div>
		</div>
    		
	</g:form>
	
	
</body>
</html>
