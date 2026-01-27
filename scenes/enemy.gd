extends CharacterBody2D

@export var angle: float
@export var length: float
@export var direction = Vector2.UP

@onready var sprite_2d: Sprite2D = $Sprite2D


var half_angle_rads
var player

func _ready():
	player = get_tree().get_first_node_in_group("player")
	half_angle_rads =  deg_to_rad(angle / 2)

func _physics_process(delta):
	if is_in_cone():
		sprite_2d.self_modulate = Color.RED
	else:
		sprite_2d.self_modulate = Color.WHITE

func _draw():
	var left_dir = direction.rotated(-half_angle_rads) * length
	var right_dir = direction.rotated(half_angle_rads) * length
	
	draw_line(Vector2.ZERO, left_dir, Color.YELLOW, 2.0)
	draw_line(Vector2.ZERO, right_dir, Color.YELLOW, 2.0)

func is_in_cone():
	var player_local_position = to_local(player.global_position)
	var angle_to_player = direction.angle_to(player_local_position)
	return abs(angle_to_player) <= half_angle_rads
	
