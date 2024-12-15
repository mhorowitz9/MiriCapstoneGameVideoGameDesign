extends Area2D

# Signal for when the player collides with the GoodCandyCane
signal player_collided

# Called when another body enters the area (player hits the GoodCandyCane)
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("fairy"):  # Ensure we only react when the player collides
		print("Player collided with GoodCandyCane!")  # Debugging line
		
		# Call the add_points method on the player
		body.add_points(1)  # Adds 1 point to the player

		queue_free()  # Remove the GoodCandyCane from the scene after collecting it
		emit_signal("player_collided")  # Optional signal for other uses
