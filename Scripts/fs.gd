extends Node

func save(path: String, content: String) -> void:
	var file = FileAccess.open(path, FileAccess.WRITE)
	if !file: return
	file.store_string(content)

func _load(path: String) -> String:
	if !FileAccess.file_exists(path): return ""
	return FileAccess.get_file_as_string(path)
