<html lang="en">
<head>
  	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
 	<meta name="layout" content="fullscreen" />
	<title>P90X Fantasy Fit : Select Version Plan</title>
</head>
<body>

	<style type="text/css">
		.version{
			width:200px;
			float:left;
			margin:10px 20px;
		}
		.version .well{
			height:175px;
		}
		.version h2{
			margin-top:0px;
		}
		.version-description{
			height:70px;
		}
	</style>
	
	<div style="text-align:center">
		<div style="width:750px; margin:auto;">
			
			<h2 style="margin-top:0px">Select a Version</h2>
			
			<g:if test="${flash.message}">
				<div class="alert alert-info">${raw(flash.message)}</div>
			</g:if>
			
			<div class="version">
				<div class="well">
	    			<h2>P90X</h2>
					<div class="version-description">
						<p>The wildly popular and the original video series.  Contains 12 Videos</p>
					</div>
					
					<a href="${g.createLink(action:'selectPlan', params : [planVersion:'one', planName:"P90X"])}" id="one" class="btn btn-primary">Select Version &nbsp;&#xBB;</a>
					
					<!--
					<g:link action="selectPlan" params="[planVersion:'one', planName:"P90X"]" class="btn btn-primary">Select Version &nbsp;&#xBB;</g:link>
					-->
				</div>
			</div>	
			
			<div class="version">
				<div class="well">
	    			<h2>P90X2</h2>
					
					<div class="version-description">
						<p>The second installment of the series.   Contains 12 Videos</p>
					</div>
					<p class="label label-info">In Development</p>
					<!--
					<g:link action="selectPlan" params="[planVersion:'two', planName:"P90X2"]" class="btn btn-default">Select Version</g:link>
					-->
					
				</div>
			</div>
			
			<div class="version">
				<div class="well">
	    			<h2>P90X3</h2>
					
					<div class="version-description">
						<p>Final video series. Each workout is only 30mins long. 16 Videos</p>
					</div>
					
					<p class="label label-info">In Development</p>
					<!--
					<g:link action="selectPlan" params="[planVersion:'three', planName:"P90X3"]" class="btn btn-default">Select Version</g:link>
					-->
					
				</div>
			</div>	
				
			<div class="version">
				<div class="well">
	    			<h2>Freestyle</h2>
					
					<div class="version-description">
						<p>No Schedule, pick and choose workouts as you go...</p>
					</div>
					
					<!--<p class="label label-info">In Development</p>-->
					
					
					<a href="${g.createLink(action:'freestyle')}" id="freestyle" class="btn btn-primary">Select Version &nbsp;&#xBB;</a>
					
				</div>
			</div>		
			<br class="clear"/>
			
		</div>
		
  	</div>
  	
</body>
</html>
