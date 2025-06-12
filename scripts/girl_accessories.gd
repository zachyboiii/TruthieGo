extends Node2D


func _on_texture_button_back_to_board_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Board2D.tscn")


func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/girl_shoes.tscn")


func _on_texture_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/girl_bottom.tscn")


func _on_texture_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/girl_top.tscn")


func _on_texture_button_4_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/girl_hair.tscn")
