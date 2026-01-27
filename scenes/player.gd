extends CharacterBody2D

var base_speed = 400.0
@export var fear_speed = 600
@export var fear_duration = 0.4
@export var fear_cooldown = 10.0

var cooldown_timer = 0.0
var is_afraid = false
var fear_timer = 0.0


func _physics_process(delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	
	if cooldown_timer > 0:
		cooldown_timer -= delta
	
	
	if Input.is_action_just_pressed("shift"):
		if not is_afraid and cooldown_timer <= 0:
			is_afraid = true
			fear_timer = fear_duration
			cooldown_timer = fear_cooldown
		
	if is_afraid:
		fear_timer -= delta
		if fear_timer <= 0:
			is_afraid = false
	
	var current_speed = fear_speed if is_afraid else base_speed
	velocity = input_direction * current_speed
	move_and_slide()
