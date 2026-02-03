extends Node

func _ready():
	ScreenFader.fade_in()
	AudioManager.play_music()
	AudioManager.play_rain()
	
