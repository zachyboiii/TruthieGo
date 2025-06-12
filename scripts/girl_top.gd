extends Node2D


func _on_texture_button_bottom_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/girl_bottom.tscn") # Replace with function body.


func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Board2D.tscn") # Replace with function body.
