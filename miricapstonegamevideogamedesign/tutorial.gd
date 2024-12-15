extends Control



func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://mainscene.tscn")


func _on_tutorial_pressed() -> void:
	pass # Replace with function body.
	get_tree().change_scene_to_file("res://tutorial.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
