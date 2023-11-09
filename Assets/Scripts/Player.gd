extends CharacterBody2D
class_name Player


@export var MisilePrefab : PackedScene
@export var ExplosionPrefab : PackedScene
@export var FireCooldownSequencer : AnimationPlayer
@export var ShipAnimator : AnimationPlayer
@export var audioStreamPlayer: AudioStreamPlayer
@export var misileSpawnPoint : Node2D
@export var FireRate : float = 5
@export var MovementSpeed : float = 300


@export var CanShoot : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	FireCooldownSequencer.speed_scale = 1/FireRate #This works assuming the animation is 1 second long
	ShipAnimator.play("Idle")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	get_input()
	self.move_and_slide()
		
func get_input():
	if Input.is_action_just_pressed("Shoot")  and  CanShoot:
		shoot()
	var input_dir = Input.get_vector("Left", "Right", "Up", "Down")
	#modficamos la propiedad interna velocity directamente
	velocity = input_dir * MovementSpeed

func shoot():
	FireCooldownSequencer.play("Recharge")
	CanShoot = false
	var new_misile = MisilePrefab.instantiate()
	new_misile.position = misileSpawnPoint.global_position
	new_misile.rotation = misileSpawnPoint.global_rotation
	add_sibling(new_misile)
	
func enableShooting():
	CanShoot = true

func Die():
	#Broadcast death with a signal
	GameState.PlayerDied.emit()
	
	var new_explosion = ExplosionPrefab.instantiate()
	new_explosion.position = self.position
	new_explosion.rotation = self.global_rotation
	add_sibling(new_explosion)
	
	self.queue_free()

