extends Node

@onready var music = $Music
@onready var rain = $Rain

func play_rain():
	if not rain.playing:
		rain.play()
func stop_rain():
	if rain.playing:
		rain.stop()

func play_music():
	if not music.playing:
		music.play()
		
func stop_music():
	music.stop()
