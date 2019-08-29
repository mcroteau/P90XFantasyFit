<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>P90X Fantasy Fit: Home</title>
	</head>
	<body>
	

		<style type="text/css">
			.home-content h1{
				font-size:48px;
			}
			
			p.home-large{
				font-size:18px;
			}
			
			p.home-large{
				margin:20px auto;
			}
			.btn-lg{
				font-size:16px !important;
			}
			.home-content{
				width:930px; margin:auto;
			}
		</style>
		
			
		<div class="home-content" style="margin-bottom:100px">
			
			<div style="text-align:center;padding-top:50px;">
				
				
				<sec:ifLoggedIn>
					<h1>Welcome Back <sec:username/>! <br/>You ready to Bring It!?</h1>
				</sec:ifLoggedIn>
				<sec:ifNotLoggedIn>
					<h1>Fantasy League Dedicated to P90X where you're the player</h1>
				</sec:ifNotLoggedIn>
				
				<p class="home-large" style="margin:auto;margin-bottom:30px; width:750px"><strong>P90X Fantasy Fit</strong> allows you to create 90 Day workout plans, log P90X workouts earning points as you go... workout alone or compete with friends by starting a competition</p>
				
				<div style="">
					
					<img src="static/images/home-competition-screen.png" style="float:left; margin-top:30px;"/>
					
					<div style="width:260px; float:right; text-align:center">
						<img src="static/images/home-logo-badge.png" style="margin:0px auto"/>
						
						<div style="text-align:left; margin-top:20px;">

	
							<sec:ifLoggedIn>
								<g:link controller="account" action="dashboard" class="btn btn-primary btn-lg">Take me to my Dashboard</g:link>
								
								<p style="margin-top:10px; margin-bottom:20px; font-size:13px; color:#777">Back for more I see!?!??</p>
								
                			</sec:ifLoggedIn>
				
							<sec:ifNotLoggedIn>
								<g:link controller="account" action="registration" class="btn btn-primary btn-lg">Register & Start Competing Now!</g:link>
								
								<p style="margin-top:10px; margin-bottom:20px; font-size:13px; color:#777">* Only accepting a limited number of registrations for alpha release</p>
								
                            	
								<g:link controller="auth" action="login" class="btn btn-default">Already a Member? Log In</g:link>
							</sec:ifNotLoggedIn>
						
						</div>
					</div>
					
					<br class="clear"/>
				</div>
				
			</div><!-- end of home top -->
		</div>	
			
			
			
			
		<div id="based-p90x" style="text-align:center; background:#f8f8f8; border:solid 1px #ddd; padding-top:45px; padding-bottom:75px; margin:100px auto">
				
			<div class="home-content">
				
				<img src="static/images/home-p90x-workout.png" style="float:left"/>
				
				<div style="float:right; width:360px; text-align:left">
					
					<h1>Based on P90X</h1>
				
					<p class="home-large" style="margin-bottom:20px;">P90X is probably the best workout program ever developed, why deviate.   All of the first P90X workouts are available.  Choose from <strong>Classic</strong>, <strong>Lean</strong> or <strong>Doubles</strong></p>
        		
					<p class="home-large">If you haven't already tried P90X, give it a try!</p>
					
        			<div style="text-align:center">
						<a href="http://www.beachbody.com/product/fitness_programs/p90x.do" target="_blank" class="btn btn-primary" style="margin:auto">Visit P90X Website</a>
					</div>
				</div>
				
				<br class="clear"/>
			</div>
		
		</div>
		
		
		
		
		<div style="text-align:center;margin:100px auto">
		
			<div class="home-content">
				
				<div style="width:400px; text-align:left; float:left">
					<h1>Cross-Browser Capatible</h1>
					
					<p class="home-large">P90X Fantasy Fit was developed to work on all modern browsers. Use your laptop, tablet or mobile phone to log workouts</p>
				</div>
				
				<img src="static/images/home-cross-browser.png" style="float:right"/>
				
				<br class="clear"/>
			</div>
		
		</div>
		
		
			
		<div id="based-p90x" style="text-align:center; background:#f2f2f2; border:solid 1px #ddd; padding-top:35px; padding-bottom:75px; margin:50px auto">
			
			<div class="home-content">
				
				<div style="width:530px; float:left; text-align:left">
					
					<h1>Motivation Notifications</h1>
					
					<p class="home-large" style="margin-top:20px;margin-bottom:20px">Recieve either text or email notifications when a competitor logs a workout.</p>  

					<p class="home-large" style="margin-bottom:20px">Why would I want this?  Simple, it serves as a reminder and to hold yourself accountable for your commitment to win...</p>

					<p class="home-large">Dont like it?  Easily turn off notifications</p>
				
				</div>
				
				<img src="static/images/home-motivation-notifications.png" style="float:right"/>
				
				<br class="clear"/>
					
			</div>
			
		</div>
		
		
		
		<div style="margin:70px auto 100px auto">
		
			<div class="home-content">
			
				<h1 style="margin-bottom:30px;">Action Based Point System</h1>
				
				<div style="text-align:center">
					
					<div style="width:650px; margin:auto;">
						<div style="width:300px;float:left; text-align:left;">
							<p class="home-large">Keep it simple, earn points based on your actions, not on performance so you can compete with anyone at any fitness level.</p>
                    	
							<p class="home-large" style="margin-top:30px;">See Point System breakdown for more information</p>
						</div>

						<g:link controller="account" action="registration" class="btn btn-primary btn-lg">Register & Start Competing Now!</g:link>
						
						<br class="clear"/>
					</div>
					
				</div>
				
			</div>
			
		</div>
		
		
	</body>
</html>
