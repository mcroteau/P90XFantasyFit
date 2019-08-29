<%@ page import="org.motus.common.CompetitionInviteStatus" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="fullscreen">
	<title>P90X Fantasy Fit : Search Members</title>

</head>
<body>


	<style type="text/css">
		#invite-search-left{
			width:600px;
			float:left;
		}
		
		#invite-search-right{
			width:320px;
			float:right;
		}
		
		#search-box-container{
			background:#f2f2f2;
			padding:20px;
			border:solid 1px #ddd;
			-webkit-border-radius: 3px;
			-moz-border-radius: 3px;
			border-radius: 3px;
		}
		#search-box-container input[type="text"]{
			width:420px;
			display:inline-block;
		}
		#search-results-table td{
			vertical-align:middle;
		}
	</style>
	
	
	<div id="invite-search-left">
	
		<g:if test="${flash.message}">
			<div class="alert alert-info">${raw(flash.message)}</div>
		</g:if>
		
		<g:if test="${flash.error}">
			<div class="alert alert-warning">${flash.error}</div>
		</g:if>
	
	
		<h2>SEARCH MEMBERS TO INVITE</h2>
		<p><strong>Competition :&nbsp;</strong> Channel 6 News</p>
		
		
		
		<form action="/bringit/competitionInvite/search/${competition.id}" method="get">
			<div id="search-box-container">
				<input type="text" name="query" value="" class="form-control"/>
				<input type="submit" value="Search Members" class="btn btn-primary"/>
			</div>
		</form>
		
		
		
		<g:if test="${accounts}">
			
			<p style="margin:5px auto; text-align:center"><strong>${accounts.size()}</strong>&nbsp;Results</p>
		
			<table id="search-results-table" class="table table-condensed table-striped" style="margin-top:15px;">
				<tr>
					<th></th>
					<th>Username</th>
					<th>Name</th>
					<th class="align-center"></th>
				</tr>
				<g:each in="${accounts}" var="member">
					<tr>
						<td>
							<g:if test="${member?.profileImageUrl}">
								<img src="/bringit/${member?.profileImageUrl}" height="30" width="30" title="${member?.name} Profile" alt="${member?.name} Profile">	
							</g:if>
							<g:else>
								<img src="${resource(dir:'images/profile.jpg')}" height="30" width="30" title="${member?.name} Profile" alt="${member?.name} Profile">	
							</g:else>
						</td>
						<td>${member.username}</td>
						<td>${member.name}</td>
						<td class="align-center">
							<g:link action="prepare" id="${competition.id}" class="btn btn-default" params="[ memberId : member.id ]">Send Invite</g:link>
						</td>
					</tr>
				</g:each>
			</table>
		</g:if>
		
	</div>
	
	
	
	
	<div id="invite-search-right" style="padding-top:40px;">
		
		<h5>Current Invites</h5>
		
		<g:if test="${invites}">
			<table id="search-results-table" class="table table-condensed table-striped" style="margin-top:15px;">
				<tr>
					<th></th>
					<th>Username</th>
					<th>Status</th>
				</tr>
				<g:each in="${invites}" var="invite">
					<tr>
						<td>
							<g:if test="${invite.account?.profileImageUrl}">
								<img src="/bringit/${invite.account?.profileImageUrl}" height="30" width="30" title="${invite.account?.name} Profile" alt="${invite.account?.name} Profile">	
							</g:if>
							<g:else>
								<img src="${resource(dir:'images/profile.jpg')}" height="30" width="30" title="${invite.account?.name} Profile" alt="${invite.account?.name} Profile">	
							</g:else>
						</td>
						<td>${invite.account.username}</td>
						<td>
							<g:if test="${invite.status == CompetitionInviteStatus.PENDING.description()}">
								<span class="label label-info">pending</span>
							</g:if>
							<g:elseif test="${invite.status == CompetitionInviteStatus.ACCEPTED.description()}">
								<span class="label label-primary">accepted</span>
							</g:elseif>
							<g:elseif test="${invite.status == CompetitionInviteStatus.DECLINED.description()}">
								<span class="label label-danger">declined</span>
							</g:elseif>
						</td>
					</tr>
				</g:each>
			</table>
		</g:if>
		<g:else>
			<p>No invites sent yet</p>
		</g:else>
		
	</div>
	
	
	
	<br class="clear"/>


</body>
</html>
