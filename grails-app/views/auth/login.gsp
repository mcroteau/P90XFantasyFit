<html lang="en">
<head>
  	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
 	<meta name="layout" content="fullscreen" />
	<title>P90X Fantasy Fit : Login</title>
</head>
<body>
  
  	<style type="text/css">
  		#login-outer-container{
			width:650px;
			margin:auto;
			text-align:left;
			padding:30px;
			background:#f2f2f2;
			background:#fff;
			border:1px solid #e8e8e8;
			border:1px solid #fff;
			-webkit-border-radius: 3px;
			-moz-border-radius: 3px;
			border-radius: 3px;
		}
  	</style>
  
  	<div style="text-align:center">
  
		<div id="login-outer-container">
    	
			<div style="width:300px;float:left; border-right:solid 1px #e8e8e8; padding-right:30px">
			
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
					  	<input type="password" name="password" class="form-control" id="password" >
					</div>
					
					<div class="form-group">
					  	<g:link controller="account" action="forgot">Forgot password?</g:link>
					</div>
					
					<input type="hidden" name="targetUri" value="${targetUri}" />
					<button type="submit" class="btn btn-primary pull-right">Login</button>
					<br class="clear"/>
				</g:form>
			</div>
			
			<div style="float:right; margin-left:20px; width:250px;">
				<h5>Dont have an account?</h5>
				<p>Signup for free and begin tracking your workouts</p>
				<g:link controller="account" action="registration" class="btn btn-default">Register Now</g:link>
			</div>
			
			<br class="clear"/>
  		</div>
		
  	</div>
	
	
</body>
</html>
