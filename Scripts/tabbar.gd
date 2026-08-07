class_name GriddyTabBar
extends RichTextLabel

var editor: FileManager

func _ready() -> void:
	bbcode_enabled = true
	meta_clicked.connect(_on_meta_clicked)
	LuaSingleton.on_theme_load.connect(refresh)
	LuaSingleton.on_settings_change.connect(refresh)

func refresh() -> void:
	clear()
	if editor == null or editor.open_files.is_empty():
		hide()
		return
	show()

	var bb: String = ""
	var font_color: String = LuaSingleton.gui.font_color.to_html(false)
	var selection: String = LuaSingleton.gui.selection_color.to_html(false)

	for i in editor.open_files.size():
		var path: String = editor.open_files[i]
		var name := path.get_file()
		var icon := Icons.get_icon_data(name.get_extension())
		var active := path == editor.current_file
		var modified: bool = editor.buffers.has(path) and editor.buffers[path]["file_modified"]

		if active:
			bb += "[bgcolor=#%s]" % selection
		bb += "[color=#%s][url=switch:%d]%s %s[/url][/color]" % [font_color, i, icon["icon"], name]
		if modified:
			bb += " [color=#ffcc00]●[/color]"
		bb += " [color=#%s][url=close:%d]󰅖[/url][/color]" % [font_color, i]
		if active:
			bb += "[/bgcolor]"
		bb += "  "

	text = bb

func _on_meta_clicked(meta) -> void:
	if meta is not String:
		return
	var parts := (meta as String).split(":", true, 1)
	if parts.size() != 2:
		return
	match parts[0]:
		"switch":
			editor.switch_to_index(int(parts[1]))
		"close":
			editor.close_tab(editor.open_files[int(parts[1])])
