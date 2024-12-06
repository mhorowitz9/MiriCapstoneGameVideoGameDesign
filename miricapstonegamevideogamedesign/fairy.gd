extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -800.0  # Higher jump velocity for a higher jump
const GRAVITY = 1500.0  # Increased gravity to make the character fall faster

func _physics_process(delta: float) -> void:
	# Apply gravity manually to the velocity.y axis.
	if not is_on_floor():
		velocity.y += GRAVITY * delta  # Apply custom gravity

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY  # Apply higher jump velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()  # Move the character with automatic collision handling
