extends Node2D

var t = 0.0
func _process(delta):
	t += delta
	position.y = -16 + sin(t * 5.0) * 2
