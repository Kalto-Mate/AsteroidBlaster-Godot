extends Node
@export var MusicPlayer : AudioStreamPlayer
@export var animationPlayer : AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.PlayerDied.connect(_on_player_player_died)


func _on_player_player_died():
	MusicPlayer.stop()
	animationPlayer.play("GameOver_sequence")

func ResetGame():
	GameState.ResetGame()
