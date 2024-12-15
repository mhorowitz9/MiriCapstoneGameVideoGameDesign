extends Area2D

# Signal for when the player collides with the SpikyCandyCane
signal player_collided

# Called when another body enters the area (player hits the SpikyCandyCane)
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("fairy"):  # Assuming the player is in the "fairy" group
		print("Player touched the spiky candy cane!")
		body.take_damage()  # Deal damage to the player
		emit_signal("player_collided")  # Optional: Emit the signal if you need it elsewhere
