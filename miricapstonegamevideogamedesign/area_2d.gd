extends Area2D

# Signal for when the player collides with the SpikyCandyCane
signal player_collided

# Called when another body enters the area (player hits the SpikyCandyCane)
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("fairy"):  # Ensure we only react when the player collides
		print("Player collided with SpikyCandyCane!")  
		
		# Call the take_damage method on the player
		body.take_damage()  # Reduces health by 1

		queue_free()  # Remove the SpikyCandyCane from the scene after collision
		emit_signal("player_collided")  
