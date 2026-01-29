extends Node

var rooms_completed = {
	"room1": false,
	"room2": false,
	"room3": false,
	"room4": false
}
func check_all_rooms():
	for r in rooms_completed.values():
		if r == false:
			return false
	return true

func start_puzzle():
	$PuzzleTimer.start()

func _on_puzzle_timer_timeout():
	get_tree().reload_current_scene()
	

func _on_exit_area_body_entered(body):
	if not body.is_in_group("player"):
		return
	if check_all_rooms():
		print("freedom")
		get_tree().change_scene_to_file("res://scenes/Main.tscn")
	else:
			print("Exit locked - objectives missing")
