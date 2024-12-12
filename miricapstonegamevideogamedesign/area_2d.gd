extends Area2D


signal player_collided


func _on_body_entered(body: Node) -> void:
	
	if body.is_in_group("fairy"):  
		print("Player touched the spiky candy cane!")

		body.take_damage()  
	
		emit_signal("player_collided")
