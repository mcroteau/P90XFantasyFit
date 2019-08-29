<%@ page import="org.apache.shiro.SecurityUtils"%>

<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]> <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]> <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]> <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>

	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<title><g:layoutTitle default="P90X Fantasy Fit" /></title>
	<meta name="description" content="Fantasy League Dedicated to P90X where you're the player">
	<meta name="keywords" content="p90x, p90x workout log, online p90x worksheets, p90x worksheets, online p90x workout log, worksheets, p90x schedule, p90x fantasy league, compete p90x">
	<meta name="google-site-verification" content="dgtsZM2rBzzUOkSnuof6MPokYL4UUpH5AQchOBM6A3o" />
	<meta name="author" content="Mike Croteau">
	
	
	<link rel="stylesheet" href="${resource(dir:'bootstrap/4.2.1/css/bootstrap.css')}" />	
    <link rel="stylesheet" href="${resource(dir:'css', file:'app.css')}" />
	

	<script type="text/javascript" src="${resource(dir:'js/lib/jquery/jquery.min.js')}"></script>
	<script type="text/javascript" src="${resource(dir:'bootstrap/4.2.1/js/bootstrap.min.js')}"></script>
	<script type="text/javascript" src="${resource(dir:'js/lib/chartjs/1.0.1-beta.3/', file:'chart.js')}"></script>
	
	<g:layoutHead/>
	
</head>
<body style="text-align:left;">

	
	<style type="text/css">
		
		.workout-entry{
			background:inherit !important;
		}
		
		.workout-entry input[type="text"]{
			width:45px;
			margin-left:3px;
			display:inline-block;
		}
		
		.workout-entry td{
			border:none !important;
		}
		.col-xs-1, .col-sm-1, .col-md-1, .col-lg-1, .col-xs-2, .col-sm-2, .col-md-2, .col-lg-2, .col-xs-3, .col-sm-3, .col-md-3, .col-lg-3, .col-xs-4, .col-sm-4, .col-md-4, .col-lg-4, .col-xs-5, .col-sm-5, .col-md-5, .col-lg-5, .col-xs-6, .col-sm-6, .col-md-6, .col-lg-6, .col-xs-7, .col-sm-7, .col-md-7, .col-lg-7, .col-xs-8, .col-sm-8, .col-md-8, .col-lg-8, .col-xs-9, .col-sm-9, .col-md-9, .col-lg-9, .col-xs-10, .col-sm-10, .col-md-10, .col-lg-10, .col-xs-11, .col-sm-11, .col-md-11, .col-lg-11, .col-xs-12, .col-sm-12, .col-md-12, .col-lg-12 {
			padding-left:3px;
			padding-right:3px;
			
		}	
	</style>
	
	
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<g:link controller="content" action="home" class="navbar-brand logo" style="display:inline-block; margin-top:10px; margin-left:10px">
			<img src="${resource(dir:'images/template-logo.png')}"/>
			<span class="label label-danger" style="margin-left:5px; font-size:10px; font-weight:normal;">alpha</span>
		</g:link>
	  
	  
	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  </button>

	  <div class="collapse navbar-collapse" id="navbarSupportedContent">
		 <ul class="navbar-nav mr-auto">
			<li><g:link controller="account" action="dashboard">Dashboard</g:link></li>
			<li><g:link controller="competition" action="index">Competition</g:link></li>
			<li><g:link controller="workoutPlan" action="schedule_mobile">Schedule</g:link></li>
			<li><g:link controller="workoutPlan" action="workouts">Workouts</g:link></li>
			<li><g:link controller="workoutPlan" action="plan">Plan</g:link></li>
			<li><g:link controller="account" action="profile_mobile">Profile</g:link></li>
			<sec:ifLoggedIn>
				<li><g:link controller="logout" action="index">Logout</g:link></li>
			</sec:ifLoggedIn>
			<sec:ifNotLoggedIn>
				<li><g:link controller="auth" action="login">Login</g:link>
				<li><g:link controller="account" action="registration">Register</g:link>
			</sec:ifNotLoggedIn>
    	</ul>
	  </div>
	</nav>
	
	<div class="container" style="padding:20px 30px 75px 30px !important;">
		<g:layoutBody/>
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

	
	