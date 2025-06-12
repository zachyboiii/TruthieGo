extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_loading_timer_timeout() -> void:
	$loading_screen_fake_news.visible = false 
	$fake_news_instruction.visible = true 
	
