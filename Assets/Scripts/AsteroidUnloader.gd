extends Area2D

@export var AsteroidGroupName: String = "Asteroid"



func _on_body_exited(body):
	if body.is_in_group(AsteroidGroupName):
		body.queue_free()
