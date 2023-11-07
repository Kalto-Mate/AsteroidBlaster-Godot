extends Area2D
@export var MisilePrefab : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Shoot"):
		shoot()

func shoot():
	var new_misile = MisilePrefab.instantiate()
	new_misile.position = self.position
	new_misile.rotation = self.global_rotation
	add_sibling(new_misile)
