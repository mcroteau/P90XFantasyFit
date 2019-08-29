<%@ page import="org.apache.shiro.SecurityUtils"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="profile">
	
	<title>P90X Fantasy Fit : Calendar</title>
	
    <link rel="stylesheet" href="${resource(dir:'js/lib/fullcalendar/1.6.4/',file:'fullcalendar.css')}" />		
    <link rel="stylesheet" href="${resource(dir:'css',file:'fullcalendar-mods.css')}" />		
	<script type="text/javascript" src="${resource(dir:'js/lib/fullcalendar/1.6.4/fullcalendar.min.js')}"></script>
	
</head>
<body>

	<style type="text/css">
		
		#calendar-container{
			margin-top:20px;
			position:relative;
		}
		
		#calendar{
			margin-top:5px;
		}
		
		#calendar-legend{
			font-size:11px;
			color:#555;
			text-align:right;
			margin-top:20px;
			position:absolute;
			top:30px;
			right:200px;
		}
		
		.calendar-legend {
			height:10px;
			width:10px;
			margin-right:20px;
			display:inline-block;
		}
	
		.incomplete-legend{
			background:#f2f2f2;
			border:solid 1px #ddd;
		}
		.completed-legend{
			background:#246FF9;
			border:solid 1px #0048cc;
		}
		.skipped-legend{
			background: #D2322D !important;
			border:solid 1px #b3140f;
			/**
			background: #ffdb41 !important;
			border:solid 1px #ecc82e;
			**/
		}
	
	
		.fc-event{
			opacity : 0.8;
			padding:5px 10px;
		}
		
		.fc-event.incomplete{
			background: #f2f2f2;
			color:#000 !important;
			border:solid 1px #ddd;
		}

		
		.fc-event.skipped{
			color:#766001;
			color:#fff;
			background: #D2322D !important;
			border:solid 1px #b3140f;
			/**
	        background: #ffdb41 !important;
			border:solid 1px #ecc82e;
			**/
		}
		
		.fc-event.completed{
			color:#fff;
			background: #246FF9 !important;
			border:solid 1px #0048cc;
		}
	</style>
	
	
	<g:if test="${workoutPlan}">
		
		<g:if test="${workoutPlan.planVersion == "Freestyle"}">
			<p class="alert alert-info">Youre freestyling, no schedule needed... only action</p>
		</g:if>
		
		<div id="calendar-container">

			<div style="height:40px; margin-top:20px;">
				
				<a href="${g.createLink(controller : "workoutPlan", action:'schedule_list')}"  class="btn btn-default pull-right" id="schedule_list"><span class="glyphicon glyphicon-th-list"></span></a>
				
				
				<g:link controller="workoutPlan" action="schedule" class="btn btn-default active pull-right"><span class="glyphicon glyphicon-calendar"></span></g:link>
				
			</div>
			
			<div id="calendar-legend">
				Completed &nbsp;<span class="calendar-legend completed-legend"></span>
				Incomplete &nbsp;<span class="calendar-legend incomplete-legend"></span>
				Skipped &nbsp;<span class="calendar-legend skipped-legend"></span>
			</div>
			
			<div id="calendar"></div>
		</div>
		
	</g:if>
	<g:else>
	
		<div style="margin-top:40px;">
		<h2>Nothing on the schedule yet....</h2>
		
			<g:if test="${SecurityUtils.getSubject().isPermitted('account:edit:' + account?.id)}">
				<p>You currently don't have Workout Plan started</p>
				<g:link controller="workoutPlan" action="selectVersion" class="btn btn-primary">Start a new workout plan</g:link>
			</g:if>
			<g:else>
				<p>${account.username} is not currently in a workout plan</p>
			</g:else>
		</div>
	</g:else>
	

<g:if test="${workoutPlan}">
	
<script type="text/javascript">	
	

$(document).ready(function(){

	//var workouts = ${workouts};

	var Calendar = function($calendarDiv){
		var self = this;
		
		//console.info('calendar div', $calendarDiv);
		
		self.$calendarDiv = $calendarDiv;


		var $day = $('.fc-widget-content');
		var $loading = $('#loading');

		var $calendar;


		self.init = function(){
			self.render();
			//self.bindQtipOnEvents();
		};

		var count = 0;

		self.render = function(){
	
			//console.info('RENDER', workouts.length);
			
			$calendar = self.$calendarDiv.fullCalendar({

				events : "/bringit/workoutPlan/workout_data?id=${account.id}",
				disableDragging : true,
				selectable : true,
				select : function(start, end, allDay, jsEvent, view, onevent){

					var $cellOverlay = 	$('.fc-cell-overlay');

					var dateString = start.getFullYear() + '-' + (start.getMonth() + 1) + '-' + start.getDate();
					var today = new Date();
					var result = util.dates.compare(start, today);

					if(result === 1){

						var message = 'Cannot log entry for the future... what are you trying to pull here...';

						
						/**
						$cellOverlay.qtip({
							content: {
								text: message
							},
						   	position: {
						    	my: 'bottom center',  // Position my top left...
						      	at: 'top center', // at the bottom right of...
						    },
							style: {
								classes: 'ui-tooltip-youtube'
							}
						});
						$cellOverlay.qtip().show();
						**/

					}else{
					
						//window.location = '/virtueEntry/logEntry?date=' + dateString;
					}

				},
				loading : function(bool) {
					if (bool){
						$loading.show();
						//console.info('loading....')	
					} else {
						$loading.hide();
					}
				},
				eventRender: function(event, element) {
					count++
					//console.log(count, event)
					$(element).addClass(event.class)
				}

			});				
		};

		self.bindQtipOnEvents = function(){
		
			/** replace qtip qith modern hover lib
			$('.fc-event').qtip({
				content: {
					text: "View Details"
				},
				position: {
					my: 'bottom center',  // Position my top left...
				  	at: 'top center', // at the bottom right of...
				},
				style: {
					classes: 'ui-tooltip-youtube'
				}

			});
			**/
			
		};

		self.zeroPad = function(num, count){
			var numZeropad = num + '';
			while(numZeropad.length < count) {
				numZeropad = "0" + numZeropad;
			}
			return numZeropad;
		}
	}


	var calendar = new Calendar($('#calendar'));
	calendar.init();


});

function zeroPad(num, count){
	var numZeropad = num + '';
	while(numZeropad.length < count) {
		numZeropad = "0" + numZeropad;
	}
	return numZeropad;
}



</script>		
	
</g:if>

							
</body>
</html>
