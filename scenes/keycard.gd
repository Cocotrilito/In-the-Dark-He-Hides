extends Node2D

var player_inside = false
var taken = false
var sequence = ["right", "right", "left", "right"]
var current_index = 0
var puzzle_active = false



func _on_area_2d_body_entered(body):
	if body.is_in_group("player") and not taken:
		player_inside = true
		$Label.visible = true
		



func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		player_inside = false
		$Label.visible = false
		
func _process(delta):
	if player_inside and not taken and Input.is_action_just_pressed("interact"):
		start_keycard_puzzle()
		
func start_keycard_puzzle():
	puzzle_active = true
	current_index = 0
	print("puzzle start")
	print("sequence", sequence)

func _input(event):
	if not puzzle_active:
		return
	if Input.is_action_just_pressed("puzzle_right"):
		check_input("right")
	elif Input.is_action_just_pressed("puzzle_left"):
		check_input("left")
		
func check_input(dir):
	if dir == sequence [current_index]:
		current_index += 1
		print("correct", dir)
		if current_index >= sequence.size():
			puzzle_succes()
	else:
		print("wrong input")
		puzzle_fail()
	
func puzzle_succes():
	print("KEYCARD OBTAINED")
	taken = true
	puzzle_active = false
	$Hint.visible = false
	$Sprite2D.visible = false
	$Label.visible = false
	
	GameState.has_keycard = true
	
func puzzle_fail():
	print("Puzzle Failed")
	current_index = 0
	
