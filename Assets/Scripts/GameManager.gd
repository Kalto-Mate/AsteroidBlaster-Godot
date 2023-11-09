extends Node
@export var MusicPlayer : AudioStreamPlayer
@export var animationPlayer : AnimationPlayer

var Score: int = 0
var StringFormatter : String
var NumberOfDigits: int = 7

@export var SurvivalTickFrec : float = 2
@export var PointsPerSurvivalTick : int = 10
@export var PointsForMisileImpact : int = 500
@export var ScoreTimer : Timer
@export var ScoreDisplay : Label

# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.PlayerDied.connect(_on_player_player_died)
	GameState.MisileImpacted.connect(ScoreMisileImpact)
	
	ScoreTimer.wait_time = SurvivalTickFrec
	StringFormatter = "%0" + str(NumberOfDigits) + "d"
	ScoreDisplay.text = StringFormatter % Score

func _on_player_player_died():
	MusicPlayer.stop()
	ScoreTimer.stop()
	animationPlayer.play("GameOver_sequence")

func ResetGame():
	GameState.ResetGame()

func ScorePoints (Points: int):
	Score += Points
	ScoreDisplay.text = StringFormatter % Score

func ScoreMisileImpact():
	ScorePoints(PointsForMisileImpact)

func _on_score_timer_timeout():
	ScorePoints (PointsPerSurvivalTick)
