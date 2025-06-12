extends Control


func _on_cross_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/story_loss.tscn")
