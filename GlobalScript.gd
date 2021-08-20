extends Node2D



func _ready():
	get_tree().change_scene("res://MainMenu.tscn")
	

var current_level = 0

func next_level():
	current_level += 1
	get_tree().change_scene("res://Levels/Level" + str(current_level) + ".tscn")
