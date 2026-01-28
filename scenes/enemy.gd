extends CharacterBody2D


@export var speed = 40.0
@export var retreat_speed = 60.0

var in_light = false
var player = null


func _ready():
	add_to_group("enemies")
	call_deferred("_find_player")
func _find_player():
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	if player == null:
		print("NO PLAYER")
		return
	var diff = player.global_position - global_position
	var distance = diff.length()
	if distance < 20:
		velocity = Vector2.ZERO
	else:
		var dir = diff.normalized()
		if in_light:
			velocity = -dir * retreat_speed
		else:
			velocity = dir * speed
		
	move_and_slide()
