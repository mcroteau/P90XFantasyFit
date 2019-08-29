<div class="row">

	<div class="col-md-12">
	
		<div class="control-group">
			<label>Minutes</label>
			<g:select name="minutes" value="${plannedWorkout.minutes}"  from="${[20, 25, 30, 35, 40, 45, 50, 60, 70, 80, 90]}" />
		</div>
		
	</div>

</div>

<div class="row">

	<div class="col-md-12">
	
		<p>Notes : </p>
		
		<p><textarea name="notes"  style="width:100%" rows="4">${plannedWorkout?.notes}</textarea></p>
		
	</div>
	
</div>