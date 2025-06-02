extends Node2D

var move_speed := 300
var path := []
var moving := false
var target_pos := Vector2.ZERO

func _process(delta):
	if moving:
		var direction = (target_pos - position).normalized()
		position += direction * move_speed * delta
		if position.distance_to(target_pos) < 2:
			position = target_pos
			if path.size() > 0:
				target_pos = path.pop_front()
			else:
				moving = false

func move_along_path(tiles: Array):
	path = tiles.duplicate()
	if path.size() > 0:
		target_pos = path.pop_front()
		moving = true
