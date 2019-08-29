<html lang="en">
<head>
  	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
 	<meta name="layout" content="mobile" />
	<title>P90X Fantasy Fit : Login</title>
</head>
<body>
  

  
  	<div class="row">
  
		<div class="col-md-12" style="margin-bottom:50px">
    	
			
   			<h2 style="margin-top:0px">Sign In</h2>
			
			
  			<g:if test="${flash.message}">
   				<div class="alert alert-info">${raw(flash.message)}</div>
  			</g:if>
			
  			<g:if test="${flash.error}">
   				<div class="alert alert-warning">${flash.error}</div>
  			</g:if>
			
			
			<g:form controller="login" action="authenticate" class="form">
				<div class="form-group">
				  	<label for="username">Username</label>
				  	<input type="text" name="username" class="form-control" id="username" placeholder="" value="${username}">
				</div>
				<div class="form-group">
				  	<label for="password">Password</label>
				  	<input type="password" name="password" class="form-control" id="password">
				</div>
				
				<div class="form-group">
				  	<g:link controller="account" action="forgot">Forgot password?</g:link><br/>
					<g:link controller="account" action="registration">Register Now</g:link>
				</div>
				
				<input type="hidden" name="targetUri" value="${targetUri}" />
				<button type="submit" class="btn btn-primary pull-right">Login</button>
				<br class="clear"/>
			</g:form>
			

  		</div>
		
  	</div>
	
	
</body>
</html>
