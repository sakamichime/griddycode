-- Highlight Keywords
highlight("and", "reserved")
highlight("as", "reserved")
highlight("await", "reserved")
highlight("break", "reserved")
highlight("class", "reserved")
highlight("class_name", "reserved")
highlight("const", "reserved")
highlight("continue", "reserved")
highlight("elif", "reserved")
highlight("else", "reserved")
highlight("enum", "reserved")
highlight("extends", "reserved")
highlight("false", "reserved")
highlight("for", "reserved")
highlight("func", "reserved")
highlight("if", "reserved")
highlight("in", "reserved")
highlight("is", "reserved")
highlight("match", "reserved")
highlight("not", "reserved")
highlight("null", "reserved")
highlight("or", "reserved")
highlight("pass", "reserved")
highlight("preload", "reserved")
highlight("return", "reserved")
highlight("self", "reserved")
highlight("signal", "reserved")
highlight("static", "reserved")
highlight("super", "reserved")
highlight("true", "reserved")
highlight("var", "reserved")
highlight("void", "reserved")
highlight("when", "reserved")
highlight("while", "reserved")
highlight("yield", "reserved")

-- Annotations
highlight("@onready", "annotation")
highlight("@export", "annotation")
highlight("@export_group", "annotation")
highlight("@export_subgroup", "annotation")
highlight("@export_range", "annotation")
highlight("@export_enum", "annotation")
highlight("@export_color_no_alpha", "annotation")
highlight("@export_flags", "annotation")
highlight("@export_multiline", "annotation")
highlight("@export_file", "annotation")
highlight("@export_dir", "annotation")
highlight("@export_placeholder", "annotation")
highlight("@warning_ignore", "annotation")
highlight("@tool", "annotation")
highlight("@icon", "annotation")
highlight("@rpc", "annotation")
highlight("@category", "annotation")

-- Built-in types
highlight("int", "annotation")
highlight("float", "annotation")
highlight("bool", "annotation")
highlight("String", "annotation")
highlight("StringName", "annotation")
highlight("NodePath", "annotation")
highlight("Vector2", "annotation")
highlight("Vector2i", "annotation")
highlight("Vector3", "annotation")
highlight("Vector3i", "annotation")
highlight("Vector4", "annotation")
highlight("Vector4i", "annotation")
highlight("Rect2", "annotation")
highlight("Rect2i", "annotation")
highlight("Transform2D", "annotation")
highlight("Transform3D", "annotation")
highlight("Color", "annotation")
highlight("Array", "annotation")
highlight("Dictionary", "annotation")
highlight("Callable", "annotation")
highlight("Signal", "annotation")
highlight("PackedByteArray", "annotation")
highlight("PackedInt32Array", "annotation")
highlight("PackedFloat32Array", "annotation")
highlight("PackedStringArray", "annotation")
highlight("Variant", "annotation")

-- Global singletons & helpers
highlight("print", "function")
highlight("printt", "function")
highlight("printerr", "function")
highlight("push_error", "function")
highlight("push_warning", "function")
highlight("assert", "function")
highlight("load", "function")
highlight("instance_from_id", "function")
highlight("lerp", "function")
highlight("clamp", "function")
highlight("abs", "function")
highlight("min", "function")
highlight("max", "function")
highlight("randf", "function")
highlight("randi", "function")
highlight("randi_range", "function")
highlight("randf_range", "function")
highlight("Engine", "function")
highlight("OS", "function")
highlight("Time", "function")
highlight("Input", "function")
highlight("InputMap", "function")
highlight("ProjectSettings", "function")
highlight("ResourceLoader", "function")
highlight("ResourceSaver", "function")
highlight("SceneTree", "function")
highlight("RenderingServer", "function")
highlight("PhysicsServer2D", "function")
highlight("PhysicsServer3D", "function")

-- Operators
highlight("=", "operator")
highlight("+", "operator")
highlight("-", "operator")
highlight("*", "operator")
highlight("/", "operator")
highlight("%", "operator")
highlight("+=", "operator")
highlight("-=", "operator")
highlight("*=", "operator")
highlight("/=", "operator")
highlight("%=", "operator")
highlight("==", "operator")
highlight("!=", "operator")
highlight(">", "operator")
highlight("<", "operator")
highlight(">=", "operator")
highlight("<=", "operator")
highlight("&&", "operator")
highlight("||", "operator")
highlight("!", "operator")
highlight("&", "operator")
highlight("|", "operator")
highlight("^", "operator")
highlight("~", "operator")
highlight("<<", "operator")
highlight(">>", "operator")
highlight("->", "operator")
highlight("=>", "operator")
highlight("??", "operator")
highlight("...", "operator")
highlight("..", "operator")

-- Special Characters
highlight("{", "binary")
highlight("}", "binary")
highlight("[", "binary")
highlight("]", "binary")
highlight("(", "binary")
highlight(")", "binary")
highlight(";", "binary")
highlight(",", "binary")
highlight(":", "binary")

-- Strings
highlight_region("\"", "\"", "string")
highlight_region("'", "'", "string")
highlight_region("\"\"\"", "\"\"\"", "string")
highlight_region("'''", "'''", "string")

-- Comments
highlight_region("#", "", "comments", true)

-- Comments
add_comment("GDScript: Python's cooler, Godot-flavored sibling")
add_comment("Signals: the notification system that doesn't spam you")
add_comment("if node == null: queue_free() — the ultimate breakup")
add_comment("The scene tree is a family tree, and you are the weird uncle")
add_comment("Somewhere a node forgot to set its process mode")
add_comment("export vars are just ask forgiveness, not permission")

-- Autocomplete

function detect_functions(content)
    local functionNames = {}

    for line in content:gmatch("[^\r\n]+") do
        local functionName = line:match("%s*func%s+([%w_]+)%s*%(")
        if functionName then
            table.insert(functionNames, functionName)
        end
        local builtinName = line:match("%s*(_ready)%s*%(")
        if builtinName then
            table.insert(functionNames, builtinName)
        end
    end

    return functionNames
end

function detect_variables(content)
    local variable_names = {}
    local lines = content:gmatch("[^\r\n]+")

    for line in lines do
        local variable = line:match("%s*var%s+([%w_]+)%s*[:=]")
        if not variable then
            variable = line:match("%s*var%s+([%w_]+)%s*$")
        end
        if not variable then
            variable = line:match("%s*const%s+([%w_]+)%s*[:=]")
        end
        if variable then
            table.insert(variable_names, variable)
        end
    end

    return variable_names
end

function detect_api(content)
    local api = {}

    local node_classes = {
        "Node", "Node2D", "Node3D", "Control", "CanvasItem", "CanvasLayer",
        "Sprite2D", "AnimatedSprite2D", "Sprite3D", "AnimatedSprite3D",
        "Camera2D", "Camera3D", "AudioStreamPlayer", "AudioStreamPlayer2D",
        "AudioStreamPlayer3D", "CharacterBody2D", "CharacterBody3D",
        "RigidBody2D", "RigidBody3D", "StaticBody2D", "StaticBody3D",
        "Area2D", "Area3D", "CollisionShape2D", "CollisionShape3D",
        "Label", "RichTextLabel", "Button", "TextureButton", "TouchScreenButton",
        "LineEdit", "TextEdit", "CodeEdit", "OptionButton", "CheckButton",
        "CheckBox", "SpinBox", "Slider", "HSlider", "VSlider",
        "ProgressBar", "TextureProgressBar", "ColorPicker", "ColorPickerButton",
        "FileDialog", "PopupMenu", "MenuBar", "TabBar", "TabContainer",
        "Tree", "ItemList", "GridContainer", "HBoxContainer", "VBoxContainer",
        "CenterContainer", "MarginContainer", "Panel", "PanelContainer",
        "ScrollContainer", "Viewport", "SubViewport", "SubViewportContainer",
        "AnimationPlayer", "AnimationTree", "Tween", "Timer",
        "TileMap", "TileMapLayer", "Parallax2D", "YSort",
        "MultiplayerSynchronizer", "MultiplayerSpawner", "HTTPRequest",
        "PackedScene", "Resource", "SceneTree", "Texture2D"
    };

    local node_methods = {
        "add_child", "remove_child", "get_node", "get_node_or_null",
        "get_parent", "queue_free", "free", "duplicate", "is_inside_tree",
        "is_node_ready", "is_queued_for_deletion", "get_tree",
        "get_viewport", "get_owner", "set_name", "get_name", "set_scene_file_path",
        "call", "call_deferred", "connect", "disconnect", "emit_signal",
        "set_meta", "get_meta", "has_meta", "set_process", "set_process_input",
        "set_process_unhandled_input", "process_mode", "get_children",
        "find_child", "find_children", "request_ready", "has_node",
        "set", "get", "set_indexed", "get_indexed", "property_list_changed_notify"
    };

    local node_properties = {
        "position", "global_position", "rotation", "scale", "global_scale",
        "visible", "modulate", "z_index", "z_as_relative", "name", "owner",
        "process_mode", "process_priority", "pause_mode", "tree_entered",
        "tree_exited", "input", "ready", "visibility_changed",
        "frame", "animation", "playing", "speed_scale", "direction"
    };

    local control_methods = {
        "set_position", "set_size", "set_global_position",
        "set_anchor", "set_anchors_preset", "set_grow_direction",
        "set_mouse_filter", "set_pivot_offset", "grab_focus",
        "get_global_rect", "get_rect", "get_size", "get_minimum_size",
        "set_focus_mode", "set_focus_neighbor", "has_focus", "get_global_mouse_position"
    };

    local control_properties = {
        "size", "min_size", "custom_minimum_size", "anchor_left", "anchor_top",
        "anchor_right", "anchor_bottom", "offset_left", "offset_top",
        "offset_right", "offset_bottom", "pivot_offset", "mouse_filter",
        "focus_mode", "tooltip_text", "disabled", "text", "alignment",
        "font", "font_size", "font_color", "theme", "theme_override"
    };

    local input_helpers = {
        "is_action_pressed", "is_action_just_pressed", "is_action_just_released",
        "is_key_pressed", "is_mouse_button_pressed", "get_vector",
        "get_action_strength", "action_press", "action_release"
    };

    for _, name in ipairs(node_classes) do
        table.insert(api, { name = name, kind = "class" })
    end

    for _, name in ipairs(node_methods) do
        table.insert(api, { name = name, kind = "member", insert = name .. "()" })
    end
    for _, name in ipairs(control_methods) do
        table.insert(api, { name = name, kind = "member", insert = name .. "()" })
    end
    for _, name in ipairs(input_helpers) do
        table.insert(api, { name = name, kind = "member", insert = name .. "()" })
    end

    for _, name in ipairs(node_properties) do
        table.insert(api, { name = name, kind = "member" })
    end
    for _, name in ipairs(control_properties) do
        table.insert(api, { name = name, kind = "member" })
    end

    table.insert(api, { name = "print", kind = "function", insert = "print()" })
    table.insert(api, { name = "get_node", kind = "function", insert = "get_node(\"\")" })
    table.insert(api, { name = "preload", kind = "function", insert = "preload(\"\")" })

    return api
end
