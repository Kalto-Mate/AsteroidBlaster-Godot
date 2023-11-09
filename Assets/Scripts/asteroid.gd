extends RigidBody2D
class_name Asteroid

@export var Visuals: Sprite2D
@export var Collision: CollisionShape2D

@export var local_movement_direction : Vector2 = Vector2(-1,0)
@export var min_vel:int = 4
@export var max_vel:int = 8

@export var min_angular_vel:int = 3
@export var max_angular_vel:int = 7
var angularvel_multiplier:float = 500

@export var min_resize: float = 0.75
@export var max_resize: float = 2.5

@export var Skins: Array[Texture2D]

# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.PlayerDied.connect(Flee)
	
	#Randomize Linear Speed ====================================================================
	var velocity:float = randf_range(min_vel, max_vel) * GameState.AsteroidVelMultiplier
	
	#Transform cannot be grabbed to reference directly, so we use a getter:
	var local_transform : Transform2D = self.get_transform()
	
	#self.linear_velocity = self.local_transform.basis_xform(velocity_vector)
	
		#while the above is perfectly servizable with a 1,1 scale, it can break if the scale is 
		# anything else. this happens because the scale makes the basis part of the Transform 2x3
		# structure to not be of magnitude 1
	
		#the answer is to normalise the adapted local direction into the global reference system
		#which turns it into an identity, magnitude 1 vector, and restore the velocity by
		#multiplicating it by the absolute velocity value
		
	var global_velocity: Vector2 = local_transform.basis_xform(local_movement_direction).normalized() * velocity
	self.linear_velocity = global_velocity
	
	#Randomize Spin====================================================================
	var angular_vel:float = randi_range(min_angular_vel, max_angular_vel)
	var rotation_direction: float = pow(-1, randi_range(0,1))
	angular_vel = angular_vel * angularvel_multiplier * rotation_direction
	self.constant_torque = angular_vel
	
	#Randomize Size====================================================================
	var resize_factor:float = randf_range(min_resize, max_resize)
	Visuals.scale = Visuals.scale * resize_factor
	Collision.scale = Collision.scale * resize_factor
	
	#Randomize Looks====================================================================
	var skinIndex : int = randi() % Skins.size()
	var Chosen_Skin : Texture2D = Skins[skinIndex]
	Visuals.set_texture(Chosen_Skin)
	
	#print(str (get_instance_id()) + ">" + self.name + "____ Vx:" + str(velocity_x) + " R:" + str(angular_vel) + " Size:" + str(resize_factor) + " Text:" + str(skinIndex))
	#print("       Visuals:" + str (Visuals.get_instance_id()) + "Collision:" + str (Collision.get_instance_id())  ) 

func ChangeCourse(misileTransform: Vector2,Speed: float): #Expected for call in misile script
	var newDirection : Vector2 = self.global_position - misileTransform
	newDirection = newDirection.normalized()
	self.linear_velocity = newDirection*Speed
	pass


func _on_body_entered(body):
	if body is Player:
		body.Die()
		self.ChangeCourse(body.global_position,400)

func Flee(): #Used for asteroids to move out of the screen faster on player death
	var ScreenCenterRight : Vector2 = Vector2 (1280/2,720/2)
	self.ChangeCourse(ScreenCenterRight,1000)
