extends Node2D

@onready var tween = $Tween
signal profile_completed


func _ready():
	$cross_button/cross.pressed.connect(_on_cross_pressed)
	$like_button/like.pressed.connect(_on_like_pressed)  # Optional if you want to handle like too
	$WarningNotif/next_button/next.pressed.connect(_on_next_pressed)

func _on_like_pressed():
	$WarningNotif.visible = true  # Show warning
	get_parent()._decrease_life()  # Call up to scam_swipe_gameplay

func _on_cross_pressed():
	var tween := create_tween()
	var end_pos = position + Vector2(-1000, 0)
	tween.tween_property(self, "position", end_pos, 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	await tween.finished
	emit_signal("profile_completed")
	queue_free()
	
func _on_next_pressed():
	var tween := create_tween()
	var end_pos = position + Vector2(1000, 0)
	tween.tween_property(self, "position", end_pos, 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	await tween.finished
	emit_signal("profile_completed")
	queue_free()
