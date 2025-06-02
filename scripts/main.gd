extends Node2D

var board_path = []
var current_index = 0

func _ready():
	_generate_board_path()
	move_player_by_steps(8)  # Test: move 5 tiles forward


func _generate_board_path():
	board_path.clear()

	# Top row (left → right)
	for x in range(0, 9):
		board_path.append(Vector2(x, 0) * 70)

	# Right column (top → bottom)
	for y in range(1, 8):
		board_path.append(Vector2(8, y) * 70)

	# Bottom row (right → left)
	for x in range(7, -1, -1):
		board_path.append(Vector2(x, 8) * 70)

	# Left column (bottom → top)
	for y in range(7, 0, -1):
		board_path.append(Vector2(0, y) * 70)


func move_player_by_steps(steps):
	var path = []
	for i in range(steps):
		var index = (current_index + i) % board_path.size()
		path.append(board_path[index])
	current_index = (current_index + steps) % board_path.size()
	$Player.move_along_path(path)
