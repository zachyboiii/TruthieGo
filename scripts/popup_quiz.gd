extends Control


func _on_no_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/hacked_screen.tscn")


func _on_cross_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/option_c.tscn")


func _on_yes_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/hacked_screen.tscn")
