extends Node


func _on_antivirus_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/hacked_screen.tscn")


func _on_ignore_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/hacked_screen.tscn")


func _on_cross_button_pressed() -> void:
	
	get_tree().change_scene_to_file("res://scenes/option_c.tscn")
