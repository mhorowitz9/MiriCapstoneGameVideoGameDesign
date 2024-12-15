extends CharacterBody2D

# Constants for movement and gravity
const SPEED = 300.0
const JUMP_VELOCITY = -900.0
const GRAVITY = 1500.0  # Gravity constant

# Health and points variables
var health = 3
var points = 0  # Player's score

# Animation reference
@onready var animated_sprite = $AnimatedSprite2D

# Health UI elements
@onready var Heart1 = $CanvasLayer/Heart1
@onready var Heart2 = $CanvasLayer/Heart2
@onready var Heart3 = $CanvasLayer/Heart3
@onready var score_label = $CanvasLayer/ScoreLabel  # Make sure ScoreLabel is correctly referenced

# Game Over scene reference
var game_over_scene = preload("res://GameOver.tscn")

# Movement states
var is_jumping = false
var is_flying = false
var is_facing_right = true

# Called when the node enters the scene tree
func _ready():
	add_to_group("fairy")  # Ensure player is part of "fairy" group for collision detection

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
				play_animation("walking" if velocity.x != 0 else "idle")
			else:
				play_animation("idle")

	# Handle input for movement and jumping
	var direction = Input.get_axis("ui_left", "ui_right")

	# Jumping logic (spacebar)
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY  # Apply upward velocity for jumping
		is_jumping = true
		play_animation("jumping")  # Play jumping animation

	# Flying logic (spacebar held down)
	elif Input.is_action_pressed("ui_accept"):
		is_flying = true
		if direction < 0:
			is_facing_right = false
			play_animation("flyingleft")
			velocity.x = -SPEED  # Move left while flying
		elif direction > 0:
			is_facing_right = true
			play_animation("flyingright")
			velocity.x = SPEED  # Move right while flying

	# Walking logic (not flying)
	elif direction != 0:
		is_flying = false
		velocity.x = direction * SPEED
		if direction < 0:
			is_facing_right = false
			play_animation("walkingleft")
		else:
			is_facing_right = true
			play_animation("walkingright")
	else:
		# Idle animation when not moving
		is_flying = false
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if not is_jumping and is_on_floor():
			play_animation("idle")

	# Move the character (use built-in move_and_slide method)
	move_and_slide()

# Function to play animations based on movement or state
func play_animation(animation_name: String):
	if animated_sprite.animation != animation_name:
		animated_sprite.play(animation_name)

# Function to handle the player's death (transition to Game Over scene)
func die():
	print("Player died!")
	health = 3  # Reset health (optional)
	update_health_ui()  # Update health UI
	get_tree().change_scene_to_file("res://GameOver.tscn")  # Change to Game Over scene

# Function to update health UI
func update_health_ui():
	Heart1.visible = health >= 1
	Heart2.visible = health >= 2
	Heart3.visible = health >= 3
	score_label.text = "Score: " + str(points)

# Function to add points
func add_points(amount: int):
	points += amount
	update_health_ui()  # Update UI after adding points

# Function to take damage
func take_damage():
	health -= 1
	update_health_ui()  # Update UI after taking damage

	if health <= 0:
		die()  # Call die() to handle Game Over
	else:
		play_animation("lose")  # Play "hurt" animation when the player takes damage
