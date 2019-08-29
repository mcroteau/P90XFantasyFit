<html lang="en">
<head>
  	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
 	<meta name="layout" content="mobile" />
	<title>P90X Fantasy Fit : Select Version Plan</title>
</head>
<body>
  
  	<div class="row">
		<div class="col-md-12">
			<g:if test="${flash.message}">
				<div class="alert alert-info">${raw(flash.message)}</div>
			</g:if>	
		</div>
	</div>
	
	<div class="row">
	
		<div class="col-md-12">
		
			<h2 style="margin-top:0px;">Select a Version</h2>
			
			<div class="col-md-3 col-sm-3">
				<div class="well">
	    			<h2 style="margin-top:0px;">P90X</h2>
					<p>The popular and the original video series.  Contains 12 Videos</p>
					<g:link action="selectPlan" params="[planVersion:'one']" class="btn btn-primary">Select Version &nbsp;&#xBB;</g:link>
				</div>
			</div>	
			
			<div class="col-md-3 col-sm-3">
				<div class="well">
	    			<h2 style="margin-top:0px;">P90X2</h2>
					<div class="version-description">
						<p>The second installment of the series.   Contains 12 Videos</p>
					</div>
					<p class="label label-info">In Development</p>
					<!--
					<g:link action="selectPlan" params="[planVersion:'two', planName:"P90X2"]" class="btn btn-default">Select Version</g:link>
					-->
				</div>
			</div>
			
			<div class="col-md-3 col-sm-3">
				<div class="well">
	    			<h2 style="margin-top:0px;">P90X3</h2>
					<div class="version-description">
						<p>Final video series. Each workout is only 30mins long. 16 Videos</p>
					</div>
					
					<p class="label label-info">In Development</p>
					<!--
					<g:link action="selectPlan" params="[planVersion:'three', planName:"P90X3"]" class="btn btn-default">Select Version</g:link>
					-->
				</div>
			</div>		
				
		</div>
		
  	</div>
  	
</body>
</html>
