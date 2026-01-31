extends Node2D

@export var ring_delay = 2.5
@onready var ring = $Ring
@onready var voice = $Voice
@onready var label = $Label

var can_answer = false
var answered = false


	
func _process(delta):
	if can_answer and not answered and Input.is_action_just_pressed("interact"):
		answer_phone()
		
		
func answer_phone():
	answered = true
	ring.stop()
	label.visible = false
	voice.play()
	await voice.finished()
	on_call_finished()

func on_call_finished():
	pass
