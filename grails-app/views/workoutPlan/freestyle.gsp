<html lang="en">
<head>
  	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
 	<meta name="layout" content="fullscreen" />
	<title>P90X Fantasy Fit : Select Workout Plan</title>
		
	<script type="text/javascript" src="${resource(dir:'js/lib/moment/2.4.0/moment.min.js')}"></script>
	
	
</head>
<body>
  
	
	<style type="text/css">
		h2 .label{
			margin-top:8px;
			font-size:11px;
		}
	</style>
	
	<div style="text-align:center">
	
		<div style="margin:auto; width:370px;" class="well">
			
			<g:if test="${flash.message}">
				<div class="alert alert-info">${raw(flash.message)}</div>
			</g:if>				
			<g:if test="${flash.error}">
				<div class="alert alert-danger">${flash.error}</div>
			</g:if>
			
			<g:form action="save_freestyle" method="post">
			
				<h2 style="margin-top:0px">Freestyle Plan Setup</h2>

				<p>Give your plan a title:<br/>
					<input type="text" name="title" value="" class="form-control" style="width:300px; margin:10px auto 20px auto;" placeholder="e.g. Fit for Summer"/>
				</p>

				
				<input type="submit" class="btn btn-primary btn-block" value="Start Plan"/>
			</g:form>
			
		</div>
	
		<div class="col-md-6">
		</div>
	
		
  	</div>
	
</body>
</html>
