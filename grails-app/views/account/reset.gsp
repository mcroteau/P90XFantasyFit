<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
	<title>P90X Fantasy Fit : Reset Password</title>
</head>
<body>


<div class="row">

	<div class="col-md-12">
	
		<h1>Reset Password</h1>
		<g:if test="${flash.message}">
			<div class="message info" id="">
				<span class="header"></span>
				<span class="messageDetails">
			    	${raw(flash.message)}
				</span>
			</div>		
	    </g:if>

	
		<div class="resetWrapper notes">
		
			<div class="resetForm">
				<p class="large inactive">
					<em class="highight">Step One : Enter Email</em><br/>
				</p>
				<p class="large inactive">
					<em>Step Two : Verify Email</em><br/>
				</p>
				<p class="large ">
					<em>Step Three : Reset Password</em><br/>
				</p>
				
	            <form id="resetPasswordForm" name="resetPasswordForm" action="resetPassword" method="post" >
					<p>
	            		<label for="password">New Password</label>
	            		<input type="password" name="password" id="password" value="" >
	            	</p>
					<p>
		        		<label for="username">Confirm Password</label>
		        		<input type="password" name="confirmPassword" id="confirmPassword" value="" >
		        	</p>
					<input type="hidden" value="${username}" name="username"/>
					<div class="buttons">
						<a href="#" id="reset" class="button small blue">Reset Password</a>
					</div>
				</form>
				
			</div>

	
		</div>
		
		<br class="clear"/>
		
	</div>
	
</div>


</body>
</html>
