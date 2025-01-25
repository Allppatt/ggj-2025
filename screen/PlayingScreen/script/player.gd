extends CharacterBody2D

const max_speed = 125
const accel = 1400
const friction = 1000
const GRAVITY := 1900
const JUMP_VELOCITY := -1000
var input = Vector2.ZERO

#fordash
var dash_speed = 1000
var can_dash = false
var can_dashhh = true

func _process(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta

func _physics_process(delta):
	player_movement(delta)
	
	if Input.is_action_just_pressed("dash") and can_dashhh:
		can_dash = true
		can_dashhh = false
		$Timer.start()
		$timer_again.start()

func get_input():
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	return input.normalized()
	
func player_movement(delta):
	input = get_input()
	
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (input * accel * delta)
		velocity = velocity.limit_length(max_speed)
	
	if is_on_floor() and Input.is_action_pressed("ui_up"):
		velocity.y = JUMP_VELOCITY
	
	var direct :=  Input.get_axis("ui_left","ui_right")
	if direct:
		if can_dash:
			velocity.x = direct * dash_speed
		else:
			velocity.x = direct * max_speed
		
	move_and_slide()


func _on_timer_timeout() -> void:
	can_dash = false


func _on_timer_again_timeout() -> void:
	can_dashhh = true
