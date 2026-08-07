extends Node

func save(path: String, content: String) -> Error:
	var file = FileAccess.open(path, FileAccess.WRITE)
	if !file: return ERR_CANT_OPEN
	file.store_string(content)
	return file.get_error()

func _load(path: String) -> String:
	if !FileAccess.file_exists(path): return ""
	return FileAccess.get_file_as_string(path)
