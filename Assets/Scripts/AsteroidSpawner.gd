extends Sprite2D

@export var AsteroidPrefab: PackedScene
@export var MaxAngleDeg: float = 10
@export var animationPlayer : AnimationPlayer
var MaxAngleRad: float

func _ready():
	self.visible = false
	MaxAngleRad = deg_to_rad(abs(MaxAngleDeg))
	animationPlayer.play("UpAndDown")

func Spawn(): #Called from timer timeout
	var new_asteroid = AsteroidPrefab.instantiate()
	new_asteroid.position = self.position
	new_asteroid.rotation = self.global_rotation
	add_sibling(new_asteroid)

func RandomizeAngle():
	var newRotation:float = randf_range(-MaxAngleRad, MaxAngleRad)
	self.rotation = newRotation

func _on_timer_timeout():
	RandomizeAngle()
	Spawn()
