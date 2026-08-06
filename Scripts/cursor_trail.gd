extends Node2D

# Neovide-style cursor trail (ported from neovide-cursor.js)
# Each caret is drawn as an opaque quad whose 4 corners lag behind with
# damped springs, stretching along the direction of travel.

class DampedSpringAnimation:
	var position: float = 0.0
	var velocity: float = 0.0

	func update(dt: float, animation_length: float) -> bool:
		if animation_length <= dt or position == 0.0:
			reset()
			return false
		var omega = 4.0 / animation_length
		var a = position
		var b = position * omega + velocity
		var c = exp(-omega * dt)
		position = (a + b * dt) * c
		velocity = c * (-a * omega - b * dt * omega + b)
		if absf(position) < 0.01:
			reset()
			return false
		return true

	func reset() -> void:
		position = 0.0
		velocity = 0.0


class Corner:
	var relative_position: Vector2
	var current_position: Vector2 = Vector2.ZERO
	var previous_destination: Vector2 = Vector2(-1000, -1000)
	var animation_x := DampedSpringAnimation.new()
	var animation_y := DampedSpringAnimation.new()
	var animation_length: float = 0.10

	func _init(relative: Vector2) -> void:
		relative_position = relative

	func get_destination(center: Vector2, dimensions: Vector2) -> Vector2:
		return center + relative_position * dimensions

	func calculate_direction_alignment(dimensions: Vector2, destination: Vector2) -> float:
		var corner_destination = get_destination(destination, dimensions)
		var travel_direction = (corner_destination - current_position).normalized()
		return travel_direction.dot(relative_position.normalized())

	func jump(destination: Vector2, dimensions: Vector2, rank: int, trail_size: float, base_length: float, short_length: float) -> void:
		var target = get_destination(destination, dimensions)
		var jump_vec = (target - previous_destination) / dimensions

		var is_short_jump = absf(jump_vec.x) <= 2.001 and absf(jump_vec.y) <= 0.001

		if is_short_jump:
			animation_length = minf(base_length, short_length)
		else:
			var leading = base_length * clampf(1.0 - trail_size, 0.0, 1.0)
			var trailing = base_length
			if rank >= 2:
				animation_length = leading
			elif rank == 1:
				animation_length = (leading + trailing) / 2.0
			else:
				animation_length = trailing
		animation_x.reset()
		animation_y.reset()

	func update(dimensions: Vector2, destination: Vector2, dt: float, immediate: bool) -> bool:
		var corner_destination = get_destination(destination, dimensions)

		if corner_destination != previous_destination:
			var delta = corner_destination - current_position
			animation_x.position = delta.x
			animation_y.position = delta.y
			previous_destination = corner_destination

		if immediate:
			current_position = corner_destination
			animation_x.reset()
			animation_y.reset()
			return false

		var anim_x = animation_x.update(dt, animation_length)
		var anim_y = animation_y.update(dt, animation_length)

		current_position = corner_destination - Vector2(animation_x.position, animation_y.position)
		return anim_x or anim_y


@onready var code: CodeEdit = %Code

var trail_color := Color(1, 1, 1, 1)
var shadow_layers: int = 3

const STANDARD_CORNERS = [
	Vector2(-0.5, -0.5), Vector2(0.5, -0.5),
	Vector2(0.5, 0.5), Vector2(-0.5, 0.5)
]

# Godot draws the caret as a thin rectangle (2px wide), so the trail quad
# must match that shape instead of a whole character cell.
const CARET_WIDTH := 2.0

var cursor_instances: Dictionary = {}

var last_scroll_vertical: float = 0.0
var last_scroll_horizontal: float = 0.0

var animation_length: float = 0.10
var short_animation_length: float = 0.04
var trail_size: float = 1.0

func _ready() -> void:
	set_process(true)
	_hide_builtin_caret()
	trail_color = LuaSingleton.gui.caret_color if "caret_color" in LuaSingleton.gui else Color(0.32, 0.55, 1, 1)
	LuaSingleton.on_theme_load.connect(_on_theme_load)

func _on_theme_load() -> void:
	trail_color = LuaSingleton.gui.caret_color if "caret_color" in LuaSingleton.gui else Color(0.32, 0.55, 1, 1)
	_hide_builtin_caret()

func _hide_builtin_caret() -> void:
	# The trail quad replaces the editor's own caret, so hide it. settings.gd
	# re-applies caret_color on every theme load; this must run after that.
	code.add_theme_color_override("caret_color", Color(0, 0, 0, 0))

func _process(delta: float) -> void:
	if not code.has_focus():
		if cursor_instances.size() > 0:
			cursor_instances.clear()
			queue_redraw()
		return

	var scrolling = code.scroll_vertical != last_scroll_vertical or code.scroll_horizontal != last_scroll_horizontal
	last_scroll_vertical = code.scroll_vertical
	last_scroll_horizontal = code.scroll_horizontal

	var dimensions := _get_caret_size()
	var caret_count = code.get_caret_count()

	var live_ids := {}
	for i in caret_count:
		if not code.is_caret_visible(i):
			continue
		var cell_rect := code.get_rect_at_line_column(code.get_caret_line(i), code.get_caret_column(i))
		if cell_rect.position.x < 0 or cell_rect.position.y < 0:
			continue
		var target := Vector2(cell_rect.position)
		live_ids[i] = true

		var instance: Dictionary
		if not cursor_instances.has(i):
			instance = _make_instance(target, dimensions)
			cursor_instances[i] = instance
		else:
			instance = cursor_instances[i]
			if instance["last_target"] != target:
				_compute_ranks(instance, target, dimensions, scrolling)

		var corners: Array = instance["corners"]
		var destination = target + dimensions / 2.0
		for corner in corners:
			corner.update(dimensions, destination, delta, scrolling)

		instance["last_target"] = target

	for id in cursor_instances.keys():
		if not live_ids.has(id):
			cursor_instances.erase(id)

	queue_redraw()

func _get_caret_size() -> Vector2:
	return Vector2(CARET_WIDTH, code.get_line_height())

func _make_instance(target: Vector2, dimensions: Vector2) -> Dictionary:
	var corners := []
	for rel in STANDARD_CORNERS:
		corners.append(Corner.new(rel))

	var instance = {
		"corners": corners,
		"last_target": target
	}

	var center = target + dimensions / 2.0
	for corner in corners:
		var dest = corner.get_destination(center, dimensions)
		corner.current_position = dest
		corner.previous_destination = dest
		corner.animation_x.reset()
		corner.animation_y.reset()

	return instance

func _compute_ranks(instance: Dictionary, target: Vector2, dimensions: Vector2, scrolling: bool) -> void:
	var corners: Array = instance["corners"]
	var center_destination = target + dimensions / 2.0

	if scrolling:
		for corner in corners:
			var dest = corner.get_destination(center_destination, dimensions)
			corner.current_position = dest
			corner.previous_destination = dest
			corner.animation_x.reset()
			corner.animation_y.reset()
		return

	var aligned := []
	for i in corners.size():
		var value = corners[i].calculate_direction_alignment(dimensions, center_destination)
		aligned.append({ "index": i, "value": value })

	aligned.sort_custom(func(a, b): return a["value"] < b["value"] if a["value"] != b["value"] else a["index"] < b["index"])

	var ranks := []
	ranks.resize(corners.size())
	for rank in aligned.size():
		ranks[aligned[rank]["index"]] = rank

	for i in corners.size():
		corners[i].jump(center_destination, dimensions, ranks[i], trail_size, animation_length, short_animation_length)

func _draw() -> void:
	for id in cursor_instances:
		var corners: Array = cursor_instances[id]["corners"]
		var points := PackedVector2Array()
		for corner in corners:
			points.append(corner.current_position)

		var color := trail_color
		var center := Vector2.ZERO
		for point in points:
			center += point
		center /= float(points.size())

		for layer in range(shadow_layers, 0, -1):
			var layer_alpha = color.a * 0.08 * float(layer)
			var dilation = float(shadow_layers - layer) * 2.0
			var expanded := PackedVector2Array()
			for point in points:
				var dir = (point - center).normalized()
				expanded.append(point + dir * dilation)
			draw_colored_polygon(expanded, Color(color.r, color.g, color.b, layer_alpha))

		draw_colored_polygon(points, color)
