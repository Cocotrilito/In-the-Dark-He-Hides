extends Node

var has_keycard = false
var generator_on = false
var simon_done = false
var has_sample = false

func _ready():
	AudioManager.play_music()

func start_puzzle():
	$PuzzleTimer.start()

func _on_puzzle_timer_timeout():
	get_tree().reload_current_scene()
	

func _on_exit_area_body_entered(body):
	if not body.is_in_group("player"):
		return
	if has_sample:
		print("freedom")
		get_tree().change_scene_to_file("res://scenes/Main.tscn")
	else:
			print("Exit locked - objectives missing")
