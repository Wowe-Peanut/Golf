extends Node2D


#Create Ball & Hole Instance
onready var Ball = load("res://GameObjects/Ball.tscn").instance()
onready var Hole = load("res://GameObjects/Hole.tscn").instance()

var ball_starting_pos = Vector2(100, 100)
var hole_starting_pos = Vector2(200, 200)

func _ready():
	add_child(Hole)
	add_child(Ball)
	reset_level()
	
func _process(delta):
	check_hole()
	
func check_hole():
	if Hole.position.distance_to(Ball.position) < 10:
		reset_level()
		#Global.next_level()


func reset_level():
		Ball.position = ball_starting_pos
		Hole.position = hole_starting_pos
		





