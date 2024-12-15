extends Node2D  # Using Node2D as root for a 2D scene

# Function to change to the main game scene when "Start" button is pressed
func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://mainscene.tscn")

# Function to change to the tutorial scene when "Tutorial" button is pressed
func _on_tutorial_pressed() -> void:
	get_tree().change_scene_to_file("res://tutorial.tscn")

# Function to quit the game when "Exit" button is pressed
func _on_exit_pressed() -> void:
	get_tree().quit()  # This will exit the game
