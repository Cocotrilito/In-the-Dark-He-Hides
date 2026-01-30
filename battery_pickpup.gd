extends Area2D

@export var charge_amount = 40.0



func _on_body_entered(body):
	if body.is_in_group("player"):
		body.add_battery(charge_amount)
		queue_free()
