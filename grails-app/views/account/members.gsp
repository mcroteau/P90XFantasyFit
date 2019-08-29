<%@ page import="org.motus.Account" %>
<html lang="en">
<head>
 	<meta name="layout" content="main" />
	<title>P90X Fantasy Fit : Search Members</title>
</head>
<body>
  
		
	<g:if test="${flash.message}">
		<div class="alert alert-info">${raw(flash.message)}</div>
	</g:if>
	
	<g:if test="${flash.error}">
		<div class="alert alert-warning">${flash.error}</div>
	</g:if>
	
	
	<div class="">
		<h2>Member Search</h2>
	</div>
	
	
</body>
</html>
