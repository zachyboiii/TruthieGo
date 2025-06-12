extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_win_screen_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/greatjob_win.tscn")


func _on_a_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/a_last.tscn")
