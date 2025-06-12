extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$EndButton/end.pressed.connect(_on_end_button_pressed)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_end_button_pressed() -> void:
	Globals.add_points(20)
	get_tree().change_scene_to_file("res://scenes/Board2D.tscn")
