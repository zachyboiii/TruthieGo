extends Node2D

func _ready():
	$scamSwipe_instructions.visible = false
	$scam_swipe_gameplay.visible = false


func _on_loading_timer_timeout():
	$scam_swipe_loading.visible = false
	$scamSwipe_instructions.visible = true
