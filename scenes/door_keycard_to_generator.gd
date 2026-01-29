extends Node2D

@export var required_flag = "has_keycard"
@export var message = "Locked Needs keycard"




func _on_area_2d_body_entered(body):
	if not body.is_in_group("player"):
		return
	var main = get_node("/root/Main")
	if required_flag != "has_keycard" and not main.get(required_flag):
		print("Needs Keycard")
		return
	queue_free()
