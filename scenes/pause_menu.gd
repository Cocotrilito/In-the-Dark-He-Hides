extends CanvasLayer
@onready var ui: Control = $"../UI"



func _ready():
	visible = false
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()
	
func toggle_pause():
	var paused = not get_tree().paused
	get_tree().paused = paused
	visible = paused
	ui.visible = not paused


func _on_resume_pressed():
	toggle_pause()


func _on_restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
