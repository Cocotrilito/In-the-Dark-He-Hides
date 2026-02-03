extends CharacterBody2D


@export var speed = 350
@export var retreat_speed = 60.0
@export var kill_distance = 180.0
@export var fear_time = 1
@export var calm_time = 0.5
@onready var agent: NavigationAgent2D = $NavigationAgent2D
@onready var sprite: AnimatedSprite2D = $Sprite2D
@onready var footsteps = $FootstepsEnemy
@onready var tension_mgr = get_node("../TensionManager")
@export var base_speed = 350
@export var high_tension_speed = 420




var calm_timer = 0.0
var fear_timer = 0.0
var in_light = false
var player = null
var is_afraid = false

func _ready():
	add_to_group("enemies")
	call_deferred("_find_player")
	agent.path_desired_distance = 8
	agent.target_desired_distance = 8
	sprite.play("chase_dark")
func _find_player():
	player = get_tree().get_first_node_in_group("player")

#ANIMACION
func play_anim(name: String):
	if sprite.animation != name:
		sprite.play(name)


func _physics_process(delta):
	var current_speed = base_speed
	if TensionManager.tension > 0.8:
		current_speed = high_tension_speed
	TensionManager.add(0.15 * delta)
	if player == null:
		print("NO PLAYER")
		return
	if tension_mgr and tension_mgr.tension > 0.8:
		speed = 420
		print("Tension:", tension_mgr.tension,"speed:", speed)
	else:
		speed = 350
	
	agent.target_position = player.global_position
	if agent.is_navigation_finished():
		return
		print("NO PATH")
	
	var next_pos = agent.get_next_path_position()
	var dir = (next_pos - global_position).normalized()
	
	
	if in_light and not is_afraid and calm_timer <= 0:
		is_afraid = true
		fear_timer = fear_time
	
	#aqui va el miedo
	if is_afraid:
		play_anim("chase_light")
		fear_timer -= delta
		velocity = -dir * retreat_speed
		if fear_timer <= 0:
			is_afraid = false
			calm_timer = calm_time
	#aqui va la calma
	elif calm_timer > 0:
		
		calm_timer -= delta
		velocity = Vector2.ZERO
	else:
		play_anim("chase_dark")
		velocity  = dir * current_speed
	move_and_slide()
	var is_moving = velocity.length() > 10
	if is_moving and calm_timer <= 0:
		if not footsteps.playing:
			footsteps.play()
	else:
		if footsteps.playing:
			footsteps.stop()
	if player:
		var distance = global_position.distance_to(player.global_position)
		footsteps.volume_db = clamp(-12 - distance / 35, -40, -12)
		
		if not is_afraid and calm_timer <= 0:
			footsteps.pitch_scale = 1.1
		else:
			footsteps.pitch_scale = 0.95


func _on_kill_area_body_entered(body):
	if body.is_in_group("player"):
		ScreenFader.fade_out()
		get_tree().change_scene_to_file("res://scenes/dead.tscn")
		print("entra el", body.name)
