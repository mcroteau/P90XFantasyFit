package org.motus.common

public enum AccoladeDescription {

	LOGGED_WORKOUT('Completed workout!'),
	LOGGED_XSTRETCH('Completed X Stretch'),
	LOGGED_YOGAX('Completed Yoga X'),
	COMPLETED_AB_RIPPER('Completed Ab Ripper X'),
	PERFECT_WEEK('Perfect Week! No workouts skipped'),
	TWENTY_MINUTE_CARDIO('20 minute Cardio Workout'),
	THIRTY_MINUTE_CARDIO('30 minute Cardio Workout'),
	FORTY_MINUTE_CARDIO('40 minute Cardio Workout'),
	FIFTY_MINUTE_CARDIO('50 minute Cardio Workout'),
	SIXTY_MINUTE_CARDIO('60 minute Cardio Workout'),
	SEVENTY_MINUTE_CARDIO('70 minute Cardio Workout'),
	EIGHTY_MINUTE_CARDIO('80 minute Cardio Workout'),
	NINETY_MINUTE_CARDIO('90 minute Cardio Workout'),
	TWENTY_MINUTE_FREEWEIGHTS('20 Minute Free Weights Workout'),
	THIRTY_MINUTE_FREEWEIGHTS('30 Minute Free Weights Workout'),
	FORTY_MINUTE_FREEWEIGHTS('40 Minute Free Weights Workout'),
	FIFTY_MINUTE_FREEWEIGHTS('50 Minute Free Weights Workout'),
	SIXTY_MINUTE_FREEWEIGHTS('60 Minute Free Weights Workout'),
	SEVENTY_MINUTE_FREEWEIGHTS('70 Minute Free Weights Workout'),
	EIGHTY_MINUTE_FREEWEIGHTS('80 Minute Free Weights Workout'),
	NINETY_MINUTE_FREEWEIGHTS('90 Minute Free Weights Workout'),
	PROGRAM_COMPLETE('Completed a workout program'),
	PERFECT_PROGRAM('Perfect Program! <strong>0 Skipped</strong> Workouts!!'),
	PHOTO_UPLOADED('Progress Photo uploaded'),
	PARTICIPATED_COMPETITION('Participated in Competition'),
	FIRST_PLACE_COMPETITION('FIRST_PLACE_COMPETITION'),
	SECOND_PLACE_COMPETITION('SECOND_PLACE_COMPETITION'),
	THIRD_PLACE_COMPETITION('THIRD_PLACE_COMPETITION')
	
	private final String description
	
	AccoladeDescription(String description){
		this.description = description
	}
	
	public String description(){
		return this.description
	}
	
}
