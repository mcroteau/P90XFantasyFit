<%@ page import="org.apache.shiro.SecurityUtils"%>
<%@ page import="org.motus.common.PhotoType"%>

<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="fullscreen-menu">
	
	<title>P90X Fantasy Fit : Photos</title>
	
</head>
<body>

	<g:if test="${flash.message}">
		<div class="alert alert-info">${raw(flash.message)}</div>
	</g:if>
	<g:if test="${flash.error}">
		<div class="alert alert-warning">${flash.error}</div>
	</g:if>

				
					
	<style type="text/css">
		h2 .large{
			display:block;
			font-size:30px;
			font-family:Roboto-Thin;
		}
	</style>

	
	<g:if test="${workoutPlan}">
	
		<h2 style="float:left;"><span class="large">${account.name}</span> ${workoutPlan.title} Progress Photos</h2>
		
		<div class="dropdown" style="float:right; margin-top:20px">
			<button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown">
			  	Select Workout Plan
				<span class="caret"></span>
			</button>
			<ul class="dropdown-menu dropdown-menu-right" role="menu" aria-labelledby="dropdownMenu1">
				<g:each in="${workoutPlanList}" status="i" var="workoutPlan"> 
					<li role="presentation">
						<g:link controller="workoutPlan" action="photos" id="${workoutPlan.id}">${workoutPlan.title}</g:link>
					</li>
				</g:each>
			</ul>
		</div>
		<br class="clear"/>
		
					
		<g:if test="${beforePhotos.size() > 0}">
		
			<p class="instructions">To compare progress photos, select a photo from each section, Day 1, 30 Days, 60 Days and 90 Days.  </p>
			
			<div class="photo-container" style="text-align:center; float:left; margin-right:5px">
				<h3>Day 1</h3>
				<img src="/bringit/images/placeholder.jpg" height="300px" width="240px" id="1-day-photo"/>
			</div>
			
			
			<div class="photo-container" style="text-align:center; float:left; margin-right:5px">
				<h3>30 Day</h3>
				<img src="/bringit/images/placeholder.jpg" height="300px" width="240px" id="30-day-photo"/>
			</div>
			
			
			<div class="photo-container" style="text-align:center; float:left; margin-right:5px">
				<h3>60 Day</h3>
				<img src="/bringit/images/placeholder.jpg" height="300px" width="240px" id="60-day-photo"/>
			</div>
			
			
			<div class="photo-container" style="text-align:center; float:left;">
				<h3>90 Day</h3>
				<img src="/bringit/images/placeholder.jpg" height="300px" width="240px" id="90-day-photo"/>
			</div>
			
			
			<br class="clear"/>
			
			
			<div id="social-media">
				<!-- TODO: ADD SOCIAL MEDIA -->
			</div>
			
			
			
			<div class="progress-photo-previews 1-day-photos">
				<h3>Day 1 
					<g:if test="${SecurityUtils.getSubject().isPermitted('workoutPlan:edit:' + workoutPlan.id)}">
						<g:link controller="progressPhoto" action="add_photo" id="${workoutPlan.id}">+ add photos</g:link>
					</g:if>
				</h3>
				
				<g:if test="${beforePhotos.size() > 0}">
					<g:each in="${beforePhotos}" status="i" var="beforePhoto"> 
						<img src="/bringit/${beforePhoto.thumbImageUrl}" data-image="${beforePhoto.imageUrl}"/>
					</g:each>
				</g:if>
				<g:else>
					<p style="float:left; margin-top:30px;">Take any before photos?</p>
				</g:else>
				
				<br class="clear"/>
			</div>
			
			
			
			<div class="progress-photo-previews 30-day-photos">
				<h3>30 Days 
					<g:if test="${SecurityUtils.getSubject().isPermitted('workoutPlan:edit:' + workoutPlan.id)}">
						<g:link controller="progressPhoto" action="add_photo" id="${workoutPlan.id}">+ add photos</g:link>
					</g:if>
				</h3>
				
				<g:if test="${thirtyDayPhotos.size() > 0}">
					<g:each in="${thirtyDayPhotos}" status="i" var="thirtyDayPhoto"> 
						<img src="/bringit/${thirtyDayPhoto.thumbImageUrl}" data-image="${thirtyDayPhoto.imageUrl}"/>
					</g:each>
				</g:if>
				<g:else>
					<p style="float:left; margin-top:30px;">Make it to 30 Days?</p>
				</g:else>
				
				<br class="clear"/>
			</div>
			
			
			
			<div class="progress-photo-previews 60-day-photos">
				<h3>60 Days 
					<g:if test="${SecurityUtils.getSubject().isPermitted('workoutPlan:edit:' + workoutPlan.id)}">
						<g:link controller="progressPhoto" action="add_photo" id="${workoutPlan.id}">+ add photos</g:link>
					</g:if>
				</h3>
				
				<g:if test="${sixtyDayPhotos.size() > 0}">
					<g:each in="${sixtyDayPhotos}" status="i" var="sixtyDayPhoto"> 
						<img src="/bringit/${sixtyDayPhoto.thumbImageUrl}" data-image="${sixtyDayPhoto.imageUrl}"/>
					</g:each>
				</g:if>
				<g:else>
					<p style="float:left; margin-top:30px;">Make it to 60 Days?</p>
				</g:else>
				
				<br class="clear"/>
			</div>
			
			
			
			<div class="progress-photo-previews 90-day-photos">
				<h3>90 Days
					<g:if test="${SecurityUtils.getSubject().isPermitted('workoutPlan:edit:' + workoutPlan.id)}">
						<g:link controller="progressPhoto" action="add_photo" id="${workoutPlan.id}">+ add photos</g:link>
					</g:if>
				</h3>
				
				
				<g:if test="${ninetyDayPhotos.size() > 0}">
					<g:each in="${ninetyDayPhotos}" status="i" var="ninetyDayPhoto"> 
						<img src="/bringit/${ninetyDayPhoto.thumbImageUrl}" data-image="${ninetyDayPhoto.imageUrl}"/>
					</g:each>
				</g:if>
				<g:else>
					<p style="float:left; margin-top:30px;">Make it to 90 Days?</p>
				</g:else>
				
				<br class="clear"/>
			</div>
    	
		</g:if>
		<g:else>
			
			<p>No photos uploaded yet...</p>
			
			<g:if test="${SecurityUtils.getSubject().isPermitted('workoutPlan:edit:' + workoutPlan.id)}">
				<g:link controller="progressPhoto" action="add_photo" class="btn btn-primary" params="[type : PhotoType.BEFORE.description()]" id="${workoutPlan.id}">Add Photos</g:link>
			</g:if>
			
		</g:else>
		
	</g:if>
	<g:else>
		<h2>No photos uploaded yet</h2>


		<g:if test="${SecurityUtils.getSubject().isPermitted('account:edit:' + account?.id)}">
			<p>You currently don't have Workout Plan started</p>
			<g:link controller="workoutPlan" action="selectVersion" class="btn btn-primary">Start a new workout plan</g:link>
		</g:if>
		<g:else>
			<p>${account.username} is not currently in a workout plan</p>
		</g:else>
		
	</g:else>	
		
					
<script type="text/javascript">	
$(document).ready(function(){
	var $day1Photo = $('#1-day-photo'),
		$day30Photo = $('#30-day-photo'),
		$day60Photo = $('#60-day-photo'),
		$day90Photo = $('#90-day-photo');
		
	var $day1Photos = $('.1-day-photos img'),	
		$day30Photos = $('.30-day-photos img'),
		$day60Photos = $('.60-day-photos img'),
		$day90Photos = $('.90-day-photos img');
		
		
	$day1Photos.click(replaceDayOne);
	$day30Photos.click(replaceDayThirty);
	$day60Photos.click(replaceDaySixty);
	$day90Photos.click(replaceDayNinety);
	
	
	
	function replaceDayOne(event){
		var $target = $(event.target);
		var src = "/bringit/" + $target.data('image');
		console.log(src);
		$day1Photo.attr('src', src);
	}
	
	function replaceDayThirty(event){
		var $target = $(event.target);
		var src = $target.attr('src');
		
		$day30Photo.attr('src', src);
	}
	
	function replaceDaySixty(event){
		var $target = $(event.target);
		var src = $target.attr('src');
		
		$day60Photo.attr('src', src);
	}
	
	function replaceDayNinety(event){
		var $target = $(event.target);
		var src = $target.attr('src');
		
		$day90Photo.attr('src', src);
	}
		
	
	
	if($day1Photos[0]){
		$day1Photos[0].click();
	}
	
	if($day30Photos[0]){
		$day30Photos[0].click();
	}
	
	if($day60Photos[0]){
		$day60Photos[0].click();
	}
	
	if($day90Photos[0]){
		$day90Photos[0].click();
	}
	
	
	console.log($day1Photos);
		
})
</script>	

</body>
</html>						