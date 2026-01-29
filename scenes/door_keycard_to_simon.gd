extends Node2D

@export var required_flag = "generator_on"
@export var message = "Locked"



func _on_area_2d_body_entered(body):
	if not body.is_in_group("player"):
		return
	var main = get_node("/root/Main")
	
	if required_flag != "generator_on" and not main.get(required_flag):
		print("No power")
		return
	queue_free()
