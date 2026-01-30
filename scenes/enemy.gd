extends CharacterBody2D


@export var speed = 350
@export var retreat_speed = 60.0
@export var kill_distance = 180.0
@export var fear_time = 1
@export var calm_time = 0.5
@onready var agent: NavigationAgent2D = $NavigationAgent2D





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
func _find_player():
	player = get_tree().get_first_node_in_group("player")




func _physics_process(delta):
	if player == null:
		print("NO PLAYER")
		return
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
		velocity  = dir * speed
	move_and_slide()




func _on_kill_area_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene_to_file("res://scenes/Main.tscn")
		print("entra el", body.name)
