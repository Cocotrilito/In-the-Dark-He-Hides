extends Node2D

@export var required_flag = "generator_on"
@export var message = "Locked"
@onready var sprite = $Sprite2D


func _on_area_2d_body_entered(body):
	if not body.is_in_group("player"):
		return
	
	if GameState.simon_done:
		open_door()
	else:
		print("door locked")
func open_door():
	sprite.visible = false
	$Area2D/CollisionShape2D.disabled = true
