<html lang="en">
<head>
 	<meta name="layout" content="fullscreen" />
	<title>P90X Fantasy Fit : Registration</title>
</head>
<body>

	<style type="text/css">
		#registration_form{
			width:450px; 
			margin:auto; 
			padding:30px; 
			background:#f2f2f2; 
			border:1px solid #e8e8e8;
			-webkit-border-radius: 3px;
			-moz-border-radius: 3px;
			border-radius: 3px;
		}
	</style>
	
	<div id="registration_form">
	
		<h2 style="margin-top:0px">P90X Fantasy Fit Registration</h2>
			
		<p style="font-size:12px;color:#b3322e">* Note :&nbsp; This is a <strong>"alpha"</strong> release of the <strong>P90X Fantasy Fit</strong> app and is currently under development.  There will be issues, in addition all data is liable to be lost.  Use at your own risk.</p>
		
		<p style="font-size:12px; color:#b3322e">The site was developed independently is not affiliated with Beachbody</p>
		
		<p style="font-size:12px;color:#b3322e">Please feel free to contact us at <strong><a href="mailto:croteau.mike@gmail.com" style="font-size:12px;color:#b3322e">croteau.mike@gmail.com</a></strong> for questions and comments.  Feedback encouraged</p>
			
		<g:if test="${flash.message}">
			<div class="alert alert-info">${raw(flash.message)}</div>
		</g:if>
		
		<g:if test="${flash.error}">
			<div class="alert alert-warning">${raw(flash.error)}</div>
		</g:if>
	
		<g:hasErrors bean="${accountInstance}">
			<div class="alert alert-danger">
			<ul class="errors" role="alert">
				<g:eachError bean="${accountInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</div>
		</g:hasErrors>
		
		
		
		<g:form action="register" class="form">
		
			<div class="alert alert-warning" id="match-alert" style="display:none">Passwords Don't Match</div>
			<div class="alert alert-warning" id="length-alert" style="display:none">Passwords Must be at least 5 characters long</div>
		
			<div class="form-group">
			  	<label for="username">Username</label>
			  	<input type="text" name="username" class="form-control" id="username" placeholder="" value="${accountInstance?.username}">
			</div>
			<div class="form-group">
			  	<label for="email">Email Address</label>
			  	<input type="text" name="email" class="form-control" id="email" placeholder="" value="${accountInstance?.email}">
			</div>
			
			
			<div class="form-group">
			  	<label for="password">Password</label>
			  	<input type="password" name="password" class="form-control" id="password" placeholder="*****">
			</div>
			<div class="form-group">
			  	<label for="passwordRepeat">Re-Enter Password</label>
			  	<input type="password" name="passwordRepeat" class="form-control" id="passwordRepeat" placeholder="*****">
			</div>
			
			<div class="form-group">
				<button type="submit" class="btn btn-primary pull-right" id="register">Register</button>
			</div>
			
			<br class="clear"/>
			
		</g:form>
		
	</div>
	
			
<script type="text/javascript">
	$(document).ready(function(){
		var $password = $('#password'),
		    $passwordRepeat = $('#passwordRepeat'),
			$matchAlert = $('#match-alert')
			
		$passwordRepeat.blur(validatePasswords)
		
		function validatePasswords(data){
			console.log($password.val(), $passwordRepeat.val())
			if($password.val() == $passwordRepeat.val()){
				$matchAlert.hide();
			}else{
				$matchAlert.show();
			}
		
		}
		
	
	})
</script>
  	
</body>
</html>
