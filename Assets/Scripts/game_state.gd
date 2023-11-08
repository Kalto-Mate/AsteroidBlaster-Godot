extends Node
signal PlayerDied

# Called when the node enters the scene tree for the first time.
func ResetGame():
	#print("GAME RESET!")
	get_tree().reload_current_scene()
