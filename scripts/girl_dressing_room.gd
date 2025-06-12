extends Node2D


func _on_texture_button_go_to_boy_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Boy Dressing Room.tscn") # Replace with function body.


func _on_texture_button_customise_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/girl_hair.tscn") # Replace with function body.


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Board2D.tscn") # Replace with function body.
