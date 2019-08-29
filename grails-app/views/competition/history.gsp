<%@ page import="org.apache.shiro.SecurityUtils"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="profile">
	<title>P90X Fantasy Fit : Workout History</title>
</head>
<body>
	

	<ul class="nav nav-tabs" role="tablist" style="margin-top:10px;">
		<li><g:link uri="/public/history/${account.username}">Workouts</g:link></li>
		<li><g:link controller="workoutPlan" action="planHistory" params="[accountId : account.id]">Plans</g:link></li>
		<li class="active"><g:link controller="competition" action="history" params="[accountId : account.id]">Competitions</g:link></li>
	</ul>
	
	
	<g:if test="${competitions}">
			
		<table class="table table-striped" style="margin-top:20px;">
			<tr>
				<th>Name</th>
				<th>Start</th>
				<th>End</th>
				<th>Status</th>
				<th class="align-center">Rank</th>
				<th></th>		
			</tr>
			<g:each in="${competitions}" status="j" var="competition">
				<tr>
					<td>${competition.name}</td>
					<td class="align-left"><g:formatDate format="dd MMM yyyy" date="${competition.startDate}"/></td>
					<td class="align-left"><g:formatDate format="dd MMM yyyy" date="${competition.endDate}"/></td>
					<td>${competition.status}</td>
					<td class="align-center">
						<g:if test="${memberRank > 0}">
							${competition.memberRank}
						</g:if>
						<g:else>
							-
						</g:else>
					</td>
					<td class="align-center"><g:link controller="competition" action="results" id="${competition.id}" params="[accountId : account.id]">View Results</g:link></td>
				</tr>
			</g:each>
		</table>
	
	</g:if>
	
	
	
	<g:else>
	
		<h2>No Competitions found.</h2>


		<g:if test="${SecurityUtils.getSubject().isPermitted('account:edit:' + account?.id)}">
			<p>You currently don't have any Competitions</p>
			<g:link controller="competition" action="setup" class="btn btn-primary">Begin a Competition Now!</g:link>
		</g:if>
		
		<br class="clear"/>
		
	</g:else>
	
							
</body>
</html>
