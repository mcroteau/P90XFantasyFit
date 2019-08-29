<%@ page import="org.apache.shiro.SecurityUtils"%>

<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]> <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]> <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]> <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>

	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<title><g:layoutTitle default="P90X Fantasy Fit" /></title>
	<meta name="description" content="Fantasy League Dedicated to P90X where you're the player">
	<meta name="keywords" content="p90x, p90x workout log, online p90x worksheets, p90x worksheets, online p90x workout log, worksheets, p90x schedule, p90x fantasy league, compete p90x">
	<meta name="google-site-verification" content="dgtsZM2rBzzUOkSnuof6MPokYL4UUpH5AQchOBM6A3o" />
	<meta name="author" content="Mike Croteau">
	
	
	<link rel="stylesheet" href="${resource(dir:'bootstrap/3.1.1/css', file:'bootstrap.css')}" />	
    <link rel="stylesheet" href="${resource(dir:'css', file:'app.css')}" />
	

	<script type="text/javascript" src="${resource(dir:'js/lib/jquery/jquery.min.js')}"></script>
	<script type="text/javascript" src="${resource(dir:'bootstrap/3.1.1/js/bootstrap.min.js')}"></script>
	<script type="text/javascript" src="${resource(dir:'js/lib/chartjs/1.0.1-beta.3/', file:'chart.js')}"></script>
	
	
	<g:layoutHead/>
	
</head>
<body>
	
	<div id="app-wrapper">
		
		<div id="top-bar-container">
			<div id="top-bar">				

				<g:link controller="content" action="home" class="logo">
					<img src="${resource(dir:'images/template-logo.png')}"/>
					<span class="label label-danger" style="margin-left:5px; font-size:10px; font-weight:normal;">alpha</span>
				</g:link>
				
				<ul id="top-nav">
					<li><g:link controller="content" action="home">Home</g:link></li>

					<!--
					<sec:ifNotLoggedIn>
						<li><g:link controller="content" action="about">About</g:link></li>
					</sec:ifNotLoggedIn>
					-->
					
					<li><g:link controller="account" action="profile">Profile</g:link></li>
					<li><g:link controller="account" action="member_search">Members</g:link></li>
					
					<sec:ifLoggedIn>
						<li><g:link controller="logout" action="index">Logout</g:link></li>
					</sec:ifLoggedIn>
					<sec:ifNotLoggedIn>
						<li><g:link controller="auth" action="login">Login</g:link>
						<li><g:link controller="account" action="registration">Register</g:link>
					</sec:ifNotLoggedIn>
				</ul>
				<br class="clear"/>
			</div>
		</div>
		
		
		<div id="content-container">
			
			
			<div id="content-inner-container-full">
				
				
				<div id="content-full" style="min-height:400px">
					<g:layoutBody/>
				</div>
				<!-- end of content -->
				
				
			</div>
			<!-- end of content-inner-container -->
			
			
			<br class="clear"/>
			
		</div>
		<!-- end content-container -->
		

		
		<div id="footer-container">
			<div id="footer">
				&nbsp;&copy; 2019 P90X Fantasy Fit
		
				<sec:access expression="hasRole('ROLE_ADMIN')">
					<div style="background:#f2f2f2; border:solid 1px #ddd">
				
						<ul id="admin-nav">
							<li><g:link controller="account" action="list">Accounts</g:link></li>
						</ul>
					
					</div>
				</sec:access>
				
			</div>
		</div>
		
	</div>	


<g:if env="production">
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-40862316-4', 'auto');
  ga('send', 'pageview');

</script>
</g:if>


</body>
</html>
