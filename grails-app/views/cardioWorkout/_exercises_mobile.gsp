<%@ page import="org.motus.common.CardioType" %>
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
			<label>Type</label>
			<select name="type"  id="typeSel">
				<option value="${CardioType.JOGGING.description()}" selected>Jogging</option>
				<option value="${CardioType.INTERVALS.description()}">Intervals</option>
				<option value="${CardioType.WALKING.description()}">Walking</option>
				<option value="${CardioType.ELLIPTICAL.description()}">Elliptical</option>
				<option value="${CardioType.BIKING.description()}">Biking</option>
				<option value="${CardioType.HIKING.description()}">Hiking</option>
				<option value="${CardioType.SWIMMING.description()}">Swimming</option>
			</select>
		</div>
		
	
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