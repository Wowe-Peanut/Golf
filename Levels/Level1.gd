extends Node2D

onready var Ball = $Ball
onready var StrokeCounter = $StrokeCounter

func _ready():
	Ball.StrokesRemaining = 1
	$StrokePowerup.set_bonus(1)
	pass
	
func _process(delta):
	StrokeCounter.text = "Strokes Remaining: " + str(Ball.StrokesRemaining)
	pass
