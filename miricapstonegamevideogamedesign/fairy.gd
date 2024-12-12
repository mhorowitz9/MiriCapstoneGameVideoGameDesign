extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -800.0
const GRAVITY = 1500.0

# Health variable
var health = 3


@onready var Heart1 = $CanvasLayer/Heart1
@onready var Heart2 = $CanvasLayer/Heart2
@onready var Heart3 = $CanvasLayer/Heart3


func _ready():

	add_to_group("fairy")

	
	if Heart1 == null or Heart2 == null or Heart3 == null:
		print("Error: One or more heart nodes not found.")
		return

	# Update health UI based on initial health value
	update_health_ui()

# Called every frame
func _physics_process(delta: float) -> void:
	# Gravity and movement code
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func take_damage():
	health -= 1
	print("Player hit! Current health: " + str(health))  # Debug print to check health
	update_health_ui()  


func update_health_ui():
	if Heart1 == null or Heart2 == null or Heart3 == null:
		print("Error: Heart nodes are not properly initialized.")
		return

	
	Heart1.visible = health >= 1
	Heart2.visible = health >= 2
	Heart3.visible = health >= 3


func _on_body_entered(body: Node) -> void:

	if body.is_in_group("fairy"):  
		print("Player touched the spiky candy cane!")
		body.take_damage()  
