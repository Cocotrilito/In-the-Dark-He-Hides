extends Control

func _ready():
	ScreenFader.fade_in()
	AudioManager.play_music()

func _on_play_pressed():
	await ScreenFader.fade_out()
	get_tree().change_scene_to_file("res://scenes/Main.tscn")

func _on_quit_pressed():
	get_tree().quit()
