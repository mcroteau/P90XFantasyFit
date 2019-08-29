<html lang="en">
<head>
  	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
 	<meta name="layout" content="fullscreen" />
	<title>P90X Fantasy Fit : Configure Competition</title>
</head>
<body>
  
  	<style type="text/css">
  		#configure-container{
			width:450px;
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
  
  	<div style="text-align:center">
  
		<div id="configure-container">
    	
   			<h2 style="margin-top:0px">Setup Competition</h2>
		
			
  			<g:if test="${flash.message}">
   				<div class="alert alert-info">${raw(flash.message)}</div>
  			</g:if>
			
  			<g:if test="${flash.error}">
   				<div class="alert alert-warning">${flash.error}</div>
  			</g:if>
			
			<g:hasErrors bean="${competition}">
				<div class="alert alert-warning">
					<ul class="errors" role="alert">
						<g:eachError bean="${competition}" var="error">
						<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
						</g:eachError>
					</ul>
				</div>
			</g:hasErrors>
			
			
			<g:form action="save" class="form">
			
				<div class="form-group">
					<p>Give your Competition a Name:<br/></p>
				  	
					<input type="text" name="name" class="form-control" id="name" placeholder="eg. Arizona Jigganauts Season 1" value="${competition?.name}">
					
				</div>
				
				<div class="form-group">
				  	<label for="startDate" style="display:inline-block; width:100px;text-align:right; margin-right:10px;">Start Date</label>
					<g:datePicker value="${competition?.startDate}" precision="day" name="startDate"/>
				</div>
				
				<div class="form-group">
				  	<label for="endDate" style="display:inline-block; width:100px;text-align:right;margin-right:10px;">End Date</label>
					<g:datePicker value="${endDate}" precision="day" name="endDate"/>
				</div>
				
				<p style="font-size:11px; color:#777"><strong>* </strong> You are only allowed to participate in <strong>1</strong> competition at a time.</p>
				
				<p style="font-size:11px; color:#777"><strong>* </strong> Competitions cannot be deleted once started.</p>
				
				
				 
				<button type="submit" class="btn btn-primary pull-right">Save Competition</button>
				<br class="clear"/>
			</g:form>
			
			<br class="clear"/>
  		</div>
		
  	</div>
	
	
</body>
</html>
