extends Node2D

@export var room_id = "room3"

var player_inside = false
var taken = false

func _ready():
	$"../Label".visible = false
	

func _on_area_2d_body_entered(body):
	if body.is_in_group("player") and not taken:
		player_inside = true
		$"../Label".visible = true
		


func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		player_inside = false
		$"../Label".visible = false	
		
func _process(delta):
	if player_inside and not taken and Input.is_action_just_pressed("interact"):
		collect_sample()
		
func collect_sample():
	taken = true
	$Sprite2D.visible = false
	$"../Label".visible = false
	print("sample collected")
	get_node("/root/Main").rooms_completed[room_id] = true
