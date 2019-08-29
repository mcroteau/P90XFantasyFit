<%@ page import="org.motus.common.PhotoType" %>

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="fullscreen">
		<title>P90X Fantasy Fit : Progress Photos</title>
	</head>
	<body>
	
		<div style="text-align:center">
			
			<div style="width:500px; margin:10px auto; text-align:left">
			
				<h1>${workoutPlan.title} : Progress Photos</h1>
				<p>The site is optimized for photos that are <strong>240 pixels by 300 pixels</strong>.  Please edit photos to meet minimum size requirements.</p>
				
				<g:if test="${flash.message}">
					<div class="alert alert-info" role="status">${raw(flash.message)}</div>
				</g:if>
				
				<g:uploadForm action="upload_photo" method="post" >
				
					<input type="hidden" name="id" value="${workoutPlan.id}"/>
					
					<style type="text/css">
						.photo-type{
							font-size:16px;
							margin:5px 20px 5px auto;
							display:inline-block;
						}
					</style>
					
					
					<div class="form-group">
						<span class="photo-type">Day 1&nbsp;<input type="radio" name="type" value="${PhotoType.BEFORE.description()}" checked="true"></span>
						<span class="photo-type">30 Day&nbsp;<input type="radio" name="type" value="${PhotoType.THIRTY_DAY.description()}"></span>
						<span class="photo-type">60 Day&nbsp;<input type="radio" name="type" value="${PhotoType.SIXTY_DAY.description()}"></span>
						<span class="photo-type">90 Day&nbsp;<input type="radio" name="type" value="${PhotoType.NINETY_DAY.description()}"></span>
					</div>
					
					
		
					<div class="form-group">
						<input type="file" name="image" id="image" />	
					</div>
					
					
					<div class="form-group" style="margin-top:20px;">	
						<g:link controller="account" action="profile" class="btn btn-default">Cancel</g:link>
						<g:submitButton class="btn btn-primary" value="Upload Photo" name="upload"/>
					</div>
					
				</g:uploadForm>
				
				<g:if test="${progressPhotos.size() > 0}">
					<table class="table">
						<thead>
							<tr>	
								<th></th>
								<th>Day</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<g:each in="${progressPhotos}" status="i" var="photoInstance">
							<tr>
								<td>
									<a href="/bringit/${photoInstance.imageUrl}">
										<img src="/bringit/${photoInstance.thumbImageUrl}"/>
									</a>
								</td>
								<td>${photoInstance.type}</td>
								<td>
									<g:link action="remove_photo" class="btn btn-default" id="${photoInstance.id}">Remove</g:link>
								</td>
							</tr>
							</g:each>
						</tbody>
					</table>
				</g:if>
			</div>
		</div>
	</body>
</html>
