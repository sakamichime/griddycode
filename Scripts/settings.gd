extends CodeEdit

@onready var code: CodeEdit = %Code
@onready var editor: FileManager = $".."

const VARIABLE = preload("res://Icons/variable.png")
const FUNCTION = preload("res://Icons/function.png")
const KEYWORD = preload("res://Icons/keyword.png")

@onready var rich_text_labels: Array[RichTextLabel] = [
	%FileDialog,
];

var file_modified = false;

var _show = false;
var active_overlay: Variant;
var node_is_transitioning: bool;
var _collapsed_carets := false;

func _ready() -> void:
	grab_focus()

	LuaSingleton.on_theme_load.connect(setup_theme)

	tween_fade(%FileDialog, 0)
	tween_fade(%Settings, 0)

	setup_theme()

func setup_theme() -> void:
	setup_highlighter()

	%Background.color = LuaSingleton.gui.background_color;
	%ExternalBackground.color = LuaSingleton.gui.background_color;

	code.add_theme_color_override("background_color", LuaSingleton.gui.background_color)
	code.add_theme_color_override("current_line_color", LuaSingleton.gui.current_line_color)
	code.add_theme_color_override("selection_color", LuaSingleton.gui.selection_color)
	code.add_theme_color_override("font_color", LuaSingleton.gui.font_color)
	code.add_theme_color_override("word_highlighted_color", LuaSingleton.gui.word_highlighted_color)
	code.add_theme_color_override("completion_background_color", LuaSingleton.gui.completion_background_color)
	code.add_theme_color_override("completion_selected_color", LuaSingleton.gui.completion_selected_color)
	code.add_theme_color_override("caret_color", LuaSingleton.gui.caret_color)

	for label in rich_text_labels:
		label.add_theme_color_override("default_color", LuaSingleton.gui.font_color)

func setup_highlighter() -> void:
	var CH: CodeHighlighter = CodeHighlighter.new();

	syntax_highlighter = CH;

	CH.number_color = LuaSingleton.keywords.binary;
	CH.symbol_color = LuaSingleton.keywords.symbol;
	CH.function_color = LuaSingleton.keywords.function;
	CH.member_variable_color = LuaSingleton.keywords.member;

	# i dont remember why this was here, but the code works without it now
	#await LuaSingleton.done_parsing;

	var kth = LuaSingleton.keywords_to_highlight;
	var crth = LuaSingleton.color_regions_to_highlight;

	for key in kth:
		CH.add_keyword_color(key, LuaSingleton.keywords[kth[key]])

	for entry in crth:
		if CH.has_color_region(entry[0]): continue

		CH.add_color_region(entry[0], entry[1], LuaSingleton.keywords[entry[2]], entry[3])

# CodeEdit functionality
func _on_code_completion_requested() -> void:
	var function_names = LuaSingleton.lua.call_function("detect_functions", [text, get_caret_line(), get_caret_column()])
	var variable_names = LuaSingleton.lua.call_function("detect_variables", [text, get_caret_line(), get_caret_column()])
	var api_items = LuaSingleton.lua.call_function("detect_api", [text, get_caret_line(), get_caret_column()])

	if typeof(function_names) == Variant.Type.TYPE_ARRAY:
		for each in unique_array(function_names):
			add_code_completion_option(CodeEdit.KIND_FUNCTION, each, each+"()", LuaSingleton.keywords.function, FUNCTION)
	if typeof(variable_names) == Variant.Type.TYPE_ARRAY:
		for each in unique_array(variable_names):
			add_code_completion_option(CodeEdit.KIND_VARIABLE, each, each, LuaSingleton.keywords.variable, VARIABLE)
	if typeof(api_items) == Variant.Type.TYPE_ARRAY:
		for item in api_items:
			if typeof(item) != Variant.Type.TYPE_DICTIONARY: continue
			add_code_completion_option(_api_kind(item.get("kind", "class")), str(item.get("name", "")), str(item.get("insert", "")), LuaSingleton.keywords.function, FUNCTION)

	for keyword in LuaSingleton.keywords_to_highlight:
		if LuaSingleton.keywords_to_highlight[keyword] != "reserved": continue
		if not keyword.is_valid_identifier(): continue
		add_code_completion_option(CodeEdit.KIND_KEYWORD, keyword, keyword, LuaSingleton.keywords.reserved, KEYWORD)

	update_code_completion_options(true)

func _api_kind(kind: String) -> CodeEdit.CodeCompletionKind:
	match kind:
		"function":
			return CodeEdit.KIND_FUNCTION
		"signal":
			return CodeEdit.KIND_SIGNAL
		"variable":
			return CodeEdit.KIND_VARIABLE
		"member":
			return CodeEdit.KIND_MEMBER
		_:
			return CodeEdit.KIND_CLASS

func unique_array(arr: Array) -> Array:
	var out := {}
	for element in arr:
		out[element] = element
	return out.values()

func _on_text_changed() -> void:
	file_modified = true;
	request_code_completion()

# UI animations
func toggle(node: Object, apply_background: bool = true, factor: float = (18 * 7.5)) -> void:
	# fuck me
	# _show is a boolean to show the editor
	# _show is NOT a boolean to show the overlay

	# i dont know what the fuck is happening here, but ill try explaining it
	if active_overlay != node and active_overlay != null: return # we already have an overlay active, and this function call isn't from it trying to hide, so fuck off
	if active_overlay == node && !_show: return # if the active overlay is the node trying to toggle, and it wants to show even tho it's already shown, it shall fuck off
	if node_is_transitioning: return # node is already trying to go, stop spamming the keys; DO NOT FUCKING REMOVE.

	var opacity = 0 if _show else 1;

	tween_fade(node, opacity)

	var future_pos = slide_from_left(node, opacity, factor)

	if node is FileDialogType:
		node.active = !_show;

		if _show && !editor.current_file:
			editor.warn(tr("WARN_EMPTY_FILE"))

	if apply_background:
		tween_fade(%Background, opacity, !_show)
	elif not apply_background and !_show:
		node.grab_focus()

	if _show:
		%Cam.focus_die()
		if !node is FileDialogType:
			code.grab_focus()
	else:
		if node.name == "Info":
			future_pos.x += 700
			future_pos.y += 500
		if node.name == "Settings":
			future_pos.x += 200
			future_pos.y += 300
		if node.name == "Comments":
			future_pos.x += 200
			future_pos.y += 300

		%Cam.focus_on(future_pos, node.zoom if ("zoom" in node) else Vector2(1,1))
		code.release_focus()

	_show = !_show;

func tween_fade(node: Object, opacity: float, ignore_gui: bool = false) -> void:
	var tween = create_tween()
	var color = node.modulate;

	if opacity == 1:
		node.show()

	color.a = opacity

	tween.tween_property(node, "modulate", color, 0.2)

	tween.tween_callback(func() -> void:
		if opacity == 0:
			node.hide()

			if !ignore_gui: active_overlay = null;
			if node is CommentsOverlay:
				node.container.setup()

		else:
			node.show()
			if !ignore_gui: active_overlay = node;
	)

func slide_from_left(node: Object, __show: bool, factor: float) -> Vector2:
	node_is_transitioning = true;

	var tween = create_tween()
	var pos = node.global_position;

	var future_pos = Vector2(pos.x + factor, pos.y) if __show else Vector2(pos.x - factor, pos.y)

	tween.tween_property(node, "position", future_pos, 0.2)
	tween.tween_callback(func() -> void:
		node_is_transitioning = false;
	)

	return future_pos

func _on_file_dialog_ui_close():
	toggle(%FileDialog)


# MISC

func get_longest_line(lines: Array = text.split("\n")) -> String:
	var longestLine := ""

	for line in lines:
		if line.length() > longestLine.length():
			longestLine = line

	return longestLine

func _process(_delta):
	if Input.is_action_just_pressed("ui_open"):      toggle(%FileDialog)
	if Input.is_action_just_pressed("ui_settings"):  toggle(%Settings, true, (18 * 7.5) * 2)
	if Input.is_action_just_pressed("ui_info"):      toggle(%Info, true, 1500)
	if Input.is_action_just_pressed("ui_theme"):     toggle(%ThemeChooser, false, (18 * 28))
	if Input.is_action_just_pressed("ui_new_file"):
		if %FileDialog.create_mode == 1:
			%FileDialog.cancel_create()
			return
		if active_overlay != %FileDialog:
			toggle(%FileDialog)
		%FileDialog.enter_create_mode(1)
	if Input.is_action_just_pressed("ui_new_folder"):
		if %FileDialog.create_mode == 2:
			%FileDialog.cancel_create()
			return
		if active_overlay != %FileDialog:
			toggle(%FileDialog)
		%FileDialog.enter_create_mode(2)
	if Input.is_action_just_pressed("ui_cancel"):
		if %FileDialog.try_consume_cancel():
			return
		if %FileDialog.create_mode != 0:
			%FileDialog.cancel_create()
			return
		if _collapsed_carets:
			_collapsed_carets = false
			return
		if get_caret_count() > 1:
			remove_secondary_carets()
			_collapsed_carets = true
			return
		toggle(%FileDialog)
	if Input.is_action_just_pressed("ui_comments"):  toggle(%Comments, false, -(18 * 7.5))

func _on_gui_input(_event):
	if Input.is_action_just_pressed("ui_open"):      accept_event(); toggle(%FileDialog)
	if Input.is_action_just_pressed("ui_settings"):  accept_event(); toggle(%Settings, true, (18 * 7.5) * 2)
	if Input.is_action_just_pressed("ui_info"):      accept_event(); toggle(%Info, true, 1500)
	if Input.is_action_just_pressed("ui_theme"):     accept_event(); toggle(%ThemeChooser, false, (18 * 28))
	if Input.is_action_just_pressed("ui_new_file"):
		accept_event()
		if %FileDialog.create_mode == 1:
			%FileDialog.cancel_create()
			return
		if active_overlay != %FileDialog:
			toggle(%FileDialog)
		%FileDialog.enter_create_mode(1)
	if Input.is_action_just_pressed("ui_new_folder"):
		accept_event()
		if %FileDialog.create_mode == 2:
			%FileDialog.cancel_create()
			return
		if active_overlay != %FileDialog:
			toggle(%FileDialog)
		%FileDialog.enter_create_mode(2)
	if Input.is_action_just_pressed("ui_cancel"):
		if %FileDialog.try_consume_cancel():
			accept_event()
			return
		if %FileDialog.create_mode != 0:
			%FileDialog.cancel_create()
			accept_event()
			return
		if get_caret_count() > 1:
			remove_secondary_carets()
			_collapsed_carets = true
			accept_event()
			return
		accept_event(); toggle(%FileDialog)
	if Input.is_action_just_pressed("ui_comments"):  accept_event(); toggle(%Comments, false, -(18 * 7.5))

# Multi-cursor shortcuts (VS Code style)
func _shortcut_input(event: InputEvent) -> void:
	if event is not InputEventKey or not event.pressed or event.echo:
		return

	var ctrl = event.ctrl_pressed and not event.alt_pressed and not event.shift_pressed
	var ctrl_alt = event.ctrl_pressed and event.alt_pressed and not event.shift_pressed
	var ctrl_shift = event.ctrl_pressed and not event.alt_pressed and event.shift_pressed

	if ctrl and event.keycode == KEY_D:
		add_selection_for_next_occurrence()
		accept_event()
	elif ctrl_shift and event.keycode == KEY_L:
		select_all_occurrences()
		accept_event()
	elif ctrl_alt and event.keycode == KEY_DOWN:
		add_caret_at_carets(true)
		accept_event()
	elif ctrl_alt and event.keycode == KEY_UP:
		add_caret_at_carets(false)
		accept_event()

func select_all_occurrences() -> void:
	var needle: String = get_selected_text(0)
	var origin_line = get_selection_origin_line(0)
	var origin_col = get_selection_origin_column(0)

	if needle.is_empty():
		needle = get_word_at_caret()
		if needle.is_empty(): return

	var from := 0
	var added := 0
	const MAX_SELECTIONS := 200

	while added < MAX_SELECTIONS:
		var idx = text.find(needle, from)
		if idx == -1: break

		var line = text.substr(0, idx).count("\n")
		var line_start = text.rfind("\n", idx - 1) + 1 if line > 0 else 0
		var col = idx - line_start

		var is_current = line == origin_line and col == origin_col
		if not is_current:
			var caret_index = add_caret(line, col)
			select(line, col, line, col + needle.length(), caret_index)
			added += 1

		from = idx + needle.length()

func get_word_at_caret() -> String:
	var caret_line = get_caret_line(0)
	var caret_col = get_caret_column(0)
	var line_text: String = get_line(caret_line)
	if line_text.is_empty(): return ""

	var start: int = caret_col
	var end: int = caret_col

	while start > 0 and (line_text[start - 1].is_valid_identifier() or line_text[start - 1] == "_"):
		start -= 1
	while end < line_text.length() and (line_text[end].is_valid_identifier() or line_text[end] == "_"):
		end += 1

	return line_text.substr(start, end - start)
