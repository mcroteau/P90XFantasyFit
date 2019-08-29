<%@ page import="org.motus.Account" %>
<html lang="en">
<head>
 	<meta name="layout" content="main" />
	<title>P90X Fantasy Fit : ${accountInstance.username}</title>
</head>
<body>
  
	<div class="row">
	
		<div class="col-md-5">
		
  			<g:if test="${flash.message}">
    			<div class="alert alert-warning">${raw(flash.message)}</div>
  			</g:if>

			
			<h1>${accountInstance.username}</h1>
			
			<h3>${accountInstance.name}</h3>
			
			<h4>${accountInstance.age}</h4>
			
			<h5># Motivators : ${accountInstance.motivators.size()}
			
			<p># workouts completed : ${workoutsCompleted}</p>
			
			<p># plans completed : ${plansCompleted}</p>
			
			<p>#workouts skipped : ${workoutsSkipped}</p>
			
			<p>Member since : ${accountInstance.dateCreated}</p>
			
			<p>Last seen : ${lastSeen}</p>
			
			<p># Followers : ${followers}</p>
			
			<p>Max Pull ups : ${maxPullups} : ${maxPullupsWorkout}</p>
			
			<p>Max Pus ups : ${maxPushups} : ${maxPushupsWorkout}</p>
			
			
			<g:if test="${shiro.principal() != accountInstance?.username}">
			
				<g:if test="${!motivator}">
					<g:form controller="accountMotivator" action="request_motivate_form">
						<input type="hidden" name="username" value="${accountInstance.username}"/>
						<input type="submit" class="btn btn-info" value="Motivate">
					</g:form>
				</g:if>
				<g:elseif test="${motivator.status == "PENDING"}">
					<h2>Request to motivate pending</h2>
				</g:elseif>
				<g:elseif test="${motivator.status == "APPROVED"}">
					<h2>Motivator</h2>
				</g:elseif>
				
			</g:if>
			
		</div>
		
  	</div>
  	
</body>
</html>
