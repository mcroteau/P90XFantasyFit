<html lang="en">
<head>
    <meta name="layout" content="fullscreen" />
	<title>P90X Fantasyrd</title>
</head>
<body>

	<div class="row">
	
		<div class="col-md-12">
		
			<h2 style="margin-top:0px;">Reset Password</h2>
		
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
					<p class="large inactive">
						<em>2. Verify Email</em><br/>
					</p>
					<p class="large ">
						<em>3. Reset Password</em><br/>
					</p>
					
					<p>Reseting password for <strong>${username}</strong></p>
		            <g:form action="resetPassword" method="post" >
						<p>
		            		<label for="password">New Password</label>
		            		<input type="password" name="password" id="password" value="" class="form-control" style="width:250px" placeholder="****">
		            	</p>
						<p>
			        		<label for="passwordRepeat">Confirm Password</label>
			        		<input type="password" name="passwordRepeat" id="passwordRepeat" value="" class="form-control" style="width:250px" >
			        	</p>
						<input type="hidden" name="uuid" value="${uuid}"/>
						<input type="hidden" name="username" value="${username}"/>
						
						<input type="submit" value="Reset Password" class="btn btn-primary"/>
						
					</g:form>
					
				</div>
			</div>
		</div>
	</div>
	

</body>
</html>
