<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="mobile">
	<title></title>

</head>
<body>



	<div class="row">
		<div class="col-md-12">
				
			<g:if test="${flash.message}">
				<div class="alert alert-info">${raw(flash.message)}</div>
			</g:if>
			<g:if test="${flash.error}">
				<div class="alert alert-warning">${flash.error}</div>
			</g:if>
			
				
			<span id="profile-name">${account.name}</span>
			<span id="profile-info">
				<g:if test="${account.age}">${account.age},</g:if> 
				${account.location}
			</span>
			
			<h5>ALL TIME STATS</h5>
			<table class="stats-table">
				<tr>
					<td class="stat-description">Total Points</td>
					<td class="stat-value">${account?.totalPoints}</td>
				</tr>
				<tr>
					<td class="stat-description">Workouts Completed</td>
					<td class="stat-value">${account?.workoutsCompleted}</td>
				</tr>
				<tr>
					<td class="stat-description">Workouts Skipped</td>
					<td class="stat-value">${account?.workoutsSkipped}</td>
				</tr>
				<tr>
					<td class="stat-description">Plans Completed</td>
					<td class="stat-value">${account?.plansCompleted}</td>
				</tr>
			</table>
		</div>
	</div>
	
	<div class="row">
		<div class="col-md-12" style="text-align:center; margin:30px auto 100px auto;">
			<g:link controller="account" action="dashboard" class="btn btn-primary btn-block">Dashboard</g:link>
			<g:link controller="account" action="edit" class="btn btn-default btn-block">Edit</g:link>
		</div>
	</div>
	
	
</body>
</html>
