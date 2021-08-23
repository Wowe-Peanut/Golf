extends Area2D

func _on_Hole_body_entered(body):
	if body.name == "Ball":
		if body.velocity.length() < 200:
			
			body.go_into_hole(position)
			yield(get_tree().create_timer(1), "timeout")
			Global.next_level()

