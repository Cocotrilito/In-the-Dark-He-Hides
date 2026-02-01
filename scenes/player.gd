extends CharacterBody2D

var base_speed = 400.0
@export var fear_speed = 600
@export var fear_duration = 0.4
@export var fear_cooldown = 10.0
@export var  max_battery = 140.0
@export var drain_per_second = 10.0
@onready var flashlight: PointLight2D = $Flashlight/PointLight2D
@onready var light_area: Area2D = $Flashlight/PointLight2D/LightArea
@onready var sprite: AnimatedSprite2D = $Sprite2D
@onready var battery_bar = get_node_or_null("../CanvasLayer/UI/BatteryBar")
@onready var dash_bar = get_node_or_null("../CanvasLayer/UI/Dashbar")
@onready var footsteps = $Footsteps
@onready var tension_mgr = get_node("../TensionManager")

var last_direction = "down"
var battery = max_battery
var flashlight_on = false
var cooldown_timer = 0.0
var is_afraid = false
var fear_timer = 0.0

func _process(delta):
	if not flashlight_on:
		TensionManager.add(0.05 * delta)
	rotate_flashlight()
	if tension_mgr:
		var t = tension_mgr.tension
		
	
	if battery_bar:
		battery_bar.value = battery
		var ratio = battery / max_battery
		if ratio <= 0.15:
			battery_bar.modulate = Color(1, 0.2, 0.2)
			battery_bar.modulate.a = 0.6+ sin(Time.get_ticks_msec() * 0.015) * 0.3
		elif ratio <= 0.25:
			battery_bar.modulate = Color(1, 0.6, 0.2)
			battery_bar.modulate.a = 1.0
		else:
			battery_bar.modulate = Color(0.211, 0.342, 0.203, 1.0)
			battery_bar.modulate.a = 1.0
	if flashlight_on:
		battery -= drain_per_second * delta
		if battery <= 0:
			battery = 0
			set_flashlight(false)
			return
		
		if battery < max_battery * 0.15:
			flashlight.energy = 0.4 + sin(Time.get_ticks_msec() * 0.02) * 0.2
		elif  battery < max_battery * 0.25:
			flashlight.energy = 0.6
		else:
			flashlight.energy = 1.0
	
		
	#dash separado de la bateria
	if dash_bar:
		dash_bar.max_value = fear_cooldown
		dash_bar.value = fear_cooldown - cooldown_timer
		var ratio_dash = dash_bar.value / dash_bar.max_value
		if ratio_dash <= 0.2:
			dash_bar.modulate = Color(0.5, 0.5, 0.5)
		elif ratio_dash < 1.0:
			dash_bar.modulate = Color(0.7, 0.4, 1.0)
		else:
			dash_bar.modulate = Color(1.0, 0.6, 1.0)
		
func _input(event):
	if Input.is_action_just_pressed("flashlight") and battery > 0:
		set_flashlight(!flashlight_on)
		
func set_flashlight(state: bool):
	flashlight_on = state
	flashlight.visible = state
	light_area.monitoring = state
	
func add_battery(amount):
	battery = min(battery + amount, max_battery)
	
	
func _ready():
	add_to_group("player")
	battery = max_battery
	set_flashlight(false)
	
	if battery_bar:
		battery_bar.max_value = max_battery
		battery_bar.value = battery
	
func rotate_flashlight():
	var mouse_pos = get_global_mouse_position()
	var dir = mouse_pos - global_position
	$Flashlight.rotation = dir.angle() - PI / 2

func _physics_process(delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	update_animation(input_direction)
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
	var is_moving = velocity.length() > 10
	if is_moving:
			if not footsteps.playing:
				footsteps.play()
	else:
		footsteps.stop()
#animaciones
func update_animation(input_dir: Vector2):
	if input_dir == Vector2.ZERO:
		sprite.play("idle_" + last_direction)
		return
	if abs(input_dir.x) > abs(input_dir.y):
		last_direction = "side"
		sprite.flip_h = input_dir.x < 0
	else:
		if input_dir.y > 0:
			last_direction = "down"
		else:
			last_direction = "up"
			sprite.flip_h = false
	sprite.play("walk_" + last_direction)

func _on_light_area_body_entered(body):
	
	if body.is_in_group("enemies"):
		body.in_light = true

func _on_light_area_body_exited(body):
	
	if body.is_in_group("enemies"):
		body.in_light = false
