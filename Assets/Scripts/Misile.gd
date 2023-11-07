extends RigidBody2D
class_name Misile

@export var animationPlayer : AnimationPlayer
@export var explosionPrefab : PackedScene
@export var velocity : float = 200
@export var velocityTransferOnImpact : float = 300
@export var local_movement_direction : Vector2 = Vector2(1,0) 

# Called when the node enters the scene tree for the first time.
func _ready():
	var local_transform : Transform2D = self.get_transform()	
	var global_velocity: Vector2 = local_transform.basis_xform(local_movement_direction).normalized() * velocity
	self.linear_velocity = global_velocity
	#print("global_velocity: " + str(global_velocity)   )
	animationPlayer.play("Idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func Detonate():
	print("Misile: Boom")
	var new_explosion = explosionPrefab.instantiate()
	new_explosion.position = self.position
	new_explosion.rotation = self.global_rotation
	add_sibling(new_explosion)
	self.queue_free()


func _on_body_entered(body):
	if body is Asteroid :  
		self.Detonate()
		body.ChangeCourse(self.global_position,velocityTransferOnImpact)
