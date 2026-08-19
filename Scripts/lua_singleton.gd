extends Node

const NOTO_COLOR_EMOJI_REGULAR: FontFile = preload("res://Fonts/NotoColorEmoji-Regular.ttf")

var themes: Array = ["One Dark Pro Darker"];
var theme: String = "One Dark Pro Darker"; # default

# TODO: change me each version
var version: String = "v1.2.2";

var gui: Dictionary = {
	"background_color":            str_to_clr("#23272e"),
	"current_line_color":          str_to_clr("#23272e"),
	"selection_color":             str_to_clr("#23272e"),
	"font_color":                  str_to_clr("#23272e"),
	"word_highlighted_color":      str_to_clr("#23272e"),
	"completion_background_color": str_to_clr("#23272e"),
	"completion_selected_color":   str_to_clr("#23272e"),
	"caret_color":                 str_to_clr("#23272e")
}

# #### SETTINGS ####
# # Info:
# Property = identifier
# Display = the setting name to display.
# Options = dropdown options. Leave empty for no dropdown.
# Icon = nerdfont unicode for the icon
# Value = initial value. Reminder this gets overwritten by the save file.
# Unit = the unit to display after the slider.
# Min = the minimum slider value.
# Max = the maximum slider value.
# Precision = whether or not the slider should go from int to float.
# Shader = whether or not to disable the previously-enabled shader setting, as they can't be stacked.

var editor_theme: Theme = load("res://theme.tres");
var fonts = load_available_fonts()


func load_available_fonts() -> Array:
	var built_ins = load_built_in_fonts()
	var system = load_system_fonts()
	built_ins.append_array(system)
	return built_ins


func load_built_in_fonts() -> Array:
	return Array(editor_theme.get_font_list("MyType")).map(load_built_in_font)


func load_built_in_font(_name: String) -> Dictionary:
	var font = editor_theme.get_font(_name, "MyType");

	return { "display": font.get_font_name(), "value": font, "name": _name }


func load_system_font(font_name: String):
	var font: SystemFont = SystemFont.new()
	font.multichannel_signed_distance_field = true
	font.font_names = [font_name]

	return { "display": font.get_font_name(), "value": font, "name": font_name }


func load_system_fonts() -> Array:
	return Array(OS.get_system_fonts()).map(load_system_font)


var settings: Array = [
	{
		"property": "caret_type",
		"display": "SETTING_CARET_TYPE",
		"options": [{"display": "Line", "value": 0}, {"display": "Block", "value": 1}, {"display": "Underline", "value": 2}],
		"icon": "",
		"value": CodeEdit.CARET_TYPE_LINE,
	},
	{
		"property": "caret_blink",
		"display": "SETTING_CARET_BLINK",
		"options": [],
		"icon": "|",
		"value": true
	},
	{
		"property": "editor_font",
		"display": "SETTING_EDITOR_FONT",
		"options": fonts,
		"icon": "",
		"value": 0
	},
	{
		"property": "caret_interval",
		"display": "SETTING_CARET_INTERVAL",
		"options": [],
		"icon": "",
		"value": 0.6,
		"unit": "UNIT_SECONDS",
		"min": 0.1, "max": 3,
		"precision": true,
	},
	{
		"property": "manual_save",
		"display": "SETTING_MANUAL_SAVE",
		"options": [],
		"icon": "󰈈",
		"value": false
	},
	{
		"property": "draw_line_numbers",
		"display": "SETTING_DRAW_LINE_NUMBERS",
		"options": [],
		"icon": "",
		"value": true
	},
	{
		"property": "code_completion",
		"display": "SETTING_CODE_COMPLETION",
		"options": [],
		"icon": "",
		"value": true
	},
	{
		"property": "indentation_size",
		"display": "SETTING_INDENTATION_SIZE",
		"options": [],
		"icon": "󰌒",
		"value": 4,
		"unit": "UNIT_TABS",
		"min": 1, "max": 8,
	},
	{
		"property": "indentation_automatic",
		"display": "SETTING_INDENTATION_AUTOMATIC",
		"options": [],
		"icon": "󰁨",
		"value": true
	},
	{
		"property": "indentation_use_spaces",
		"display": "SETTING_INDENTATION_USE_SPACES",
		"options": [],
		"icon": "󱁐",
		"value": false
	},
	{
		"property": "auto_brace_completion",
		"display": "SETTING_AUTO_BRACE_COMPLETION",
		"options": [],
		"icon": "󰅩",
		"value": true
	},
	{
		"property": "auto_brace_highlight_matching",
		"display": "SETTING_AUTO_BRACE_HIGHLIGHT",
		"options": [],
		"icon": "󱃖",
		"value": true
	},
	{
		"property": "smooth_scrolling",
		"display": "SETTING_SMOOTH_SCROLLING",
		"options": [],
		"icon": "󱕒",
		"value": true
	},
	{
		"property": "v_scroll_speed",
		"display": "SETTING_V_SCROLL_SPEED",
		"options": [],
		"icon": "",
		"value": 150,
		"unit": "UNIT_PX_S",
		"min": 10, "max": 900,
	},
	{
		"property": "minimap",
		"display": "SETTING_MINIMAP",
		"options": [],
		"icon": "󰍍",
		"value": true
	},
	{
		"property": "minimap_width",
		"display": "SETTING_MINIMAP_WIDTH",
		"options": [],
		"icon": "",
		"value": 80,
		"unit": "UNIT_PX",
		"min": 20, "max": 500,
	},
	{
		"property": "glow",
		"display": "SETTING_GLOW",
		"options": [],
		"icon": "󰌶",
		"value": true,
	},
	{
		"property": "sunlight",
		"display": "SETTING_SUNLIGHT",
		"options": [],
		"icon": "",
		"value": false,
		"shader": true
	},
	{
		"property": "vhs",
		"display": "SETTING_VHS",
		"options": [],
		"icon": "",
		"value": false,
		"shader": true
	},
	{
		"property": "music",
		"display": "SETTING_MUSIC",
		"options": [],
		"icon": "󰝚",
		"value": false,
	},
	{
		"property": "music_volume",
		"display": "SETTING_MUSIC_VOLUME",
		"options": [],
		"icon": "",
		"value": 100,
		"unit": "UNIT_PERCENT",
		"min": 0, "max": 100,
	},
	{
		"property": "music_move_intensity",
		"display": "SETTING_MUSIC_MOVE_INTENSITY",
		"options": [],
		"icon": "",
		"value": 1,
		"unit": "UNIT_X",
		"min": 0, "max": 10,
	},
	{
		"property": "discord_sdk",
		"display": "SETTING_DISCORD_SDK",
		"options": [],
		"icon": "󰙯",
		"value": true,
	},
];

var keywords: Dictionary = {
	"reserved":   str_to_clr("c678cc"),
	"annotation": str_to_clr("a2b429"),
	"string":     str_to_clr("98c379"),
	"binary":     str_to_clr("d19a66"),
	"symbol":     str_to_clr("839fb6"),
	"variable":   str_to_clr("e5c07b"),
	"operator":   str_to_clr("56b6c2"),
	"comments":   str_to_clr("7f848e"),
	"error":      str_to_clr("d31820"),
	"function":   str_to_clr("437ed9"),
	"member":     str_to_clr("e06c75")
}

const EXTENSION_ALIASES: Dictionary = {
	"kts": "kt",
	"hpp": "cpp",
	"cc": "cpp",
	"cxx": "cpp",
	"hh": "cpp",
	"h": "c",
	"mjs": "js",
	"cjs": "js",
	"yml": "yaml",
	"pm": "pl",
	"pyw": "py",
	"pyi": "py",
	"hcl": "tf",
	"dockerfile": "docker",
}

const CONTENT_SIGNATURES: Array = [
	["#!/usr/bin/env python", "py"],
	["#!/usr/bin/python", "py"],
	["#!/bin/bash", "sh"],
	["#!/bin/sh", "sh"],
	["<?php", "php"],
	["<!doctype html", "html"],
	["<html", "html"],
	["fn main", "rs"],
	["use std::", "rs"],
	["println!", "rs"],
	["fn ", "rs"],
	["fun main", "kt"],
	["println(", "kt"],
	["^fun ", "kt"],
	["^val ", "kt"],
	["public class", "java"],
	["^class ", "java"],
	["package ", "go"],
	["import \"fmt\"", "go"],
	["func main", "go"],
	["#include <", "c"],
	["^extends ", "gd"],
	["^class_name ", "gd"],
	["@tool", "gd"],
	["^func ", "gd"],
	["^var ", "gd"],
	["^const ", "gd"],
	["local function", "lua"],
	["--[[", "lua"],
	["^function ", "lua"],
	["^local ", "lua"],
	["^def ", "py"],
	["console.log", "js"],
	["module.exports", "js"],
	["require(", "js"],
	["using system", "cs"],
	["select ", "sql"],
	["create table", "sql"],
	["insert into", "sql"],
]

var keywords_to_highlight: Dictionary = {}
var color_regions_to_highlight: Array = []
var comments: Array = []

var language_options: Array = []

func _ready() -> void:
	build_language_options()

func build_language_options() -> void:
	language_options = [{ "display": "LANGUAGE_SYSTEM", "value": "" }]
	for locale in TranslationServer.get_loaded_locales():
		language_options.append({ "display": TranslationServer.get_locale_name(locale), "value": locale })

	if get_setting("language")[1] == -1:
		settings.insert(0, {
			"property": "language",
			"display": "SETTING_LANGUAGE",
			"options": language_options,
			"icon": "󰍵",
			"value": 0
		})

var discord_sdk: bool = true;

const SUNLIGHT = preload("res://Shaders/sunlight.gdshader")
const VHS_AND_CRT = preload("res://Shaders/vhs_and_crt.gdshader")

@onready var editor: FileManager = $/root/Editor;
@onready var code: CodeEdit = $/root/Editor/Code;
@onready var world_environment: WorldEnvironment = $/root/Editor/WorldEnvironment
@onready var shader_layer: ColorRect = $/root/Editor/ShaderLayer





signal done_parsing;
signal on_theme_load;
signal on_settings_change;




func get_setting(property: String) -> Array:
	var i = -1;

	for setting in settings:
		i += 1;

		if setting["property"] == property:
			return [setting, i]

	return [{}, -1]

func change_setting(property: String, value: Variant) -> void:
	for setting in settings:
		if setting["property"] == property:
			setting["value"] = value
			handle_internal_setting_change(property, value)
			return

func toggle_shader(shader: Shader, value: bool) -> void:
	if value:
		shader_layer.show()
		shader_layer.material.shader = shader
	else:
		shader_layer.material.shader = null
		shader_layer.hide()



func handle_internal_setting_change(property: String, value: Variant) -> void:
	# oh my god he's about to do it
	var p = property;

	if p == "language":
		var locale: String = ""
		if language_options.size() > int(value):
			locale = language_options[int(value)]["value"]
		if locale.is_empty():
			locale = OS.get_locale()
		TranslationServer.set_locale(locale)
	if p == "caret_type":
		if value == 2:
			code.caret_type = CodeEdit.CARET_TYPE_LINE
		else:
			code.caret_type = value
	if p == "caret_blink":
		code.caret_blink = value
	if p == "caret_interval":
		code.caret_blink_interval = value;
	if p == "manual_save":
		var autosave_timer: Timer = editor.get_node("AutoSaveTimer")
		if autosave_timer:
			if value:
				autosave_timer.stop()
			else:
				autosave_timer.start()
	if p == "draw_line_numbers":
		code.gutters_draw_line_numbers = value;
	if p == "code_completion":
		code.code_completion_enabled = value
	if p == "indentation_size":
		code.indent_size = value
	if p == "indentation_automatic":
		code.indent_automatic = value
	if p == "indentation_use_spaces":
		code.indent_use_spaces = value
	if p == "auto_brace_completion":
		code.auto_brace_completion_enabled = value
	if p == "auto_brace_highlight_matching":
		code.auto_brace_completion_highlight_matching = value
	if p == "smooth_scrolling":
		code.scroll_smooth = value
	if p == "v_scroll_speed":
		code.scroll_v_scroll_speed = value
	if p == "minimap":
		code.minimap_draw = value
	if p == "minimap_width":
		code.minimap_width = value
	if p == "editor_font":
		fonts[value].value.set_fallbacks([NOTO_COLOR_EMOJI_REGULAR])

		editor_theme.set_font("normal_font", "RichTextLabel", fonts[value].value)
		editor_theme.set_font("font", "Label", fonts[value].value)
		editor_theme.set_font("font", "CodeEdit", fonts[value].value)
		editor_theme.set_font("font", "Button", fonts[value].value)

	# SHADERS
	if p == "glow":
		world_environment.environment.glow_enabled = value
	if p == "sunlight":
		toggle_shader(SUNLIGHT, value)
	if p == "vhs":
		toggle_shader(VHS_AND_CRT, value)
	# MUSIC
	if p == "music":
		Music.set_enabled(value)
	if p == "music_volume":
		Music.set_volume(value)
	if p == "music_move_intensity":
		Music.music_move_intensity = value
	if p == "discord_sdk":
		discord_sdk = value;

func setup_discord_sdk(detail: String, state: String) -> void:
	if !discord_sdk: return
	DiscordSDK.details = detail
	DiscordSDK.state = state

	DiscordSDK.refresh()

# LUA
var lua: LuaAPI = LuaAPI.new()
var theme_lua: LuaAPI = LuaAPI.new()

func str_to_clr(string: String) -> Color:
	return Color.from_string(string, "#ff0000");


func _lua_highlight(keyword: String, color: String):
	if !(color in keywords.keys()):
		print("ERROR: provided color property (\"%s\") at \"%s\" is invalid." % [color, keyword])
		return

	keywords_to_highlight[keyword] = color;

func _lua_highlight_region(start: String, end: String, color: String, line_only: bool = false):
	if !(color in keywords.keys()):
		print("ERROR: provided color (\"%s\") at color region (start: \"%s\", end: \"%s\") is invalid." % [color, start, end])
		return

	color_regions_to_highlight.append([start, end, color, line_only])

func _lua_set_keywords(property: String, new_color: String) -> void:
	if !(property in keywords.keys()):
		print("ERROR: provided color property (\"%s\") in theme (KEYWORD) is invalid." % [property])
		return

	keywords[property] = str_to_clr(new_color)

func _lua_disable_glow() -> void:
	editor.warn(tr("WARN_GLOW_DISABLED"))
	handle_internal_setting_change("glow", false)

func _lua_set_gui(property: String, new_color: String) -> void:
	if !(property in gui.keys()):
		print("ERROR: provided color property (\"%s\") in theme (GUI) is invalid." % [property])
		return

	gui[property] = str_to_clr(new_color)

func _add_comment(comment: String) -> void:
	comments.append(comment)

func _splitstr(input: String, separator: String):
	return input.split(separator)

func _trim(input: String):
	return input.strip_edges()

func setup_extension(extension: String, content: String = "") -> void:
	# FILE EXTENSIONS
	keywords_to_highlight.clear()
	color_regions_to_highlight.clear()
	comments.clear()

	var plugin := resolve_language_plugin(extension, content)
	if plugin.is_empty():
		editor.warn(tr("WARN_LANG_UNSUPPORTED"))
		return

	lua.bind_libraries(["base", "table", "string"])

	lua.push_variant("highlight", _lua_highlight)
	lua.push_variant("highlight_region", _lua_highlight_region)
	lua.push_variant("add_comment", _add_comment)

	lua.push_variant("splitstr", _splitstr)
	lua.push_variant("trim", _trim)

	var err: LuaError = lua.do_file("user://langs/" + plugin + ".lua")
	if err is LuaError:
		editor.warn(tr("WARN_LANG_UNSUPPORTED"))
		print("ERROR %d: %s" % [err.type, err.message])
		return

	done_parsing.emit()

func resolve_language_plugin(extension: String, content: String = "") -> String:
	var candidates := PackedStringArray()

	if not extension.is_empty():
		var ext := extension.to_lower()
		candidates.append(ext)
		if EXTENSION_ALIASES.has(ext):
			candidates.append(EXTENSION_ALIASES[ext])

	for candidate in candidates:
		if plugin_exists(candidate):
			return candidate

	var detected := detect_language_from_content(content)
	if not detected.is_empty() and plugin_exists(detected):
		return detected

	return ""

func plugin_exists(plugin: String) -> bool:
	return FileAccess.file_exists("user://langs/" + plugin + ".lua") \
		or FileAccess.file_exists("res://Lua/Plugins/" + plugin + ".lua")

func detect_language_from_content(content: String) -> String:
	if content.is_empty():
		return ""

	var sample := content.substr(0, 4096).to_lower().replace("\r", "")

	for signature in CONTENT_SIGNATURES:
		if match_signature(sample, signature[0]):
			return signature[1]

	return ""

func match_signature(sample: String, needle: String) -> bool:
	if needle.begins_with("^"):
		var anchored := needle.substr(1)
		return sample.begins_with(anchored) or sample.contains("\n" + anchored)
	return sample.contains(needle)

func setup_theme(given_theme: String) -> void:
	theme_lua.bind_libraries(["base", "table", "string"])

	theme_lua.push_variant("disable_glow", _lua_disable_glow)
	theme_lua.push_variant("set_keywords", _lua_set_keywords)
	theme_lua.push_variant("set_gui", _lua_set_gui)

	var theme_err: LuaError = theme_lua.do_file("user://themes/" + given_theme + ".lua")
	if theme_err is LuaError:
		editor.warn(tr("WARN_THEME_FAILED") % theme_err.message)
		print("ERROR %d: %s" % [theme_err.type, theme_err.message])
		return

	on_theme_load.emit()
