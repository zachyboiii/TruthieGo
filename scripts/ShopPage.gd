extends Control

func _on_back_button_pressed():
	var board_scene = preload("res://scenes/Board2D.tscn")
	get_tree().change_scene_to_packed(board_scene)
