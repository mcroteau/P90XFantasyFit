<div class="row">

	<div class="col-md-12" >
		
		<style type="text/css">
			.control-group{
				margin:10px auto;
			}
			.control-group label{
				text-align:right;
				display:inline-block;
			}
		</style>

		
		<div class="control-group">
			<label>Minutes</label>	
			<g:select name="minutes" value="${plannedWorkout.minutes}"  from="${[20, 25, 30, 35, 40, 45, 50, 60, 70, 80, 90]}" disabled="true"/>
		</div>
		
	</div>
</div>

