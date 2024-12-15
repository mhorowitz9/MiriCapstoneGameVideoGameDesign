extends Area2D

# Signal for when the player collides with the GoodCandyCane
signal player_collided

# Called when another body enters the area (player collects the GoodCandyCane)
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("fairy"):  # Assuming the player is in the "fairy" group
		print("Player collided with GoodCandyCane!")
		body.add_points(1)  # Add a point to the player
		queue_free()  # Remove the GoodCandyCane from the scene after collecting it
		emit_signal("player_collided")  # Optional: Emit the signal if you need it elsewhere
