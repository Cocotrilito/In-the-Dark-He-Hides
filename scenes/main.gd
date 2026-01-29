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
	
	


func _on_room_1_area_body_entered(body):
	if body.is_in_group("player") and not rooms_completed["room1"]:
		rooms_completed["room1"] = true	
		print("Sala 1 act")

func _on_room_2_area_body_entered(body):
	if body.is_in_group("player") and not rooms_completed["room2"]:
		rooms_completed["room2"] = true	
		print("Sala 2 act")




func _on_room_3_area_body_entered(body):
	if body.is_in_group("player") and not rooms_completed["room3"]:
		rooms_completed["room3"] = true
		print("Sala 3 act")
	


func _on_room_4_area_body_entered(body):
	if body.is_in_group("player") and not rooms_completed["room4"]:
		rooms_completed["room4"] = true
		print("Sala 4 act")
	


func _on_exit_area_body_entered(body):
	if body.is_in_group("player") and check_all_rooms():
		print("freedom")
		get_tree().change_scene_to_file("res://scenes/Main.tscn")
