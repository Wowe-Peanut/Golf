extends Node2D

var current_level = 0

func _ready():
	get_tree().change_scene("res://MainMenu.tscn")
	

func start():
	current_level = 0
	next_level()

func next_level():
	current_level += 1
	get_tree().change_scene("res://Levels/Level" + str(current_level) + ".tscn")

func reset_level():
	get_tree().change_scene("res://Levels/Level" + str(current_level) + ".tscn")

func _input(event):
	if event.is_action_pressed("Esc"):
		get_tree().change_scene("res://MainMenu.tscn")

