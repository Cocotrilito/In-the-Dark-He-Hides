extends Node2D

func _ready():
	ScreenFader.fade_in()

func _on_restart_pressed():
	
	await ScreenFader.fade_out()
	get_tree().change_scene_to_file("res://scenes/Main.tscn")
	ScreenFader.fade_in()



func _on_main_menu_pressed():
	await ScreenFader.fade_out()
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
	



func _on_quit_pressed():
	get_tree().quit()
