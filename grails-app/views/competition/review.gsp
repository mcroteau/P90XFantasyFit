<html lang="en">
<head>
  	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
 	<meta name="layout" content="fullscreen" />
	<title>P90X Fantasy Fit : Configure Competition</title>
</head>
<body>
  
  	<style type="text/css">
  		#configure-container{
			width:450px;
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
  
		<div id="configure-container">
    	
   			<h2 style="margin-top:0px">${competition.name} Competition</h2>
			
  			<g:if test="${flash.message}">
   				<div class="alert alert-info">${raw(flash.message)}</div>
  			</g:if>
			
  			<g:if test="${flash.error}">
   				<div class="alert alert-warning">${flash.error}</div>
  			</g:if>

			
			<div class="form-group">
			  	<label for="startDate" style="text-align:right">Starts :&nbsp;</label>
				<g:formatDate date="${competition?.startDate}" format="dd MMM yyyy"/>
			</div>
			
			<div class="form-group">
			  	<label for="endDate" style="text-align:right">Ends :&nbsp;</label>
				<g:formatDate date="${competition?.endDate}" format="dd MMM yyyy"/>
			</div>
			
			
			<g:link action="edit" class="btn btn-default">Edit</g:link>
			
			<g:link controller="competitionInvite" action="search" class="btn btn-primary">Invite Others</g:link>
			
				
			
			<br class="clear"/>
  		</div>
		
  	</div>
	
	
</body>
</html>
