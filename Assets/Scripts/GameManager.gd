extends Node
@export var MusicPlayer : AudioStreamPlayer
@export var animationPlayer : AnimationPlayer

var Score: int = 0

@export var PointsPerSurvivalTick : int = 50
@export var PointsForMisileImpact : int = 1500


# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.PlayerDied.connect(_on_player_player_died)

func _on_player_player_died():
	MusicPlayer.stop()
	animationPlayer.play("GameOver_sequence")

func ResetGame():
	GameState.ResetGame()


