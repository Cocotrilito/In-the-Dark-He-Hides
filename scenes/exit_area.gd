extends Area2D
@export var hint_time = 2.5
@onready var hint_label = $"../ExitHint/Label"
var showing_hint = false
func _ready():
	hint_label.visible = false
	
func _on_body_entered(body):
	if not body.is_in_group("player"):
		return
	
	if GameState.has_sample:
		print("freedom")
		get_tree().change_scene_to_file("res://scenes/Win.tscn")
	else:
		show_hint()
		print("Exit locked sample missing")
		
func show_hint():
	if showing_hint:
		return
	showing_hint = true
	hint_label.visible = true
	await get_tree().create_timer(hint_time).timeout
	hint_label.visible = false
	showing_hint = false
