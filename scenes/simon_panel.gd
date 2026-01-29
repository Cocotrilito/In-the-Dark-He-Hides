extends Node2D

@export var room_id = "room4"

@onready var red = $RedLight
@onready var blue = $BlueLight
@onready var green = $GreenLight
@onready var yellow =$YellowLight
@onready var hint = $HintSprite

var sequence = ["red", "green", "yellow", "blue"]
var current_index = 0
var puzzle_active = false
var player_inside = false

func _ready():
	$HintSprite.visible = false
	
func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player_inside = true
		puzzle_active = true
		current_index = 0
		$HintSprite.visible = true
		print("simon started")
		
func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		player_inside = false
		puzzle_active = false
		current_index = 0
		$HintSprite.visible = false
func _input(event):
	if not puzzle_active:
		return
	if  Input.is_action_just_pressed("simon_red"):
		check_input("red")
	elif Input.is_action_just_pressed("simon_green"):
		check_input("green")
	elif Input.is_action_just_pressed("simon_yellow"):
		check_input("yellow")
	elif Input.is_action_just_pressed("simon_blue"):
		check_input("blue")

func check_input(color):
		print("pressed:", color)
		if color == sequence[current_index]:
			flash_light(color)
			current_index += 1
			
			if current_index >= sequence.size():
				puzzle_succes()
		else:
			puzzle_fail()

func flash_light(color):
		match color:
			"red":
				$RedLight.modulate = Color(0.477, 0.0, 0.093, 1.0)
			"green":
				$GreenLight.modulate = Color(0.0, 0.561, 0.0, 1.0)
			"yellow":
				$YellowLight.modulate = Color(0.73, 0.483, 0.0, 1.0)
			"blue":
				$BlueLight.modulate = Color(0.0, 0.0, 0.451, 1.0)
				
func puzzle_succes():
		print("simon solved")
		puzzle_active = false
		$HintSprite.visible = false
		get_node("/root/Main").simon_done = true
		
func puzzle_fail():
		print("puzzle failed")
		current_index = 0
