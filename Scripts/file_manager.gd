class_name FileManager
extends Node2D

@onready var Code: CodeEdit = %Code;
@onready var file_dialog = %FileDialog
@onready var tabs: GriddyTabBar = %TabBar
@onready var canvas_layer: CanvasLayer = $CanvasLayer
const NOTICE = preload("res://Scenes/notice.tscn")

var current_file: String;
var current_dir: String = "/";

var open_files: Array[String] = [];
var buffers: Dictionary = {}; # path -> { text, line, col, scroll, file_modified }

var time_start = 0
var time_now = 0

func _ready():
	print(OS.get_cmdline_args())
	if LuaSingleton.discord_sdk:
		DiscordSDK.app_id = 1220393467738591242 # Application ID

		DiscordSDK.large_image = "griddycode" # Image key from "Art Assets"
		DiscordSDK.large_image_text = "https://github.com/face-hh/griddycode"
		DiscordSDK.start_timestamp = int(Time.get_unix_time_from_system())
	var running_on_gaming_os = OS.get_name() == "Windows"
	if running_on_gaming_os:
		current_dir = "C:/"

	var args = OS.get_cmdline_args()
	var is_debug = OS.is_debug_build()
	var path = []

	# in order to be compatible with the gayming OS...
	var pwd_cmd = "pwd"
	# I didn't know that godot doesn't execute
	# commands within batch on Windows...
	var exec_args = []

	if running_on_gaming_os:
		# running "cd" (in batch) without any args will only print the path
		pwd_cmd = "cmd.exe"
		exec_args.append("/C")
		exec_args.append("cd")

	OS.execute(pwd_cmd, exec_args, path)

	if running_on_gaming_os:
		# EWW GROSS
		# why are we still using CRLF?
		path[0] = path[0].replace("\r", "")
	path = path[0].replace("\n", "")

	if args.size() > 0:
		if args[0] != ".":
			current_file = path + "/" + args[0]
		current_dir = path

	var is_cli = args.size() > 0
	print("INFO: Running inside CLI mode: ", is_cli)

	inject_lua()
	check_for_reserved()

	load_game(is_cli)
	restore_tabs(is_cli)

	LuaSingleton.themes = list_themes()

	if !current_file.is_empty():
		LuaSingleton.setup_extension(current_file.get_extension())
	LuaSingleton.setup_theme(LuaSingleton.theme)

	tabs.editor = self
	tabs.refresh()

	file_dialog.setup()

	if !current_file:
		LuaSingleton.setup_discord_sdk("Idle", "")
		Code.toggle(%FileDialog)
		warn(tr("WELCOME"))

func check_for_reserved() -> void:
	var folders = ["langs", "themes"]

	for folder in folders:
		if !DirAccess.dir_exists_absolute(folder):
			DirAccess.make_dir_recursive_absolute("user://" + folder)

func _on_file_dialog_file_selected(path: String) -> void:
	open_file(path)

func inject_lua() -> void:
	DirAccess.make_dir_absolute("user://themes")
	DirAccess.make_dir_absolute("user://langs")

	var themes = DirAccess.open("res://Lua/Themes").get_files()
	var plugins = DirAccess.open("res://Lua/Plugins").get_files()

	for theme in themes:
		copy_if_not_exist("themes", "Themes", theme)
	for plugin in plugins:
		copy_if_not_exist("langs", "Plugins", plugin)

func copy_from_res(from: String, to: String) -> void:
	var file_from = FileAccess.open(from, FileAccess.READ)
	var file_to = FileAccess.open(to, FileAccess.WRITE)
	file_to.store_buffer(file_from.get_buffer(file_from.get_length()))
	file_to = null
	file_from = null

func copy_if_not_exist(user_path: String, res_path: String, file: String) -> void:
	if !file.contains("lua"): return

	var path = "user://" + user_path + "/" + file;
	var current_path = "res://Lua/" + res_path + "/" + file;

	DirAccess.remove_absolute(path)
	copy_from_res(current_path, path)

func warn(notice: String) -> void:
	var node = NOTICE.instantiate()

	canvas_layer.add_child(node)

	node.set_notice(notice)

	get_tree().create_timer(5).timeout.connect(func():
		node.queue_free()
	)

func open_file(path: String) -> void:
	LuaSingleton.setup_discord_sdk("Editing " + path.split("/")[-1], "In " + current_dir.split("/")[-1])

	if path.is_empty():
		return

	if open_files.has(path):
		switch_to(path)
		return

	open_files.append(path)
	buffers[path] = {
		"text": Fs._load(path),
		"line": 0,
		"col": 0,
		"scroll": 0,
		"file_modified": false,
	}

	current_file = path
	current_dir = path.get_base_dir()
	LuaSingleton.setup_extension(path.get_file().get_extension())
	load_buffer(current_file)
	tabs.refresh()

func switch_to(path: String) -> void:
	if path == current_file:
		tabs.refresh()
		return
	if !open_files.has(path):
		open_file(path)
		return

	save_current_buffer()
	current_file = path
	current_dir = path.get_base_dir()

	LuaSingleton.setup_discord_sdk("Editing " + path.split("/")[-1], "In " + current_dir.split("/")[-1])
	LuaSingleton.setup_extension(path.get_file().get_extension())

	load_buffer(current_file)
	tabs.refresh()

func save_current_buffer() -> void:
	if current_file.is_empty() or !buffers.has(current_file):
		return

	buffers[current_file] = {
		"text": Code.text,
		"line": Code.get_caret_line(0),
		"col": Code.get_caret_column(0),
		"scroll": Code.scroll_vertical,
		"file_modified": Code.file_modified,
	}

func load_buffer(path: String) -> void:
	var buffer: Dictionary = buffers[path]

	Code.text = buffer["text"]
	Code.set_caret_line(buffer["line"], true, -1, 0)
	Code.set_caret_column(buffer["col"])
	Code.scroll_vertical = buffer["scroll"]
	Code.file_modified = buffer["file_modified"]

	Code.setup_highlighter()

func close_tab(path: String) -> void:
	if !open_files.has(path):
		return

	var index := open_files.find(path)

	save_current_buffer()
	if buffers.has(path):
		var buffer: Dictionary = buffers[path]
		if buffer["file_modified"]:
			var err := Fs.save(path, buffer["text"])
			if err != OK:
				push_error("Failed to save %s on close: %d" % [path, err])

	buffers.erase(path)
	open_files.remove_at(index)

	if open_files.is_empty():
		current_file = ""
		Code.text = ""
		Code.file_modified = false
		Code.setup_highlighter()
		tabs.refresh()
		Code.toggle(%FileDialog)
		warn(tr("WELCOME"))
		return

	if path != current_file:
		tabs.refresh()
		return

	var new_index := clampi(index, 0, open_files.size() - 1)
	current_file = open_files[new_index]
	current_dir = current_file.get_base_dir()

	load_buffer(current_file)
	tabs.refresh()

func restore_tabs(is_cli: bool) -> void:
	if is_cli:
		if current_file.is_empty():
			return
		open_files.clear()
		buffers.clear()
		open_file(current_file)
		return

	if open_files.is_empty() and !current_file.is_empty():
		open_file(current_file)
		return

	if open_files.is_empty():
		return

	var saved_current := current_file
	current_file = ""
	for opened in open_files:
		buffers[opened] = {
			"text": Fs._load(opened),
			"line": 0,
			"col": 0,
			"scroll": 0,
			"file_modified": false,
		}

	if open_files.has(saved_current):
		current_file = saved_current
	else:
		current_file = open_files[0]

	current_dir = current_file.get_base_dir()

	load_buffer(current_file)

func list_themes() -> Array:
	var themes_folder = DirAccess.open("user://themes");

	var curated = [];

	for theme_file in themes_folder.get_files():
		curated.append(theme_file.replace(".lua", ""))

	return curated;

func get_property_value(settings: Array) -> Array:
	var out := []
	for setting in settings:
		out.append({ "property": setting.property, "value": setting.value })
	return out

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		var save_dict = {
			"current_file": current_file,
			"current_dir": current_dir,
			"open_files": open_files,
			"settings": get_property_value(LuaSingleton.settings),
			"theme": LuaSingleton.theme
		}

		save_data(save_dict)
		if !is_manual_save():
			save_all_buffers(false)
			var err_close = Fs.save(current_file, Code.text)
			if err_close != OK and current_file:
				push_error("Failed to save %s on close: %d" % [current_file, err_close])

		get_tree().quit()
	if what == MainLoop.NOTIFICATION_APPLICATION_FOCUS_OUT:
		if is_manual_save(): return
		save_all_buffers(true)

func save_all_buffers(focus_out: bool) -> void:
	for opened in open_files:
		if opened == current_file and !focus_out:
			continue
		if !buffers.has(opened):
			continue
		var err = Fs.save(opened, buffers[opened]["text"])
		if err != OK:
			push_error("Failed to save %s on close: %d" % [opened, err])
		buffers[opened]["file_modified"] = false

func save_data(dict: Dictionary):
	var save_game = FileAccess.open("user://data.save", FileAccess.WRITE)

	var json_string = JSON.stringify(dict)

	save_game.store_line(json_string)

func load_game(cli: bool = false):
	if not FileAccess.file_exists("user://data.save"):
		return # Error! We don't have a save to load.

	var save_game = FileAccess.open("user://data.save", FileAccess.READ)
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()

		var json = JSON.new()

		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		var node_data = json.get_data()

		if !cli:
			current_dir = node_data["current_dir"]
			current_file = node_data["current_file"]
			if node_data.has("open_files") and node_data["open_files"] is Array:
				open_files = node_data["open_files"]

		LuaSingleton.theme = node_data["theme"]

		var settings = node_data["settings"]

		for dic: Dictionary in settings:
			LuaSingleton.handle_internal_setting_change(dic.property, dic.value)

			var index = LuaSingleton.get_setting(dic.property)[1]

			if index == -1:
				print("WARNING: Omitted setting \"%s\" due to finding operation failing." % dic.property)
				return

			LuaSingleton.settings[index].value = dic.value

		LuaSingleton.on_settings_change.emit()


func save_current_file() -> Error:
	if current_file.is_empty():
		warn(tr("WARN_NO_FILE"))
		return ERR_FILE_NOT_FOUND

	var err = Fs.save(current_file, Code.text)
	if err == OK:
		Code.file_modified = false
		if buffers.has(current_file):
			buffers[current_file]["file_modified"] = false
		tabs.refresh()
		warn(tr("SAVED"))
	else:
		warn(tr("WARN_SAVE_FAILED") % current_file)
	return err

func is_manual_save() -> bool:
	return bool(LuaSingleton.get_setting("manual_save")[0].get("value", false))

func _on_auto_save_timer_timeout():
	if is_manual_save(): return
	if !current_file: return
	if !Code.file_modified: return

	var err = Fs.save(current_file, Code.text)
	if err != OK:
		push_error("Auto-save failed for %s: %d" % [current_file, err])
		return
	Code.file_modified = false;
	if buffers.has(current_file):
		buffers[current_file]["file_modified"] = false
	tabs.refresh()

func switch_next_tab() -> void:
	if open_files.is_empty(): return
	var index := open_files.find(current_file)
	switch_to(open_files[(index + 1) % open_files.size()])

func switch_prev_tab() -> void:
	if open_files.is_empty(): return
	var index := open_files.find(current_file)
	switch_to(open_files[(index - 1 + open_files.size()) % open_files.size()])

func switch_to_index(index: int) -> void:
	if index < 0 or index >= open_files.size(): return
	switch_to(open_files[index])

func close_current_tab() -> void:
	if current_file.is_empty(): return
	close_tab(current_file)

func preview_theme(index: int) -> void:
	var theme_picker: OptionButton = %ThemeChooser
	var theme = theme_picker.get_item_text(index)

	LuaSingleton.setup_theme(theme)
	LuaSingleton.on_settings_change.emit()

func _on_theme_chooser_item_focused(index):
	preview_theme(index)


func _on_theme_chooser_item_selected(index):
	preview_theme(index)
	LuaSingleton.theme = %ThemeChooser.get_item_text(index)
