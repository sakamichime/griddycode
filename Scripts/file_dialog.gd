class_name FileDialogType

extends RichTextLabel

@onready var editor: FileManager = $".."
@onready var code = %Code

var selected_index: int = 0
var dir: DirAccess
var dirs: Array[String]
var bbcode_dirs: Array[String]
var shortened_dirs: Array[String]
var files: Array[String]

var query: String = ""
var create_mode: int = 0
var _cancel_consumed: bool = false
var search_limit: int = 1000
var current_dirs_count: int = 0
var handled: bool
var erased: bool
var max_coincidence: Array = []
var coincidence: Array = []

var zoom: Vector2;

var active: bool = false;
signal ui_close

func change_dir(path) -> void:
	query = ""
	if !dir: dir = DirAccess.open(path)
	#dir.include_hidden = true
	# WARNING: this will heavily affect performance if de-commented

	dirs = [".."];
	dirs.append_array(dir.get_directories())
	dirs.append_array(dir.get_files())

	shortened_dirs = []
	for dir_ in dirs:
		if len(dir_) > 30:
			dir_ = dir_.left(30) + "..." + dir_.right(3)
		shortened_dirs.append(dir_)

	bbcode_dirs = []
	bbcode_dirs.append_array(dirs)

	current_dirs_count = len(dirs)

	files.append_array(dir.get_files())

	zoom = %Cam.to_zoom(code.get_longest_line(dirs).length())

	if active:
		%Cam.focus_on(gp(), zoom)

func setup() -> void:
	active = false
	create_mode = 0
	change_dir(editor.current_dir)

	update_ui()

func _input(event: InputEvent) -> void:
	if !active: return
	if !(event is InputEventKey): return

	var key_event = event as InputEventKey
	bbcode_dirs = []
	bbcode_dirs.append_array(dirs)

	if !(key_event.is_pressed()): return;

	if create_mode != 0:
		_handle_create_input(key_event)
		return

	handled = true
	if key_event.keycode == KEY_UP:
		selected_index = max(0, selected_index - 1)
	elif key_event.keycode == KEY_DOWN:
		selected_index = min(len(dirs) - 1, selected_index + 1)
	elif key_event.keycode == KEY_ENTER:
		handle_enter_key()
	else:
		handled = false

	erased = false
	if current_dirs_count <= search_limit and !handled:
		if key_event.keycode == KEY_BACKSPACE:
			erased = true
			if len(query) > 0:
				query = query.substr(0, len(query) - 1)
		elif key_event.as_text() == 'Ctrl+Backspace':
			erased = true
			query = ""
		if len(key_event.as_text()) == 1:
			query += key_event.as_text().to_lower()
		elif key_event.keycode == KEY_PERIOD:
			query += "."

	max_coincidence = []

	if len(query) > 0:
		for i in range(1, len(dirs)):
			coincidence = fuzzy_search(shortened_dirs[i].to_lower(), query)
			bbcode_dirs[i] = make_bold(shortened_dirs[i], coincidence)
			if is_closer(max_coincidence, coincidence):
				max_coincidence = coincidence
				if not handled:	selected_index = i

	update_ui()

func _handle_create_input(key_event: InputEventKey) -> void:
	if key_event.ctrl_pressed or key_event.meta_pressed:
		if key_event.keycode == KEY_ESCAPE or Input.is_action_just_pressed("ui_cancel"):
			_cancel_consumed = true
			cancel_create()
		return
	if key_event.keycode == KEY_ESCAPE or Input.is_action_just_pressed("ui_cancel"):
		_cancel_consumed = true
		cancel_create()
		return
	if key_event.keycode == KEY_ENTER:
		confirm_create(query)
		return
	if key_event.keycode == KEY_BACKSPACE:
		if len(query) > 0:
			query = query.substr(0, len(query) - 1)
		update_ui()
		return
	var character = key_event.unicode
	if character == 0:
		return
	if len(query) == 0 and character == 46: # leading dot
		return
	if query.contains("/") or query.contains("\\"):
		return
	query += char(character)
	update_ui()

func update_ui() -> void:
	clear()
	show_items()

func show_items() -> void:
	_draw_create_indicator()
	for i in range(len(bbcode_dirs)):
		show_item(i)

func show_item(index: int) -> void:
	var item = dirs[index]
	var bbcode_item = bbcode_dirs[index]
	if is_selected(item):
		push_bgcolor(LuaSingleton.gui.selection_color)
	else:
		push_bgcolor(Color(0, 0, 0, 0))  # Reset background color if not selected

	var is_dir = dir.get_directories().find(item) != -1

	if item == "..":
		push_color(LuaSingleton.gui.font_color)
		add_text("󰕌")
	elif is_dir:
		push_color(LuaSingleton.gui.completion_selected_color)
		add_text("")
	else:
		var extension = item.split(".")[-1]
		var data = Icons.get_icon_data(extension)

		push_color(Color.from_string(data.color, data.color))
		add_text(data.icon)

	pop()

	var filename = bbcode_item.split(".")[0]

	if is_dir: filename = bbcode_item


	if bbcode_item == "..":
		append_text(" %s\n" % [ bbcode_item ])
	elif is_dir or !item.contains("."):
		append_text(" %s\n" % [ filename ])
	else:
		append_text(" %s.%s\n" % [ filename, bbcode_item.split(".")[1] ])

	if active: %Cam.focus_on(Vector2(gp().x, global_position.y + (selected_index * 23)), zoom)

# i gave up at that point, sorry for what you're about to witness
func is_selected(item: String) -> bool:
	var dir_item = dirs.find(item);

	var is_dir_item = dir_item != -1;
	var is_dir_current = dir_item == selected_index;

	return (is_dir_item and is_dir_current)

func handle_enter_key() -> void:
	if selected_index > len(dirs): return
	# ^^ this happens when the cursor was at, i.e., pos. 6, but arr is only has 4 entries

	var item = dirs[selected_index];

	var is_file = files.find(item) != -1;

	if is_file:
		editor.current_dir = dir.get_current_dir();
		editor.open_file(editor.current_dir + "/" + item)

		LuaSingleton.setup_extension(item.split(".")[-1])

		code.setup_highlighter()
		get_tree().create_timer(.1).timeout.connect(func():
			code.grab_focus()
		)

		ui_close.emit()
	else:
		selected_index = 0;
		dir.change_dir(item)
		change_dir(item)
	update_ui()

func enter_create_mode(mode: int) -> void:
	create_mode = mode
	query = ""
	update_ui()

func cancel_create() -> void:
	create_mode = 0
	query = ""
	update_ui()

func try_consume_cancel() -> bool:
	if _cancel_consumed:
		_cancel_consumed = false
		return true
	return false

func confirm_create(name: String) -> void:
	name = name.strip_edges()
	if name.is_empty():
		return
	if name == "." or name == "..":
		editor.warn(tr("WARN_INVALID_NAME"))
		return
	if name.contains("/") or name.contains("\\"):
		editor.warn(tr("WARN_INVALID_NAME"))
		return

	var current_path = dir.get_current_dir()
	var target = current_path + "/" + name

	if create_mode == 2:
		if DirAccess.dir_exists_absolute(target):
			editor.warn(tr("WARN_EXISTS") % name)
			return
		var err = DirAccess.make_dir_recursive_absolute(target)
		if err != OK:
			editor.warn(tr("WARN_CREATE_FAILED"))
			return
		cancel_create()
		change_dir(current_path)
		update_ui()
		return

	if FileAccess.file_exists(target):
		editor.warn(tr("WARN_EXISTS") % name)
		return
	var file = FileAccess.open(target, FileAccess.WRITE)
	if file == null:
		file = null
		editor.warn(tr("WARN_CREATE_FAILED"))
		return
	file = null

	editor.current_dir = current_path
	editor.open_file(target)
	LuaSingleton.setup_extension(name.split(".")[-1])
	code.setup_highlighter()
	get_tree().create_timer(.1).timeout.connect(func():
		code.grab_focus()
	)
	ui_close.emit()
	cancel_create()

func _draw_create_indicator() -> void:
	if create_mode == 0:
		return
	push_bgcolor(LuaSingleton.gui.selection_color)
	push_color(LuaSingleton.gui.font_color)
	if create_mode == 1:
		add_text("󰈔")
	else:
		add_text("")
	pop()
	pop()
	var label = tr("CREATE_FILE_NEW") if create_mode == 1 else tr("CREATE_FOLDER_NEW")
	var suffix: String = query if !query.is_empty() else "..."
	append_text(" " + label + ": " + suffix + "\n")

func make_bold(string: String, indexes: Array) -> String:
	var new_string: String = ""

	for i in range(len(string)):
		if i in indexes: new_string += "[i][color=yellow]" + string[i] + "[/color][/i]"
		else: new_string += string[i]

	return new_string

func fuzzy_search(string: String, substring: String) -> Array:
	var indexes: Array = []
	var pos: int = 0
	var last_index: int = 0

	for i in range(string.length()):
		if string[i] == substring[pos]:
			indexes.append(i)
			pos += 1
			if pos == substring.length():
				break
		else:
			if last_index < i - 1:
				i = last_index
			pos = 0
			indexes = []

		last_index = i

	return indexes

# Compares 2 fuzzy Arrays and returns if 'new' Array is closer to query than 'old'
func is_closer(old: Array, new: Array) -> bool:
	if len(old) == 0: return true
	if len(new) == 0: return false

	if old == new: return false

	for i in range(len(old)):
		if old[i] > new[i]: return true
		elif old[i] < new[i]: return false

	return false

# global_position is slightly off, so we customize it a little.
func gp() -> Vector2:
	var vec = global_position;

	vec.x += 100;

	return vec;
