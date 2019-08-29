<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="fullscreen" />
	<title>P90X Fantasy Fit : Reset Password</title>
</head>

<body>

<div class="row">

	<div class="col-md-12">

		<h2 style="margin-top:0px;">Begin Password Reset Process</h2>
    	
		<g:if test="${flash.message}">
			<div class="alert alert-info">${raw(flash.message)}</div>		
    	</g:if>
    	
		<g:if test="${flash.error}">
			<div class="alert alert-warning">${flash.error}</div>		
    	</g:if>
		
    	
		
		<div id="reset-form">
    	
			<g:form action="sendResetEmail" method="post" >
    	
				<div class="resetForm">
				
					<p class="large">
						<em class="highight">1. Enter Email</em><br/>
						An email will be sent to this address with instructions on how to continue reset process
						<input type="email" value="" class="form-control" id="email" name="email" style="width:250px;"/>
					</p>
					
					<p class="large inactive">
						<em>2. Verify Email</em><br/>
						<span class="small">An email will be sent to this address with instructions on how to continue reset process</span>
					</p>
					
					<p class="large inactive">
						<em>3.  Reset Password</em><br/>
					</p>
    	    	
				</div>
				
				<input type="submit" value="Start Reset Process" class="btn btn-primary"/>
				
			</g:form>
    	
		</div>
    	
		<br class="clear"/>
		
	</div>
    	
</div>


	
</body>
</html>
