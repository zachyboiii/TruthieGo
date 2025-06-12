extends Control



@onready var leaderboard_ui = $QuiverLeaderboards  # 🔁 Add this line

func _ready():
	leaderboard_ui.leaderboard_id = "truthiego-truthiego-0rxo"
	


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scripts/Board2D.tscn")
