<%@ page import="org.motus.common.CompetitionStatus" %>
<%@ page import="org.apache.shiro.SecurityUtils"%>
<html lang="en">
<head>
  	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
 	<meta name="layout" content="fullscreen-menu" />
	<title>P90X Fantasy Fit : Competition Results</title>
</head>
<body>
  
 

 
	<div id="standings-container">

		
		<h2 style="margin:20px auto 0px auto">
			<span class="large">Competition Results</span> 
			${competition.name}
			
			<g:if test="${competition.status == CompetitionStatus.ACTIVE.description()}">
				<span class="label label-primary">Active</span>
			</g:if>
			<g:elseif test="${competition.status == CompetitionStatus.UPCOMING.description()}">
				<span class="label label-info">Upcoming</span>
			</g:elseif>
			<g:elseif test="${competition.status == CompetitionStatus.STOPPED.description()}">
				<span class="label label-danger">Stopped</span>
			</g:elseif>	
			<g:elseif test="${competition.status == CompetitionStatus.COMPLETED.description()}">
				<span class="label label-info">Complete</span>
			</g:elseif>
		</h2>
		
		
		
		
		<br class="clear"/>
		
		<style type="text/css">
			h2 .large{
				display:block;
				font-size:30px;
				font-family:Roboto-Thin;
			}
			
			#standings-container{
				width:700px; 
				margin:auto; 
				text-align:center; 
				margin-top:20px
				border:solid 1px #ddd;
			}
			
			#standings{
				margin:auto;
			}
			#standings th{
				text-align:center;
			}
			#standings td{
				vertical-align:middle;
				font-size: 16px;
				text-align:center;
			}
			#standings td.rank{
				font-size:18px;
				text-align:center;
				font-family:Roboto-Black;
			}
			#standings td.left,
			#standings th.left{
				text-align:left;
			}
			
			.standings-links{
				margin-bottom:10px;
			}
			#standings-links-left{
				float:left;							
			}
			#standings-links-right{
				float:right;
				text-align:right;
			}
		</style>
		
		<div id="standings-links-left" class="standings-links">
			<strong>Started :&nbsp;</strong>
			<g:formatDate date="${competition?.startDate}" format="dd MMM yyyy"/>
			&nbsp;&nbsp;
			<strong>Ended :&nbsp;</strong>
			<g:formatDate date="${competition?.endDate}" format="dd MMM yyyy"/>
		</div>
		
		<div id="standings-links-right" class="standings-links">
			
			<g:link controller="competition" action="history" params="[accountId : account.id ]">Competition History</g:link> 
			
		</div>
		
		<br class="clear"/>
		

		<table id="standings" class="table table-striped table-condensed">
			<tr>
				<th style="text-align:center">Rank</th>
				<th style="width:60px"></th>
				<th class="left">Member</th>
				<th>Completed</th>	
				<th>Total Points</th>
			</tr>
			<g:each in="${competitionStats}" var="stats" status="i">
				<tr>
					<td class="rank">
						<g:if test="${stats.rank > 0}">
							<g:if test="${stats.rank == 1}">
								<g:set var="sup" value="st" />
							</g:if>
							<g:elseif test="${stats.rank == 2}">
								<g:set var="sup" value="nd" />
							</g:elseif>
							<g:elseif test="${stats.rank == 3}">
								<g:set var="sup" value="rd" />
							</g:elseif>
							<g:else>
								<g:set var="sup" value="th" />
							</g:else>
							${stats.rank}<sup style="font-family:Roboto-Regular">${sup}</sup>
						</g:if>
						<g:else>
							-
						</g:else>
					</td>
					<td>
						<g:link uri="/public/dashboard/${stats.account.username}">
							<g:if test="${stats.account?.profileImageUrl}">
								<img src="/bringit/${stats.account?.profileImageUrl}" height="30" width="30" title="${stats.account?.name} Profile" alt="${stats.account?.name} Profile">	
							</g:if>
							<g:else>
								<img src="${resource(dir:'images/profile.jpg')}" height="30" width="30" title="${stats.account?.name} Profile" alt="${stats.account?.name} Profile">	
							</g:else>
						</g:link>
					</td>
					<td class="left">
						<g:link uri="/public/dashboard/${stats.account.username}">
							${stats.account.username}
							<g:if test="${competition.account.username == stats.account.username}">
								<span style="font-size:11px; color:#777">(organizer)</span>
							</g:if>
						</g:link>
					</td>
					<td>${stats.totalCompleted}</td>
					<td><strong>${stats.totalPoints}</strong></td>
				</tr>
			</g:each>
		</table>
	</div>
	
</body>
</html>
