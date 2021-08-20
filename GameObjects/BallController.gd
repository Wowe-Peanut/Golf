extends KinematicBody2D


#Child Nodes
onready var sprite = $Sprite
onready var hitbox = $Hitbox

#Physics Properties
var max_ball_speed = 3000
var friction_ceoffient = 0.95
var distance_power_multiplier = 6
var stop_speed = 1

#Other
var clicked = false
var velocity = Vector2()
var force = 0

func _ready():
	position.x = 200
	position.y = 200
	
func _physics_process(delta):
	
	#Apply Friction
	velocity *= friction_ceoffient
	if velocity.length() < stop_speed:
		velocity = Vector2()
		
	#Move & Bounce if necessary
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.normal)
		
func _input(event):
	if(velocity.length() == 0 && Input.is_action_just_pressed("Click")):
		clicked = true
		sprite.modulate = Color(1, 0, 1)
		
	if(Input.is_action_just_released("Click") && clicked):
		clicked = false
		calculate_power()
		launch_ball()
		sprite.modulate = Color(1, 1, 1)
	
func calculate_power():
	force = abs(position.distance_to(get_global_mouse_position())) * distance_power_multiplier
	if force > max_ball_speed:
		force = max_ball_speed

func launch_ball():
	look_at(get_global_mouse_position())
	velocity = Vector2(force, 0)
	velocity = velocity.rotated(rotation)	
	
