extends Node
signal PlayerDied
signal MisileImpacted
signal ScoreUpdated
signal SpawnRateUpdated

var Score: int = 0
var SurvivalTicksCounter : int = 0
const DificultyIncreaseCicle = 5

const SurvivalTickFrec : float = 1
const PointsPerSurvivalTick : int = 50
const PointsForMisileImpact : int = 500

var AsteroidSpawnRate:float = 1
const reset_AsteroidSpawnRate: float = 1
const SpawnRateIncreaseAmount = 0.05 #Considering difficulty the Asteroid SpawnRate
const SpawnRateCap = 1.25

var AsteroidVelMultiplier: float = 95
const reset_AsteroidVelMultiplier: float = 95
const SpeedMultIncreaseAmount = 1
const SpeedMultCap = 115

func _ready():
	MisileImpacted.connect(ScoreMisileImpact)
	ChangeSpawnRate(reset_AsteroidSpawnRate)

func _process(_delta):
	if SurvivalTicksCounter>DificultyIncreaseCicle :
		SurvivalTicksCounter=0
		ChangeSpawnRate(AsteroidSpawnRate+SpawnRateIncreaseAmount)
		ChangeVelMultiplier(AsteroidVelMultiplier+SpeedMultIncreaseAmount)
		
		print ("Dif+! SpawnRate: " + str(AsteroidSpawnRate) + " VelMult: " + str(AsteroidVelMultiplier))
	
func ScorePoints (Points: int):
	Score += Points
	ScoreUpdated.emit()
	
func ScoreMisileImpact():
	GameState.ScorePoints(GameState.PointsForMisileImpact)
	
func ScoreSurvivalPoints():
	SurvivalTicksCounter+=1
	GameState.ScorePoints(GameState.PointsPerSurvivalTick)

func ChangeSpawnRate(NewRate: float):
	AsteroidSpawnRate = NewRate
	
	if AsteroidSpawnRate>SpawnRateCap:
		AsteroidSpawnRate=SpawnRateCap
		
	SpawnRateUpdated.emit()
func ChangeVelMultiplier(NewVel: float):
	AsteroidVelMultiplier = NewVel
	
	if AsteroidVelMultiplier>SpeedMultCap:
		AsteroidVelMultiplier=SpeedMultCap
		
	SpawnRateUpdated.emit()

func ResetGame():
	#print("GAME RESET!")
	Score = 0
	SurvivalTicksCounter = 0
	AsteroidSpawnRate = reset_AsteroidSpawnRate
	AsteroidVelMultiplier = reset_AsteroidVelMultiplier
	get_tree().reload_current_scene()
