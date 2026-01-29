extends StaticBody2D

@export var required_flag = "simon_done"
@export var locked_message = "door locked"
@onready var sprite = $Sprite2D
@onready var collider = $Blocker



func _on_area_2d_body_entered(body):
	if not body.is_in_group("player"):
		return
	if GameState.get(required_flag):
		open_door()
	else:
		print(locked_message)
func open_door():
	print("Door opened ", required_flag)
	sprite.visible = false
	collider.call_deferred("set_disabled", true)
	$Area2D.set_deferred("monitoring",false)
