extends CharacterBody2D

var base_speed = 400.0
@export var fear_speed = 600
@export var fear_duration = 0.4
@export var fear_cooldown = 10.0
@export var  max_battery = 100.0
@export var drain_per_second = 20.0
@onready var flashlight: PointLight2D = $Flashlight/PointLight2D
@onready var light_area: Area2D = $Flashlight/PointLight2D/LightArea


var battery = max_battery
var flashlight_on = false
var cooldown_timer = 0.0
var is_afraid = false
var fear_timer = 0.0

func _process(delta):
	rotate_flashlight()
	if flashlight_on:
		battery -= drain_per_second * delta
		if battery <= 0:
			battery = 0
			flashlight_on = false
			flashlight.visible = false
func _input(event):
	if event.is_action("flashlight") and battery > 0:
		flashlight_on = !flashlight_on
		flashlight.visible = flashlight_on
		

func _ready():
	add_to_group("player")

func rotate_flashlight():
	var mouse_pos = get_global_mouse_position()
	var dir = mouse_pos - global_position
	$Flashlight.rotation = dir.angle() - PI / 2

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

func _on_light_area_body_entered(body):
	
	if body.is_in_group("enemies"):
		body.in_light = true

func _on_light_area_body_exited(body):
	
	if body.is_in_group("enemies"):
		body.in_light = false
