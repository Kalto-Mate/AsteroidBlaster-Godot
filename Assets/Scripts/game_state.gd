extends Node
signal PlayerDied
signal MisileImpacted
	
func ResetGame():
	#print("GAME RESET!")
	#Score = 0
	get_tree().reload_current_scene()
