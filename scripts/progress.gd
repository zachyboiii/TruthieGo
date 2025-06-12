extends Node2D

@onready var points_label = $progress_points

func _process(delta):
	var current_points = Globals.points
	points_label.text = str(current_points)


func _on_texture_button_sunny_beach_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/sunny_beach.tscn") # Replace with function body.


func _on_texture_button_meadow_park_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/meadow_park.tscn") # Replace with function body.


func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Board2D.tscn") # Replace with function body.
