<%@ page import="org.apache.shiro.SecurityUtils"%>
<%@ page import="org.motus.common.PhotoType"%>

<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="fullscreen">
	
	<title>P90X Fantasy Fit : Member Search</title>
	
</head>
<body>

<div style="text-align:center">

	<style type="text/css">
		
		#search-container{
			width:760px; 
			margin:10px auto;
			padding:20px 30px;
			text-align:left;
			background:#f2f2f2;
			border:1px solid #e8e8e8;
			-webkit-border-radius: 3px;
			-moz-border-radius: 3px;
			border-radius: 3px;
		}
		
	</style>
	

	<div id="search-container">
		
		<g:if test="${flash.message}">
			<div class="alert alert-info">${raw(flash.message)}</div>
		</g:if>
		<g:if test="${flash.error}">
			<div class="alert alert-warning">${flash.error}</div>
		</g:if>
		
		<form action="/bringit/account/search" method="get">
		
			<div style="float:left; margin-right:30px; width:230px;">
				<h2 style="margin-top:0px;">
					Member Search
					<span style="font-size:14px; color:#777; text-transform:none; display:block">Searches by name and username.</span>
				</h2>
			</div>
		

			
			<input type="submit" id="search-button" value="Search" name="search-button" class="btn btn-primary" style="margin-left:10px;float:right;"/>

			
			<input type="text" name="query" class="form-control" style="float:right;width:350px; font-size:18px;" placeholder="name or username"/>
			
			<p class="pull-right" style="margin-top:10px; color:#777">Search for your friends, see who's a member, sign up and compete.</p>
			
		</form>
		
		<br class="clear"/>
		
		

		
	</div>
	
	
	<g:if test="${results}">
		<h1 style="font-size:100px;font-weight:bold; line-height:1.0; margin-top:30px;">${accounts.size()} 
			<span style="display:block;font-weight:normal;font-size:13px;margin-top:10px;color:#999">Results</span>
			
			<g:if test="${accounts.size() == 0}">
				<span style="display:block;font-weight:normal;font-size:14px;margin-top:10px;">Sorry! Try something different</span>
			</g:if>
		</h1>
	</g:if>
	<g:else>
		<h1 style="font-size:100px;font-weight:bold; line-height:1.0; margin-top:70px;">${currentMembers} 
			<span style="display:block;font-weight:normal;font-size:27px;margin-top:10px;color:#999">Current Members</span>
			<span style="display:block;font-weight:normal;font-size:17px;margin-top:10px;">Check to see if anyone you know has an account</span>
		</h1>
	</g:else>	
		
		
		
	<g:if test="${accounts}">
		<span style="font-size:12px;">${accounts.size()} members found</span>
		
		<style type="text/css">
			.table th:nth-child(1){
				width:55px;
			}
			.table th:nth-child(5){
				width:100px;
			}
			.table td{
				font-size:16px;
				vertical-align:middle !important;
				text-align:left !important;
			}
		</style>
		
		<table class="table table-striped table-condensed " style="margin:auto; width:800px;">
			<tr>
				<th></th>
				<th>Username</th>
				<th>Name</th>
				<th>Location</th>
				<th></th>
			</tr>
			<g:each in="${accounts}" var="${account}">
				<tr>
					<td>
					<g:link uri="/public/dashboard/${account.username}">
						<g:if test="${account?.profileImageUrl}">
							<img src="/bringit/${account?.profileImageUrl}" height="50" width="50" title="${account?.name} Profile" alt="${account?.name} Profile">	
						</g:if>
						<g:else>
							<img src="${resource(dir:'images/profile.jpg')}" height="50" width="50" title="${account?.name} Profile" alt="${account?.name} Profile">	
						</g:else>
					</g:link>
					</td>
					<td><g:link uri="/public/dashboard/${account.username}">${account.username}</g:link></td>
					<td><g:link uri="/public/dashboard/${account.username}">${account.name}</g:link></td>
					<td>${account.location}</td>
					<td><g:link uri="/public/dashboard/${account.username}" class="btn btn-default;">View Member</g:link></td>
				</tr>
			</g:each>
		</table>
	
	</g:if>	
	
</div>
				
</body>
</htm>
					

		
