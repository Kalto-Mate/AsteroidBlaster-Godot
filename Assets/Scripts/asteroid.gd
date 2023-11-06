extends RigidBody2D

@export var Visuals: Sprite2D
@export var Collision: CollisionShape2D

var x_direction:int = -1
@export var min_vel:int = 4
@export var max_vel:int = 8
var vel_multiplier:float = 50

@export var min_angular_vel:int = 3
@export var max_angular_vel:int = 7
var angularvel_multiplier:float = 500

@export var Skins: Array[Texture2D]

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#Randomize Linear Speed
	var velocity:float = randf_range(min_vel, max_vel) * vel_multiplier
	
	#Make it into a vector to higlight the transformation process, useful for non-pure directions
	var direction : Vector2 = Vector2(-1,0) #Or Vector2.LEFT
	var velocity_vector : Vector2 = direction * velocity
	self.linear_velocity = self.get_global_transform().basis_xform(velocity_vector)
	#Transform cannot be grabbed to reference directly, so we use a getter
	
	#Randomize Spin
	var angular_vel:float = randi_range(min_angular_vel, max_angular_vel)
	var rotation_direction: float = pow(-1, randi_range(0,1))
	angular_vel = angular_vel * angularvel_multiplier * rotation_direction
	self.constant_torque = angular_vel
	
	#Randomize Size
	var resize_factor:float = randf_range(0.5, 1.5)
	Visuals.scale = Visuals.scale * resize_factor
	Collision.scale = Collision.scale * resize_factor
	
	#Randomize Looks
	var skinIndex : int = randi() % Skins.size()
	var Chosen_Skin : Texture2D = Skins[skinIndex]
	Visuals.set_texture(Chosen_Skin)
	
	#print(str (get_instance_id()) + ">" + self.name + "____ Vx:" + str(velocity_x) + " R:" + str(angular_vel) + " Size:" + str(resize_factor) + " Text:" + str(skinIndex))
	#print("       Visuals:" + str (Visuals.get_instance_id()) + "Collision:" + str (Collision.get_instance_id())  ) 
