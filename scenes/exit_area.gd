extends Area2D



func _on_body_entered(body):
	if not body.is_in_group("player"):
		return
	var main = get_tree().get_current_scene()
	
	if main.has_sample:
		print("freedom")
		get_tree().change_scene_to_file("res://scenes/Main.tscn")
	else:
		print("Exit locked sample missing")
