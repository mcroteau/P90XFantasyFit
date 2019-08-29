<%@ page import="org.motus.common.CompetitionStatus" %>
<%@ page import="org.apache.shiro.SecurityUtils"%>
<html lang="en">
<head>
  	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
 	<meta name="layout" content="mobile" />
	<title>P90X Fantasy Fit : Competition Standings</title>
</head>
<body>

 
 
<g:if test="${competition}">
 

	<div class="row">
		
		<div class="col-md-12">
		
  
			<g:if test="${flash.message}">
				<div class="alert alert-info" style="margin-top:10px">${raw(flash.message)}</div>
			</g:if>
        	
			<g:if test="${flash.error}">
				<div class="alert alert-warning" style="margin-top:10px">${flash.error}</div>
			</g:if>
			
        	
			
        
			<h2 style="margin:0px auto 0px auto;">
				<g:if test="${competition.status == CompetitionStatus.ACTIVE.description()}">
					<span class="large">Competition Standings</span> 
					${competition.name} 
					<span class="label label-primary">Active</span>
				</g:if>
				<g:elseif test="${competition.status == CompetitionStatus.UPCOMING.description()}">
					<span class="large">Competition Overview</span> 
					${competition.name} 
					<span class="label label-info">Upcoming</span>
				</g:elseif>
				<g:elseif test="${competition.status == CompetitionStatus.STOPPED.description()}">
					<span class="large">Competition Results</span> 
					${competition.name} 
					<span class="label label-danger">Stopped</span>
				</g:elseif>	
				<g:elseif test="${competition.status == CompetitionStatus.COMPLETED.description()}">
					<span class="large">Competition Results</span> 
					${competition.name} 
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
				<strong>Starts :&nbsp;</strong>
				<g:formatDate date="${competition?.startDate}" format="dd MMM yyyy"/>
				&nbsp;&nbsp;
				<br/>
				<strong>Ends :&nbsp;</strong>
				<g:formatDate date="${competition?.endDate}" format="dd MMM yyyy"/>
				&nbsp;&nbsp;
				
				<g:if test="${competition.status == CompetitionStatus.ACTIVE.description()}">
					<strong>Day :&nbsp;</strong>
					${duration}
				</g:if>
				
			</div>
        	
        	
			<br class="clear"/>
			
			
        	
			<table id="standings" class="table table-striped table-condensed">
				<tr>
					<th style="text-align:center">Rank</th>
					<th class="left">Competitor</th>
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
						<td class="left">
							<g:link uri="/public/dashboard/${stats.account.username}">
								${stats.account.username}
								<g:if test="${competition.account.username == stats.account.username}">
									<span style="font-size:11px; color:#777">(commissioner)</span>
								</g:if>
							</g:link>
						</td>
						<td><strong>${stats.totalPoints}</strong></td>
					</tr>
				</g:each>
			</table>
		</div>
	</div>
	
</g:if>
<g:else>
	


	<div class="row">
		<div class="col-md-12">
		
			<g:if test="${flash.message}">
				<div class="alert alert-info" style="margin-top:10px">${raw(flash.message)}</div>
			</g:if>
    		
			<g:if test="${flash.error}">
				<div class="alert alert-warning" style="margin-top:10px">${flash.error}</div>
			</g:if>
			
			
			<h2>No Competitions started</h2>
    		
			<g:if test="${SecurityUtils.getSubject().isPermitted('account:edit:' + account?.id)}">
				<p>You currently are not participating in a competition</p>
				<p>Log into the website using your computer to setup a competition</p>
			</g:if>
			
			<g:else>
				<p>${account.username} is not currently in a competition</p>
			</g:else>
			
		</div>
	</div>
	
</g:else>	
	  	
		
</body>
</html>
