extends Node2D

@export var ScoreTimer : Timer
@export var ScoreDisplay : Label

var StringFormatter : String
@export var NumberOfDigits: int = 7

# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.ScoreUpdated.connect(RefreshDisplay)
	GameState.PlayerDied.connect(StopSurvivalTimer)
	
	ScoreTimer.wait_time = GameState.SurvivalTickFrec
	StringFormatter = "%0" + str(NumberOfDigits) + "d"
	ScoreDisplay.text = StringFormatter % GameState.Score

func _on_score_timer_timeout():
	GameState.ScoreSurvivalPoints()
	
func RefreshDisplay():
	ScoreDisplay.text = StringFormatter % GameState.Score
func StopSurvivalTimer():
	ScoreTimer.stop()



