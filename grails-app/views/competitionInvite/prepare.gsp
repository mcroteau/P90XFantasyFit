<html lang="en">
<head>
  	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
 	<meta name="layout" content="fullscreen" />
	<title>P90X Fantasy Fit : Prepare Invite</title>
</head>
<body>
  
  	<style type="text/css">
  		#prepare-outer-container{
			width:375px;
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
  
		<div id="prepare-outer-container">
    	
	
			<h2 style="margin-top:0px">Competition Invite</h2>
		
  			<g:if test="${flash.message}">
   				<div class="alert alert-info">${raw(flash.message)}</div>
  			</g:if>
			
  			<g:if test="${flash.error}">
   				<div class="alert alert-warning">${flash.error}</div>
  			</g:if>
			
			<g:hasErrors bean="${competitionInvite}">
				<div class="alert alert-warning">
					<ul class="errors" role="alert">
						<g:eachError bean="${competitionInvite}" var="error">
						<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
						</g:eachError>
					</ul>
				</div>
			</g:hasErrors>
			
			<g:form controller="competitionInvite" action="invite" id="${competition.id}" method="post">
				
				<input type="hidden" name="memberId" value="${member.id}"/>
				<input type="hidden" name="accountId" value="${account.id}"/>
				 
				<p><strong style="width:100px; text-align:right; margin-right:10px; display:inline-block;">Competition :&nbsp;</strong>${competition.name}</p>
				<p><strong style="width:100px; text-align:right; margin-right:10px; display:inline-block;">User :&nbsp;</strong>${member.username}</p>
				
				<p><strong>Message :&nbsp;</strong></p>
				
				<g:if test="${competitionInvite?.message}">
					<g:set var="message" value="${competitionInvite?.message}" />
				</g:if>
				<g:else>
					<g:set var="message" value="Hi ${member.username}, please join my competition" />
				</g:else>

				<textarea name="message" class="form-control" rows="5">${message}</textarea>
				
				<br/>
				
				<input type="submit" value="Send Invite" class="btn btn-primary pull-right"/>
				
				<br class="clear"/>
				
			</g:form>
			
  		</div>
		
  	</div>
	
	
</body>
</html>
