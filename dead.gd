extends Control



func _on_restart_pressed():
	$FadeLayer.fade_to("res://scenes/MainMenu.tscn")



func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
	



func _on_quit_pressed():
	get_tree().quit()
