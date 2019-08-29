<html lang="en">
<head>
  	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
 	<meta name="layout" content="fullscreen" />
	<title>P90X Fantasy Fit : Login</title>
</head>
<body>
  
  	<style type="text/css">
  		#manage-outer-container{
			width:550px;
			margin:auto;
			text-align:left;
		}
		
		#manage-outer-container table td{
			vertical-align:middle;
		}
  	</style>
  
  	<div style="text-align:center">
  
		<div id="manage-outer-container">
    	
			<h2>Competition Invites</h2>
			
			<table class="table table-bordered table-condensed table-striped" style="background:#fff">
				<tr>
					<th>Competition</th>
					<th>Message</th>
					<th></th>
				</tr>
				<g:each in="${pendingInvites}" var="invite">
					<tr>
						<td>${invite.competition.name}</td>
						<td>${invite.message}</td>
						<td class="align-center">
							<g:link controller="competitionInvite" action="manage" id="${invite.id}" class="btn btn-primary">Manage</g:link>
						</td>
					</tr>
				</g:each>
			</table>
			
  		</div>
		
  	</div>
	
	
</body>
</html>
