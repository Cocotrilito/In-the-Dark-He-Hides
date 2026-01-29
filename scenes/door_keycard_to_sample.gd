extends Node2D

@export var required_flag = "simon_done"
@export var message = "LOCKED"



func _on_area_2d_body_entered(body):
	if not body.is_in_group("player"):
		return
	var main = get_node("/root/Main")
	if required_flag != "simon_done" and not main.get(required_flag):
		print("System locked")
		return
	queue_free()
