extends Control

@onready var info: RichTextLabel = $RichTextLabel2
@onready var current_version: RichTextLabel = $RichTextLabel

var is_requesting = false;

func _ready():
	current_version.text = tr("UPDATE_CURRENT") % LuaSingleton.version
	$HTTPRequest.request_completed.connect(_on_request_completed)

func _notification(what: int) -> void:
	if what == NOTIFICATION_TRANSLATION_CHANGED and is_node_ready():
		current_version.text = tr("UPDATE_CURRENT") % LuaSingleton.version

func _on_button_pressed():
	if is_requesting: return

	$HTTPRequest.request("https://api.github.com/repos/face-hh/griddycode/releases/latest")
	is_requesting = true

	info.show()

	info.text = tr("UPDATE_LOADING")

func _on_request_completed(_result, _response_code, _headers, body):
	info.clear()

	var json = JSON.parse_string(body.get_string_from_utf8())
	if !is_higher_version(json["name"]):
		info.text = tr("UPDATE_UP_TO_DATE")
	else:
		info.text = tr("UPDATE_NEW_AVAILABLE") % json["name"]

	info.show()

	is_requesting = false

	get_tree().create_timer(10).timeout.connect(info.hide)

func is_higher_version(new_version: String) -> bool:
	var current_components = LuaSingleton.version.replace("v", "").split(".")
	var new_components = new_version.replace("v", "").split(".")

	for i in range(3):
		var current_num = current_components[i]
		var new_num = new_components[i]

		if new_num > current_num:
			return true
		elif new_num < current_num:
			return false

	return false  # Same version if we reach here
