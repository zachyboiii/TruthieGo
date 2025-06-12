class_name LeaderboardUI
extends Control

# === CONFIGURABLE PROPERTIES ===
@export var leaderboard_id: String:
	set(id):
		leaderboard_id = id
		score_offset = 0

@export var score_filter := Leaderboards.ScoreFilter.ALL:
	set(filter):
		score_filter = filter
		score_offset = 0

@export var score_offset := 0
@export_range(1, 50) var score_limit := 10
@export_range(1, 25) var nearby_count := 5
@export var nearby_anchor := Leaderboards.NearbyAnchor.BEST
@export var current_player_highlight_color := Color("#005216")

# === UI References ===
@onready var next_button: Button = %NextButton
@onready var prev_button: Button = %PrevButton
@onready var score_list: Tree = %ScoreList
@onready var scores_label: Label = %ScoresLabel
@onready var title_label: Label = %TitleLabel

# === INIT ===
func _ready() -> void:
	if not score_list:
		printerr("❌ LeaderboardUI Error: ScoreList node not found.")
		return
	
	# Setup table columns
	score_list.set_column_expand_ratio(1, 3)
	var column_names := ["Rank", "Name", "CyberShields"]
	for i in range(column_names.size()):
		score_list.set_column_title(i, column_names[i])
		score_list.set_column_title_alignment(i, HORIZONTAL_ALIGNMENT_LEFT)
	
	# Load data if ready
	if leaderboard_id:
		await get_tree().process_frame  # Ensure all nodes initialized
		refresh_scores()

# === LOAD SCORES ===
func refresh_scores():
	if not leaderboard_id:
		printerr("[Quiver Leaderboards] No leaderboard ID set.")
		return

	prev_button.disabled = score_offset == 0
	next_button.disabled = true

	score_list.clear()
	var root: TreeItem = score_list.create_item()

	var score_data: Dictionary
	match score_filter:
		Leaderboards.ScoreFilter.ALL:
			score_data = await Leaderboards.get_scores(leaderboard_id, score_offset, score_limit)
		Leaderboards.ScoreFilter.PLAYER:
			score_data = await Leaderboards.get_player_scores(leaderboard_id, score_offset, score_limit)
		Leaderboards.ScoreFilter.NEARBY:
			score_data = await Leaderboards.get_nearby_scores(leaderboard_id, nearby_count, nearby_anchor)
		_:
			score_data = {}

	# Handle response
	if "scores" in score_data and score_data["scores"].size() > 0:
		for score in score_data["scores"]:
			var row := score_list.create_item(root)
			row.set_text(0, str(int(score.get("rank", 0))))                      # 🟩 Rank (no decimal)
			row.set_text(1, str(score.get("name", "Unknown")))
			row.set_text(2, str(int(score.get("score", 0))))                    # 🟩 Score (no decimal)

			if score.get("is_current_player", false):
				for i in range(3):
					row.set_custom_bg_color(i, current_player_highlight_color)
	else:
		var row := score_list.create_item(root)
		row.set_text(0, score_data.get("error", "No scores were found."))

	next_button.disabled = not score_data.get("has_more_scores", false)


# === PAGINATION ===
func _on_prev_button_pressed() -> void:
	if score_offset > 0:
		score_offset = max(0, score_offset - score_limit)
		refresh_scores()

func _on_next_button_pressed() -> void:
	score_offset += score_limit
	refresh_scores()
