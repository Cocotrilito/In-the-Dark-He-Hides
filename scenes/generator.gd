extends Node2D

@export var room_id = "room2"
@export var activation_time = 4.0

var player_inside = false
var activating = false

func _ready():
	$Label.visible = false
	$GeneratorTimer.wait_time = activation_time
	


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player_inside = true
		$Label.visible = true
		

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		player_inside = false
		$Label.visible = false

func _process(delta):
	if not player_inside:
		return
	if Input.is_action_just_pressed("interact") and not activating:
		start_activation()
		
	if activating and Input.is_action_just_released("interact"):
		cancel_activation()
		
		
func start_activation():
	activating = true
	print("generator activating")
	$GeneratorTimer.start()
	
	
	
func cancel_activation():
	if activating:
		activating = false
		$GeneratorTimer.stop()
		print("generator cancelled")

func _on_generator_timer_timeout():
	print("generator ON")
	activating = false
	$Label.visible = false
	
	GameState.generator_on = true
