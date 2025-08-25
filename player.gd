extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -400.0
var jump_count = 0
var dash_speed = 3
var is_dashing = false
func bounce_jump():
	#AudioController.play_jump()
	velocity.y = JUMP_VELOCITY
func jump_side(x):
	#AudioController.play_jump()
	velocity.y = JUMP_VELOCITY
	velocity.x = x
		
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and jump_count == 1:
		#AudioController.play_jump()
		velocity.y = JUMP_VELOCITY
		jump_count = 2
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		#AudioController.play_jump()
		velocity.y = JUMP_VELOCITY
		jump_count = 1
	if !Input.is_action_just_pressed("Jump") and is_on_floor():
		jump_count = 0;
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left", "Right")
	if Input.is_action_just_pressed("Dash"):
		if !is_dashing and direction:
			#AudioController.play_dash()
			start_dash()
		
	if direction:
		if is_dashing:
		
			velocity.x = direction * SPEED * dash_speed
		else:
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
func start_dash():
	is_dashing = true
	$DashTimer.connect("timeout", stop_dash)
	$DashTimer.start()
func stop_dash():
	is_dashing = false
	
