extends CharacterBody2D

# Constants for movement and gravity
const SPEED = 300.0
const JUMP_VELOCITY = -800.0
const GRAVITY = 1500.0  # Gravity constant

# Health and points variables
var health = 3
var points = 0  # Player's score

# Animation reference for AnimatedSprite2D
@onready var animated_sprite = $AnimatedSprite2D

# Health UI elements (adjust paths to match your scene)
@onready var Heart1 = $CanvasLayer/Heart1
@onready var Heart2 = $CanvasLayer/Heart2
@onready var Heart3 = $CanvasLayer/Heart3
@onready var score_label = $CanvasLayer/ScoreLabel  # Make sure ScoreLabel is correctly referenced

# Movement states
var is_jumping = false
var is_flying = false
var is_facing_right = true

# Called when the node enters the scene tree
func _ready():
	add_to_group("fairy")  # Make sure the player is in the "fairy" group for collision detection
	if animated_sprite == null:
		print("Error: AnimatedSprite2D node not found!")  # Debugging line
	else:
		animated_sprite.play("idle")  # Only play animation if it's valid

	# Update health UI based on initial health value
	update_health_ui()

# Called every frame
func _physics_process(delta: float) -> void:
	# Gravity and jumping logic
	if not is_on_floor():
		velocity.y += GRAVITY * delta  # Apply gravity
		if not is_jumping:
			play_animation("jumping")  # Play jumping animation if in the air
	else:
		if is_jumping:
			is_jumping = false
			if velocity.x != 0:
				play_animation("walk_left" if velocity.x < 0 else "walk_right")
			else:
				play_animation("idle")

	# Handle input for movement and jumping
	var direction = Input.get_axis("ui_left", "ui_right")

	# Jumping logic (spacebar)
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY  # Apply upward velocity for jumping
		is_jumping = true
		play_animation("jumping")  # Play jumping animation

	# Walking logic (not flying)
	elif direction != 0:
		velocity.x = direction * SPEED
		if direction < 0:
			is_facing_right = false
			play_animation("walk_left")
		else:
			is_facing_right = true
			play_animation("walk_right")
	else:
		# Idle animation when not moving
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if not is_jumping and is_on_floor():
			play_animation("idle")

	# Move the character (use built-in move_and_slide method)
	move_and_slide()

# Function to play animations based on movement or state
func play_animation(animation_name: String):
	# Safety check before accessing the animation property
	if animated_sprite != null and animated_sprite.animation != animation_name:
		animated_sprite.play(animation_name)

# Health UI Update Function
func update_health_ui():
	Heart1.visible = health >= 1
	Heart2.visible = health >= 2
	Heart3.visible = health >= 3
	score_label.text = "Score: " + str(points)

# Function to handle player collision with enemies (e.g., spiky candy cane)
func take_damage():
	health -= 1
	update_health_ui()  # Update the health UI
	if health <= 0:
		die()  # Call the die function if health is 0 or less

# Function to handle player's death
func die():
	health = 3  # Reset health
	update_health_ui()

	# Load the GameOver scene
	var game_over_scene = load("res://Scenes/GameOver.tscn")
	if game_over_scene == null:
		print("Error: Could not load the GameOver scene!")
		return  # Exit if the scene couldn't be loaded

	# Change to the GameOver scene
	get_tree().change_scene_to(game_over_scene)

	# Optionally, you can free the old scene after changing if needed
	# But this is usually not necessary unless you're managing resources manually
	# get_tree().current_scene.queue_free()  # Don't do this here
