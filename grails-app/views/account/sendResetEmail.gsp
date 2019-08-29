<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="fullscreen" />
	<title>P90X Fantasy Fit : Reset Password</title>
</head>
<body>
	

<div class="row">

	<div class="col-md-12">	
	
		<h2 style="margin-top:0px;">Email Confirmation Sent</h2>
		
		<g:if test="${flash.message}">
			<div class="alert alert-info">${raw(flash.message)}</div>		
    	</g:if>
    	
		<g:if test="${flash.error}">
			<div class="alert alert-warning">${flash.error}</div>		
    	</g:if>
		

	
		<div id="reset-form">
	
			<div class="resetForm">
				<p class="large inactive">
					<em>1. Enter Email</em><br/>
				</p>
				<p class="large">
					<em>2. Verify Email</em><br/>
					
					Successfully sent reset password email. <br/>Please check the email address entered for instructions on how to continue the password reset process.
				</p>
				<p class="large inactive">
					<em>3. Reset Password</em><br/>
				</p>
			</div>

	
		</div>
		
		<br class="clear"/>
	</div>
</div>
	
</body>
</html>
