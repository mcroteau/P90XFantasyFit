<%@ page import="org.apache.shiro.SecurityUtils"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="profile">
	
	<title>P90X Fantasytle>
	
    <link rel="stylesheet" href="${resource(dir:'js/lib/fullcalendar/1.6.4/',file:'fullcalendar.css')}" />		
    <link rel="stylesheet" href="${resource(dir:'css',file:'fullcalendar-mods.css')}" />		
	<script type="text/javascript" src="${resource(dir:'js/lib/fullcalendar/1.6.4/fullcalendar.min.js')}"></script>
	
</head>
<body>

	<g:if test="${currentPlan}">
		<div id="calendar"></div>
	</g:if>
	<g:else>
		<h2>Nothing on the schedule yet....</h2>
		

		<g:if test="${SecurityUtils.getSubject().isPermitted('account:edit:' + account?.id)}">
			<p>You currently don't have Workout Plan started</p>
			<g:link controller="workoutPlan" action="selectVersion" class="btn btn-primary">Start a new workout plan</g:link>
		</g:if>
		<g:else>
			<p>${account.username} is not currently in a workout plan</p>
		</g:else>
		
	</g:else>
	

<g:if test="${currentPlan}">
	
<script type="text/javascript">	
	

$(document).ready(function(){

	var workouts = ${workouts};

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

				//events : "entries",
				events : "/bringit/account/workouts?id=${account.id}",
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
