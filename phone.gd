extends Node2D

@export var ring_delay  = 2.5
@onready var ring: AudioStreamPlayer2D = $ring
@onready var voice: AudioStreamPlayer2D = $voice
@onready var label: Label = $Label
@onready var area: Area2D = $Area2D

var can_answer = false
var answered = false

func _ready():
	label.visible = false
	await get_tree().create_timer(ring_delay).timeout
	if not answered:
		ring.play()
	
func _process(delta):
	if can_answer and not answered and Input.is_action_just_pressed("interact"):
		answer_phone()

func answer_phone():
	answered = true
	can_answer = false
	label.visible = false
	ring.stop()
	voice.play()
	


func _on_area_2d_body_entered(body):
	if body.is_in_group("player") and not answered:
		can_answer = true
		label.visible = true
		
func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		can_answer = false
		label.visible = false
