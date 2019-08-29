<div class="row">

	<div class="col-md-12">

		<div class="control-group">
			<label>Minutes</label>
			<g:select name="minutes" value="${plannedWorkout.minutes}"  from="${[20, 25, 30, 35, 40, 45, 50, 60, 70, 80, 90]}"/>
		</div>
		
		
		<div class="control-group">
			<p>Notes : </p>
			<p><textarea name="notes" cols="50" rows="4">${plannedWorkout?.notes}</textarea></p>
		</div>
		
	</div>
	
</div>