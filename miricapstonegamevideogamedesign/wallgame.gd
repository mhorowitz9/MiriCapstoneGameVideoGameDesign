extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("fairy"):  # Check if the colliding body is the player
		body.win_game()  # Call win_game() on the player to trigger the win condition
