extends RigidBody2D

var x_direction:int = -1
var vel_multiplier:float = 50
var min_vel:int = 4
var max_vel:int = 8

var angularvel_multiplier:float = 500
var min_angular_vel:int = 3
var max_angular_vel:int = 7

# Called when the node enters the scene tree for the first time.
func _ready():

	var velocity_x:float = randf_range(min_vel, max_vel) * vel_multiplier
	var velocity:Vector2=Vector2(velocity_x * x_direction,0)
	self.linear_velocity = velocity

	var angular_vel:float = randi_range(min_angular_vel, max_angular_vel)
	var rotation_direction: int = pow(-1, randi_range(0,1))
	angular_vel = angular_vel * angularvel_multiplier * rotation_direction
	self.constant_torque = angular_vel

	print(self.name + "     Vx = " + str(velocity_x) + "     R = " + str(angular_vel))

