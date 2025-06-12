extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_option_a_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/option_a.tscn")


func _on_option_b_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/option_b.tscn")


func _on_option_c_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/option_c.tscn")
