extends Area2D

# Signal for when the player collides with the GoodCandyCane
signal player_collided

# Called when another body enters the area (player hits the GoodCandyCane)
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("fairy"):  # Assuming the player is in the "fairy" group
		print("Player collided with GoodCandyCane!")
		body.add_points(1)  # Add a point to the player
		queue_free()  # Remove the GoodCandyCane from the scene after collecting it
		emit_signal("player_collided")  # Emit the signal (optional, if needed elsewhere)


func _on_player_collided() -> void:
	pass # Replace with function body.
