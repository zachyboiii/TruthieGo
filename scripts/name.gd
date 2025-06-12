extends Control

@onready var username_input = $UsernameLineEdit  # Replace with your actual LineEdit node name
@onready var http_request = $HTTPRequest         # Make sure an HTTPRequest node exists in your scene

func _on_lets_go_button_pressed() -> void:
	var username = username_input.text.strip_edges()
	if username == "":
		print("❗ Please enter a username.")
	else:
		Globals.username = username
		store_username(Globals.firebase_uid, username, Globals.firebase_id_token)

func store_username(uid: String, username: String, id_token: String) -> void:
	var url = "https://truthiego-default-rtdb.asia-southeast1.firebasedatabase.app/users/%s.json?auth=%s" % [uid, id_token]
	var body = JSON.stringify({
		"username": username
	})
	var headers = ["Content-Type: application/json"]
	var _err = await http_request.request(url, headers, HTTPClient.METHOD_PUT, body)

func _on_http_request_request_completed(_result: int, response_code: int, _headers: PackedStringArray, body: PackedByteArray) -> void:
	if response_code == 200:
		print("✅ Username saved for:", Globals.firebase_uid)
		get_tree().change_scene_to_file("res://scenes/login_choosechar.tscn")  # Replace with your next scene
	else:
		var msg = body.get_string_from_utf8()
		print("❌ Error storing username:", msg)
