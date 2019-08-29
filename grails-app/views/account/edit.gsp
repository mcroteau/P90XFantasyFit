<%@ page import="org.motus.Account" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="fullscreen">
		<g:set var="entityName" value="${message(code: 'account.label', default: 'Account')}" />
		<title>P90X Fantasy Fit</title>
	</head>
	<body>
	
	<div style="text-align:center">
	
		<div id="edit-account"  style="width:500px; margin:0px auto; text-align:left;">

			<h2 style="margin-top:0px; text-align:center">Edit Profile</h2>
			
			<g:if test="${flash.message}">
				<div class="alert alert-info" role="status">${raw(flash.message)}</div>
			</g:if>
				
			<g:if test="${flash.error}">
				<div class="alert alert-info" role="status">${flash.error}</div>
			</g:if>
			
			
			<g:hasErrors bean="${accountInstance}">
				<ul class="errors" role="alert">
					<g:eachError bean="${accountInstance}" var="error">
					<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
					</g:eachError>
				</ul>
			</g:hasErrors>
			
			
			<g:uploadForm method="post" >
			
				<div class="form-group" style="text-align:center">
					
					<div id="profile-pic" style="margin:auto;">
						<g:if test="${accountInstance?.profileImageUrl}">
							<img src="/bringit/static/${accountInstance?.profileImageUrl}" height="200" width="200" style="margin:auto" title="${accountInstance?.name} Profile" alt="${accountInstance?.name} Profile">	
						</g:if>
						<g:else>
							<img src="${resource(dir:'images/profile.jpg')}" height="200" width="200"  style="margin:auto" alt="${account?.name} Profile">	
						</g:else>
					</div>
					
					<br/>
					<input type="file" name="image" id="image" style="margin:auto"/>	
					
				</div>
			
				<g:hiddenField name="id" value="${accountInstance?.id}" />
				<g:hiddenField name="version" value="${accountInstance?.version}" />
				
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				
				<div style="width:500px; margin:auto; text-align:center">
					<g:actionSubmit class="save" action="update" value="Update Account" class="btn btn-primary"/>
				</div>
			</g:uploadForm>
		</div>
	</div>

	
	</body>
</html>
