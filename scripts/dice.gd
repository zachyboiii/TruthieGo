extends Node2D

@onready var dice_sprite = $DiceSprite  # reference your AnimatedSprite2D node

signal dice_rolled(result: int)

func roll_dice_once():
	dice_sprite.play("roll")
	await get_tree().create_timer(0.6).timeout
	dice_sprite.stop()

	var result = randi() % 6
	dice_sprite.frame = result
	emit_signal("dice_rolled", result + 1)
