class_name Comments

extends VBoxContainer

const COMMENT = preload("res://Scenes/comment.tscn")

func _ready():
	await LuaSingleton.done_parsing

	setup()

func _notification(what: int) -> void:
	if what == NOTIFICATION_TRANSLATION_CHANGED and is_node_ready():
		setup()

func setup():
	var names = CommentsData.NAMES.duplicate();

	for child in get_children():
		child.queue_free()

	for comment in get_random_comments():
		var _name = names.pick_random();

		var name_index = names.find(_name)
		if name_index != -1:
			names.remove_at(name_index)

		var node: Comment = COMMENT.instantiate();

		add_child(node)

		node.setup(_name, comment)
func get_random_comments() -> Array:
	LuaSingleton.comments.shuffle()

	return LuaSingleton.comments.slice(0, 3)
