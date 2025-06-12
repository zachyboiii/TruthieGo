extends Node2D






func _on_login_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/Board2D.tscn")
