extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_left_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/login_choosechar.tscn")


func _on_right_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/login_choosechar.tscn")


func _on_chosen_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/login_loadingpage.tscn")
