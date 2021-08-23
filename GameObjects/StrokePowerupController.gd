extends Area2D


var StrokeBonus = 1

func set_bonus(bonus):
	StrokeBonus = bonus
	$Label.text = "+" + str(StrokeBonus)

func _on_StrokePowerup_body_entered(body):
	if body.name == "Ball":
		body.add_strokes(StrokeBonus)
		self.queue_free()
		

