extends Node

@onready var music = $Music
@onready var rain = $Rain
@onready var heartbeat = $Heartbeat



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

func update_tension_audio(tension: float):
	#musica baja
	music.volume_db = lerp(-10.0, -8.0, tension)
	music.pitch_scale = lerp(0.95, 1.05, tension)
	
	#aqui los pulsos
	if tension > 0.6:
		if not heartbeat.playing:
			heartbeat.play()
		heartbeat.volume_db = lerp(-18.0, -2.0, tension)
		heartbeat.pitch_scale = lerp(1.0, 1.35, tension)
	else:
		if heartbeat.playing:
			heartbeat.stop()
			
	
	
