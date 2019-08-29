<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mobile">
		<title>P90X Fantasy Fit : Home</title>
	</head>
	<body>
	
		<style type="text/css">
			.wrapper{
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
		
		<div class="row">
			
			<div class="col-md-12 wrapper">
				<h2 style="margin-top:0px;">Welcome to P90X Fantasy Fit </h2>
				<p>This is the pre-beta release.</p>
				
				<sec:ifLoggedIn>
					Welcome Back <sec:username/>!

					<g:link controller="account" action="dashboard" class="btn btn-default">Dashboard</g:link>
				</sec:ifLoggedIn>
				<sec:ifNotLoggedIn>
				<g:link controller="auth" action="login" class="btn btn-default">Login</g:link>
				<g:link controller="account" action="registration" class="btn btn-primary">Register</g:link>
				</sec:ifNotLoggedIn>
			</div>
		
		</div>
	</body>
</html>
