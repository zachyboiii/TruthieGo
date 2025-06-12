extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_false_button_pressed():
	get_tree().change_scene_to_file("res://scenes/wrong_answer.tscn")
	


func _on_correct_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/fake_news_win.tscn")
