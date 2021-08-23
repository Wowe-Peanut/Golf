extends KinematicBody2D


#Child Nodes
onready var sprite = $Sprite
onready var hitbox = $Hitbox
onready var tween = $Tween
onready var light = $Light

#Physics Properties
var max_ball_speed = 3000
var friction_ceoffient = 0.98
var distance_power_multiplier = 6
var stop_speed = 10



#Other
var clicked = false
var velocity = Vector2()
var force = 0
var StrokesRemaining = 3
var InAnimation = false

func add_strokes(n):
	StrokesRemaining += n

#Dropping into hole animation
func go_into_hole(HolePos):
	InAnimation = true
	var entry_speed = velocity.length()
	velocity = Vector2(0, 0)
	
	#Move to center of hole, shrink, and dim light
	tween.interpolate_property(self, "position", position, HolePos, ((position.distance_to(HolePos))/entry_speed) if entry_speed != 0 else 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(sprite, "scale", sprite.scale, sprite.scale * Vector2(.3, .3), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(light, "texture_scale", light.texture_scale, light.texture_scale * .5, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	tween.start()
	
func _physics_process(delta):
	
	#Apply Friction
	velocity *= friction_ceoffient
	if velocity.length() < stop_speed:
		velocity = Vector2()
		
	#Move & Bounce if necessary
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.normal)
		
	if StrokesRemaining == 0 && !InAnimation && velocity.length() == 0:
		Global.reset_level()
		
func _input(event):
	if(velocity.length() == 0 && Input.is_action_just_pressed("Click") && to_local(get_global_mouse_position()).distance_to(hitbox.position) < hitbox.shape.radius):
		clicked = true
		sprite.modulate = Color(1, 0, 1)
		
	if(Input.is_action_just_released("Click") && clicked):
		clicked = false
		calculate_power()
		launch_ball()
		sprite.modulate = Color(1, 1, 1)
		
	if(Input.is_action_pressed("RestartLevel")):
		Global.reset_level()
	
func calculate_power():
	force = abs(position.distance_to(get_global_mouse_position())) * distance_power_multiplier
	if force > max_ball_speed:
		force = max_ball_speed

func launch_ball():
	look_at(get_global_mouse_position())
	velocity = Vector2(force, 0)
	velocity = velocity.rotated(rotation)	
	StrokesRemaining -= 1
	


