<%@ page import="org.apache.shiro.SecurityUtils"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="fullscreen">
	
	<title>P90X Fantasy Fit : Pick Workout</title>
	
</head>
<body>

	<h1>Select a Workout below to continue</h1>
	
	<style type="text/css">
		.well.select-workout{
			float:left;
			width:300px;
			margin: 0px 15px
		}
		.select-workout ul{
		}
		.select-workout ul li{
			list-style:square;
		}
	</style>
	
	<div class="well select-workout">
		<h2>P90X Workouts</h2>
		<ul>
			<li><g:link controller="chestBack" action="logWorkout">Chest &amp; Back</g:link></li>
			<li><g:link controller="armsShoulders" action="logWorkout">Shoulders &amp; Arms</g:link></li>
			<li><g:link controller="legsBack" action="logWorkout">Legs &amp; Back</g:link></li>
			<li><g:link controller="chestShouldersTriceps" action="logWorkout">Chest, Shoulders &amp; Triceps</g:link></li>
			<li><g:link controller="backBiceps" action="logWorkout">Back &amp; Biceps</g:link></li>
			<li><g:link controller="coreSynergistics" action="logWorkout">Core Synergistics</g:link></li>
			<li><g:link controller="yogaX" action="logWorkout">Yoga X</g:link></li>
			<li><g:link controller="plyometrics" action="logWorkout">Plyometrics</g:link></li>
			<li><g:link controller="kenpoX" action="logWorkout">Kenpo X</g:link></li>
			<li><g:link controller="cardioX" action="logWorkout">Cardio X</g:link></li>
			<li><g:link controller="xstretch" action="logWorkout">X Stretch</g:link></li>
			<li><g:link controller="cardioWorkout" action="logWorkout">Extra Cardio Workout</g:link></li>
			<li><g:link controller="freeWeights" action="logWorkout">Free Weights Workout</g:link></li>
			<li><g:link controller="abRipperX" action="logWorkout">Ab Ripper X</g:link></li>
		</ul>
	</div>

							
</body>
</html>
