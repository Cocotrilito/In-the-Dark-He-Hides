extends CanvasLayer

@onready var rect: ColorRect = $FadeRect
@export var fade_time = 0.5


func _ready():
	rect.modulate.a = 1.0
	fade_in()


func fade_in():
	var tween = create_tween()
	tween.tween_property(rect, "modulate:a", 0.0, fade_time)

func fade_to(scene_path: String):
	var tween = create_tween()
	tween.tween_callback(func():
		get_tree().change_scene_to_file(scene_path))
