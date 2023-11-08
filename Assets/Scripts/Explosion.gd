extends Sprite2D
@export var animationPlayer : AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	animationPlayer.play("Explode")

func selfDestruct():
	#print("Explosion Self Destruct")
	self.queue_free()
