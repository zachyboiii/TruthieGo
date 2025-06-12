extends Control


# Called when the node enters the scene tree for the first time.

func _ready():
	$startButton.pressed.connect(_on_start_button_pressed)

func _on_start_button_pressed():
	queue_free()  # Deletes the scene
	# Show gameplay (sibling node)
	get_parent().get_node("scam_swipe_gameplay").visible = true




	
