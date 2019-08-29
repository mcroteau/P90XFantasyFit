<html lang="en">
<head>
  	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
 	<meta name="layout" content="fullscreen" />
	<title>P90X Fantasy Fit : Login</title>
</head>
<body>
  
  	<style type="text/css">
  		#manage-outer-container{
			width:350px;
			margin:auto;
			text-align:left;
			padding:30px;
			background:#f2f2f2;
			border:1px solid #e8e8e8;
			-webkit-border-radius: 3px;
			-moz-border-radius: 3px;
			border-radius: 3px;
		}
  	</style>
  
  	<div style="text-align:center">
  
		<div id="manage-outer-container">
    	
			<h2 style="margin:0px auto;">You Were Invited ...</h2>
			
			<strong>Competition :&nbsp;</strong>${competitionInvite.competition.name}
			<br/>
			
			<strong>Message :&nbsp;</strong><br/>
			<p>${competitionInvite.message}</p>
			
			<br/>
			<div class="control-group" style="text-align:center">
			
				<input type="hidden" name="id" value="${competitionInvite.id}"/>
				
				<g:form method="post" id="${competitionInvite.id}">
					<g:actionSubmit class="btn btn-danger" action="decline" value="Decline" id="${competitionInvite.id}"/>
					
					<g:actionSubmit class="btn btn-primary" action="accept" value="Accept" id="${competitionInvite.id}"/>
				</g:form>
				
			</div>
			
			
  		</div>
		
  	</div>
	
	
</body>
</html>
