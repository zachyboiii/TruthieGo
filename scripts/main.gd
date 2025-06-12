extends Node2D

@onready var http = $HTTPRequest
@onready var points_label = $UILayer/PointsLabel
@onready var tBucks_label = $UILayer/TruthBucks
@onready var leaderboards = $QuiverLeaderboards  # Reference to your leaderboards node
@onready var vbox = $VBoxContainer



var board_path = []
var current_index = 0
var board_offset = Vector2(8, -1000)
var is_moving = false
var board_origin = Vector2(105, 105)

const TILE_SIZE = 105

func _process(delta):
	var current_points = Globals.points
	var current_buck = Globals.tBucks
	points_label.text = str(current_points)
	tBucks_label.text = str(current_buck)
	# update_user_stats(current_points, current_buck) 
	

func _ready():
	Globals.username = "TestPlayer"
	Globals.points = 123

	randomize()
	_generate_board_path()
	current_index = Globals.last_tile_index
	$Player.position = board_path[current_index]
	$UILayer/RollButton.pressed.connect(_on_roll_button_pressed)
	$Dice.dice_rolled.connect(_on_dice_rolled)

	await _submit_score_to_leaderboards()

	http.request_completed.connect(_on_http_request_request_completed)
	write_test_data()
	read_test_data()
	


func write_test_data():
	var url = "https://truthiego-default-rtdb.asia-southeast1.firebasedatabase.app/test.json"
	var data = {"message": "test2"}
	var json = JSON.stringify(data)
	var headers = ["Content-Type: application/json"]
	http.request(url, headers, HTTPClient.METHOD_PUT, json)

func read_test_data():
	var url = "https://truthiego-default-rtdb.asia-southeast1.firebasedatabase.app/test.json"
	http.request(url, [], HTTPClient.METHOD_GET)

func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var json = body.get_string_from_utf8()
	var data = JSON.parse_string(json)
	print("📦 Data from Firebase:", data)
	print("Response Code:", response_code)
	print("Body:", body.get_string_from_utf8())

func _generate_board_path():
	board_path.clear()

	# 1. Left column (bottom → top)
	for y in range(9, -1, -1):  # y: 9 → 0
		board_path.append(board_offset + Vector2(0, y) * TILE_SIZE)

	# 2. Top row (left → right), skip (0,0)
	for x in range(1, 10):  # x: 1 → 9
		board_path.append(board_offset + Vector2(x, 0) * TILE_SIZE)

	# 3. Right column (top → bottom), skip (9,0)
	for y in range(1, 10):  # y: 1 → 9
		board_path.append(board_offset + Vector2(9, y) * TILE_SIZE)

	# 4. Bottom row (right → left), skip (9,9) and (0,9)
	for x in range(8, 0, -1):  # x: 8 → 1
		board_path.append(board_offset + Vector2(x, 9) * TILE_SIZE)

func _on_roll_button_pressed():
	if is_moving:
		return
	is_moving = true
	$Dice.roll_dice_once()

func _on_dice_rolled(result: int):
	var path = []
	for i in range(1, result + 1):
		var index = (current_index + i) % board_path.size()
		path.append(board_path[index])
	current_index = (current_index + result) % board_path.size()

	$Player.move_along_path(path)
	await _wait_until_player_stops()
	is_moving = false
	_check_for_popup_quiz_tile()
	_check_for_scamswipe_tile()
	_check_for_fakenews_tile()
	_check_for_storymode_tile()

func _wait_until_player_stops():
	while $Player.moving:
		await get_tree().process_frame
		
func _check_for_popup_quiz_tile():
	var minigame_tiles = [4,7, 22, 13, 30]
	var other_minigame_tiles = [2,17, 33, 11, 29]
		
	print("Current tile index:", current_index)
	if current_index in minigame_tiles:
		print("🎯 Minigame tile hit!")
		_show_minigame_popup()
	elif current_index in other_minigame_tiles:
		_show_virus_popup()

func _show_minigame_popup():
	Globals.last_tile_index = current_index
	get_tree().change_scene_to_file("res://scenes/popup_quiz.tscn")

func _show_virus_popup():
	Globals.last_tile_index = current_index
	get_tree().change_scene_to_file("res://scenes/popup_quiz_virus_found.tscn")	
	
func _on_texture_button_pressed():
	Globals.last_tile_index = current_index
	var shop_scene = preload("res://scenes/girl_dressing_room.tscn")
	get_tree().change_scene_to_packed(shop_scene)
	print("✅ SHOP CLICKED")

func _check_for_scamswipe_tile():
	var minigame_tiles = [27]  

	print("Current tile index:", current_index)
	if current_index in minigame_tiles:
		print("🎯 Minigame tile hit!")
		_show_scamswipe_popup()

func _show_scamswipe_popup():
	Globals.last_tile_index = current_index
	get_tree().change_scene_to_file("res://scenes/scamSwipe_main.tscn")

func _check_for_fakenews_tile():
	var minigame_tiles = [9]

	print("Current tile index:", current_index)
	if current_index in minigame_tiles:
		print("🎯 Minigame tile hit!")
		_show_fakenews_popup()

func _show_fakenews_popup():
	Globals.last_tile_index = current_index
	get_tree().change_scene_to_file("res://scenes/fake_news.tscn")
	
func _check_for_storymode_tile():
	var minigame_tiles = [18]
	if current_index in minigame_tiles:
		_show_storymode_popup()
	
func _show_storymode_popup():
	Globals.last_tile_index = current_index
	get_tree().change_scene_to_file("res://scenes/storymode.tscn")
	
# Separate HTTP request for Firebase updates
func update_user_stats(points: int, tBucks: int) -> void:
	var url = "https://truthiego-default-rtdb.asia-southeast1.firebasedatabase.app/users/%s.json?auth=%s" % [Globals.firebase_uid, Globals.firebase_id_token]
	var body = JSON.stringify({
		"points": points,
		"truthBucks": tBucks
	})
	var headers = ["Content-Type: application/json"]
	var err = http.request(url, headers, HTTPClient.METHOD_PATCH, body)

	if err != OK:
		print("❌ Failed to update user stats:", err)
	else:
		print("✅ Updated user stats:", points, tBucks)
		
		# Submit score to Quiver Leaderboards (properly)
		# await Leaderboards.post_guest_score("truthiego-truthiego-0rxo", Globals.points, Globals.username if Globals.username != "" else "Anonymous")
		await _submit_score_to_leaderboards()





# Proper leaderboard submission
# 🟦 Submit the score after guest login
func _submit_score_to_leaderboards():
	await _ensure_guest_logged_in()

	var player_name = Globals.username if Globals.username != "" else "Anonymous"
	var score = Globals.points
	var leaderboard_id = "truthiego-truthiego-0rxo"

	print("🏆 Submitting score:", score, "Name:", player_name)

	var success = await Leaderboards.post_guest_score(
		leaderboard_id,
		score,
		player_name,
		{},  # metadata
		0.0,  # timestamp
		true  # retry
	)

	if success:
		print("✅ Score submitted to Quiver!")
	else:
		print("❌ Score submission failed.")


# 🟩 Ensure player is logged in as guest
func _ensure_guest_logged_in() -> void:
	if not PlayerAccounts.is_logged_in():
		var success = await PlayerAccounts.register_guest()
		if success:
			print("✅ Guest player registered")
		else:
			print("❌ Failed to register guest")


func _on_leaderboards_button_pressed() -> void:
	Globals.last_tile_index = current_index
	get_tree().change_scene_to_file("res://scenes/leaderboard.tscn")

func _on_progression_button_pressed() -> void:
	Globals.last_tile_index = current_index
	get_tree().change_scene_to_file("res://scenes/progress.tscn")
