extends Node2D


var current_life = 3

func _ready():
	$win.visible = false
	$lose.visible = false
	$scam_profile.profile_completed.connect(_on_profile_completed)


func _decrease_life():
	if current_life == 3:
		$life_bar/lives3/FullLife.visible = false
	elif current_life == 2:
		$life_bar/lives/FullLife.visible = false
	elif current_life == 1:
		$life_bar/lives2/FullLife.visible = false
	
	current_life -= 1

	if current_life <= 0:
		_on_game_over()

func _on_profile_completed():
	if current_life > 0:
		$win.visible = true
		$lose.queue_free()
	else:
		$lose.visible = true
		$win.queue_free()  # Remove win node


func _on_game_over():
	print("Game over!")  # You can replace this with actual end-game logic
	
