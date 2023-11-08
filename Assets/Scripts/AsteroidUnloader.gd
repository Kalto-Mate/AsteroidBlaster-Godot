extends Area2D

@export var AsteroidGroupName: String = "Asteroid"



func _on_body_exited(body):
	if body is Asteroid or body is Misile:
		body.queue_free()
		#print("Freed " + body.name)
