<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="fullscreen">
	<title>P90X Fantasy Fit : Confirm Stop</title>

</head>
<body>
	
	<style type="text/css">
		.confirmStopContainer{
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

	<div class="row" style="text-align:center">
	
		<div class="confirmStopContainer">
		
			<h2 style="margin-top:0px">Confirm Stop Competition</h2>
			
			<p>Are you sure you want to stop <strong>${competition.name}</strong> competition?</p>
			
			<p>This cannot be undone!</p>
			
			<p>Once stopped, you will be able to start or join a new competition</p>
			
			<br/>
			
			<g:form controller="competition" action="stop" method="post">
				<input type="hidden" name="id" value="${competition.id}"/>
				<g:link action="index" class="btn btn-default">Cancel</g:link>
				<input type="submit" class="btn btn-danger" value="Go ahead, Stop Competition"/>
			</g:form>
		</div>

	</div>


</body>
</html>
