extends CharacterBody2D

# Constants for movement
const MAX_SPEED = 400
const ACCELERATION = 1500
const FRICTION = 600
const GRAVITY = 1900
const JUMP_VELOCITY = -1000

# Dash variables
const DASH_SPEED = 1000
var can_dash = false
var can_dash_ready = true

# Input variables
var input_x = 0.0
var input_y = 0.0

func _process(delta):
	# Apply gravity if not on the floor
	if not is_on_floor():
		velocity.y += GRAVITY * delta

func _physics_process(delta):
	# Handle player movement
	handle_player_movement(delta)

	# Handle dash input
	if Input.is_action_just_pressed("dash") and can_dash_ready:
		initiate_dash()

func get_input():
	# Get input for horizontal movement
	input_x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	return input_x

func handle_player_movement(delta):
	input_x = get_input()

	# Apply friction if no input is given
	if input_x == 0:
		apply_friction(delta)
	else:
		apply_acceleration(delta)

	# Handle jumping
	if is_on_floor() and Input.is_action_pressed("ui_up"):
		velocity.y = JUMP_VELOCITY

	# Handle dashing
	if can_dash:
		handle_dash()

	# Move the character
	move_and_slide()

func apply_friction(delta):
	if velocity.length() > (FRICTION * delta):
		velocity.x -= sign(velocity.x) * (FRICTION * delta)
	else:
		velocity.x = 0

func apply_acceleration(delta):
	velocity.x += (input_x * ACCELERATION * delta)
	velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)

func handle_dash():
	if input_x != 0:
		velocity.x = input_x * DASH_SPEED

func initiate_dash():
	can_dash = true
	can_dash_ready = false
	$Timer.start()
	$timer_again.start()

func _on_timer_timeout() -> void:
	can_dash = false

func _on_timer_again_timeout() -> void:
	can_dash_ready = true
