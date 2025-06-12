extends Node2D

func _ready() -> void:
	Globals.add_points(20)
	Globals.add_tBuck(120)

func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Board2D.tscn")
